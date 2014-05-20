From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 20 May 2014 22:55:26 +0200
Subject: [PATCH 2/2] ARM: sun6i: Add MMC0 controller to the Colombus board
In-Reply-To: <1400600866-29938-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1400600866-29938-1-git-send-email-maxime.ripard@free-electrons.com>
 <1400600866-29938-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <537BC13E.4080901@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 05/20/2014 05:47 PM, Maxime Ripard wrote:
> The Colombus has a full size SD slot wired to the MMC0 controller. In order to
> work, the MMC lines have to have the pull-ups enabled though.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>   arch/arm/boot/dts/sun6i-a31-colombus.dts | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun6i-a31-colombus.dts b/arch/arm/boot/dts/sun6i-a31-colombus.dts
> index 3898a7bce831..e2cf2f3646bf 100644
> --- a/arch/arm/boot/dts/sun6i-a31-colombus.dts
> +++ b/arch/arm/boot/dts/sun6i-a31-colombus.dts
> @@ -13,6 +13,7 @@
>
>   /dts-v1/;
>   /include/ "sun6i-a31.dtsi"
> +/include/ "sunxi-common-regulators.dtsi"
>
>   / {
>   	model = "WITS A31 Colombus Evaluation Board";
> @@ -23,6 +24,32 @@
>   	};
>
>   	soc at 01c00000 {
> +		mmc0: mmc at 01c0f000 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&mmc0_pins_colombus>, <&mmc0_cd_pin_colombus>;
> +			vmmc-supply = <&reg_vcc3v0>;
> +			bus-width = <4>;
> +			cd-gpios = <&pio 0 8 0>; /* PA8 */
> +			cd-inverted;
> +			status = "okay";
> +		};
> +
> +		pio: pinctrl at 01c20800 {
> +			mmc0_pins_colombus: mmc0 at 0 {
> +				allwinner,pins = "PF0","PF1","PF2","PF3","PF4","PF5";
> +				allwinner,function = "mmc0";
> +				allwinner,drive = <2>;
> +				allwinner,pull = <1>;
> +			};

You could just use mmc0_pins_a here and only set allwinner,pull.

Other then that both patches are:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans
