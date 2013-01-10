From: mporter@ti.com (Matt Porter)
Date: Thu, 10 Jan 2013 15:26:31 -0500
Subject: [RFC PATCH v3 13/16] ARM: dts: add AM33XX MMC support
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA5AE57@DBDE01.ent.ti.com>
References: <1350566815-409-1-git-send-email-mporter@ti.com>
 <1350566815-409-14-git-send-email-mporter@ti.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA5AE57@DBDE01.ent.ti.com>
Message-ID: <20130110202631.GR14660@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 30, 2012 at 05:33:40AM +0000, AnilKumar wrote:
> On Thu, Oct 18, 2012 at 18:56:52, Porter, Matt wrote:
> > Adds AM33XX MMC support for am335x-bone and am335x-evm.
> > 
> > Signed-off-by: Matt Porter <mporter@ti.com>
> > ---
> >  arch/arm/boot/dts/am335x-bone.dts |    6 ++++++
> >  arch/arm/boot/dts/am335x-evm.dts  |    6 ++++++
> >  arch/arm/boot/dts/am33xx.dtsi     |   27 +++++++++++++++++++++++++++
> >  3 files changed, 39 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
> > index c634f87..5510979 100644
> > --- a/arch/arm/boot/dts/am335x-bone.dts
> > +++ b/arch/arm/boot/dts/am335x-bone.dts
> > @@ -70,6 +70,8 @@
> >  		};
> >  
> >  		ldo3_reg: regulator at 5 {
> > +			regulator-min-microvolt = <1800000>;
> > +			regulator-max-microvolt = <3300000>;
> 
> I think these min & max limits are regulator limits. Are these fields
> required? Add details of these additions. AFAIK fine-tuned (board
> specific) min/max limits should be add here(like mpu and core
> regulator nodes)

This is required as the mmc driver builds the ocr mask from the
regulator range..and won't run without it. However, with the additional
updates since 3.7-rc1 to the am33xx release dts support, this is already
there so you won't see this hunk in v4.

> >  			regulator-always-on;
> >  		};
> >  
> > @@ -78,3 +80,7 @@
> >  		};
> >  	};
> >  };
> > +
> > +&mmc1 {
> > +	vmmc-supply = <&ldo3_reg>;
> > +};
> > diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
> > index 185d632..d63fce8 100644
> > --- a/arch/arm/boot/dts/am335x-evm.dts
> > +++ b/arch/arm/boot/dts/am335x-evm.dts
> > @@ -114,7 +114,13 @@
> >  		};
> >  
> >  		vmmc_reg: regulator at 12 {
> > +			regulator-min-microvolt = <1800000>;
> > +			regulator-max-microvolt = <3300000>;
> 
> =same=

as above.

> 
> >  			regulator-always-on;
> >  		};
> >  	};
> >  };
> > +
> > +&mmc1 {
> > +	vmmc-supply = <&vmmc_reg>;
> > +};
> > diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> > index ab9c78f..26a6af7 100644
> > --- a/arch/arm/boot/dts/am33xx.dtsi
> > +++ b/arch/arm/boot/dts/am33xx.dtsi
> > @@ -234,6 +234,33 @@
> >  			status = "disabled";
> >  		};
> >  
> > +		mmc1: mmc at 48060000 {
> > +			compatible = "ti,omap3-hsmmc";
> > +			ti,hwmods = "mmc1";
> > +			ti,dual-volt;
> > +			ti,needs-special-reset;
> > +			dmas = <&edma 24
> > +				&edma 25>;
> > +			dma-names = "tx", "rx";
> 
> Add status = "disabled" here and "okay" in corresponding
> .dts file

yeah, I originally decided to avoid fixing non-dma related items, but
I'll fix this up in v4 while I'm there...to match the other mmc nodes.

> > +		};
> > +
> > +		mmc2: mmc at 481d8000 {
> > +			compatible = "ti,omap3-hsmmc";
> > +			ti,hwmods = "mmc2";
> > +			ti,needs-special-reset;
> > +			dmas = <&edma 2
> > +				&edma 3>;
> > +			dma-names = "tx", "rx";
> > +			status = "disabled";
> > +		};
> > +
> > +		mmc3: mmc at 47810000 {
> > +			compatible = "ti,omap3-hsmmc";
> > +			ti,hwmods = "mmc3";
> > +			ti,needs-special-reset;
> 
> What about DMA resources for mmc3?
 
DMA resources for mmc3 are "special" in that mmc3 (actually MMC2 due
to the hwmod fortran style numbering) is on the crossbar. Since
dmaengine has no concept of a mux in front of dmac channels, we handle
our mux with h/w specific properties. What this means is that we can't
hardcode DMA resources for mmc3 (MMC2) or any other peripheral that sits
on the crossbar as they aren't a fixed EDMA channel.

Since the only peripheral sitting on mmc3 (or any crossbar based DMA
event) on one of the am33xx boards in wl12xx, I can't provide an example
of how this is done within this series...as wl12xx has no DT support and
can't be used.

However, for testing, I did a simple gpio event driver using a GPIO
instance on the crossbar. This purely an out-of-tree testing thing wired
op on the BeagleBone but it looks like this:

	&edma {
        	ti,edma-xbar-event-map = <32 12>;
	};

	gpevt {
		compatible = "gpevt";
		dmas = <&edma 12>;
		dma-names = "gpioevt";
		gpio-evt = <&gpio3 2 0>;
	};

The first node adds a crossbar event mapping (application-specific)
which maps GPIOEVT2 to EDMA channel 12 (an open channel with no fixed
peripheral use.

The gpevt device node then configures the board specific dma resources.

I don't see any reason to configure board specific dma resources for a
driver that can't use them until the driver is converted to DT...at that
time it makes sense to add mmc3 dma support for the evm and evmsk dts
files.

-Matt

> > +			status = "disabled";
> > +		};
> > +
> >  		wdt2: wdt at 44e35000 {
> >  			compatible = "ti,omap3-wdt";
> >  			ti,hwmods = "wd_timer2";
> > -- 
> > 1.7.9.5
> > 
> > _______________________________________________
> > devicetree-discuss mailing list
> > devicetree-discuss at lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/devicetree-discuss
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
