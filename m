From: beanhuo@micron.com (=?gb2312?B?QmVhbiBIdW8gu/Sx87HzIChiZWFuaHVvKQ==?=)
Date: Tue, 8 Dec 2015 06:21:00 +0000
Subject: [PATCH linux-next 0/5] mtd: spi-nor: add driver for Atmel QSPI
 controller
In-Reply-To: <20151207193441.GO120110@google.com>
References: <cover.1449494420.git.cyrille.pitchen@atmel.com>
 <20151207193441.GO120110@google.com>
Message-ID: <A765B125120D1346A63912DDE6D8B6310BF53437@NTXXIAMBX02.xacn.micron.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Brian Norris [mailto:computersforpeace at gmail.com]
> Sent: Tuesday, December 08, 2015 3:35 AM
> To: Cyrille Pitchen
> Cc: linux-mtd at lists.infradead.org; nicolas.ferre at atmel.com; marex at denx.de;
> vigneshr at ti.com; linux-kernel at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; devicetree at vger.kernel.org;
> robh+dt at kernel.org; pawel.moll at arm.com; mark.rutland at arm.com;
> ijc+devicetree at hellion.org.uk; galak at codeaurora.org; Bean Huo ???
> (beanhuo)
> Subject: Re: [PATCH linux-next 0/5] mtd: spi-nor: add driver for Atmel QSPI
> controller
> 
> + Bean Huo
> 
> Hi Cyrille,
> 
> On Mon, Dec 07, 2015 at 03:09:09PM +0100, Cyrille Pitchen wrote:
> > Hi all,
> >
> > this series of patches adds support to the Atmel QSPI controller
> > available on sama5d2 SoCs. It was tested on a sama5d2 xplained ultra
> > board with a Micron n25q128a13 QSPI memory and a at25df321a SPI
> memory.
> >
> > In order to use the Micron memory in its Quad SPI mode, the spi-nor
> > framework needed to be patched to fix the support of Quad/Dual SPI
> > protocols with some memory manufacturers such as Spansion, Micron and
> > Macronix. There are many comments in the source code to explain the
> > implementation choices based on the datasheets from memory
> manufacturers.
> >
> >
> > This series was based and tested on linux-next-20151207
> >
> > 1 - Atmel QSPI + Micron n25q128a13 (atmel-quadspi.c driver)
> >
> > SPI 1-1-1: This mode was tested replacing SPI_NOR_QUAD by
> SPI_NOR_FAST as
> >            argument to spi_nor_scan() called from atmel_qspi_probe().
> >
> > SPI 1-1-4: Bootloaders (at91bootstrap/uboot) don't enable the Quad SPI
> >            mode of the Micron memory. When probed from Linux, the
> memory
> >            uses its Extended SPI mode and replies to the regular Read ID
> >            (0x9f) command.
> >
> > SPI 4-4-4: The romcode enabled the Quad SPI mode the of Micron memory
> >            before loading the at91bootstrap. When probed from Linux,
> the
> >            memory uses its Quad SPI mode and no longer replies to the
> >            regular Read ID (0x9f) command but instead to the Read ID
> >            Multiple I/O (0xaf) command. The memory expects ALL
> commands
> >            to use the SPI 4-4-4 protocol.
> 
> I'll admit I'm a little fuzzy on the differences between dual and quad modes on
> various flash manufacturers. Can you help clear it up for me?

For Micron SPI NOR spi quad mode, means that Qaud I/O prototocol, it follows I/O
Bus width is command-address-Data 4-4-4, at this time, DQ0,DQ1,DQ2,DQ3
are all used to transfer address/command/data. For this maybe not the same between
different flash manufactures. For example, for Spansion Qspi NOR, its all instructions are
transferred from host to memory as a single bit serial sequence on the DQ0 signal, even under
Quad mode.  Dual mode the same as Qaud mode scenario.

for SPI NOR 1-1-4, means command and address are transferred on the DQ0,
but for data, being transferred on DQ0,DQ1,DQ2,DQ3.For this, it is the same
between different flash manufacturers. Of course, at this moment, SPI NOR
should work under extended I/O mode.

> I think some of the comments on patch 2 help too, but I'll just comment here
> for now.
> It looks like the current driver has problems regarding the non 1-x-y modes
> (e.g., 4-4-4), right? But I see that spi-nor.c never tries to send a 4_4_4
> command; it only sets read_opcode to SPINOR_OP_READ_1_1_{1,2,4}. So is
> this an oversight in patches like Bean's patch?

For SPINOR_OP_READ_1_1_{1,2,4} commands, Spi NOR actually works under
Extended I/O mode, not Quad mode. They just push Spi NOR output data by Quad mode,
Command and address still following extended I/O mode.
For 4-4-4 I/O protocol, SPI NOR should change to Quad mode(just as my patch), 
of course, SPI controller should support this. for Micron Qspi NOR, under quad mode,
all commands/address/data are transferred on DQ0,DQ1,DQ2,DQ3 signals. No matter what
kind of command. 


>     commit 548cd3ab54da ("mtd: spi-nor: Add quad I/O support for Micron
>     SPI NOR")
> 
> Why would we even need to enable quad modes like that, if we're not going
> to send the 4-4-4 opcodes?
I think, in order to high speed SPI NOR, after enable quad mode, 
SPINOR_OP_READ_1_1_{1,2,4} commands don't need any more, normal read command (0x03)
Can implement as them.

> My next question (if my understanding is roughly correct) is, do we need the
> 4-4-4 modes, and what risks come with them? I understand we can shorten
> the command and address phases, but does that alone yield much
> performance benefit? And I think the risk is that a given system might not be
> prepared for the flash to be in a 4-4-4 mode, if the boot code tries to use 1-x-y
> commands.

As far as my current experience and knowledge, this still need to be enabled, especially for
fast boot, and some IOT devices to store info into SPI NOR.
For this patches, my current concern is that host side how to get different I/O protocol changes,
and distinguish between different flash manufacturers I/O mode.

> Also, I see a lot of good comments in patch 2 about Spansion vs.
> Macronix vs. Micron memories. I wonder if previous developers have
> completely tested their patches, or if they're just reading the datasheets... so,
> what kind have testing have you done? Do you have samples of all these flash
> to test?
> Regards,
> Brian
