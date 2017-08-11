From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 11 Aug 2017 11:47:24 +0200
Subject: [PATCH v2 3/5] arm64: dts: rockchip: add tsadc node for rk3328 SoC
In-Reply-To: <903bc8ea-a597-80b9-a2bf-551c1b6288fb@rock-chips.com>
References: <1501833976-1100-1-git-send-email-rocky.hao@rock-chips.com>
 <1ea7dab5-95c9-9d5f-5d4e-4c5a7f2a6254@rock-chips.com>
 <903bc8ea-a597-80b9-a2bf-551c1b6288fb@rock-chips.com>
Message-ID: <9393194.mCcQ07NuDA@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 11. August 2017, 17:45:00 CEST schrieb rocky.hao:
> 
> ? 2017/8/11 14:38, Caesar Wang ??:
> > ? 2017?08?04? 16:06, Rocky Hao ??:
> >> add tsadc needed main information for rk3328 SoC.
> >> 50000Hz is the max clock rate supported by tsadc module.
> >>
> >> Signed-off-by: Rocky Hao <rocky.hao@rock-chips.com>
> >> ---
> >> Change in v2:
> >> - remove gerrit Change-Id
> >>
> >>   arch/arm64/boot/dts/rockchip/rk3328.dtsi | 20 ++++++++++++++++++++
> >>   1 file changed, 20 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi 
> >> b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> >> index db4b2708084d..186fb93fdffd 100644
> >> --- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> >> +++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> >> @@ -308,6 +308,26 @@
> >>           interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
> >>       };
> >> +    tsadc: tsadc at ff250000 {
> >> +        compatible = "rockchip,rk3328-tsadc";
> >> +        reg = <0x0 0xff250000 0x0 0x100>;
> >> +        interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH 0>;
> >> +        rockchip,grf = <&grf>;
> >> +        clocks = <&cru SCLK_TSADC>, <&cru PCLK_TSADC>;
> >> +        clock-names = "tsadc", "apb_pclk";
> >> +        assigned-clocks = <&cru SCLK_TSADC>;
> >> +        assigned-clock-rates = <50000>;
> >> +        resets = <&cru SRST_TSADC>;
> >> +        reset-names = "tsadc-apb";
> >> +        pinctrl-names = "init", "default", "sleep";
> >> +        pinctrl-0 = <&otp_gpio>;
> >> +        pinctrl-1 = <&otp_out>;
> >> +        pinctrl-2 = <&otp_gpio>;
> >> +        #thermal-sensor-cells = <1>;
> > 
> > Only one sensor, so maybe the value should be 0.
> Caesar, #thermal-sensor-cells means parameter counts used to match the 
> proper sensor registered. Both 0 and 1 work well.
> 
> Case 0, i.e. #thermal-sensor-cells = <0>, it uses the default channel 
> number 0 to match tsadc channal.
> Case 1, i.e. #thermal-sensor-cells = <1>, it uses the setting 
> "thermal-sensors = <&tsadc 0>;" to match tsadc channal.
> 
> Case 1 provides more readable info than case 0. By my understanding, 
> using the default value such as case 0, is not a good coding style.

Also, the binding for the tsadc controller specifies
	#thermal-sensor-cells: 1

And the IP block in general can of course handle multiple channels,
so it should also stay that way in the dts.


Heiko

> > 
> >> +        rockchip,hw-tshut-temp = <100000>;
> >> +        status = "disabled";
> >> +    };
> >> +
> >>       saradc: adc at ff280000 {
> >>           compatible = "rockchip,rk3328-saradc", 
> >> "rockchip,rk3399-saradc";
> >>           reg = <0x0 0xff280000 0x0 0x100>;
> > 
> > 
> > 
> > 
> 
> 
> 
