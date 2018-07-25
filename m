From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 25 Jul 2018 12:02:34 +0200
Subject: [PATCH v0] arm64: dts: rockchip: add support for ROC-RK3399-PC
 board
In-Reply-To: <87in54ge68.fsf@archiso.i-did-not-set--mail-host-address--so-tickle-me>
References: <1532161826-2537-1-git-send-email-djw@t-chip.com.cn>
 <139327780.KNaNigg5Hs@phil>
 <87in54ge68.fsf@archiso.i-did-not-set--mail-host-address--so-tickle-me>
Message-ID: <2859712.DISUneb7pN@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Levin,

Am Mittwoch, 25. Juli 2018, 05:57:51 CEST schrieb djw at t-chip.com.cn:
> >> +	vcc_vbus_typec0: vcc-vbus-typec0 {
> >> +		compatible = "regulator-fixed";
> >> +		regulator-name = "vcc_vbus_typec0";
> >> +		regulator-always-on;
> >> +		regulator-boot-on;
> >> +		regulator-min-microvolt = <5000000>;
> >> +		regulator-max-microvolt = <5000000>;
> >> +	};
> >> +
> >> +	vcc12v_sys: mp8859-dcdc1 {
> >
> > The mp8859 seems to be an i2c-device, as also shown by the
> > nearly empty mp8859 entry below, so shouldn't this regulator
> > be defined there?
> 
> Question here. Since mp8859 driver is not mainlined yet. Shall I leave
> the regulator here (mp8859 defaults to output 5V) and remove the
> mp8859 from the i2c?

Yep, sounds good ... also please add a comment of sorts that this is
temporary until the mp8859 has its own dt-binding.

> > [...]
> >
> >> +	vcc_hub_en: vcc_hub_en-regulator {
> >> +		compatible = "regulator-fixed";
> >> +		enable-active-high;
> >> +		gpio = <&gpio2 RK_PA4 GPIO_ACTIVE_HIGH>;
> >> +		pinctrl-names = "default";
> >> +		pinctrl-0 = <&hub_rst>;
> >> +		regulator-name = "vcc_hub_en";
> >> +		regulator-always-on;
> >
> > missing vin-supply
> This just comes in need of setting GPIO2_A4 (HUB_RST) to high 
> This dummy regulator should be removed.
> 
> I modify the pinctrl of hub_rst to output high:
> 
>                hub_rst: hub-rst {                                                                                                                 
>                         rockchip,pins = <2 RK_PA4 RK_FUNC_GPIO &pcfg_output_high>;                                                                 
>                };                                                                                                                                 
> 
> and add hub_rst to the pinctrl-0 of vcc5v0_host:
> 
>     vcc5v0_host: vcc5v0-host-regulator {                                                                                                       
>             compatible = "regulator-fixed";                                                                                                    
>             enable-active-high;                                                                                                                
>             gpio = <&gpio1 RK_PA0 GPIO_ACTIVE_HIGH>;                                                                                           
>             pinctrl-names = "default";                                                                                                         
>             pinctrl-0 = <&vcc5v0_host_en &hub_rst>;                                                                                            
>             regulator-name = "vcc5v0_host";                                                                                                    
>             regulator-always-on;                                                                                                               
>             vin-supply = <&vcc_sys>;                                                                                                           
>     };
> 
> Tested show that it works. But is it the recommended way to set this
>  gpio (HUB_RST) high? BTW, vcc5v0_host is the usb host voltage,
>  and HUB_RST needs to set high for the usb hub chip to work.

It seems you can also model usb-hirarchy internals via the devicetree.
I guess for these things like soc-gpios and such. See
Documentation/devicetree/bindings/usb/usb-device.txt

While I don't know if this can handle such reset gpios yet, you
could at least move the pinctrl setting there.


> >> +		reg = <0x66>;
> >> +	};
> >> +
> >> +	fusb1: usb-typec at 22 {
> >> +		compatible = "fcs,fusb302";
> >> +		reg = <0x22>;
> >> +		pinctrl-names = "default";
> >> +		pinctrl-0 = <&fusb1_int>;
> >> +		fcs,int-n = <&gpio1 RK_PA1 GPIO_ACTIVE_HIGH>;
> >
> > mainline binding expects an "interrupts" property not the
> > fcs,int-n from above
> >
> It seems no existing user of fusb302 yet. I take that fcs,int-n
> from the driver code. But I look up the binding doc, and come
> with this result:
> 
>     fusb1: usb-typec at 22 {                                                                                                                      
>             compatible = "fcs,fusb302";                                                                                                        
>             reg = <0x22>;                                                                                                                      
>             pinctrl-names = "default";                                                                                                         
>             pinctrl-0 = <&fusb1_int>;                                                                                                          
>             interrupt-parent = <&gpio1>;                                                                                                       
>             interrupts = <1 IRQ_TYPE_LEVEL_LOW>;                                                                                               
>             status = "okay";                                                                                                                   
>     };                                                                                                                                         

looks good, except please move the interrupt* properties between reg
and pinctrl


Heiko
