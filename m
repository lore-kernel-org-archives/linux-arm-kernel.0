From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 24 Aug 2012 15:21:05 +0800
Subject: [PATCH 1/2] imx6q: Configure the pwm node for pinmux support
In-Reply-To: <1345735959-12964-2-git-send-email-hachimi.samir@gmail.com>
References: <1345735959-12964-2-git-send-email-hachimi.samir@gmail.com>
Message-ID: <20120824072102.GB31998@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 23, 2012 at 05:32:38PM +0200, hachimi.samir at gmail.com wrote:
> From: Samir Hachimi <hachimi.samir@gmail.com>
> 
>  Add the pinmux support for pwm.
>  Several pin can be set to PwmO for the same Pwm. This configuration set all
>  of them when enabled.

No, not at all.  See more below.

> 
> Signed-off-by: Samir Hachimi <shachimi@adeneo-embedded.com>
> ---
>  arch/arm/boot/dts/imx6q.dtsi |   42 ++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 42 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
> index fd57079..c913b99 100644
> --- a/arch/arm/boot/dts/imx6q.dtsi
> +++ b/arch/arm/boot/dts/imx6q.dtsi
> @@ -248,23 +248,35 @@
>  			};
>  
>  			pwm at 02080000 { /* PWM1 */
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_pwm1_1>;
>  				reg = <0x02080000 0x4000>;
>  				interrupts = <0 83 0x04>;
> +				status = "disabled";
>  			};
>  
>  			pwm at 02084000 { /* PWM2 */
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_pwm2_1>;
>  				reg = <0x02084000 0x4000>;
>  				interrupts = <0 84 0x04>;
> +				status = "disabled";
>  			};
>  
>  			pwm at 02088000 { /* PWM3 */
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_pwm3_1>;
>  				reg = <0x02088000 0x4000>;
>  				interrupts = <0 85 0x04>;
> +				status = "disabled";
>  			};
>  
>  			pwm at 0208c000 { /* PWM4 */
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_pwm4_1>;
>  				reg = <0x0208c000 0x4000>;
>  				interrupts = <0 86 0x04>;
> +				status = "disabled";
>  			};
>  
>  			flexcan at 02090000 { /* CAN1 */
> @@ -559,6 +571,36 @@
>  					};
>  				};
>  
> +				pwm1 {
> +				     	pinctrl_pwm1_1: pwm1grp-1 {
> +						fsl,pins = <1543 0x80000000	/* MX6Q_PAD_SD1_DAT3__PWM1_PWMO */
> +							    574 0x80000000      /* MX6Q_PAD_DISPO_DAT8__PWM1_PWMO */
> +							    971 0x80000000>;	/* MX6Q_PAD_GPIO_9__PWM1_PWMO */
> +					};

It really should be something like the below.

				     	pinctrl_pwm1_1: pwm1grp-1 {
						fsl,pins = <
							1543 0x80000000	/* MX6Q_PAD_SD1_DAT3__PWM1_PWMO */
						>;
					};


				     	pinctrl_pwm1_2: pwm1grp-2 {
						fsl,pins = <
							574 0x80000000	/* MX6Q_PAD_DISPO_DAT8__PWM1_PWMO */
						>;
					};

				     	pinctrl_pwm1_3: pwm1grp-3 {
						fsl,pins = <
							971 0x80000000	/* MX6Q_PAD_GPIO_9__PWM1_PWMO */
						>;
					};

The rationale behind this is there are 3 possible pads on SoC imx6q,
MX6Q_PAD_SD1_DAT3, MX6Q_PAD_DISPO_DAT8 and MX6Q_PAD_GPIO_9 could be
muxed on function PWM1_PWMO.  But for particular user (board design),
only one option is needed.

You do not need to enumerate all the possible options from the
beginning.  We would add an option when it's actually used by some
board.

Regards,
Shawn

> +				};
> +
> +				pwm2 {
> +				     	pinctrl_pwm2_1: pwm2grp-1 {
> +						fsl,pins = <1557 0x80000000     /* MX6Q_PAD_SD1_DAT2__PWM2_PWMO */
> +							    582 0x80000000	/* MX6Q_PAD_DISP0_DAT9__PWM2_PWMO */
> +							    963 0x80000000>;	/* MX6Q_PAD_GPIO_1__PWM2_PWMO */
> +					};
> +				};
> +
> +				pwm3 {
> +				     	pinctrl_pwm3_1: pwm3grp-1 {
> +						fsl,pins = <1471 0x80000000	/* MX6Q_PAD_SD4_DAT1__PWM3_PWMO */
> +							    1526 0x80000000>;	/* MX6Q_PAD_SD1_DAT1__PWM3_PWMO */
> +					};
> +				};
> +
> +				pwm4 {
> +				     	pinctrl_pwm4_1: pwm4grp-1 {
> +						fsl,pins = <1479 0x80000000	/* MX6Q_PAD_SD4_DAT2__PWM4_PWMO */
> +							    1550 0x80000000>;	/* MX6Q_PAD_SD1_CMD__PWM4_PWMO */
> +					};
> +				};
> +
>  				usdhc3 {
>  					pinctrl_usdhc3_1: usdhc3grp-1 {
>  						fsl,pins = <1273 0x17059	/* MX6Q_PAD_SD3_CMD__USDHC3_CMD */
> -- 
> 1.7.1
> 
