From: ray.jui@broadcom.com (Ray Jui)
Date: Tue, 4 Sep 2018 13:39:30 -0700
Subject: [PATCH v3 1/3] ARM: dts: NSP: Enable SFP on bcm958625hr
In-Reply-To: <20180831192039.11842-2-f.fainelli@gmail.com>
References: <20180831192039.11842-1-f.fainelli@gmail.com>
 <20180831192039.11842-2-f.fainelli@gmail.com>
Message-ID: <68b987de-9229-4606-a972-650b3f486e19@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 8/31/2018 12:20 PM, Florian Fainelli wrote:
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
> index ea3fc194f8f3..a53a2f629d74 100644
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
> +	i2c1: i2c {
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

Looks good to me. Thanks!

Reviewed-by: Ray Jui <ray.jui@broadcom.com>
