From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 17 Dec 2015 18:18:57 -0800
Subject: [PATCH linux-next 2/5] mtd: spi-nor: fix Quad SPI mode support
 for Spansion, Micron and Macronix
In-Reply-To: <7f2a084da433f1936a1305dfa30327bc5abc802c.1449494420.git.cyrille.pitchen@atmel.com>
References: <cover.1449494420.git.cyrille.pitchen@atmel.com>
 <7f2a084da433f1936a1305dfa30327bc5abc802c.1449494420.git.cyrille.pitchen@atmel.com>
Message-ID: <20151218021857.GI10460@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 07, 2015 at 03:09:11PM +0100, Cyrille Pitchen wrote:
> This patch reworks the support of Quad and Dual SPI protocols for Micron,
> Spansion and Macronix Quad/Dual capable memories. Indeed, in the best
> case, only Spansion memories are correctly supported by the current
> spi-nor framework.

^^ Ah, so this is what I was struggling with at first. I agree that
Micron looks broken. Quite possibly Macronix too. Unfortunately, I
haven't had great test hardware for some of the quad modes. Especially
not anything that supports generic SPI, and not completely on mainline.

> 1 - Micron:
> When their Quad SPI mode is enabled, Micron spi-nor memories expect all
> commands to use the SPI 4-4-4 protocol. Also when the Dual SPI mode is
> enabled, all commands must use the SPI 2-2-2 protocol.
> 
> Before this patch, the spi-nor framework used to always enable the Quad
> mode when the mode argument of spi_nor_scan() took the value SPI_NOR_QUAD.
> That was not suited with drivers only supporting SPI 1-x-4 protocols but
> not the 4-4-4 (e.g. the m25p80 driver). Also the SPI controller was not
> notified about which SPI protocol to use to transfert command. We cannot
> rely only on the op code: in Extended SPI mode the 0x6b command must use
> the SPI 1-1-4 protocol whereas in Quad SPi mode the SPI 4-4-4 protocol
> must be use instead.
> 
> After this patch, the spi-nor framework uses the result of the
> spi_nor_read_id() function to choose the right SPI protocol to be used.
> If the reg_proto was set to SPI_PROTO_4_4_4, we already know that the Quad
> SPI mode is already enabled and that the SPI controller supports the SPI
> 4-4-4 protocol (otherwise it would have fail to read the JEDEC ID with the
> 0xaf op code). For the very same reason, if the reg_proto was set to
> SPI_PROTO_2_2_2, we already know that the Dual mode is already enabled and
> that the SPI controller supports the SPI 2-2-2 protocol.
> Otherwise we switch back to the Extended SPI protocol, which supports at
> least the Fast Read commands:
> - 1-1-1 (0x0b)
> - Dual Output 1-1-2 (0x3b)
> - Quad Output 1-1-4 (0x6b)
> 
> We also safely set the number of dummy cycles to 8 for Fast Read commands
> through the Volatile Configuration Register (VCR): some drivers (m25p80)
> or SPI controllers only support a number of dummy cycles multiple of 8.
> This number may have previouly been set to an unsupported value by an
> early bootloader or at reset thanks to the Non-Volatile Configuration
> Register.

It's not clear to me how you're being safe with the dummy cycles at all.
It seems like you're introducing new values that may be incompatible
with drivers. That can be OK, but you have to give drivers a chance to
opt-out... Maybe some kind of "host capability" flags?

> Finally the XIP bit is always set in the VCR to disable the Continuous
> Read mode as we don't want to care about mode cycles.
> 
> 2 - Macronix:
> When the QPI mode is enabled, all commands must use the SPI 4-4-4 protocol
> and only the 0xeb op code is supported for Fast Read commands.
> Before this patch, the spi-nor framework used to force the QPI mode but
> used the 0x6b op code for Fast Read commands when the SPI controller
> claims to support Quad SPI mode.
> This patch uses the result of spi_nor_read_id() to guess whether the QPI
> mode is both enable and supported by the SPI controller (otherwise it
> would have failed to read the JEDEC ID with the 0xaf op code).
> When the QPI mode is disabled, Macronix memories still support the
> following Fast Read commands:
> - 1-1-1 (0x0b)
> - Dual Output 1-1-2 (0x3b)
> - Quad Output 1-1-4 (0x6b)
> So if the QPI mode has not already been enabled, there is not need to
> enable it. We also avoid the 0xbb (Dual I/O 1-2-2) and 0xeb (Quad I/O
> 1-4-4) op codes on purpose as we don't want to care about the value to set
> in mode cycles not to enter the Continuous Read (Performance Enhance)
> mode.
> 
> As for Micron memories, the spi-nor framework now safely sets the number
> of dummy cycles to 8 thanks to 2 volatile bits inside the Configuration
> Register.
> 
> 3 - Spansion:
> As for Macronix, we avoid the 0xbb (Dual I/O 1-2-2) and 0xeb (Quad I/O
> 1-4-4) op codes on purpose as we don't want to care about the value to set
> in mode cycles not to enter in the Continuous Read mode.
> 
> Besides, we only care about the Quad Enable bit inside the Configuration
> Register (CR) when using Quad operations. In such a case, we first check
> its state before trying to set it. Now we also notify the user about the
> update of this non-volatile bit.
> 
> We also check the Latency Code (LC) in CR to know the exact number of
> dummy cycles to use when performing a Fast Read operation. Currently only
> the 0x0b, 0x3b and 0x6b op codes are used to perform Fast Read operation
> so the number of dummy cycles is always either 0 or 8. Hence no regression
> should be introduced.
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> ---
>  drivers/mtd/spi-nor/spi-nor.c | 783 +++++++++++++++++++++++++++++++++++++-----
>  include/linux/mtd/spi-nor.h   |  15 +-
>  2 files changed, 699 insertions(+), 99 deletions(-)

That's quite a lot to do in one patch, both in number of lines of code,
and in number of tasks outlined in the commit description. Can this be
broken down at all to be more modular and incremental?

Snipped the rest of the patch for now.

Brian
