From: dianders@chromium.org (Doug Anderson)
Date: Fri, 30 Nov 2012 09:50:19 -0800
Subject: [PATCH] ARM: DTS: CROS5250: Add max77686 device tree support
In-Reply-To: <1354099900-24779-1-git-send-email-a.kesavan@samsung.com>
References: <1354099900-24779-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <CAD=FV=Xfbt25-_JMENLiR+N+oC-vPkjxR8brbqYtt4ZFr-60kw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Abhilash,

Thanks for posting this.  A few comments below based on a diff of
what's ToT in the Chrome OS kernel (and looking at the schematic).



On Wed, Nov 28, 2012 at 2:51 AM, Abhilash Kesavan <a.kesavan@samsung.com> wrote:
> The exynos5250 based chromebooks have a max77686 pmic on i2c channel 0.
> Add support for the pmic in the common cros5250 dts file.
> Tested after enabling cpufreq support for exynos5250 SoC and varying the
> arm frequency/voltage using the userspace governer.
>
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> ---
>  arch/arm/boot/dts/cros5250-common.dtsi |  137 ++++++++++++++++++++++++++++++++
>  1 files changed, 137 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/boot/dts/cros5250-common.dtsi b/arch/arm/boot/dts/cros5250-common.dtsi
> index fddd174..7849824 100644
> --- a/arch/arm/boot/dts/cros5250-common.dtsi
> +++ b/arch/arm/boot/dts/cros5250-common.dtsi
> @@ -24,6 +24,143 @@
>                 samsung,i2c-max-bus-freq = <378000>;
>                 gpios = <&gpb3 0 2 3 0>,
>                         <&gpb3 1 2 3 0>;
> +
> +               max77686 at 09 {
> +                       compatible = "maxim,max77686";
> +                       reg = <0x09>;
> +
> +                       voltage-regulators {
> +                               ldo1_reg: LDO1 {
> +                                       regulator-name = "vdd_alive";
> +                                       regulator-min-microvolt = <1000000>;
> +                                       regulator-max-microvolt = <1000000>;
> +                                       regulator-always-on;
> +                               };
> +
> +                               ldo2_reg: LDO2 {
> +                                       regulator-name = "vdd_micom";
> +                                       regulator-min-microvolt = <1800000>;
> +                                       regulator-max-microvolt = <1800000>;
> +                                       regulator-always-on;
> +                               };

I don't believe this is right.  In the least the name is wrong since
the LDO2 signal from max77686 actually goes to the EC as a signal for
detecting the end of the PMIC power on sequence.  The signal
"vdd_micom" is actually the LDO2 signal from tps65090.

Current Chrome OS kernel tree doesn't have an entry for LDO2 so it is
using whatever the bootloader setup, I believe.

> +
> +                               ldo3_reg: LDO3 {
> +                                       regulator-name = "vdd_rtc";
> +                                       regulator-min-microvolt = <1800000>;
> +                                       regulator-max-microvolt = <1800000>;
> +                                       regulator-always-on;

In Chrome OS kernel tree these don't have names like this and are just
named vdd_ldo3.  While I can see a point to being a little more
specific, it can also be misleading.  This LDO not only provides
"vdd_rtc" but also several other signals (I see it go to VDDQ_PRE1,
VIO of the max77686 itself, ...  Maybe just keep the generic "vdd_do3"
name?

This comment also applies to most of the other definitions.


> +                               };
> +

I see that several regulators that are in Chrome OS's kernel are not
here, like LDO6, LDO11, LDO13, and LDO17.  Can you explain their
absence?


> +                               ldo7_reg: LDO7 {
> +                                       regulator-name = "vdd10_xpll";
> +                                       regulator-min-microvolt = <1100000>;
> +                                       regulator-max-microvolt = <1100000>;

This voltage doesn't match what Chrome OS has.  We have 1.0V.  Do you
have a specific reason for increasing?


> +                                       regulator-always-on;
> +                               };
> +
> +                               ldo8_reg: LDO8 {
> +                                       regulator-name = "vdd10_mipihdmi";
> +                                       regulator-min-microvolt = <1000000>;
> +                                       regulator-max-microvolt = <1000000>;
> +                                       regulator-always-on;
> +                               };
> +
> +                               ldo10_reg: LDO10 {
> +                                       regulator-name = "vdd18_mipihdmi";
> +                                       regulator-min-microvolt = <1800000>;
> +                                       regulator-max-microvolt = <1800000>;
> +                                       regulator-always-on;
> +                               };
> +
> +                               ldo12_reg: LDO12 {
> +                                       regulator-name = "vdd33_usb3";
> +                                       regulator-min-microvolt = <3000000>;
> +                                       regulator-max-microvolt = <3000000>;
> +                                       regulator-always-on;
> +                               };
> +
> +                               ldo14_reg: LDO14 {
> +                                       regulator-name = "vdd18_abb0";
> +                                       regulator-min-microvolt = <1800000>;
> +                                       regulator-max-microvolt = <1800000>;
> +                                       regulator-always-on;
> +                               };
> +
> +                               ldo15_reg: LDO15 {
> +                                       regulator-name = "vdd10_hsic";
> +                                       regulator-min-microvolt = <1000000>;
> +                                       regulator-max-microvolt = <1000000>;
> +                                       regulator-always-on;
> +                               };
> +
> +                               ldo16_reg: LDO16 {
> +                                       regulator-name = "vdd18_hsic";
> +                                       regulator-min-microvolt = <1800000>;
> +                                       regulator-max-microvolt = <1800000>;
> +                                       regulator-always-on;
> +                               };
> +
> +                               buck1_reg: BUCK1 {
> +                                       regulator-name = "vdd_mif";
> +                                       regulator-min-microvolt = <950000>;
> +                                       regulator-max-microvolt = <1300000>;
> +                                       regulator-always-on;
> +                                       regulator-boot-on;
> +                               };
> +
> +                               buck2_reg: BUCK2 {
> +                                       regulator-name = "vdd_arm";
> +                                       regulator-min-microvolt = <850000>;
> +                                       regulator-max-microvolt = <1350000>;
> +                                       regulator-always-on;
> +                                       regulator-boot-on;
> +                               };
> +
> +                               buck3_reg: BUCK3 {
> +                                       regulator-name = "vdd_int";
> +                                       regulator-min-microvolt = <900000>;
> +                                       regulator-max-microvolt = <1200000>;
> +                                       regulator-always-on;
> +                                       regulator-boot-on;
> +                               };
> +
> +                               buck4_reg: BUCK4 {
> +                                       regulator-name = "vdd_g3d";
> +                                       regulator-min-microvolt = <850000>;
> +                                       regulator-max-microvolt = <1300000>;
> +                                       regulator-always-on;
> +                                       regulator-boot-on;
> +                               };
> +
> +                               buck5_reg: BUCK5 {
> +                                       regulator-name = "vdd18_adc";
> +                                       regulator-min-microvolt = <1800000>;
> +                                       regulator-max-microvolt = <1800000>;
> +                                       regulator-always-on;

I see you removed "regulator-boot-on;" compared to ChromeOS kernel.
Can you explain why?

> +                               };
> +
> +                               buck6_reg: BUCK6 {
> +                                       regulator-name = "vdd_bat1";
> +                                       regulator-min-microvolt = <1350000>;
> +                                       regulator-max-microvolt = <1350000>;
> +                                       regulator-always-on;
> +                               };
> +
> +                               buck7_reg: BUCK7 {
> +                                       regulator-name = "vdd_bat2";
> +                                       regulator-min-microvolt = <2000000>;
> +                                       regulator-max-microvolt = <2000000>;
> +                                       regulator-always-on;
> +                               };

buck6 and buck7 aren't in Chrome OS kernel (so just using whatever the
bootloader provided).  Specifying them here is fine (and these values
look correct), but I'm not 100% convinced about the name (similar to
LDOs, these signals go lots of places).

> +
> +                               buck8_reg: BUCK8 {
> +                                       regulator-name = "vdd_emmc";
> +                                       regulator-min-microvolt = <2850000>;
> +                                       regulator-max-microvolt = <2850000>;
> +                                       regulator-always-on;

I see you removed "regulator-boot-on;" compared to ChromeOS kernel.
Can you explain why?

...your voltages look better, though.  :)

> +                               };
> +                       };
> +               };
>         };
>
>         i2c at 12C70000 {
> --
> 1.7.8.6
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
