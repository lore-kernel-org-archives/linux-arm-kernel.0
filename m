From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 8 Aug 2015 17:35:36 +0200
Subject: [linux-sunxi] [PATCH v2] ARM: dts: sunxi: Add regulators for
 LeMaker BananaPi
In-Reply-To: <1438532305-5884-1-git-send-email-public_timo.s@silentcreek.de>
References: <1438532305-5884-1-git-send-email-public_timo.s@silentcreek.de>
Message-ID: <55C621C8.7040302@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 02-08-15 18:18, Timo Sigurdsson wrote:
> sun7i-a20-bananapi.dts doesn't contain regulator nodes for the AXP209 PMU
> driver, so add them to allow for voltage-scaling with cpufreq-dt.
>
> Signed-off-by: Timo Sigurdsson <public_timo.s@silentcreek.de>

Thanks for doing this, looks good to me:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


p.s.

I've replaced my own patch with this one in my sunxi-wip branch.


> ---
> Changes since v1 (RFC):
>
> - Dropped the changes to the cpufreq operating points and renamed the patch
> accordingly
> - Limited the CPU voltage range so it doesn't exceed the SOC specifications
> ---
>   arch/arm/boot/dts/sun7i-a20-bananapi.dts | 35 ++++++++++++++++++++++++++++----
>   1 file changed, 31 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi.dts b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
> index 9f7b472..74382f3 100644
> --- a/arch/arm/boot/dts/sun7i-a20-bananapi.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
> @@ -92,6 +92,10 @@
>   	status = "okay";
>   };
>
> +&cpu0 {
> +	cpu-supply = <&reg_dcdc2>;
> +};
> +
>   &ehci0 {
>   	status = "okay";
>   };
> @@ -119,13 +123,9 @@
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
> @@ -182,6 +182,33 @@
>   	};
>   };
>
> +#include "axp209.dtsi"
> +
> +&reg_dcdc2 {
> +	regulator-always-on;
> +	regulator-min-microvolt = <1000000>;
> +	regulator-max-microvolt = <1400000>;
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
