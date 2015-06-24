From: tony@atomide.com (Tony Lindgren)
Date: Wed, 24 Jun 2015 04:46:03 -0700
Subject: [PATCH 17/17] ARM: dts: omap4: Use "syscon-otghs" instead of
 "ctrl-module" in USB node
In-Reply-To: <558A92A5.5070506@ti.com>
References: <1435060743-5511-1-git-send-email-kishon@ti.com>
 <1435060743-5511-18-git-send-email-kishon@ti.com>
 <20150624104116.GC4156@atomide.com> <558A92A5.5070506@ti.com>
Message-ID: <20150624114602.GE4156@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kishon Vijay Abraham I <kishon@ti.com> [150624 04:23]:
> On Wednesday 24 June 2015 04:11 PM, Tony Lindgren wrote:
> >* Kishon Vijay Abraham I <kishon@ti.com> [150623 05:02]:
> >>--- a/arch/arm/boot/dts/omap4.dtsi
> >>+++ b/arch/arm/boot/dts/omap4.dtsi
> >>@@ -852,12 +852,6 @@
> >>  			};
> >>  		};
> >>
> >>-		omap_control_usbotg: control-phy at 4a00233c {
> >>-			compatible = "ti,control-phy-otghs";
> >>-			reg = <0x4a00233c 0x4>;
> >>-			reg-names = "otghs_control";
> >>-		};
> >>-
> >>  		usb_otg_hs: usb_otg_hs at 4a0ab000 {
> >>  			compatible = "ti,omap4-musb";
> >>  			reg = <0x4a0ab000 0x7ff>;
> >>@@ -870,7 +864,7 @@
> >>  			multipoint = <1>;
> >>  			num-eps = <16>;
> >>  			ram-bits = <12>;
> >>-			ctrl-module = <&omap_control_usbotg>;
> >>+			syscon-otghs = <&scm_conf 0x33c>;
> >>  		};
> >>
> >>  		aes: aes at 4b501000 {
> >
> >We should still keep a separate entry for the phy in the dtsi
> >files. And the phy should be a child of the scm_conf area in the
> >dtsi file.
> >
> >This is because the scm and usb_otg_hs are separate devices and
> >can be clocked separately. So the phy driver needs to be a
> >separate driver to avoid spaghetti code and issues with clocking.
> 
> AFAIK SCM is clocked by L4CFG_L4_GICLK which is either free running or is
> managed automatically by the HW i.e gated when there is no access to the
> CTRL_MODULE_CORE registers.

The point is they are separate devices on the interconnect. And we
don't want to add dependencies between separate devices. And there
is nothing stopping us from starting to idle the SCM module.
 
> Having a separate control-PHY driver only to do a regmap update to SCM is
> unnecessary IMHO.

Not true. The phy driver can be generic and used by multiple platforms.

And the phy driver should be capable of idling the phy separately
independent of the USB module. And the phy driver should be able to
tell the system things like ID pin status, VBUS status and so on.

So to summarize, we are _not_ going to start tinkering with the sycon
registers directly from random device drivers in a separate IO space.

Anything using the syscon registers must implement a driver for some
Linux generic framework such as phy, clock, or regulator framework.

Regards,

Tony
