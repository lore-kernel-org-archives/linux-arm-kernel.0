From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 27 Jul 2015 10:07:55 +0200
Subject: [linux-sunxi] [RFC] ARM: dts: sunxi: Add regulators and
 board-specific operating points for LeMaker BananaPi
In-Reply-To: <1437960486-2809-1-git-send-email-public_timo.s@silentcreek.de>
References: <1437960486-2809-1-git-send-email-public_timo.s@silentcreek.de>
Message-ID: <55B5E6DB.8020009@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 27-07-15 03:28, Timo Sigurdsson wrote:
> sun7i-a20-bananapi.dts doesn't contain regulator nodes for the AXP209 PMU
> driver, so add them to allow for voltage-scaling with cpufreq-dt. With the
> regulators enabled, we can define board-specific operating points. The defined
> CPU voltages are more conservative (based on the values used by the vendor),
> so they should be more failsafe across all boards of this kind out there.
>
> I'm posting this as RFC as I would like to make a few more remarks and raise
> questions along the way (plus, I'm anything but an experienced developer, so a
> a critical review might help).
>
> I checked the regulator definitions against the schematics released by LeMaker.
> I also compared that to the DT and schematics of Cubiboard 2 and Cubietruck. Of
> course, I also tested the patch on the actual hardware and it works fine for me.
> The CPU voltages are slightly higher than those set in sun7i-a20.dtsi and even
> though they work well for me, I thought it might be safer to use the more
> conservative values used by LeMaker in their old fex file. Would you agree?
> Besides, it it ok to have this in one patch or should it be splitted in two
> (one for the regulators and one for the opp)? Did I miss something important?
>
> Signed-off-by: Timo Sigurdsson <public_timo.s@silentcreek.de>

I've a simular patch here:

https://github.com/jwrdegoede/linux-sunxi/commit/6a30b7d5be6012b81e5e1439a444e41c0ac1afc1

I did not submit this upstream yet as it is part of a series to enable the otg
controller on the bananapi which needs axp-usb-power-supply support for which
the actual powersupply driver changes are still pending.

As you can see other then you adding the cpu operating points are patches are
identical, which is good :)

IMHO we should just stick with the standard operating points unless we know
that there are stability issues with them (such as e.g. on the A10 OlinuxIno Lime).

Regards,

Hans



> ---
>   arch/arm/boot/dts/sun7i-a20-bananapi.dts | 47 +++++++++++++++++++++++++++++---
>   1 file changed, 43 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi.dts b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
> index 9f7b472..2bcbb0e 100644
> --- a/arch/arm/boot/dts/sun7i-a20-bananapi.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
> @@ -92,6 +92,22 @@
>   	status = "okay";
>   };
>
> +&cpu0 {
> +	cpu-supply = <&reg_dcdc2>;
> +	operating-points = <
> +		/* kHz	  uV */
> +		1008000	1450000
> +		960000	1425000
> +		912000	1425000
> +		864000	1350000
> +		720000	1250000
> +		528000	1150000
> +		312000	1100000
> +		144000	1050000
> +		>;
> +	cooling-max-level = <7>;
> +};
> +
>   &ehci0 {
>   	status = "okay";
>   };
> @@ -119,13 +135,9 @@
>   	status = "okay";
>
>   	axp209: pmic at 34 {
> -		compatible = "x-powers,axp209";
>   		reg = <0x34>;
>   		interrupt-parent = <&nmi_intc>;
>   		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> -
> -		interrupt-controller;
> -		#interrupt-cells = <1>;
>   	};
>   };
>
> @@ -182,6 +194,33 @@
>   	};
>   };
>
> +#include "axp209.dtsi"
> +
> +&reg_dcdc2 {
> +	regulator-always-on;
> +	regulator-min-microvolt = <1050000>;
> +	regulator-max-microvolt = <1450000>;
> +	regulator-name = "vdd-cpu";
> +};
> +
> +&reg_dcdc3 {
> +	regulator-always-on;
> +	regulator-min-microvolt = <1000000>;
> +	regulator-max-microvolt = <1400000>;
> +	regulator-name = "vdd-int-dll";
> +};
> +
> +&reg_ldo1 {
> +	regulator-name = "vdd-rtc";
> +};
> +
> +&reg_ldo2 {
> +	regulator-always-on;
> +	regulator-min-microvolt = <3000000>;
> +	regulator-max-microvolt = <3000000>;
> +	regulator-name = "avcc";
> +};
> +
>   &reg_usb1_vbus {
>   	status = "okay";
>   };
>
