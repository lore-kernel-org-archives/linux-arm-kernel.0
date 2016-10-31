From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon, 31 Oct 2016 15:20:29 -0700
Subject: [PATCH v3] ARM: dts: Add gyro and accel to APQ8060 Dragonboard
In-Reply-To: <1477473794-26030-1-git-send-email-linus.walleij@linaro.org>
References: <1477473794-26030-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20161031222029.GG25787@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 26 Oct 02:23 PDT 2016, Linus Walleij wrote:

> This adds the MPU-3050 gyroscope and the KXSD9 accelerometer to
> the Qualcomm APQ8060 Dragonboard. The KXSD9 is mounted beyond the
> MPU-3050 and appear as a subdevice beyond it. We set up the
> required GPIO and interrupt lines to make the devices work.
> 

I'm concerned about the interrupt below, but apart from that

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:
> - Should be fine to apply now: all bindings and requirements are
>   merged.
> ChangeLog v1->v2:
> - Use the new I2C mux gate bindings from Peter Rosin (merged to
>   the I2C subsystem)
> ---
>  arch/arm/boot/dts/qcom-apq8060-dragonboard.dts | 53 ++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts b/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
[..]
> +				mpu3050 at 68 {
> +					compatible = "invensense,mpu3050";
> +					reg = <0x68>;
> +					/*
> +					 * GPIO17 has interrupt 208 on the
> +					 * PM8058, it is pulled high by a 10k
> +					 * resistor to VLOGIC so needs to be
> +					 * active low/falling edge.
> +					 */
> +					interrupt-parent = <&pm8058_gpio>;
> +					interrupts = <208 IRQ_TYPE_EDGE_FALLING>;

To remove the need of resetting the interrupt-parent in each child you
can use the following form:

    interrupts-extended = <&pm8058_gpio 208 IRQ_TYPE_EDGE_FALLING>;



But, if we correct the ssbi gpio driver then this would no longer be
interrupt 208 in this parent, right?. I believe that if you say
<&pmicintc 208 IRQ_TYPE_EDGE_FALLING> instead, which should work even
after we correct the gpio translation.

(Which probably means we need to get that redesigned, before we
introduce to many of these)

> +					pinctrl-names = "default";
> +					pinctrl-0 = <&dragon_mpu3050_gpios>;
> +					vlogic-supply = <&pm8058_lvs0>; // 1.8V
> +					vdd-supply = <&pm8058_l14>; // 2.85V
> +
> +					/*
> +					 * The MPU-3050 acts as a hub for the
> +					 * accelerometer.
> +					 */
> +					i2c-gate {
> +						#address-cells = <1>;
> +						#size-cells = <0>;
> +
> +						kxsd9 at 18 {
> +							compatible = "kionix,kxsd9";
> +							reg = <0x18>;
> +							interrupt-parent = <&tlmm>;
> +							interrupts = <57 IRQ_TYPE_EDGE_FALLING>;
> +							pinctrl-names = "default";
> +							pinctrl-0 = <&dragon_kxsd9_gpios>;
> +							iovdd-supply = <&pm8058_lvs0>; // 1.8V
> +							vdd-supply = <&pm8058_l14>; // 2.85V
> +						};
> +					};
> +				};

Regards,
Bjorn
