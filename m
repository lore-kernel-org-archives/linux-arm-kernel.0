From: hechtb@gmail.com (Bastian Hecht)
Date: Mon, 18 Feb 2013 13:34:43 -0600
Subject: [PATCH v3 8/8] ARM: shmobile: completely switch MMC interfaces on
 armadillo800eva-reference to DT
In-Reply-To: <CABYn4sz+EMFB5cb4Uyk17+KfmakRCPOXx7NQkPcQOfvT5DDWYg@mail.gmail.com>
References: <1358959071-2873-1-git-send-email-g.liakhovetski@gmx.de>
 <1358959071-2873-9-git-send-email-g.liakhovetski@gmx.de>
 <CABYn4sz+EMFB5cb4Uyk17+KfmakRCPOXx7NQkPcQOfvT5DDWYg@mail.gmail.com>
Message-ID: <CABYn4sxWpS6K21YNPKEdQ9e3xwbivOKSOs9w2+mLRiuizWmHXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I got out of place by 1 commit in the intc-of branch:
It's "ARM: shmobile: move pin configuration on
armadillo800eva-reference to DT" not "ARM: shmobile: completely switch
MMC interfaces on armadillo800eva-reference to DT" that breaks "make
dtbs".

Thanks,

 Bastian


2013/2/18 Bastian Hecht <hechtb@gmail.com>:
> Hello,
>
> I'm looking for a branch to test out my new SCI DT version on my
> Armadillo. I saw that topic/intc-of features the armadillo-reference
> implementation so I wanted to use that. But "make dtbs" fails with:
>
> Error: arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts:152.2-3
> label or path, 'gpio', not found
> FATAL ERROR: Syntax error parsing input tree
>
> The error is introduced by this commit. I'm unsure if it is the patch
> itself or the branch stacking though.
>
> Thanks,
>
>  Bastian
>
>
> 2013/1/23 Guennadi Liakhovetski <g.liakhovetski@gmx.de>:
>> Switch MMCIF, SDHI0 and SDHI1 to complete DT initialisation: use DT
>> bindings to configure regulators, interface pins, card-detect GPIOs,
>> various interface configuration parameters.
>>
>> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>> ---
>>
>> v3: add missing regulator and SDHI properties
>>
>>  .../boot/dts/r8a7740-armadillo800eva-reference.dts |  107 ++++++++++++++++++++
>>  .../board-armadillo800eva-reference.c              |    5 +-
>>  2 files changed, 109 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
>> index 319af9b..11cb0f9 100644
>> --- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
>> +++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
>> @@ -30,4 +30,111 @@
>>                 sh-eth,register-type = "gigabit";
>>                 sh-eth,phy-id = <0>;
>>         };
>> +
>> +       reg_3p3v: regulator at 0 {
>> +               compatible = "regulator-fixed";
>> +               regulator-name = "fixed-3.3V";
>> +               regulator-min-microvolt = <3300000>;
>> +               regulator-max-microvolt = <3300000>;
>> +               regulator-always-on;
>> +               regulator-boot-on;
>> +       };
>> +
>> +       mmcif0: mmcif at 0xe6bd0000 {
>> +               compatible = "renesas,sh-mmcif", "renesas,sh7372-mmcif";
>> +               reg = <0xe6bd0000 0x100>;
>> +               interrupt-parent = <&intca>;
>> +               interrupts = <0x1ac0 0x1ae0>;
>> +               vmmc-supply = <&reg_3p3v>;
>> +               bus-width = <8>;
>> +               non-removable;
>> +               pinctrl-names = "default";
>> +               pinctrl-0 = <&mmc0_pins>;
>> +       };
>> +
>> +       vcc_sdhi0: regulator at 1 {
>> +               compatible = "regulator-fixed";
>> +
>> +               regulator-name = "vcc-sdhi0";
>> +               regulator-min-microvolt = <3300000>;
>> +               regulator-max-microvolt = <3300000>;
>> +
>> +               gpio = <&gpio 75 0>;
>> +               enable-active-high;
>> +       };
>> +
>> +       vcc_sdhi1: regulator at 2 {
>> +               compatible = "regulator-fixed";
>> +
>> +               regulator-name = "vcc-sdhi1";
>> +               regulator-min-microvolt = <3300000>;
>> +               regulator-max-microvolt = <3300000>;
>> +
>> +               gpio = <&gpio 16 0>;
>> +               enable-active-high;
>> +       };
>> +
>> +       vccq_sdhi0: gpio-regulator at 0 {
>> +               compatible = "regulator-gpio";
>> +
>> +               regulator-name = "vccq-sdhi0";
>> +               regulator-min-microvolt = <1800000>;
>> +               regulator-max-microvolt = <3300000>;
>> +               vin-supply = <&vcc_sdhi0>;
>> +
>> +               enable-gpio = <&gpio 74 0>;
>> +               gpios = <&gpio 17 0>;
>> +               states = <3300000 0
>> +                         1800000 1>;
>> +
>> +               enable-active-high;
>> +       };
>> +
>> +       sdhi0: sdhi at 0xe6850000 {
>> +               compatible = "renesas,shmobile-sdhi";
>> +               reg = <0xe6850000 0x100>;
>> +               interrupt-parent = <&intca>;
>> +               interrupts = <0xe20 0xe40>;
>> +               vmmc-supply = <&vcc_sdhi0>;
>> +               vqmmc-supply = <&vccq_sdhi0>;
>> +               bus-width = <4>;
>> +               cd-gpios = <&gpio 167 1>;
>> +               pinctrl-names = "default";
>> +               pinctrl-0 = <&sdhi0_pins>;
>> +               cap-sd-highspeed;
>> +               cap-power-off-card;
>> +               toshiba,mmc-has-idle-wait;
>> +               toshiba,mmc-cap-sdio-irq;
>> +       };
>> +
>> +       sdhi1: sdhi at 0xe6860000 {
>> +               compatible = "renesas,shmobile-sdhi";
>> +               reg = <0xe6860000 0x100>;
>> +               interrupt-parent = <&intca>;
>> +               interrupts = <0xea0 0xec0>;
>> +               vmmc-supply = <&vcc_sdhi1>;
>> +               bus-width = <4>;
>> +               cd-gpios = <&gpio 72 1>;
>> +               pinctrl-names = "default";
>> +               pinctrl-0 = <&sdhi1_pins>;
>> +               cap-sd-highspeed;
>> +               cap-power-off-card;
>> +               toshiba,mmc-has-idle-wait;
>> +               toshiba,mmc-cap-sdio-irq;
>> +       };
>> +};
>> +
>> +&gpio {
>> +       sdhi0_pins: pfc_sdhi0_pins {
>> +               renesas,pins = "sdhi0_data4", "sdhi0_ctrl", "sdhi0_wp";
>> +               renesas,function = "sdhi0";
>> +       };
>> +       sdhi1_pins: pfc_sdhi1_pins {
>> +               renesas,pins = "sdhi1_data4", "sdhi1_ctrl", "sdhi1_wp";
>> +               renesas,function = "sdhi1";
>> +       };
>> +       mmc0_pins: pfc_mmc0_pins {
>> +               renesas,pins = "mmc0_data8_1", "mmc0_ctrl_1";
>> +               renesas,function = "mmc0";
>> +       };
>>  };
>> diff --git a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
>> index c206612..f929931 100644
>> --- a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
>> +++ b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
>> @@ -107,9 +107,10 @@
>>   */
>>  static void __init eva_init(void)
>>  {
>> -       r8a7740_pinmux_init();
>>         r8a7740_meram_workaround();
>>
>> +       r8a7740_add_standard_devices_dt();
>> +
>>         /* SCIFA1 */
>>         gpio_request(GPIO_FN_SCIFA1_RXD, NULL);
>>         gpio_request(GPIO_FN_SCIFA1_TXD, NULL);
>> @@ -142,8 +143,6 @@ static void __init eva_init(void)
>>         /* Early BRESP enable, Shared attribute override enable, 32K*8way */
>>         l2x0_init(IOMEM(0xf0002000), 0x40440000, 0x82000fff);
>>  #endif
>> -
>> -       r8a7740_add_standard_devices_dt();
>>  }
>>
>>  #define RESCNT2 IOMEM(0xe6188020)
>> --
>> 1.7.2.5
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
