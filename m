From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Wed, 13 Aug 2014 20:06:24 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCA0LzRdIEFSTTogZHRzOiBrZXlzdG9uZS1rMmhrOiBhZGQg?=
 =?UTF-8?B?ZHNwIGdwaW8gY29udHJvbGxlcnMgbm9kZXM=?=
In-Reply-To: <1407946582-20927-5-git-send-email-grygorii.strashko@ti.com>
References: <1407946582-20927-1-git-send-email-grygorii.strashko@ti.com>
 <1407946582-20927-5-git-send-email-grygorii.strashko@ti.com>
Message-ID: <1407945984.545232249@f170.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wed, 13 Aug 2014 19:16:22 +0300 ?? Grygorii Strashko <grygorii.strashko@ti.com>:
> Add Keystone 2 DSP GPIO nodes.
> DSP GPIO banks 0-7 correspond to DSP0-DSP7
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>  arch/arm/boot/dts/k2hk.dtsi |   56 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/k2hk.dtsi b/arch/arm/boot/dts/k2hk.dtsi
> index 321ba2f..009e180 100644
> --- a/arch/arm/boot/dts/k2hk.dtsi
> +++ b/arch/arm/boot/dts/k2hk.dtsi
> @@ -50,5 +50,61 @@
>  			#interrupt-cells = <1>;
>  			ti,syscon-dev = <&devctrl 0x2a0>;
>  		};
> +
> +		dspgpio0: keystone_dsp_gpio at 02620240 {
> +			compatible = "ti,keystone-mctrl-gpio";
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			gpio,syscon-dev = <&devctrl 0x240>;
> +		};
> +
> +		dspgpio1: keystone_dsp_gpio at 2620244 {
> +			compatible = "ti,keystone-mctrl-gpio";
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			gpio,syscon-dev = <&devctrl 0x244>;
> +		};
...
> +		dspgpio7: keystone_dsp_gpio at 262025C {
> +			compatible = "ti,keystone-mctrl-gpio";
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			gpio,syscon-dev = <&devctrl 0x25c>;
> +		};

So, devctrl is a syscon device and this DTS introduce several
identical GPIO descriptions?

On my opinion this should be placed in the gpio-syscon.c,
where you can add support for ti,keystone-dsp0{..7}-gpio.
Such change will avoid parts 2 and 3 of this patch.

static const struct syscon_gpio_data ti_keystone_dsp0_gpio = {
  .compatible = "ti,keystone-syscon",
  .dat_bit_offset = 0x240 * 8,
  ...
  .set = etc...
};

---
