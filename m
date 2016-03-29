From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Tue, 29 Mar 2016 07:44:37 -0700
Subject: [PATCH 11/12] ARM: dts: dragonboard-600c: add i2c support
In-Reply-To: <1458762490-9814-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1458762366-9233-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1458762490-9814-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <20160329144437.GN8929@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 23 Mar 12:48 PDT 2016, Srinivas Kandagatla wrote:

> This patch adds nodes required to enable 4 i2c buses on the board which
> are connected to various sensors and eeprom.
> 

I would like for the pinconf for these blocks to be in this patch (and
file) to make it clear how they are configured and where to change them.

Regards,
Bjorn

> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../arm/boot/dts/qcom-apq8064-dragonboard-600c.dts | 46 ++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-apq8064-dragonboard-600c.dts b/arch/arm/boot/dts/qcom-apq8064-dragonboard-600c.dts
> index 4fecd94..942de04 100644
> --- a/arch/arm/boot/dts/qcom-apq8064-dragonboard-600c.dts
> +++ b/arch/arm/boot/dts/qcom-apq8064-dragonboard-600c.dts
> @@ -8,6 +8,10 @@
>  	aliases {
>  		serial0 = &gsbi7_serial;
>  		serial1 = &gsbi1_serial;
> +		i2c0 = &gsbi2_i2c;
> +		i2c1 = &gsbi3_i2c;
> +		i2c2 = &gsbi4_i2c;
> +		i2c3 = &gsbi7_i2c;
>  	};
>  
>  	regulators {
> @@ -180,6 +184,42 @@
>  			};
>  		};
>  
> +		gsbi at 12480000 {
> +			status = "okay";
> +			qcom,mode = <GSBI_PROT_I2C>;
> +			i2c at 124a0000 {
> +				/* On Low speed expansion and Sensors */
> +				label = "LS-I2C0";
> +				status = "okay";
> +			};
> +		};
> +
> +		gsbi at 16200000 {
> +			status = "okay";
> +			qcom,mode = <GSBI_PROT_I2C>;
> +			i2c at 16280000 {
> +			/* On Low speed expansion */
> +				status = "okay";
> +				label = "LS-I2C1";
> +				clock-frequency = <200000>;
> +				eeprom at 52 {
> +					compatible = "atmel,24c128";
> +					reg = <0x52>;
> +					pagesize = <64>;
> +				};
> +			};
> +		};
> +
> +		gsbi at 16300000 {
> +			status = "okay";
> +			qcom,mode = <GSBI_PROT_I2C>;
> +			i2c at 16380000 {
> +				/* On High speed expansion */
> +				label = "HS-CAM-I2C3";
> +				status = "okay";
> +			};
> +		};
> +
>  		/* DEBUG UART  */
>  		gsbi at 16600000 {
>  			status = "okay";
> @@ -190,6 +230,12 @@
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&gsbi7_uart_2pins>;
>  			};
> +
> +			i2c at 16680000 {
> +				/* On High speed expansion */
> +				status = "okay";
> +				label = "HS-CAM-I2C2";
> +			};
>  		};
>  
>  		leds {
> -- 
> 2.5.0
> 
