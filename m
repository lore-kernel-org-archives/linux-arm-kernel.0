From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 6 Oct 2014 14:25:38 +0200
Subject: [PATCH v7 10/11] ARM: at91/dt: add LCD panel description to
 sama5d3xdm.dtsi
In-Reply-To: <20141006110115.GH25202@ulmo>
References: <1412175188-28278-1-git-send-email-boris.brezillon@free-electrons.com>
 <1412175188-28278-11-git-send-email-boris.brezillon@free-electrons.com>
 <20141006110115.GH25202@ulmo>
Message-ID: <20141006142538.76d2df29@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 6 Oct 2014 13:01:16 +0200
Thierry Reding <thierry.reding@gmail.com> wrote:

> On Wed, Oct 01, 2014 at 04:53:07PM +0200, Boris Brezillon wrote:
> [...]
> > diff --git a/arch/arm/boot/dts/sama5d3xdm.dtsi b/arch/arm/boot/dts/sama5d3xdm.dtsi
> [...]
> > +	bl_reg: backlight_regulator {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "backlight-power-supply";
> > +		regulator-min-microvolt = <5000000>;
> > +		regulator-max-microvolt = <5000000>;
> > +		status = "disabled";
> > +	};
> > +
> > +	panel_reg: panel_regulator {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "panel-power-supply";
> > +		regulator-min-microvolt = <3300000>;
> > +		regulator-max-microvolt = <3300000>;
> > +		status = "disabled";
> > +	};
> > +
> > +	backlight: backlight {
> > +		compatible = "pwm-backlight";
> > +		pwms = <&hlcdc_pwm 0 50000 0>;
> > +		brightness-levels = <0 4 8 16 32 64 128 255>;
> > +		default-brightness-level = <6>;
> > +		power-supply = <&bl_reg>;
> > +		status = "disabled";
> > +	};
> 
> Why are these all disabled? Patch 11/11 now needs to enable all of them
> explicitly for each board that uses this display module.

Yes, these nodes should be enabled. I just thought we could include the
xdm dtsi and enable what we really need in the board file, but it
doesn't make any sense...

> 
> > +	panel: panel {
> > +		compatible = "foxlink,fl500wvr00-a0t", "simple-panel";
> 
> "simple-panel" shouldn't be in this list. There's nothing useful a
> driver can do by matching on it.

Sure, I'll remove the "simple-panel" compatible string.

> 
> > +		backlight = <&backlight>;
> > +		power-supply = <&panel_reg>;
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +		status = "disabled";
> > +
> > +		port at 0 {
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +
> > +			panel_input: endpoint at 0 {
> > +				reg = <0>;
> > +				remote-endpoint = <&hlcdc_panel_output>;
> > +			};
> >  		};
> 
> There's no support for OF graphs in simple-panel, so this is unused,
> isn't it?

Actually I use it in my atmel_hlcdc_ouput implementation to figure out
the link between a panel and a device connected on the RGB/DPI bus. 



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
