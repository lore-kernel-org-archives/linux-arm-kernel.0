From: ray.jui@broadcom.com (Ray Jui)
Date: Tue, 28 Aug 2018 14:31:02 -0700
Subject: [PATCH v2 1/3] ARM: dts: NSP: Enable SFP on bcm958625hr
In-Reply-To: <20180828175420.7992-2-f.fainelli@gmail.com>
References: <20180828175420.7992-1-f.fainelli@gmail.com>
 <20180828175420.7992-2-f.fainelli@gmail.com>
Message-ID: <b1c97c3e-ae7f-8948-5146-df27e38da961@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 8/28/2018 10:54 AM, Florian Fainelli wrote:
> Enable the SFP connected to port 5 of the switch and wire up all GPIOs
> to the SFP cage. Because of a hardware limitation of the i2c controller
> on the iProc SoCs which prevents large i2c (> 63 bytes) transactions to
> work, we use the i2c-gpio interface instead, which does not have that
> limitation. This allows us to read the SFP module EEPROM, which would
> not be possible otherwise since it exceeds that size during a single
> read transfer.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>   arch/arm/boot/dts/bcm958625hr.dts | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/bcm958625hr.dts b/arch/arm/boot/dts/bcm958625hr.dts
> index ea3fc194f8f3..6fa0d8d1a218 100644
> --- a/arch/arm/boot/dts/bcm958625hr.dts
> +++ b/arch/arm/boot/dts/bcm958625hr.dts
> @@ -58,6 +58,24 @@
>   		open-source;
>   		priority = <200>;
>   	};
> +
> +	/* Hardware I2C block cannot do more than 63 bytes per transfer,
> +	 * which would prevent reading from a SFP's EEPROM (256 byte).
> +	 */
> +	i2c1: i2c1 {

nit, "i2c1: i2c {" ?

> +		compatible = "i2c-gpio";
> +		sda-gpios = <&gpioa 5 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +		scl-gpios = <&gpioa 4 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	};
> +
> +	sfp: sfp {
> +		compatible = "sff,sfp";
> +		i2c-bus = <&i2c1>;
> +		mod-def0-gpios = <&gpioa 28 GPIO_ACTIVE_LOW>;
> +		los-gpios = <&gpioa 24 GPIO_ACTIVE_HIGH>;
> +		tx-fault-gpios = <&gpioa 30 GPIO_ACTIVE_HIGH>;
> +		tx-disable-gpios = <&gpioa 26 GPIO_ACTIVE_HIGH>;
> +	};
>   };
>   
>   &amac0 {
> @@ -210,6 +228,14 @@
>   			reg = <4>;
>   		};
>   
> +		port at 5 {
> +			label = "sfp";
> +			phy-mode = "sgmii";
> +			reg = <5>;
> +			sfp = <&sfp>;
> +			managed = "in-band-status";
> +		};
> +
>   		port at 8 {
>   			ethernet = <&amac2>;
>   			label = "cpu";
> 
