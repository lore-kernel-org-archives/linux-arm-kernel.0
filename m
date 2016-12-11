From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 11 Dec 2016 11:26:34 +0100
Subject: [PATCH v1] watchdog: imx2: fix hang-up on boot for i.MX21,
 i.MX27 and i.MX31 SoCs
In-Reply-To: <d6d987f1-3461-214a-0ca1-16d310ddd370@mleia.com>
References: <20161211010648.6591-1-vz@mleia.com>
 <20161211093519.xrxxhrqpc7fmadfr@pengutronix.de>
 <d6d987f1-3461-214a-0ca1-16d310ddd370@mleia.com>
Message-ID: <20161211102634.jn3awmlzdrm3pqai@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Vladimir,

On Sun, Dec 11, 2016 at 12:01:08PM +0200, Vladimir Zapolskiy wrote:
> On 12/11/2016 11:35 AM, Uwe Kleine-K?nig wrote:
> > On Sun, Dec 11, 2016 at 03:06:48AM +0200, Vladimir Zapolskiy wrote:
> >> Power down counter enable/disable bit switch is located in WMCR
> >> register, but watchdog controllers found on legacy i.MX21, i.MX27 and
> >> i.MX31 SoCs don't have this register. As a result of writing data to
> >> the non-existing register on driver probe the SoC hangs up, to fix the
> >> problem add more OF compatible strings and on this basis get
> >> information about availability of the WMCR register.
> >>
> >> Fixes: 5fe65ce7ccbb ("watchdog: imx2_wdt: Disable power down counter on boot")
> >> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> >> ---
> 
> [snip]
> 
> >>  
> >>  static const struct of_device_id imx2_wdt_dt_ids[] = {
> >> -	{ .compatible = "fsl,imx21-wdt", },
> >> +	{ .compatible = "fsl,imx21-wdt", .data = IMX2_WDT_NO_WMCR },
> >> +	{ .compatible = "fsl,imx25-wdt",  },
> >> +	{ .compatible = "fsl,imx27-wdt", .data = IMX2_WDT_NO_WMCR },
> >> +	{ .compatible = "fsl,imx31-wdt", .data = IMX2_WDT_NO_WMCR },
> >> +	{ .compatible = "fsl,imx35-wdt",  },
> >> +	{ .compatible = "fsl,imx50-wdt",  },
> >> +	{ .compatible = "fsl,imx51-wdt",  },
> >> +	{ .compatible = "fsl,imx53-wdt",  },
> >> +	{ .compatible = "fsl,imx6q-wdt",  },
> >> +	{ .compatible = "fsl,imx6sl-wdt", },
> >> +	{ .compatible = "fsl,imx6sx-wdt", },
> >> +	{ .compatible = "fsl,imx6ul-wdt", },
> >> +	{ .compatible = "fsl,imx7d-wdt",  },
> >> +	{ .compatible = "fsl,vf610-wdt",  },
> > 
> > Up to now we only had fsl,imx21-wdt, now it seems that iMX31, i.MX27 and
> > i.MX21 form a group of equal watchdog IPs and the others form another
> > group, right?
> > 
> > So conceptually we should differenciate between
> > 
> > 	fsl,imx21-wdt (which is used on i.MX21, i.MX27 and i.MX31)
> > 	fsl,imx35-wdt (which is used on all others)
> > 
> 
> The problem is that "fsl,imx35-wdt" is not used on all others in the
> existing DTS, i.e. in the old firmware, which shall be compatible with
> new changes.

So old i.MX53 has

	compatible = "fsl,imx53-wdt", "fsl,imx21-wdt";

. With the change to the driver it's like using the watchdog driver in
it's pre-5fe65ce7ccbb4-state on it. If this is bad, we must indeed make
fsl,imx53-wdt known to the driver. If not, just adding a single new
compatible to the driver is just fine.

If you want to call it imx25 or imx35 doesn't matter much. The reason I
picked imx35 is that this one was already picked before for cspi. This
suggests that i.MX35 is older than i.MX25 and so this is the canonical
choice.

> $ grep -H 'fsl,imx.*-wdt' arch/arm/boot/dts/*.dtsi
> arch/arm/boot/dts/imx25.dtsi:				compatible = "fsl,imx25-wdt", "fsl,imx21-wdt";
> arch/arm/boot/dts/imx27.dtsi:				compatible = "fsl,imx27-wdt", "fsl,imx21-wdt";
> arch/arm/boot/dts/imx35.dtsi:				compatible = "fsl,imx35-wdt", "fsl,imx21-wdt";
> arch/arm/boot/dts/imx50.dtsi:				compatible = "fsl,imx50-wdt", "fsl,imx21-wdt";
> arch/arm/boot/dts/imx51.dtsi:				compatible = "fsl,imx51-wdt", "fsl,imx21-wdt";
> arch/arm/boot/dts/imx51.dtsi:				compatible = "fsl,imx51-wdt", "fsl,imx21-wdt";
> arch/arm/boot/dts/imx53.dtsi:				compatible = "fsl,imx53-wdt", "fsl,imx21-wdt";
> arch/arm/boot/dts/imx53.dtsi:				compatible = "fsl,imx53-wdt", "fsl,imx21-wdt";
> arch/arm/boot/dts/imx6qdl.dtsi:				compatible = "fsl,imx6q-wdt", "fsl,imx21-wdt";
> arch/arm/boot/dts/imx6qdl.dtsi:				compatible = "fsl,imx6q-wdt", "fsl,imx21-wdt";
> arch/arm/boot/dts/imx6sl.dtsi:				compatible = "fsl,imx6sl-wdt", "fsl,imx21-wdt";
> arch/arm/boot/dts/imx6sl.dtsi:				compatible = "fsl,imx6sl-wdt", "fsl,imx21-wdt";
> arch/arm/boot/dts/imx6sx.dtsi:				compatible = "fsl,imx6sx-wdt", "fsl,imx21-wdt";
> arch/arm/boot/dts/imx6sx.dtsi:				compatible = "fsl,imx6sx-wdt", "fsl,imx21-wdt";
> arch/arm/boot/dts/imx6sx.dtsi:				compatible = "fsl,imx6sx-wdt", "fsl,imx21-wdt";
> arch/arm/boot/dts/imx6ul.dtsi:				compatible = "fsl,imx6ul-wdt", "fsl,imx21-wdt";
> arch/arm/boot/dts/imx6ul.dtsi:				compatible = "fsl,imx6ul-wdt", "fsl,imx21-wdt";
> arch/arm/boot/dts/imx7s.dtsi:				compatible = "fsl,imx7d-wdt", "fsl,imx21-wdt";
> arch/arm/boot/dts/imx7s.dtsi:				compatible = "fsl,imx7d-wdt", "fsl,imx21-wdt";
> arch/arm/boot/dts/imx7s.dtsi:				compatible = "fsl,imx7d-wdt", "fsl,imx21-wdt";
> arch/arm/boot/dts/imx7s.dtsi:				compatible = "fsl,imx7d-wdt", "fsl,imx21-wdt";
> arch/arm/boot/dts/ls1021a.dtsi:			compatible = "fsl,imx21-wdt";
> arch/arm/boot/dts/vfxxx.dtsi:				compatible = "fsl,vf610-wdt", "fsl,imx21-wdt";
> 
> I don't see a confirmation of the fact that "fsl,imx35-wdt" is the best
> selection, hence definitely "fsl,imx25-wdt" overscores it.

I stated my reason to pick imx35 over imx25 above. Why do yo prefer
imx25?

> > A reason to add e.g. fsl,imx6sl-wdt is that dtbs in the wild use
> > 
> > 	"fsl,imx6sl-wdt", "fsl,imx21-wdt"
> > 
> > . But then I wonder if 
> > 
> > 	5fe65ce7ccbb ("watchdog: imx2_wdt: Disable power down counter on boot")
> > 
> > is that important to justify to add these all.
> 
> About this comment I don't know, you may have better insight about the original
> change. By the way, in barebox you may want to fix the same hang-up, because
> you touch WMCR unconditionally.

Sure.
 
> > Independant of this I'd like to have all dtsi for the newer SoCs changed
> > to get
> > 
> > 	"fsl,imx6sl-wdt", "fsl,imx35-wdt"
> > 
> > and if you really want to add all these compatibles, add a comment that
> > these are really fsl,imx35-wdt and were added to work around broken
> > dtbs.
> 
> No objections, but
> 
> 1) I'd like to see "fsl,imx25-wdt" as a new common compatible, and that's
> what have been proposed and shared in RFC 2/2.

Yeah, I missed that other patch (which was not part of this series).

> 2) Please remind me, why do you ask to drop "fsl,imx21-wdt" from the list?
> 
>      compatible = "fsl,imx6sx-wdt", "fsl,imx25-wdt", "fsl,imx21-wdt";
> 
> The list of compatibles above is valid (from the most specific on the left
> to the most generic on the right), and that compatible property is rightly
> handled in the driver with this change applied. I don't see a need to
> drop "fsl,imx21-wdt".

If the wdt in the i.MX6SX can be operated by the watchdog driver in it's
imx21 mode, you should keep the imx21 entry. If not, you shouldn't.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
