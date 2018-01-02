From: sre@kernel.org (Sebastian Reichel)
Date: Tue, 2 Jan 2018 18:27:20 +0100
Subject: [PATCH] nokia N9: Add support for magnetometer and touchscreen
In-Reply-To: <20180102131722.GA20706@amd>
References: <20180102131722.GA20706@amd>
Message-ID: <20180102172720.ghtez4d3d2fgcmj6@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jan 02, 2018 at 02:17:22PM +0100, Pavel Machek wrote:
> This adds dts support for magnetometer and touchscreen on Nokia N9.

I think it makes sense to have this splitted.

> Signed-off-by: Pavel Machek <pavel@ucw.cz>
> 
> diff --git a/arch/arm/boot/dts/omap3-n9.dts b/arch/arm/boot/dts/omap3-n9.dts
> index 39e35f8..57a6679 100644
> --- a/arch/arm/boot/dts/omap3-n9.dts
> +++ b/arch/arm/boot/dts/omap3-n9.dts
> @@ -36,6 +57,22 @@
>  			};
>  		};
>  	};
> +
> +	touch at 4b {

touchscreen@

> +		compatible = "atmel,maxtouch";
> +		reg = <0x4b>;
> +		interrupt-parent = <&gpio2>;
> +		interrupts = <29 2>; /* gpio_61, IRQF_TRIGGER_FALLING*/

reset-gpios = <&gpio3 17 GPIO_ACTIVE_SOMETHING>;

> +		vdd-supply = <&vio>;
> +		avdd-supply = <&vaux1>;

Those two are not mentioned in the binding and not supported by the
driver as far as I can see?

> +	};
> +};

Touchscreen with the same settings is required for n950, so it
should be in the shared n950 + n9 file.

> +&i2c3 {
> +	ak8975 at 0f {
> +		compatible = "asahi-kasei,ak8975";
> +		reg = <0x0f>;
> +	};
>  };

Looking at the N9 board file this is missing a rotation matrix. This
is supported by the binding:

Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt

>  
>  &isp {

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180102/5da4ddb9/attachment.sig>
