From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 20 Dec 2016 15:25:54 +0100
Subject: [PATCH 1/7] Documentation: DT: bindings: iio: adc: add
 documentation for Allwinner SoCs' GPADC driver
In-Reply-To: <20161220102709.9504-2-quentin.schulz@free-electrons.com>
References: <20161220102709.9504-1-quentin.schulz@free-electrons.com>
 <20161220102709.9504-2-quentin.schulz@free-electrons.com>
Message-ID: <20161220142554.rcocnculfehiwhpn@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Dec 20, 2016 at 11:27:03AM +0100, Quentin Schulz wrote:
> The Allwinner SoCs all have an ADC that can also act as a thermal sensor
> and sometimes as a touchscreen controller. If there is a touchscreen
> controller, the first four channels can be used either for the ADC or
> the touchscreen and the fifth channel is used for the thermal sensor.
> If there is not a touchscreen controller, the one and only channel is
> used for the thermal sensor.
> 
> This patch adds the documentation for the driver of the Allwinner SoCs'
> GPADC.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>  .../bindings/iio/adc/sun4i-gpadc-iio.txt           | 57 ++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/sun4i-gpadc-iio.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/sun4i-gpadc-iio.txt b/Documentation/devicetree/bindings/iio/adc/sun4i-gpadc-iio.txt
> new file mode 100644
> index 0000000..aab768d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/sun4i-gpadc-iio.txt
> @@ -0,0 +1,57 @@
> +Allwinner SoCs' GPADC Device Tree bindings
> +------------------------------------------
> +
> +The Allwinner SoCs all have an ADC that can also act as a thermal sensor and
> +sometimes as a touchscreen controller. If there is a touchscreen controller, the
> +first four channels can be used either for the ADC or the touchscreen and the
> +fifth channel is used for the thermal sensor.
> +If there is not a touchscreen controller, the one and only channel is used for
> +the thermal sensor.
> +
> +Currently, the touchscreen controller does not have a driver using this ADC
> +driver. The touchscreen controller is currently driven only by
> +input/touchscreen/sun4i-ts.c which is absolutely incompatible with this driver.
> +
> +The Allwinner A10, A13 and A31 SoCs already have a DT binding for the
> +aforementioned input driver, thus an MFD driver matches the existing DT binding
> +(mfd/sun4i-gpadc.c) and replaces the input driver. No DT binding is required for
> +these SoCs' ADC, everything is handled by the MFD which is matching the existing
> +DT binding for input/touchscreen/sun4i-ts.c.
> +
> +The Allwinner A33 GPADC only have a thermal sensor and have a proper DT binding
> +for this driver unlike the previously mentioned SoCs.

The DT bindings should be agnostic from the OS. You can remove all
mention of the implementations details in Linux.

(and you should wrap at 72 characters).

But we already have a binding document for that controller, so you
shouldn't create a new one, reuse the old one that is already there.

> +Required properties:
> + - compatible: "allwinner,sun8i-a33-gpadc-iio"

IIO is an implementation detail. The IP is called GPADC.
You're also missing reg.

> +
> +Optional properties:
> +(for use with thermal framework for CPU thermal throttling for example, and/or
> + IIO consumers)
> + - #thermal-sensor-cells = <0>; (see
> +Documentation/devicetree/bindings/thermal/thermal.txt)
> + - #io-channel-cells = <0>; (see
> +Documentation/devicetree/bindings/iio/iio-bindings.txt)

I wouldn't list that as optional.

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161220/34694221/attachment.sig>
