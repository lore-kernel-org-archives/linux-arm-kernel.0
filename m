From: jason@lakedaemon.net (Jason)
Date: Fri, 24 Feb 2012 09:35:17 -0500
Subject: [PATCH 1/2 v5] arm: kirkwood: add dreamplug (fdt) support.
In-Reply-To: <CACxGe6uMcOWC6ukTGF1soyfeTkT2fkmewhKUKA-AiK8hQDzCGQ@mail.gmail.com>
References: <cover.1312906908.git.jason@lakedaemon.net>
 <cover.1330025976.git.jason@lakedaemon.net>
 <1192198e66f9a30eb13fa427240e91fb7f0a49e4.1330025976.git.jason@lakedaemon.net>
 <CACxGe6vjzXUwvGu73p+5L2-cW5EOJtFcR8JW8-gOUrRt-choJg@mail.gmail.com>
 <20120223211138.GP23524@titan.lakedaemon.net>
 <CACxGe6uMcOWC6ukTGF1soyfeTkT2fkmewhKUKA-AiK8hQDzCGQ@mail.gmail.com>
Message-ID: <20120224143517.GQ23524@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 23, 2012 at 02:21:15PM -0700, Grant Likely wrote:
> On Thu, Feb 23, 2012 at 2:11 PM, Jason <jason@lakedaemon.net> wrote:
> > On Thu, Feb 23, 2012 at 01:18:55PM -0700, Grant Likely wrote:
> >> On Thu, Feb 23, 2012 at 12:52 PM, Jason Cooper <jason@lakedaemon.net> wrote:
> >> > Initially, copied guruplug-setup.c and did s/guruplug/dreamplug/g.
> >> > Then, switched to SPI based NOR flash.
> >> >
> >> > After talking to Arnd Bergman, chose an incremental approach to adding
> >> > devicetree support. ?First, we use the dtb to tell us we are on the
> >> > dreamplug, then we gradually port over drivers.
> >> >
> >> > Driver porting will start with the uart (see next patch), and progress
> >> > from there. ?Possibly, spi/flash/partitions will be next.
> >> >
> >> > When done, board-dt.c will no longer be dreamplug specific, and dt's can
> >> > be made for the other kirkwood boards.
> >> >
> >> > Signed-off-by: Jason Cooper <jason@lakedaemon.net>
> >> > ---
> >> > Changes from v1
> >> >
> >> > ? - attempting dts, looking for pointers.
> >> >
> >> > Changes from v2
> >> >
> >> > ? - resubmit as MACH_TYPE_DREAMPLUG (3550) is in arm/for-next, rebased
> >> > ? ? against same.
> >> > ? - removed lame fdt attempt, others are working on kirkwood fdt. ?Will
> >> > ? ? convert once kirkwood fdt is mainline.
> >> > ? - s/boot_params/atag_offset/
> >> > ? - added kirkwood_reset
> >> > ? - 1 checkpatch.pl warning (help in Kconfig), looks the same as all
> >> > ? ? other kirkwood boards...
> >> >
> >> > Changes from v3
> >> >
> >> > ? - rebased against v3.3-rc3 (recommended by Arnd)
> >> > ? - use devicetree to determine which board we are on
> >> > ? - added patch to configure uart0 from devicetree
> >> >
> >> > Changes from v4
> >> >
> >> > ? - fixed Kconfig logic so user can always see 'Dreamplug' in menuconfig.
> >> > ? - changed 'marvell,dreamplug' to 'globalscale,dreamplug' as suggested by
> >> > ? ? Grant Likely.
> >> > ? - fixed of_machine_is_compatible() logic for calling dreamplug specific
> >> > ? ? init functions.
> >> >
> >> > ?arch/arm/boot/dts/kirkwood-dreamplug.dts | ? 18 +++
> >> > ?arch/arm/boot/dts/kirkwood.dtsi ? ? ? ? ?| ? ?6 +
> >> > ?arch/arm/mach-kirkwood/Kconfig ? ? ? ? ? | ? 14 +++
> >> > ?arch/arm/mach-kirkwood/Makefile ? ? ? ? ?| ? ?1 +
> >> > ?arch/arm/mach-kirkwood/Makefile.boot ? ? | ? ?2 +
> >> > ?arch/arm/mach-kirkwood/board-dt.c ? ? ? ?| ?182 ++++++++++++++++++++++++++++++
> >> > ?6 files changed, 223 insertions(+), 0 deletions(-)
> >> > ?create mode 100644 arch/arm/boot/dts/kirkwood-dreamplug.dts
> >> > ?create mode 100644 arch/arm/boot/dts/kirkwood.dtsi
> >> > ?create mode 100644 arch/arm/mach-kirkwood/board-dt.c
> >> >
> >> > diff --git a/arch/arm/boot/dts/kirkwood-dreamplug.dts b/arch/arm/boot/dts/kirkwood-dreamplug.dts
> >> > new file mode 100644
> >> > index 0000000..765813f
> >> > --- /dev/null
> >> > +++ b/arch/arm/boot/dts/kirkwood-dreamplug.dts
> >> > @@ -0,0 +1,18 @@
> >> > +/dts-v1/;
> >> > +
> >> > +/include/ "kirkwood.dtsi"
> >> > +
> >> > +/ {
> >> > + ? ? ? model = "Globalscale Technologies Dreamplug";
> >> > + ? ? ? compatible = "globalscale,dreamplug", "globalscale,kirkwood";
> >>
> >> Hahaha... okay, more clarification is needed here.
> >>
> >> The compatible property is a list, and the first entry must always be
> >> the exact device model. ?That is why the vendor of the hardware is in
> >> the prefix. ?However, the following entries are a list of devices that
> >> it is 'compatible' with. ?In the case of the top-level compatible
> >> property, we've been using the convention of including a string for
> >> the SoC, and in that case the manufacturer is indeed Marvell.
> >>
> >> Also, *be specific*. ?Kirkwood is a family of processors, not a single
> >> SoC. ?The compatible string should reflect that. ?So, in your case,
> >> compatible should look something like:
> >>
> >> compatible = "globalscale,dreamplug", "marvell,kirkwood-88f6281";
> >
> > ahhh... ok. ?So, my board-dt.c should have:
> >
> > static const char *kirkwood_dt_board_compat[] = {
> > ? ? ? ?"marvell,kirkwood",
> > ? ? ? ?NULL
> > };
> >
> > And then the test to run the dreamplug specific init should be:
> >
> > ? ? ? ?if (of_machine_is_compatible("globalscale,dreamplug"))
> > ? ? ? ? ? ? ? ?dreamplug_init();
> >
> > And then, kirkwood.dtsi:
> >
> > compatible = "marvell,kirkwood";
> >
> > and kirkwood-dreamplug.dts:
> >
> > compatible = "globalscale,dreamplug", "marvell,kirkwood-88f6281-a1";
> >
> >
> > My only question is, should the kirkwood.dtsi have just
> > "marvell,kirkwood", or "marvell,kirkwood","marvell,kirkwood-88f6281-a1"?
> 
> Fix the order.  The list is ordered from most specific to least.
> Also, if the silicon revision can be read out of the SoC at runtime,
> then including the -a1 revision is probably overkill.

With kirkwood, it's able to determine the whole SoC part number (see
arch/arm/mach-kirkwood/common.c:394 kirkwood_id()).  So, the kernel
doesn't need to rely on the devicetree to determine which kirkwood it is
at runtime.

I'll include it as you've recommended.  I'd rather stick with convention
until we can prove we need to do otherwise.

> So, something like the following is fine:
> 
> compatible = "globalscale,dreamplug", "marvell,kirkwood-88f6281",
> "marvell,kirkwood";
> 
> BTW, does the dreamplug have a part number?

Yes, so I'll do in kirkwood-dreamplug.dts:

compatible = "globalscale,dreamplug-003-ds2001",
"globalscale,dreamplug", "marvell,kirkwood-88f6281", "marvell,kirkwood"

Thanks for the help

Jason.
