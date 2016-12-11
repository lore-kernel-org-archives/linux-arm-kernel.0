From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 11 Dec 2016 13:28:06 +0100
Subject: [PATCH v1] watchdog: imx2: fix hang-up on boot for i.MX21,
 i.MX27 and i.MX31 SoCs
In-Reply-To: <2fc2558d-fe05-14a7-745e-f71d2178bad6@mleia.com>
References: <20161211010648.6591-1-vz@mleia.com>
 <20161211093519.xrxxhrqpc7fmadfr@pengutronix.de>
 <d6d987f1-3461-214a-0ca1-16d310ddd370@mleia.com>
 <20161211102634.jn3awmlzdrm3pqai@pengutronix.de>
 <2fc2558d-fe05-14a7-745e-f71d2178bad6@mleia.com>
Message-ID: <20161211122806.vee7e7fmkpt4xj77@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 11, 2016 at 01:21:16PM +0200, Vladimir Zapolskiy wrote:
> On 12/11/2016 12:26 PM, Uwe Kleine-K?nig wrote:
> > . With the change to the driver it's like using the watchdog driver in
> > it's pre-5fe65ce7ccbb4-state on it. If this is bad, we must indeed make
> > fsl,imx53-wdt known to the driver. If not, just adding a single new
> > compatible to the driver is just fine.

<sarcasm>You can also add "marvell,armada-xp-wdt" to the end of the
list. If your kernel is configured correctly still the right thing will
happen.</sarcasm>

