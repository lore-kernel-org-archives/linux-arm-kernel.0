From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Wed, 6 Jul 2011 13:48:03 +0200
Subject: [PATCH] Add 'config IMX_NFC_V1_BISWAP' to swap the Bad block
	Indicator, and use for imx27pdk nand support.
In-Reply-To: <4E142B18.60407@televic.com>
References: <1309872828-13942-1-git-send-email-J.Lambrecht@televic.com>
	<20110706080942.GC26347@pengutronix.de>
	<4E142B18.60407@televic.com>
Message-ID: <19988.19315.787284.113228@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Lambrecht J?rgen writes:
> On 07/06/2011 10:09 AM, Sascha Hauer wrote:
> > On Tue, Jul 05, 2011 at 03:33:48PM +0200, J?rgen Lambrecht wrote:
> > > - Swap the BI-byte on position 0x7D0 with a data byte at 0x835.  To 
> > fix a bug
> > >   in Freescale imx NFC v1 SoC's for 2K page NAND flashes: imx27 and 
> > imx31.
> > >   Warning: The same solution needs to be applied to the boot loader 
> > and the
> > >   flash programmer.
> > > - Enable NAND support for the imx27pdk (3ds), and use BISWAP.
> > >
> > > Signed-off-by: J?rgen Lambrecht <J.Lambrecht@televic.com>
> > > ---
> > >  arch/arm/mach-imx/Kconfig         |   30 ++++++++++++++++++++++++++++--
> > >  arch/arm/mach-imx/mach-mx27_3ds.c |   14 ++++++++++++++
> > >  drivers/mtd/nand/mxc_nand.c       |   29 +++++++++++++++++++++++++++++
> > >  3 files changed, 71 insertions(+), 2 deletions(-)
> > >
> > [snip]
> >
> > > +
> > > +config IMX_NFC_V1_BISWAP
> > > +     bool "Make the MXC 2kB-page NAND driver swap the Bad Block 
> > Indicator"
> > > +     depends on MACH_MX27_3DS
> > > +     depends on MTD_NAND_MXC
> > > +     help
> > > +       Enable this if you want that the MXC NAND driver swaps the 
> > Bad Block
> > > +       Indicator (BBI) byte. The IMX NFC v1 (present in IMX27 and 
> > IMX31)
> > > +       contains a bug for 2kB-page flashes: the 2kB page is read out in
> > > +       4x512B chunks, so also the spare area is read out in 4
> > > +       chunks. Therefore the data area and the spare area becomes
> > > +       mixed. This causes a problem for the factory programmed BBI: it
> > > +       appears in the data area instead of the spare area, and is
> > > +       overwritten. This patch swaps that byte to the "real" spare
> > > +       area. WARNING: then also the bootloader and the flash 
> > programmer must
> > > +       be patched!!
> >
> > I don't like this approach. IMO some code should be run on a virgin
> > flash which is aware of this issue and creates a correct bad block
> > table. You run this once and forget about this afterwards and every
> > kernel/bootloader can run without patching. Otherwise if you accidently
> > or intentionally start an older (unpatched) kernel your Nand gets
> > corrupted.
> >
> I see 3 solutions: rely on the quality of the NAND flash driver (1), 
> patch the SW (2) or patch the HW (3).
> 
> 1. A normal NAND flash driver relies on the ECC to detect a 
> (potentially) bad block. But a factory bad block can have more bad bits 
> that the specified ECC bits.
>     Solution is to check after each write if the data was written 
> reliable: a write/read-back policy. (linux kernel option: Device Drivers 
> -> MTD support -> NAND Device Support -> Verify NAND page writes)
>     This will of course slow-down writing a lot.
> 2. The Freescale solution: patch the SW:
>        1. flash programmer
>        2. boot-loader NAND driver
>        3. OS NAND driver
> 3. For the HW patch, a special SW must be written that must be executed 
> before the board is programmed. That special SW must run in RAM and copy 
> the BBI byte to the "swapped" place, so that after swapping, the BBI is 
> at the good place. Then the SW must not be patched.
>     Risk: if this step is skipped, the factory BBI information is lost, 
> and if the SW has no write/read-back policy (solution 1), data will be 
> lost in some point in time.
> 
That's nonsense. You cannot copy a byte inside a page that is not
programmable (that's what Bad Blocks are).
You only need to check the byte in a well known location once and
create a BBT in flash that carries the bad block information. After
that you need not check for any bad block markers any more, but simply
use the BBT.
Since you need to program the bootloader with some external tool
anyway, that tool is the right instance to do the bad block scan and
create the BBT.
That's what we at Ka-Ro are doing since the early days of the i.MX27
for all our i.MX boards.

> Your solution is (3), but for the linux rootfs partition only, using the 
> BBT. Of course bootloader partitions and the linux kernel binary are not 
> written often, but I read (several times, and also been told) that even 
> when only reading a nand flash it can become bad!
> I still have to investigate this for how to solve this in the bootloader..
> 
You are mixing up two different things. The Bad block markers in
certain locations in the OOB area mark 'Factory bad blocks'
i.e. blocks that are already bad when you apply power to the flash for
the first time. The manufacturer guarantees that initial bad blocks
can be detected by checking those locations for a non-FF value.
There is no guarantee that you may be able to write any specific value
to a certain byte in a block that has turned bad due to wearout or
whatever at any later time. Thus bad blocks that appear due to wearout
should be kept track of in the BBT, not by writing any 'bad block
markers' to the defective blocks themselves.

> > Also, my comment above applies here too. You added a 'depends on the
> > board I care of', but usually my kernels have all available boards
> > compiled in. So I can select this option and it will change the
> > behaviour of all boards I might run the kernel on, not only the
> > ones you depend on above.
> Ok, i should then find a better way to do it.
> But, the mxc_nand.c code contains this to protect it: 'if 
> ((mtd->writesize > 512) && nfc_is_v1())'.
> Am I correct that all nfc-v1's have that bug, so only imx27 and imx51?
> The application note we finally got from freescale only mentions "FSL 
> IMX NFC".
>
It's not exactly a bug (which would be possible to get fixed), but an
inherent feature of the controller which handles NAND flash with a
page size larger than 512 byte like it has n pages of 512 byte.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
