From: computersforpeace@gmail.com (Brian Norris)
Date: Mon, 7 Dec 2015 11:34:41 -0800
Subject: [PATCH linux-next 0/5] mtd: spi-nor: add driver for Atmel QSPI
 controller
In-Reply-To: <cover.1449494420.git.cyrille.pitchen@atmel.com>
References: <cover.1449494420.git.cyrille.pitchen@atmel.com>
Message-ID: <20151207193441.GO120110@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Bean Huo

Hi Cyrille,

On Mon, Dec 07, 2015 at 03:09:09PM +0100, Cyrille Pitchen wrote:
> Hi all,
> 
> this series of patches adds support to the Atmel QSPI controller available
> on sama5d2 SoCs. It was tested on a sama5d2 xplained ultra board with a 
> Micron n25q128a13 QSPI memory and a at25df321a SPI memory.
> 
> In order to use the Micron memory in its Quad SPI mode, the spi-nor
> framework needed to be patched to fix the support of Quad/Dual SPI
> protocols with some memory manufacturers such as Spansion, Micron and
> Macronix. There are many comments in the source code to explain the
> implementation choices based on the datasheets from memory manufacturers.
> 
> 
> This series was based and tested on linux-next-20151207
> 
> 1 - Atmel QSPI + Micron n25q128a13 (atmel-quadspi.c driver)
> 
> SPI 1-1-1: This mode was tested replacing SPI_NOR_QUAD by SPI_NOR_FAST as
>            argument to spi_nor_scan() called from atmel_qspi_probe().
> 
> SPI 1-1-4: Bootloaders (at91bootstrap/uboot) don't enable the Quad SPI
>            mode of the Micron memory. When probed from Linux, the memory
>            uses its Extended SPI mode and replies to the regular Read ID
>            (0x9f) command.
> 
> SPI 4-4-4: The romcode enabled the Quad SPI mode the of Micron memory
>            before loading the at91bootstrap. When probed from Linux, the
>            memory uses its Quad SPI mode and no longer replies to the
>            regular Read ID (0x9f) command but instead to the Read ID
>            Multiple I/O (0xaf) command. The memory expects ALL commands
>            to use the SPI 4-4-4 protocol.

I'll admit I'm a little fuzzy on the differences between dual and quad
modes on various flash manufacturers. Can you help clear it up for me?
I think some of the comments on patch 2 help too, but I'll just comment
here for now.

It looks like the current driver has problems regarding the non 1-x-y
modes (e.g., 4-4-4), right? But I see that spi-nor.c never tries to
send a 4_4_4 command; it only sets read_opcode to
SPINOR_OP_READ_1_1_{1,2,4}. So is this an oversight in patches like
Bean's patch?

    commit 548cd3ab54da ("mtd: spi-nor: Add quad I/O support for Micron
    SPI NOR")

Why would we even need to enable quad modes like that, if we're not
going to send the 4-4-4 opcodes?

My next question (if my understanding is roughly correct) is, do we need
the 4-4-4 modes, and what risks come with them? I understand we can
shorten the command and address phases, but does that alone yield much
performance benefit? And I think the risk is that a given system might
not be prepared for the flash to be in a 4-4-4 mode, if the boot code
tries to use 1-x-y commands.

Also, I see a lot of good comments in patch 2 about Spansion vs.
Macronix vs. Micron memories. I wonder if previous developers have
completely tested their patches, or if they're just reading the
datasheets... so, what kind have testing have you done? Do you have
samples of all these flash to test?

Regards,
Brian