> The change under discussion preserves the current runtime behaviour for
> i.MX53 and its friends, the watchdog power down counter in WMCR is
> disabled on boot (you may want to confirm it by testing though), another
> question is if it is wanted for e.g. i.MX53 right from the beginning.
> 
> To keep the runtime compatibility of a newer kernel with old DTBs such
> a long list of device compatibles has to be inserted.
> 
> > 
> > If you want to call it imx25 or imx35 doesn't matter much. The reason I
> > picked imx35 is that this one was already picked before for cspi. This
> > suggests that i.MX35 is older than i.MX25 and so this is the canonical
> > choice.
> 
> Accepted, from the Wikipedia both i.MX25 and i.MX35 are released in 2009,
> which one is the first I don't know for sure, I supposed it could be
> i.MX25 as a SoC with a weaker core.
> 
> > 
> >> $ grep -H 'fsl,imx.*-wdt' arch/arm/boot/dts/*.dtsi
> >> arch/arm/boot/dts/imx25.dtsi:				compatible = "fsl,imx25-wdt", "fsl,imx21-wdt";
> >> arch/arm/boot/dts/imx27.dtsi:				compatible = "fsl,imx27-wdt", "fsl,imx21-wdt";
> >> arch/arm/boot/dts/imx35.dtsi:				compatible = "fsl,imx35-wdt", "fsl,imx21-wdt";
> >> arch/arm/boot/dts/imx50.dtsi:				compatible = "fsl,imx50-wdt", "fsl,imx21-wdt";
> >> arch/arm/boot/dts/imx51.dtsi:				compatible = "fsl,imx51-wdt", "fsl,imx21-wdt";
> >> arch/arm/boot/dts/imx51.dtsi:				compatible = "fsl,imx51-wdt", "fsl,imx21-wdt";
> >> arch/arm/boot/dts/imx53.dtsi:				compatible = "fsl,imx53-wdt", "fsl,imx21-wdt";
> >> arch/arm/boot/dts/imx53.dtsi:				compatible = "fsl,imx53-wdt", "fsl,imx21-wdt";
> >> arch/arm/boot/dts/imx6qdl.dtsi:				compatible = "fsl,imx6q-wdt", "fsl,imx21-wdt";
> >> arch/arm/boot/dts/imx6qdl.dtsi:				compatible = "fsl,imx6q-wdt", "fsl,imx21-wdt";
> >> arch/arm/boot/dts/imx6sl.dtsi:				compatible = "fsl,imx6sl-wdt", "fsl,imx21-wdt";
> >> arch/arm/boot/dts/imx6sl.dtsi:				compatible = "fsl,imx6sl-wdt", "fsl,imx21-wdt";
> >> arch/arm/boot/dts/imx6sx.dtsi:				compatible = "fsl,imx6sx-wdt", "fsl,imx21-wdt";
> >> arch/arm/boot/dts/imx6sx.dtsi:				compatible = "fsl,imx6sx-wdt", "fsl,imx21-wdt";
> >> arch/arm/boot/dts/imx6sx.dtsi:				compatible = "fsl,imx6sx-wdt", "fsl,imx21-wdt";
> >> arch/arm/boot/dts/imx6ul.dtsi:				compatible = "fsl,imx6ul-wdt", "fsl,imx21-wdt";
> >> arch/arm/boot/dts/imx6ul.dtsi:				compatible = "fsl,imx6ul-wdt", "fsl,imx21-wdt";
> >> arch/arm/boot/dts/imx7s.dtsi:				compatible = "fsl,imx7d-wdt", "fsl,imx21-wdt";
> >> arch/arm/boot/dts/imx7s.dtsi:				compatible = "fsl,imx7d-wdt", "fsl,imx21-wdt";
> >> arch/arm/boot/dts/imx7s.dtsi:				compatible = "fsl,imx7d-wdt", "fsl,imx21-wdt";
> >> arch/arm/boot/dts/imx7s.dtsi:				compatible = "fsl,imx7d-wdt", "fsl,imx21-wdt";
> >> arch/arm/boot/dts/ls1021a.dtsi:			compatible = "fsl,imx21-wdt";
> >> arch/arm/boot/dts/vfxxx.dtsi:				compatible = "fsl,vf610-wdt", "fsl,imx21-wdt";
> >>
> >> I don't see a confirmation of the fact that "fsl,imx35-wdt" is the best
> >> selection, hence definitely "fsl,imx25-wdt" overscores it.
> > 
> > I stated my reason to pick imx35 over imx25 above. Why do yo prefer
> > imx25?
> 
> As you said right now and until it is added into DTS files "fsl,imx25-wdt" and
> "fsl,imx35-wdt" are equal as a compatible representation of WMCR-aware watchdogs.
> 
> I may be wrong, if I assume that i.MX25 is released before i.MX35 (looks like
> they are released in parallel), but "imx25" precedes in alphanumerically sorted
> list of SoC names.

I'm sure Shawn could say something here, but I would be surprised if the
i.MX25 came first.

> >>> A reason to add e.g. fsl,imx6sl-wdt is that dtbs in the wild use
> >>>
> >>> 	"fsl,imx6sl-wdt", "fsl,imx21-wdt"
> >>>
> >>> . But then I wonder if 
> >>>
> >>> 	5fe65ce7ccbb ("watchdog: imx2_wdt: Disable power down counter on boot")
> >>>
> >>> is that important to justify to add these all.
> >>
> >> About this comment I don't know, you may have better insight about the original
> >> change. By the way, in barebox you may want to fix the same hang-up, because
> >> you touch WMCR unconditionally.
> > 
> > Sure.
> >  
> >>> Independant of this I'd like to have all dtsi for the newer SoCs changed
> >>> to get
> >>>
> >>> 	"fsl,imx6sl-wdt", "fsl,imx35-wdt"
> >>>
> >>> and if you really want to add all these compatibles, add a comment that
> >>> these are really fsl,imx35-wdt and were added to work around broken
> >>> dtbs.
> >>
> >> No objections, but
> >>
> >> 1) I'd like to see "fsl,imx25-wdt" as a new common compatible, and that's
> >> what have been proposed and shared in RFC 2/2.
> > 
> > Yeah, I missed that other patch (which was not part of this series).
> > 
> >> 2) Please remind me, why do you ask to drop "fsl,imx21-wdt" from the list?
> >>
> >>      compatible = "fsl,imx6sx-wdt", "fsl,imx25-wdt", "fsl,imx21-wdt";
> >>
> >> The list of compatibles above is valid (from the most specific on the left
> >> to the most generic on the right), and that compatible property is rightly
> >> handled in the driver with this change applied. I don't see a need to
> >> drop "fsl,imx21-wdt".
> > 
> > If the wdt in the i.MX6SX can be operated by the watchdog driver in it's
> > imx21 mode, you should keep the imx21 entry. If not, you shouldn't.
> 
> The DTS description shall be rather independent from any particular software
> implementation, someone may want to reuse the same DTB in bootloaders and OS
> kernels of different versions.

Full ack.

> Assuming that I have a bootloader/kernel with a pure i.MX21 watchdog
> driver and run it on i.MX6SX, I'd prefer to match
> "fsl,imx21-wdt" compatible.

I'd prefer to notice that the i.MX6SX has a (maybe only slightly)
different watchdog and so the i.MX21 aware driver should not bind to the
i.MX6SX hardware. So (as you said above) the compatible should be
independent from already existing i.MX21 wdt support in a driver.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
