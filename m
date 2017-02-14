From: eddie.cai.linux@gmail.com (Eddie Cai)
Date: Tue, 14 Feb 2017 17:54:41 +0800
Subject: [PATCH V2 2/2] ARM: dts: rockchip: add dts for RK3288-Tinker board
In-Reply-To: <10145131.LBiDzV4T0q@phil>
References: <1486347287-31051-1-git-send-email-eddie.cai@rock-chips.com>
 <1486347287-31051-3-git-send-email-eddie.cai@rock-chips.com>
 <10145131.LBiDzV4T0q@phil>
Message-ID: <CAJrj+DPi591xkHPH+F9KKYqoCjy1d0FrvRoBm-gq=J1-a_CbQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

2017-02-09 7:07 GMT+08:00 Heiko Stuebner <heiko@sntech.de>:
> Hi Eddie
>
> Am Montag, 6. Februar 2017, 10:14:47 CET schrieb Eddie Cai:
>> This patch add basic support for RK3288-Tinker board. We can boot in to
>> rootfs with this patch.
>>
>> Signed-off-by: Eddie Cai <eddie.cai@rock-chips.com>
>> ---
>
> [...]
>
>> +&hdmi {
>> +     #address-cells = <1>;
>> +     #size-cells = <0>;
>> +     #sound-dai-cells = <0>;
>
> why are these needed. More importantly if they are needed, they should be in
> rk3288.dtsi instead and not here.
I will remove it in next version
>
>
>> +     ddc-i2c-bus = <&i2c5>;
>> +     status = "okay";
>> +     /* Don't use vopl for HDMI */
>> +     ports {
>> +             hdmi_in: port {
>> +                     /delete-node/ endpoint at 1;
>> +             };
>> +     };
>
> See comment in previous iteration, about the link to vopl being there in
> hardware and not wanting to use it for hdmi being a driver issue.
> No working around driver issues in the devicetree, so leave the vop <-> hdmi
> links intact please :-)
Sorry, Lost this comment. I will remove it in next version
>
>> +};
>> +
>> +&i2c0 {
>> +     status = "okay";
>> +     clock-frequency = <400000>;
>> +
>> +     rk808: pmic at 1b {
>> +             compatible = "rockchip,rk808";
>> +             reg = <0x1b>;
>> +             interrupt-parent = <&gpio0>;
>> +             interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
>> +             pinctrl-names = "default";
>> +             pinctrl-0 = <&pmic_int &global_pwroff &dvs_1 &dvs_2>;
>> +             dvs-gpios = <&gpio0 11 GPIO_ACTIVE_HIGH>,
>> +                             <&gpio0 12 GPIO_ACTIVE_HIGH>;
>> +
>> +             rockchip,system-power-controller;
>> +             wakeup-source;
>> +             #clock-cells = <1>;
>> +             clock-output-names = "xin32k", "rk808-clkout2";
>> +
>> +             vcc1-supply = <&vcc_sys>;
>> +             vcc2-supply = <&vcc_sys>;
>> +             vcc3-supply = <&vcc_sys>;
>> +             vcc4-supply = <&vcc_sys>;
>> +             vcc6-supply = <&vcc_sys>;
>> +             vcc7-supply = <&vcc_sys>;
>> +             vcc8-supply = <&vcc_io>;
>> +             vcc9-supply = <&vcc_io>;
>> +             vcc10-supply = <&vcc_io>;
>> +             vcc11-supply = <&vcc_sys>;
>> +             vcc12-supply = <&vcc_io>;
>> +             vddio-supply = <&vcc_io>;
>> +
>> +             regulators {
>> +                     vdd_cpu: DCDC_REG1 {
>> +                             regulator-always-on;
>> +                             regulator-boot-on;
>> +                             regulator-min-microvolt = <750000>;
>> +                             regulator-max-microvolt = <1350000>;
>> +                             regulator-name = "vdd_arm";
>> +                             regulator-ramp-delay = <6000>;
>> +                             regulator-state-mem {
>> +                                     regulator-off-in-suspend;
>> +                             };
>> +                     };
>> +
>> +                     vdd_gpu: DCDC_REG2 {
>> +                             regulator-always-on;
>> +                             regulator-boot-on;
>> +                             regulator-min-microvolt = <850000>;
>> +                             regulator-max-microvolt = <1250000>;
>> +                             regulator-name = "vdd_gpu";
>> +                             regulator-ramp-delay = <6000>;
>> +                             regulator-state-mem {
>> +                                     regulator-on-in-suspend;
>> +                                     regulator-suspend-microvolt = <1000000>;
>> +                             };
>> +                     };
>> +
>> +                     vcc_ddr: DCDC_REG3 {
>> +                             regulator-always-on;
>> +                             regulator-boot-on;
>> +                             regulator-name = "vcc_ddr";
>> +                             regulator-state-mem {
>> +                                     regulator-on-in-suspend;
>> +                             };
>> +                     };
>> +
>> +                     vcc_io: DCDC_REG4 {
>> +                             regulator-always-on;
>> +                             regulator-boot-on;
>> +                             regulator-min-microvolt = <3300000>;
>> +                             regulator-max-microvolt = <3300000>;
>> +                             regulator-name = "vcc_io";
>> +                             regulator-state-mem {
>> +                                     regulator-on-in-suspend;
>> +                                     regulator-suspend-microvolt = <3300000>;
>> +                             };
>> +                     };
>> +
>> +                     vcc18_ldo1: LDO_REG1 {
>> +                             regulator-always-on;
>> +                             regulator-boot-on;
>> +                             regulator-min-microvolt = <1800000>;
>> +                             regulator-max-microvolt = <1800000>;
>> +                             regulator-name = "vcc18_ldo1";
>> +                             regulator-state-mem {
>> +                                     regulator-on-in-suspend;
>> +                                     regulator-suspend-microvolt = <1800000>;
>> +                             };
>> +                     };
>> +
>> +                     vcc33_mipi: LDO_REG2 {
>> +                             regulator-always-on;
>> +                             regulator-boot-on;
>> +                             regulator-min-microvolt = <3300000>;
>> +                             regulator-max-microvolt = <3300000>;
>> +                             regulator-name = "vcc33_mipi";
>> +                             regulator-state-mem {
>> +                                     regulator-off-in-suspend;
>> +                             };
>> +                     };
>> +
>> +                     vdd_10: LDO_REG3 {
>> +                             regulator-always-on;
>> +                             regulator-boot-on;
>> +                             regulator-min-microvolt = <1000000>;
>> +                             regulator-max-microvolt = <1000000>;
>> +                             regulator-name = "vdd_10";
>> +                             regulator-state-mem {
>> +                                     regulator-on-in-suspend;
>> +                                     regulator-suspend-microvolt = <1000000>;
>> +                             };
>> +                     };
>> +
>> +                     vcc18_codec: LDO_REG4 {
>> +                             regulator-always-on;
>> +                             regulator-boot-on;
>> +                             regulator-min-microvolt = <1800000>;
>> +                             regulator-max-microvolt = <1800000>;
>> +                             regulator-name = "vcc18_codec";
>> +                             regulator-state-mem {
>> +                                     regulator-on-in-suspend;
>> +                                     regulator-suspend-microvolt = <1800000>;
>> +                             };
>> +                     };
>> +
>> +                     vccio_sd: LDO_REG5 {
>> +                             regulator-min-microvolt = <1800000>;
>> +                             regulator-max-microvolt = <3300000>;
>> +                             regulator-name = "vccio_sd";
>> +                             regulator-state-mem {
>> +                                     regulator-on-in-suspend;
>> +                                     regulator-suspend-microvolt = <3300000>;
>> +                             };
>> +                     };
>> +
>> +                     vdd10_lcd: LDO_REG6 {
>> +                             regulator-always-on;
>> +                             regulator-boot-on;
>> +                             regulator-min-microvolt = <1000000>;
>> +                             regulator-max-microvolt = <1000000>;
>> +                             regulator-name = "vdd10_lcd";
>> +                             regulator-state-mem {
>> +                                     regulator-on-in-suspend;
>> +                                     regulator-suspend-microvolt = <1000000>;
>> +                             };
>> +                     };
>> +
>> +                     vcc_18: LDO_REG7 {
>> +                             regulator-always-on;
>> +                             regulator-boot-on;
>> +                             regulator-min-microvolt = <1800000>;
>> +                             regulator-max-microvolt = <1800000>;
>> +                             regulator-name = "vcc_18";
>> +                             regulator-state-mem {
>> +                                     regulator-on-in-suspend;
>> +                                     regulator-suspend-microvolt = <1800000>;
>> +                             };
>> +                     };
>> +
>> +                     vcc18_lcd: LDO_REG8 {
>> +                             regulator-always-on;
>> +                             regulator-boot-on;
>> +                             regulator-min-microvolt = <1800000>;
>> +                             regulator-max-microvolt = <1800000>;
>> +                             regulator-name = "vcc18_lcd";
>> +                             regulator-state-mem {
>> +                                     regulator-on-in-suspend;
>> +                                     regulator-suspend-microvolt = <1800000>;
>> +                             };
>> +                     };
>> +
>> +                     vcc33_sd: SWITCH_REG1 {
>> +                             regulator-always-on;
>> +                             regulator-boot-on;
>> +                             regulator-name = "vcc33_sd";
>> +                             regulator-state-mem {
>> +                                     regulator-on-in-suspend;
>> +                             };
>> +                     };
>> +
>> +                     vcc33_lan: SWITCH_REG2 {
>> +                             regulator-always-on;
>> +                             regulator-boot-on;
>> +                             regulator-name = "vcc33_lan";
>> +                             regulator-state-mem {
>> +                                     regulator-on-in-suspend;
>> +                             };
>> +                     };
>> +             };
>> +     };
>> +};
>> +
>> +&i2c2 {
>> +     status = "okay";
>> +};
>> +
>> +&i2c5 {
>> +     status = "okay";
>> +};
>> +
>> +&i2s {
>> +     #sound-dai-cells = <0>;
>> +     status = "okay";
>> +};
>> +&vopb {
>> +     status = "okay";
>> +};
>> +
>> +&vopb_mmu {
>> +     status = "okay";
>> +};
>> +
>> +&vopl {
>> +     status = "okay";
>> +     /* Don't use vopl for HDMI */
>> +     vopl_out: port {
>> +             /delete-node/ endpoint at 0;
>> +     };
>
> same here
I will remove it in next version
>
>> +};
>> +
>
>
