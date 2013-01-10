From: mporter@ti.com (Matt Porter)
Date: Thu, 10 Jan 2013 15:49:59 -0500
Subject: [RFC PATCH v3 16/16] ARM: dts: add AM33XX SPI support
In-Reply-To: <20130110194653.GA32519@kahuna>
References: <1350566815-409-1-git-send-email-mporter@ti.com>
 <1350566815-409-17-git-send-email-mporter@ti.com>
 <508D1791.1040806@ti.com> <20130110193547.GQ14660@beef>
 <20130110194653.GA32519@kahuna>
Message-ID: <20130110204959.GS14660@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 10, 2013 at 01:46:53PM -0600, Nishanth Menon wrote:
> On 14:35-20130110, Matt Porter wrote:
> > On Sun, Oct 28, 2012 at 05:01:29PM +0530, Sekhar Nori wrote:
> > > On 10/18/2012 6:56 PM, Matt Porter wrote:
> > > > Adds AM33XX SPI support for am335x-bone and am335x-evm.
> > > > 
> > > > Signed-off-by: Matt Porter <mporter@ti.com>
> > > > ---
> > > >  arch/arm/boot/dts/am335x-bone.dts |   17 +++++++++++++++
> > > >  arch/arm/boot/dts/am335x-evm.dts  |    9 ++++++++
> > > >  arch/arm/boot/dts/am33xx.dtsi     |   43 +++++++++++++++++++++++++++++++++++++
> > > >  3 files changed, 69 insertions(+)
> > > > 
> > > > diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
> > > > index 5510979..23edfd8 100644
> > > > --- a/arch/arm/boot/dts/am335x-bone.dts
> > > > +++ b/arch/arm/boot/dts/am335x-bone.dts
> > > > @@ -18,6 +18,17 @@
> > > >  		reg = <0x80000000 0x10000000>; /* 256 MB */
> > > >  	};
> > > >  
> > > > +	am3358_pinmux: pinmux at 44e10800 {
> > > > +		spi1_pins: pinmux_spi1_pins {
> > > > +			pinctrl-single,pins = <
> > > > +				0x190 0x13	/* mcasp0_aclkx.spi1_sclk, OUTPUT_PULLUP | MODE3 */
> > > > +				0x194 0x33	/* mcasp0_fsx.spi1_d0, INPUT_PULLUP | MODE3 */
> > > > +				0x198 0x13	/* mcasp0_axr0.spi1_d1, OUTPUT_PULLUP | MODE3 */
> minor comment:
> doing as a 0x33 is better for both d1, d0 as D0,D1 can be switched between SDI and SDO
> as needed with ti,pindir-d0-out-d1-in

Yes, thanks. Forgot about the new property and feature even though I
told somebody about it yesterday. :)

> > > > +				0x19c 0x13	/* mcasp0_ahclkr.spi1_cs0, OUTPUT_PULLUP | MODE3 */
> > > > +			>;
> > > 
> > > Is there a single pinmux setting that provides SPI functionality on the
> > > bone headers? Or this is specific to a cape you tested with?
> > 
> > No, there are two usable settings for spi1 and one setting for spi0.
> > I'm dropping this from the series since it's specific to how I wired up
> > the homebrew cape I use for spi testing on the Bone. I publish the
> > branch where all these extra "test-specific" patches (that aren't intended
> > to be merged) are at in the cover letter.  Anybody that needs context of
> > how/what worked and was tested can grab them there.
> Possibly dumb question:
> Cant we have pre-usable spi configurations?  Like spi1_configuration1_pins,
> spi2_configuration1_pins, spi0_configuration1_pins? If documented with
> P9 pin names in the bone dts, it saves a bit of effort in looking up
> pad offset when dealing with capes.

Yes, let's introduce these things separately. I plan to reintroduce
patches to fix the incorrect 1-based numbering on many of the AM33xx as
previous ones were dropped...and I think this makes sense on top of
that.

-Matt
> -- 
> Regards,
> Nishanth Menon
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
