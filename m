From: horms@verge.net.au (Simon Horman)
Date: Mon, 1 Dec 2014 09:30:55 +0900
Subject: [PATCH] ARM: shmobile: dts: koelsch: Fix flash partition label
 and size
In-Reply-To: <CAMuHMdUUgCGq0igyJLJcRJitcmUR543O9tx399e+4jZfS4zQUg@mail.gmail.com>
References: <1416960805-15185-1-git-send-email-horms+renesas@verge.net.au>
 <5475CCA5.2020300@cogentembedded.com>
 <20141128002718.GF30850@verge.net.au>
 <CAMuHMdUUgCGq0igyJLJcRJitcmUR543O9tx399e+4jZfS4zQUg@mail.gmail.com>
Message-ID: <20141201003054.GA23212@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 28, 2014 at 09:34:05AM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Fri, Nov 28, 2014 at 1:27 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Wed, Nov 26, 2014 at 03:50:45PM +0300, Sergei Shtylyov wrote:
> >> On 11/26/2014 3:13 AM, Simon Horman wrote:
> >>
> >> >Update the size and names of flash partitions to match the
> >> >expectations of the loader which are as follows:
> 
> Finally I had a closer look at this. Sorry that it took that long.
> 
> >> >"loader"---0x0000_0000-0x0008_0000 [loader program (readonly)]
> >> >"user"  ---0x0008_0000-0x0060_0000 [U-Boot + bootargs + dt + uImage (readonly)]
> >> >"flash" ---0x0060_0000-0x0400_0000 [filesystem and free (read/write)]
> >>
> >> >["user"'s assumed breakdown]
> >> >U-boot+ bootargs(0x0008_0000-0x0010_0000) 512KB
> 
> KiB
> 
> You may want to split this explicitly in 256 KiB for U-boot, and 256 KiB for the
> U-boot bootargs, to help people needing low-level recovery.

Are you suggesting 4 partitions or just an adjustment of the assumption
documented in the changelog?

> >> >Device tree     (0x0010_0000-0x0014_0000) 256KB
> 
> KiB
> 
> >> >uImage          (0x0014_0000-0x0060_0000) 4.75MB
> 
> Not zImage?

I think we can change this documentation without any runtime effect :^)

> 
> MiB
> 
> >> >Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> >>
> >> >---
> >>
> >> >This replaces a patch that I previously posted, "shmobile: koelsch: Fix
> >> >flash partition label and size in device tree", which has the same aim but
> >> >does so for an older version of the loader which to my knowledge is not
> >> >found in the wild.
> 
> Thanks, the new split makes sense to me.

Great!

> >> >I plan to post a similar patch for Lager if this one goes well.
> >>
> >> >I have been informed that the flash layout should also be the same
> >> >for Alt (which currently does not have flash in its dts file in mainline).
> >>
> >> >Based on the renesas-devel-20141125-v3.18-rc6 tag of my renesas tree.
> >> >---
> >> >  arch/arm/boot/dts/r8a7791-koelsch.dts | 12 ++++++------
> >> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >>
> >> >diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
> >> >index 990af16..9a4e714 100644
> >> >--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
> >> >+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
> >> >@@ -451,14 +451,14 @@
> >> >                     reg = <0x00000000 0x00080000>;
> >> >                     read-only;
> >> >             };
> >> >-            partition at 80000 {
> >> >-                    label = "bootenv";
> >> >-                    reg = <0x00080000 0x00080000>;
> >> >+            partition at 40000 {
> >> >+                    label = "user";
> >> >+                    reg = <0x00080000 0x00580000>;
> >>
> >>    The "reg" prop doesn't match the <unit-address> pat of the name.
> 
> It's not the "reg" property that must match the "<unit-addres>", but the
> other way around ;-)
> 
> > Are you suggesting this?
> >
> >                         reg = <0x00080000 0x00600000>;
> 
> No, that would change the size.
> 
> "reg = <0x00080000 ...>" means you must use "... at 80000".

Thanks, got it.

> >> >                     read-only;
> >> >             };
> >> >-            partition at 100000 {
> >> >-                    label = "data";
> >> >-                    reg = <0x00100000 0x03f00000>;
> >> >+            partition at 440000 {
> >> >+                    label = "flash";
> >> >+                    reg = <0x00600000 0x03a00000>;
> >
> > And this?
> >
> >                         reg = <0x00600000 0x04000000>;
> 
> "reg = <0x00600000 ...>" means you must use "... at 600000".
> 
> >>    Likewise.
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 
