From: horms@verge.net.au (Simon Horman)
Date: Wed, 22 May 2013 23:32:04 +0900
Subject: [PATCH 05/11] ARM: shmobile: APE6EVM LAN9220 support
In-Reply-To: <Pine.LNX.4.64.1305171458550.31481@axis700.grange>
References: <1364954906-16014-1-git-send-email-horms+renesas@verge.net.au>
 <1364954906-16014-6-git-send-email-horms+renesas@verge.net.au>
 <Pine.LNX.4.64.1305171458550.31481@axis700.grange>
Message-ID: <20130522143204.GE32012@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 17, 2013 at 03:00:23PM +0200, Guennadi Liakhovetski wrote:
> Hi Simon, Magnus
> 
> On Wed, 3 Apr 2013, Simon Horman wrote:
> 
> > From: Magnus Damm <damm@opensource.se>
> > 
> > Add LAN9220 support to the APE6EVM board using C and DT.
> > At this point the PFC driver lacks DT bindings so to
> > configure the PFC we use PINCTRL in C board code.
> > 
> > Signed-off-by: Magnus Damm <damm@opensource.se>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> >  arch/arm/boot/dts/r8a73a4-ape6evm.dts  |   23 ++++++++++++++++++-
> >  arch/arm/mach-shmobile/board-ape6evm.c |   38 ++++++++++++++++++++++++++++++++
> >  2 files changed, 60 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm.dts b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
> > index 833f703..f603c69 100644
> > --- a/arch/arm/boot/dts/r8a73a4-ape6evm.dts
> > +++ b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
> > @@ -16,7 +16,7 @@
> >  	compatible = "renesas,ape6evm", "renesas,r8a73a4";
> >  
> >  	chosen {
> > -		bootargs = "console=ttySC0,115200 ignore_loglevel";
> > +		bootargs = "console=ttySC0,115200 ignore_loglevel root=/dev/nfs ip=dhcp";
> >  	};
> >  
> >  	memory at 40000000 {
> > @@ -24,8 +24,29 @@
> >  		reg = <0 0x40000000 0 0x40000000>;
> >  	};
> >  
> > +	ape6evm_fixed_3v3: fixedregulator at 0 {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "3V3";
> > +		regulator-min-microvolt = <3300000>;
> > +		regulator-max-microvolt = <3300000>;
> > +		regulator-always-on;
> > +	};
> > +
> >  	lbsc {
> >  		#address-cells = <1>;
> >  		#size-cells = <1>;
> > +
> > +		ethernet at 8000000 {
> > +			compatible = "smsc,lan9118", "smsc,lan9115";
> > +			reg = <0x08000000 0x1000>;
> > +			interrupt-parent = <&irqc1>;
> > +			interrupts = <8 0x4>;
> > +			phy-mode = "mii";
> > +			reg-io-width = <4>;
> > +			smsc,irq-active-high;
> > +			smsc,irq-push-pull;
> > +			vdd33a-supply = <&ape6evm_fixed_3v3>;
> > +			vddvario-supply = <&ape6evm_fixed_3v3>;
> > +		};
> >  	};
> >  };
> 
> The above didn't work in my tests without this:
> 
> diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm.dts 
> b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
> index f603c69..4fb0102 100644
> --- a/arch/arm/boot/dts/r8a73a4-ape6evm.dts
> +++ b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
> @@ -33,8 +33,10 @@
>  	};
>  
>  	lbsc {
> +		compatible = "simple-bus";
>  		#address-cells = <1>;
>  		#size-cells = <1>;
> +		ranges = <0 0 0 0x80000000>;
>  
>  		ethernet at 8000000 {
>  			compatible = "smsc,lan9118", "smsc,lan9115";
> 

Could you please post this as a formal patch and indicate
if you would like it included as a fix in v3.10 or not?

Also, I am curious to know what your tests are.
