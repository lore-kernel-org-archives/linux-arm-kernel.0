From: grinberg@compulab.co.il (Igor Grinberg)
Date: Fri, 10 Oct 2014 10:36:09 +0300
Subject: [PATCH v4] ARM: dts: qcom: add CM-QS600 board
In-Reply-To: <1412179751-5859-1-git-send-email-mike.rapoport@gmail.com>
References: <1412179751-5859-1-git-send-email-mike.rapoport@gmail.com>
Message-ID: <54378C69.4000400@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kumar,

As I've understand from Kevin's letter, we can submit the DT only
platforms addition also for 3.18.

Can we please have this one applied?

Thanks!

On 10/01/14 19:09, Mike Rapoport wrote:
> CM-QS600 is a APQ8064 based computer on module.
> The details are available at
> http://compulab.co.il/products/computer-on-modules/cm-qs600/
> 
> Signed-off-by: Mike Rapoport <mike.rapoport@gmail.com>
> Acked-by: Igor Grinberg <grinberg@compulab.co.il>
> ---
> v2 changes: duplicate the settings for the cm-qs600 board in its .dts file as Kumar suggested
> v3 changes: add board details and keep dts Makefile sorted alphabetically
> v4 changes: fix eeprom defintion and update subject as per Igor's comments
> 
>  arch/arm/boot/dts/Makefile                  |  1 +
>  arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts | 59 +++++++++++++++++++++++++++++
>  2 files changed, 60 insertions(+)
>  create mode 100644 arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index aaa1a68..3243722 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -339,6 +339,7 @@ dtb-$(CONFIG_ARCH_ORION5X) += orion5x-lacie-d2-network.dtb \
>  	orion5x-rd88f5182-nas.dtb
>  dtb-$(CONFIG_ARCH_PRIMA2) += prima2-evb.dtb
>  dtb-$(CONFIG_ARCH_QCOM) += \
> +	qcom-apq8064-cm-qs600.dtb \
>  	qcom-apq8064-ifc6410.dtb \
>  	qcom-apq8074-dragonboard.dtb \
>  	qcom-apq8084-ifc6540.dtb \
> diff --git a/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts b/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
> new file mode 100644
> index 0000000..5d75666
> --- /dev/null
> +++ b/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
> @@ -0,0 +1,59 @@
> +#include "qcom-apq8064-v2.0.dtsi"
> +
> +/ {
> +	model = "CompuLab CM-QS600";
> +	compatible = "qcom,apq8064-cm-qs600", "qcom,apq8064";
> +
> +	soc {
> +		pinctrl at 800000 {
> +			i2c1_pins: i2c1 {
> +				mux {
> +					pins = "gpio20", "gpio21";
> +					function = "gsbi1";
> +				};
> +			};
> +		};
> +
> +		gsbi at 12440000 {
> +			status = "okay";
> +			qcom,mode = <GSBI_PROT_I2C>;
> +
> +			i2c at 12460000 {
> +				status = "okay";
> +				clock-frequency = <200000>;
> +				pinctrl-0 = <&i2c1_pins>;
> +				pinctrl-names = "default";
> +
> +				eeprom: eeprom at 50 {
> +					compatible = "24c02";
> +					reg = <0x50>;
> +					pagesize = <32>;
> +				};
> +			};
> +		};
> +
> +		gsbi at 16600000 {
> +			status = "ok";
> +			qcom,mode = <GSBI_PROT_I2C_UART>;
> +			serial at 16640000 {
> +				status = "ok";
> +			};
> +		};
> +
> +		amba {
> +			/* eMMC */
> +			sdcc1: sdcc at 12400000 {
> +				status = "okay";
> +			};
> +
> +			/* External micro SD card */
> +			sdcc3: sdcc at 12180000 {
> +				status = "okay";
> +			};
> +			/* WLAN */
> +			sdcc4: sdcc at 121c0000 {
> +				status = "okay";
> +			};
> +		};
> +	};
> +};
> 

-- 
Regards,
Igor.
