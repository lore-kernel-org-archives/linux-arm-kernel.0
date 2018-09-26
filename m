From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 26 Sep 2018 18:13:02 +0200
Subject: [PATCH] ARM: dts: exynos: Add CD and WP pins to Odroid XU SD card
In-Reply-To: <20180924100453eucas1p2cc67bf2cae5c0d0a031c7ce8d1117529~XTfCSQ2rd1041310413eucas1p2S@eucas1p2.samsung.com>
References: <CGME20180921210332epcas3p423aaeeb84ec3d8a44c5a898949f992e8@epcas3p4.samsung.com>
 <20180921210321.12404-1-krzk@kernel.org>
 <20180924100453eucas1p2cc67bf2cae5c0d0a031c7ce8d1117529~XTfCSQ2rd1041310413eucas1p2S@eucas1p2.samsung.com>
Message-ID: <20180926161302.GA10041@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 24, 2018 at 12:04:52PM +0200, Marek Szyprowski wrote:
> Hi Krzysztof,
> 
> On 2018-09-21 23:03, Krzysztof Kozlowski wrote:
> > Defining card-detect and write-protect GPIO pins in Odroid XU SD Card
> > does not change anything from functional point of view - dw-mmc driver
> > was reading the state from registers.  Adding cd-gpios and wp-gpios
> > properties changes only internal driver behavior to access the pins
> > directly.
> >
> > Add them to DTS only to comprehensively describe the hardware.  Minor
> > benefit is that write-protect pin configuration makes sure that it will
> > be properly pulled up to indicate write access.
> >
> > This also removes debug messages:
> >      dwmmc_exynos 12220000.mmc: No GPIO consumer cd found
> >      dwmmc_exynos 12220000.mmc: No GPIO consumer wp found
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >   arch/arm/boot/dts/exynos5410-odroidxu.dts | 12 +++++++++++-
> >   1 file changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/boot/dts/exynos5410-odroidxu.dts b/arch/arm/boot/dts/exynos5410-odroidxu.dts
> > index a2046f5f998c..dae360f29a47 100644
> > --- a/arch/arm/boot/dts/exynos5410-odroidxu.dts
> > +++ b/arch/arm/boot/dts/exynos5410-odroidxu.dts
> > @@ -525,12 +525,14 @@
> >   
> >   &mmc_2 {
> >   	status = "okay";
> > +	wp-gpios = <&gpm5 0 GPIO_ACTIVE_LOW>;
> > +	cd-gpios = <&gpc2 2 GPIO_ACTIVE_LOW>;
> >   	card-detect-delay = <200>;
> >   	samsung,dw-mshc-ciu-div = <3>;
> >   	samsung,dw-mshc-sdr-timing = <0 4>;
> >   	samsung,dw-mshc-ddr-timing = <0 2>;
> >   	pinctrl-names = "default";
> > -	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus1 &sd2_bus4>;
> > +	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus1 &sd2_bus4 &sd2_wp>;
> 
> IMHO there is no point adding cd-gpios property if CD line is already 
> assigned to this device via respective pin ctrl entry (as special function).
> 
> Handling of WP line is even more controversial imho. Ideally the drivers 
> or mmc core should check somehow if WP line is available or not and act 
> respectively. WP line is not available on uSD card connector so there is 
> no point describing it.

Thanks for comments. In that case I'll add only the pin configuration to
be sure that pin stays pulled up.

Best regards,
Krzysztof

> 
> >   	bus-width = <4>;
> >   	cap-sd-highspeed;
> >   	vmmc-supply = <&ldo21_reg>;
> > @@ -573,6 +575,14 @@
> >   		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> >   		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
> >   	};
> > +
> > +	sd2_wp: sd2-wp {
> > +		samsung,pins = "gpm5-0";
> > +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> > +		/* Pin is floating so pull it up to disable write-protect */
> > +		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> > +		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
> > +	};
> >   };
> >   
> >   &pwm {
> 
> Best regards
> -- 
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
> 
