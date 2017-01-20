From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 20 Jan 2017 09:12:31 +0100
Subject: [PATCH 2/2] ARM: dts: rockchip: add dts for RK3288-Tinker board
In-Reply-To: <CAJrj+DM5hVsmB_q+P8WPd0z_F1cYcGafyYZHXdX6P=nrqxpFyA@mail.gmail.com>
References: <1484791919-4665-1-git-send-email-eddie.cai@rock-chips.com>
 <40159140.kOHBSj8v8b@phil>
 <CAJrj+DM5hVsmB_q+P8WPd0z_F1cYcGafyYZHXdX6P=nrqxpFyA@mail.gmail.com>
Message-ID: <1831358.CPCqGifkXT@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eddie,

Am Freitag, 20. Januar 2017, 15:10:47 CET schrieb Eddie Cai:
> 2017-01-19 17:58 GMT+08:00 Heiko Stuebner <heiko@sntech.de>:
> > Hi Eddie,
> > 
> > Am Donnerstag, 19. Januar 2017, 10:11:59 CET schrieb Eddie Cai:
> >> This patch add basic support for RK3288-Tinker board. We can boot in to
> >> rootfs with this patch.
> >> 
> >> Signed-off-by: Eddie Cai <eddie.cai@rock-chips.com>
> > 
> > looks good in general, just some small question down below.
> > 
> > [...]
> > 
> >> +     /*
> >> +      * NOTE: vcc_sd isn't hooked up on v1.0 boards where power comes
> >> from
> >> +      * vcc_io directly.  Those boards won't be able to power cycle SD
> >> cards +      * but it shouldn't hurt to toggle this pin there anyway.
> >> +      */
> > 
> > just to clarify, later board will have that pin connected, right?
> 
> Copy from rk3288-evb.dtsi. forgot to delete it. I will remove it in next
> version
> >> +     vcc_sd: sdmmc-regulator {
> >> +             compatible = "regulator-fixed";
> >> +             gpio = <&gpio7 11 GPIO_ACTIVE_LOW>;
> >> +             pinctrl-names = "default";
> >> +             pinctrl-0 = <&sdmmc_pwr>;
> >> +             regulator-name = "vcc_sd";
> >> +             regulator-min-microvolt = <3300000>;
> >> +             regulator-max-microvolt = <3300000>;
> >> +             startup-delay-us = <100000>;
> >> +             vin-supply = <&vcc_io>;
> >> +     };
> >> +};
> > 
> > [...]
> > 
> >> +&hdmi {
> >> +     #address-cells = <1>;
> >> +     #size-cells = <0>;
> >> +     #sound-dai-cells = <0>;
> >> +     ddc-i2c-bus = <&i2c5>;
> >> +     status = "okay";
> >> +     /* Don't use vopl for HDMI */
> >> +     ports {
> >> +             hdmi_in: port {
> >> +                     /delete-node/ endpoint at 1;
> >> +             };
> > 
> > what is the reason for this? You enable both VOPs below and the linux
> > display subsystem should be able to select an appropriate VOP for output
> > just fine on its own. So there should be no reason for capping the hdmi's
> > connection to one of the vops.
> 
> The VOP big support 4k display. is designed for HDMI  4K display. VOP
> little is for other display(eDP, LVDS, Mipi etc)

The hdmi _can_ talk to both vops, which is why it has the connection to both. 
Resolution-limitations and selecting a matching vop should be handled in the 
drm driver I'd think - but you'll need to talk to Mark Yao or some else 
knowledgable in graphics.

The devicetree is about describing the _available_ hardware, not configuring 
how it is supposed to be used ;-) .


Heiko
