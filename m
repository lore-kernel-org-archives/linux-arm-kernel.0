From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 22 Jul 2013 19:07:15 +0200
Subject: [PATCH v2 6/6] ARM: S3C24XX: Convert s3c2416 and s3c2443 to common
 clock framework
In-Reply-To: <02cf01ce81f3$6777e5f0$3667b1d0$%kim@samsung.com>
References: <201307100057.06061.heiko@sntech.de>
 <201307100100.28992.heiko@sntech.de>
 <02cf01ce81f3$6777e5f0$3667b1d0$%kim@samsung.com>
Message-ID: <2236509.stVfXyPhpt@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 16 of July 2013 16:09:24 Kukjin Kim wrote:
> Heiko St?bner wrote:
> > This converts the mentioned platforms to use the newly introduced
> > driver
> > for the common clock framework for them.
> > 
> > With this the whole legacy clock structure can go away too.
> > 
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> > 
> >  arch/arm/boot/dts/s3c2416-smdk2416.dts  |    7 +
> >  arch/arm/boot/dts/s3c2416.dtsi          |   42 ++
> >  arch/arm/mach-s3c24xx/Kconfig           |   14 +-
> >  arch/arm/mach-s3c24xx/Makefile          |    5 +-
> >  arch/arm/mach-s3c24xx/clock-s3c2416.c   |  171 --------
> >  arch/arm/mach-s3c24xx/clock-s3c2443.c   |  212 ----------
> >  arch/arm/mach-s3c24xx/common-s3c2443.c  |  677
> >  ---------------------------> 
> > ----
> 
> In this case, to use '-D' in format-patch would be better :-)
> 
> >  arch/arm/mach-s3c24xx/common.c          |   18 +-
> >  arch/arm/mach-s3c24xx/common.h          |    8 +
> >  arch/arm/mach-s3c24xx/mach-s3c2416-dt.c |   45 +-
> >  arch/arm/mach-s3c24xx/mach-smdk2416.c   |    9 +-
> >  arch/arm/mach-s3c24xx/mach-smdk2443.c   |    9 +-
> >  12 files changed, 102 insertions(+), 1115 deletions(-)
> >  delete mode 100644 arch/arm/mach-s3c24xx/clock-s3c2416.c
> >  delete mode 100644 arch/arm/mach-s3c24xx/clock-s3c2443.c
> >  delete mode 100644 arch/arm/mach-s3c24xx/common-s3c2443.c
> > 
> > diff --git a/arch/arm/boot/dts/s3c2416-smdk2416.dts
> > b/arch/arm/boot/dts/s3c2416-smdk2416.dts
> > index 59594cf..9caeb89 100644
> > --- a/arch/arm/boot/dts/s3c2416-smdk2416.dts
> > +++ b/arch/arm/boot/dts/s3c2416-smdk2416.dts
> > @@ -19,6 +19,13 @@
> > 
> >  		reg =  <0x30000000 0x4000000>;
> >  	
> >  	};
> > 
> > +	fixed-rate-clocks {
> > +		xti {
> > +			compatible = "samsung,clock-xti";
> > +			clock-frequency = <12000000>;
> > +		};
> > +	};
> > +
> > 
> >  	serial at 50000000 {
> >  	
> >  		status = "okay";
> >  		pinctrl-names = "default";
> > 
> > diff --git a/arch/arm/boot/dts/s3c2416.dtsi
> > b/arch/arm/boot/dts/s3c2416.dtsi
> > index e6555bd..c19d99c 100644
> > --- a/arch/arm/boot/dts/s3c2416.dtsi
> > +++ b/arch/arm/boot/dts/s3c2416.dtsi
> > @@ -8,6 +8,7 @@
> > 
> >   * published by the Free Software Foundation.
> >   */
> > 
> > +#include <dt-bindings/clock/samsung,s3c2443-clock.h>
> > 
> >  #include "s3c24xx.dtsi"
> >  #include "s3c2416-pinctrl.dtsi"
> > 
> > @@ -28,26 +29,53 @@
> > 
> >  		compatible = "samsung,s3c2416-irq";
> >  	
> >  	};
> > 
> > +	clocks: clock-controller at 0x4c000000 {
> 
> +	clock: clock-controller at 0x4c000000 {
> 
> for keeping same format for Samsung stuff...
> 

Also please remove the "0x" from node name.

> > +		compatible = "samsung,s3c2416-clock";
> > +		reg = <0x4c000000 0x40>;
> > +		#clock-cells = <1>;
> > +	};
> > +
> > 
> >  	pinctrl at 56000000 {
> >  	
> >  		compatible = "samsung,s3c2416-pinctrl";
> >  	
> >  	};
> > 
> > +	timer at 51000000 {
> > +		clocks = <&clocks PCLK_PWM>;
> 
> +		clocks = <&clock PCLK_PWM>;
> 
> And I'm not sure using definition PCLK_PWM is better here...

Care to explain your doubts about it? I think this is fine.

Best regards,
Tomasz
