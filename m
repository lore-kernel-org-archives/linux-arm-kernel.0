From: kim.phillips@freescale.com (Kim Phillips)
Date: Fri, 6 Jul 2012 17:56:34 -0500
Subject: [PATCH v2] rtc: snvs: add Freescale rtc-snvs driver
In-Reply-To: <20120706002254.GB20175@S2101-09.ap.freescale.net>
References: <1341416294-3194-1-git-send-email-shawn.guo@linaro.org>
 <20120705182829.d13d6992406e02e1024552e3@freescale.com>
 <20120706002254.GB20175@S2101-09.ap.freescale.net>
Message-ID: <20120706175634.a98fb53a9a1fdf40bd4febb3@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 6 Jul 2012 08:22:56 +0800
Shawn Guo <shawn.guo@linaro.org> wrote:

> On Thu, Jul 05, 2012 at 06:28:29PM -0500, Kim Phillips wrote:
> > On Wed, 4 Jul 2012 23:38:14 +0800
> > Shawn Guo <shawn.guo@linaro.org> wrote:
> > 
> > > +static const struct of_device_id __devinitconst snvs_dt_ids[] = {
> > > +	{ .compatible = "fsl,sec-v4.0-mon-rtc-lp", },
> > 
> > the driver should be compatible with "fsl,sec-v4.0-mon", and its
> > probe function search for "fsl,sec-v4.0-mon-rtc-lp" sub-compatibles
> > (and possibly "fsl,sec-v4.0-mon-rtc-hp" in the future?).
> > 
> So you think snvs is all about rtc (lp and hp), nothing else?  If that

no, I'm aware that it's more than a couple of RTCs.

> is true, it's reasonable to do what you suggested here.  Otherwise, we
> should have a snvs driver be compatible with "fsl,sec-v4.0-mon", and
> this driver should be responsible for populate all the sub-devices of
> snvs, rtc-lp, rtc-hp, and others.  In the latter case, rtc-snvs should
> just stay as it stands right now.

but it doesn't function as it stands right now, at least on Power.
The compatible in the device tree's sec_mon node "fsl,sec-v4.0-mon"
and the driver's "fsl,sec-v4.0-mon-rtc-lp" don't match.  Here are
the device tree changes I used:

diff --git a/arch/powerpc/boot/dts/fsl/qoriq-sec4.2-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-sec4.2-0.dtsi
index 7990e0d..14c933b 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-sec4.2-0.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-sec4.2-0.dtsi
@@ -104,6 +104,14 @@ crypto: crypto at 300000 {
 
 sec_mon: sec_mon at 314000 {
        compatible = "fsl,sec-v4.2-mon", "fsl,sec-v4.0-mon";
+       #address-cells = <1>;
+       #size-cells = <1>;
+       ranges = <0 0x314000 0x1000>;
        reg = <0x314000 0x1000>;
        interrupts = <93 2 0 0>;
+
+       sec_mon_rtc_lp at 34 {
+               compatible = "fsl,sec-v4.2-mon-rtc-lp", "fsl,sec-v4.0-mon-rtc-lp";
+               reg = <0x34 0x58>;
+       };
 };

btw, I don't see any imx6q.dtsi changes.

Kim
