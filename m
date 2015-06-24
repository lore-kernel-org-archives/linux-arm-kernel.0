From: tony@atomide.com (Tony Lindgren)
Date: Wed, 24 Jun 2015 03:41:16 -0700
Subject: [PATCH 17/17] ARM: dts: omap4: Use "syscon-otghs" instead of
 "ctrl-module" in USB node
In-Reply-To: <1435060743-5511-18-git-send-email-kishon@ti.com>
References: <1435060743-5511-1-git-send-email-kishon@ti.com>
 <1435060743-5511-18-git-send-email-kishon@ti.com>
Message-ID: <20150624104116.GC4156@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kishon Vijay Abraham I <kishon@ti.com> [150623 05:02]:
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -852,12 +852,6 @@
>  			};
>  		};
>  
> -		omap_control_usbotg: control-phy at 4a00233c {
> -			compatible = "ti,control-phy-otghs";
> -			reg = <0x4a00233c 0x4>;
> -			reg-names = "otghs_control";
> -		};
> -
>  		usb_otg_hs: usb_otg_hs at 4a0ab000 {
>  			compatible = "ti,omap4-musb";
>  			reg = <0x4a0ab000 0x7ff>;
> @@ -870,7 +864,7 @@
>  			multipoint = <1>;
>  			num-eps = <16>;
>  			ram-bits = <12>;
> -			ctrl-module = <&omap_control_usbotg>;
> +			syscon-otghs = <&scm_conf 0x33c>;
>  		};
>  
>  		aes: aes at 4b501000 {

We should still keep a separate entry for the phy in the dtsi
files. And the phy should be a child of the scm_conf area in the
dtsi file.

This is because the scm and usb_otg_hs are separate devices and
can be clocked separately. So the phy driver needs to be a
separate driver to avoid spaghetti code and issues with clocking.

Regards,

Tony
