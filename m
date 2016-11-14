From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 14 Nov 2016 15:41:58 +0000
Subject: [PATCH v2] ARM: at91/dt: add dts file for sama5d36ek CMP board
In-Reply-To: <1478055958-8463-1-git-send-email-wenyou.yang@atmel.com>
References: <1478055958-8463-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <c4449cc3-46c8-8ebb-d484-a0a2337e807b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/11/16 03:05, Wenyou Yang wrote:
> The sama5d36ek CMP board is the variant of sama5d3xek board.
> It is equipped with the low-power DDR2 SDRAM, PMIC ACT8865 and
> some power rail. Its main purpose is used to measure the power
> consumption.
> The difference of the sama5d36ek CMP dts from sama5d36ek dts
> is listed as below.
>  1. The USB host nodes are removed, that is, the USB host is disabled.
>  2. The gpio_keys node is added to wake up from the sleep.
>  3. The LCD isn't supported due to the pins for LCD are conflicted
>     with gpio_keys.
>  4. The adc0 node support the pinctrl sleep state to fix the over
>     consumption on VDDANA.
>
> As said in errata, "When the USB host ports are used in high speed
> mode (EHCI), it is not possible to suspend the ports if no device is
> attached on each port. This leads to increased power consumption even
> if the system is in a low power mode." That is why the the USB host
> is disabled.
>
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> ---
>
> Changes in v2:
>  - Add the pinctrl sleep state for adc0 node to fix the over
>    consumption on VDDANA.
>  - Improve the commit log.
>
>  arch/arm/boot/dts/sama5d36ek_cmp.dts  |  51 +++++++
>  arch/arm/boot/dts/sama5d3xcm_cmp.dtsi | 166 +++++++++++++++++++++
>  arch/arm/boot/dts/sama5d3xmb_cmp.dtsi | 265 ++++++++++++++++++++++++++++++++++
>  3 files changed, 482 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sama5d36ek_cmp.dts
>  create mode 100644 arch/arm/boot/dts/sama5d3xcm_cmp.dtsi
>  create mode 100644 arch/arm/boot/dts/sama5d3xmb_cmp.dtsi
>

[...]

> +	/* Conflict with LCD pins */
> +	gpio_keys {
> +		compatible = "gpio-keys";
> +		status = "okay";
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_gpio_keys>;
> +
> +		pb_user1 {
> +			label = "pb_user1";
> +			gpios = <&pioE 27 GPIO_ACTIVE_HIGH>;
> +			linux,code = <0x100>;
> +			gpio-key,wakeup;

Please replace this with "wakeup-source", I will post patches to fix the
new comers in the mainline. It was cleaned last year.

-- 
Regards,
Sudeep
