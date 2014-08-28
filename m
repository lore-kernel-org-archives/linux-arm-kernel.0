From: horms@verge.net.au (Simon Horman)
Date: Fri, 29 Aug 2014 08:30:06 +0900
Subject: [PATCH 11/14] arm64: dts: Add initial device tree support for
 EXYNOS7
In-Reply-To: <CAOesGMhsayvhBK_gVgzB3+69YC1Ca6hsBHsONJm_QEcSKpVZOw@mail.gmail.com>
References: <1409132660-1898-1-git-send-email-ch.naveen@samsung.com>
 <1409132660-1898-3-git-send-email-ch.naveen@samsung.com>
 <20140828035639.GB4972@localhost>
 <20140828094846.GD14650@leverpostej>
 <CAOesGMjY8wfAcq2fLgs=ZWHdiWtFqxr+ncUKTje0SnXqO-CCgQ@mail.gmail.com>
 <20140828170306.GQ14650@leverpostej>
 <CAOesGMgYeFObKHA9znzBq9t2mLv8WWT1QaKugQ6yf7RgV09Qyg@mail.gmail.com>
 <CAL_JsqLVsjJVL+GoJVMoXGiGxVKSh0oyJ-nwKEkXfa+fWid7yA@mail.gmail.com>
 <CAOesGMhsayvhBK_gVgzB3+69YC1Ca6hsBHsONJm_QEcSKpVZOw@mail.gmail.com>
Message-ID: <20140828233006.GC16165@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 28, 2014 at 03:23:49PM -0700, Olof Johansson wrote:
> On Thu, Aug 28, 2014 at 10:54 AM, Rob Herring <robh@kernel.org> wrote:
> > On Thu, Aug 28, 2014 at 12:19 PM, Olof Johansson <olof@lixom.net> wrote:
> >> On Thu, Aug 28, 2014 at 10:03 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> >>> On Thu, Aug 28, 2014 at 05:28:22PM +0100, Olof Johansson wrote:
> >>>> On Thu, Aug 28, 2014 at 2:48 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> >>>> > Hi,
> >>>> >
> >>>> >> > +   cpus {
> >>>> >> > +           #address-cells = <2>;
> >>>> >> > +           #size-cells = <0>;
> >>>> >>
> >>>> >> Why size-cells=2? Can you not fit a cpuid in 32 bits?
> >>>> >
> >>>> > As of commit 72aea393a2e7 (arm64: smp: honour #address-size when parsing
> >>>> > CPU reg property) Linux can handle single-cell cpu node reg entries
> >>>> > where /cpus/#address-cells = <1>.
> >>>> >
> >>>> > I can't make any guarantees about other code (e.g. bootloaders) which
> >>>> > might try to do things with cpu nodes, YMMV.
> >>>>
> >>>> Ok. If address-cells is kept at 2 the unit address needs to be changed
> >>>> to "0,0". So one or the other has to be changed.
> >>>
> >>> I'm happy either way.
> >>>
> >>> I'm not sure the rest of the tree had "0," prefixes on all of the
> >>> unit-addresses for 64-bit addresses that were under 4GB, and I'm not
> >>> sure that existing dts consistently do that either.
> >>>
> >>> Do we want to enforce that for all 64-bit unit-addresses?
> >>
> >> Yeah, I believe that's the only valid format for a 2-address-cell unit address.
> >
> > But we don't do leading 0's anywhere else like single cell unit
> > addresses. Buses expressed with ranges and offsets are one example.
> > Also, I2C addresses have a 32-bit size in DT yet are only 8-bit and we
> > don't do leading zero's there.
> 
> Ok, I'm happily proven wrong here, also by confirming how this is done
> on "real" OF.
> 
> According to benh:
> 
> 15:20 <benh> ojn: 0,0 is not quite right, it's supposed to be used
> when the two numbers are different things, like device,fn on PCI
> 
> The same is true for >2^32 unit addresses, they just use the one
> integer instead of x,y.
> 
> So, I take back all I've said on this in the last 72 hours. :) It
> looks like we might need to revisit some of the 32-bit DTs.  Simon,
> drop the series you had. :)

Thanks will do.

Is the way forward for me to apply my original patch to
change memory at 180000000 to memory at 140000000? And abandon all
the ',' only changes?This one:

This is the original patch:

From: Simon Horman <horms+renesas@verge.net.au>

[PATCH] ARM: shmobile: lager: correct memory map

The base address of the second memory region on the lager
board is 0x140000000. Update the tag used in the dts file accordingly.

This is a documentation fix and should have no run-time affect.

This problem was introduced when the second memory region
was added to the lager dts file by 62bc32a2573c4219
("ARM: shmobile: Include all 4 GiB of memory on Lager)"
in v3.14.

Reported-by: NAOYA SHIIBA <naoya.shiiba.nx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 0118cbf..84dcafa 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -32,7 +32,7 @@
 		reg = <0 0x40000000 0 0x40000000>;
 	};
 
-	memory at 180000000 {
+	memory at 140000000 {
 		device_type = "memory";
 		reg = <1 0x40000000 0 0xc0000000>;
 	};
-- 
2.0.1
