From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 18 Sep 2015 09:58:06 +0200
Subject: [Patch V5] i2c: imx: implement bus recovery
In-Reply-To: <1441968155-10918-1-git-send-email-b54642@freescale.com>
References: <1441968155-10918-1-git-send-email-b54642@freescale.com>
Message-ID: <20150918075806.GC4044@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Sep 11, 2015 at 06:42:34PM +0800, Gao Pan wrote:
> Implement bus recovery methods for i2c-imx so we can recover from
> situations where SCL/SDA are stuck low.
> 
> Once i2c bus SCL/SDA are stuck low during transfer, config the i2c
> pinctrl to gpio mode by calling pinctrl sleep set function, and then
> use GPIO to emulate the i2c protocol to send nine dummy clock to recover
> i2c device. After recovery, set i2c pinctrl to default group setting.

If SCL/SDA a stuck low *during* a transfer that transfer went wrong and
we have to return an error and the caller must repeat the transfer. We
can't just recover the bus in the middle of a transfer and claim the
transfer worked.
We can only do bus recovery on the start of a transfer. 

> @@ -439,7 +452,10 @@ static int i2c_imx_bus_busy(struct imx_i2c_struct *i2c_imx, int for_busy)
>  		if (time_after(jiffies, orig_jiffies + msecs_to_jiffies(500))) {
>  			dev_dbg(&i2c_imx->adapter.dev,
>  				"<%s> I2C bus is busy\n", __func__);
> -			return -ETIMEDOUT;
> +			if (i2c_imx->adapter.bus_recovery_info)
> +				return i2c_recover_bus(&i2c_imx->adapter);
> +			else
> +				return -ETIMEDOUT;

In my tests with a stuck i2c bus this didn't work because this code
is not executed due to the arbitration lost check done before. The
I2SR_IAL bit was always set when the bus was stuck.

Also as mentioned above I think we should only execute the bus recovery
once in a transfer, when the controller fails to start. i2c_imx_bus_busy()
is called from far too many places.

>  		}
>  		schedule();
>  	}
> @@ -963,6 +979,62 @@ out:
>  	return (result < 0) ? result : num;
>  }
>  
> +static int i2c_imx_get_scl(struct i2c_adapter *adap)
> +{
> +	struct imx_i2c_struct *i2c_imx;
> +
> +	i2c_imx = container_of(adap, struct imx_i2c_struct, adapter);
> +
> +	return gpiod_get_value(i2c_imx->pins.scl);
> +}

There's a generic i2c_generic_gpio_recovery() which handles the bus
recovery using gpios. We should use it.

> @@ -1057,6 +1146,24 @@ static int i2c_imx_probe(struct platform_device *pdev)
>  	if (ret < 0)
>  		goto rpm_disable;
>  
> +	/* Init recover pins */
> +	i2c_imx->pins.sda =
> +		devm_gpiod_get_optional(&pdev->dev, "sda-gpios", GPIOD_IN);
> +	i2c_imx->pins.scl =
> +		devm_gpiod_get_optional(&pdev->dev, "scl-gpios", GPIOD_IN);

This cannot work. devm_gpiod_get_optional already appends "-gpios".

See my alternative approach below based on your code.

Sascha

---------------------------8<---------------------------

>From 32dcaeb4488d8311f68179adf261a909adc660a0 Mon Sep 17 00:00:00 2001
From: Gao Pan <b54642@freescale.com>
Date: Fri, 11 Sep 2015 18:42:34 +0800
Subject: [PATCH] i2c: imx: implement bus recovery

Implement bus recovery methods for i2c-imx so we can recover from
situations where SCL/SDA are stuck low.

Once i2c bus SCL/SDA are stuck low during transfer, config the i2c
pinctrl to gpio mode by calling pinctrl sleep set function, and then
use GPIO to emulate the i2c protocol to send nine dummy clock to recover
i2c device. After recovery, set i2c pinctrl to default group setting.

Signed-off-by: Fugang Duan <B38611@freescale.com>
Signed-off-by: Gao Pan <b54642@freescale.com>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 Documentation/devicetree/bindings/i2c/i2c-imx.txt |  9 +++
 drivers/i2c/busses/i2c-imx.c                      | 69 +++++++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-imx.txt b/Documentation/devicetree/bindings/i2c/i2c-imx.txt
index ce4311d..eab5836 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-imx.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-imx.txt
@@ -14,6 +14,10 @@ Optional properties:
   The absence of the propoerty indicates the default frequency 100 kHz.
 - dmas: A list of two dma specifiers, one for each entry in dma-names.
 - dma-names: should contain "tx" and "rx".
+- scl-gpios: specify the gpio related to SCL pin
+- sda-gpios: specify the gpio related to SDA pin
+- pinctrl: add extra pinctrl to configure i2c pins to gpio function for i2c
+  bus recovery, call it "gpio" state
 
 Examples:
 
@@ -37,4 +41,9 @@ i2c0: i2c at 40066000 { /* i2c0 on vf610 */
 	dmas = <&edma0 0 50>,
 		<&edma0 0 51>;
 	dma-names = "rx","tx";
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	pinctrl-1 = <&pinctrl_i2c1_gpio>;
+	scl-gpios = <&gpio5 26 GPIO_ACTIVE_HIGH>;
+	sda-gpios = <&gpio5 27 GPIO_ACTIVE_HIGH>;
 };
diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index a53a7dd..0aa5c42 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -49,6 +49,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_dma.h>
+#include <linux/of_gpio.h>
 #include <linux/platform_data/i2c-imx.h>
 #include <linux/platform_device.h>
 #include <linux/sched.h>
@@ -207,6 +208,11 @@ struct imx_i2c_struct {
 	unsigned int		cur_clk;
 	unsigned int		bitrate;
 	const struct imx_i2c_hwdata	*hwdata;
+	struct i2c_bus_recovery_info rinfo;
+
+	struct pinctrl *pinctrl;
+	struct pinctrl_state *pinctrl_pins_default;
+	struct pinctrl_state *pinctrl_pins_gpio;
 
 	struct imx_i2c_dma	*dma;
 };
@@ -896,6 +902,11 @@ static int i2c_imx_xfer(struct i2c_adapter *adapter,
 
 	/* Start I2C transfer */
 	result = i2c_imx_start(i2c_imx);
+	if (result) {
+		i2c_recover_bus(&i2c_imx->adapter);
+		result = i2c_imx_start(i2c_imx);
+	}
+
 	if (result)
 		goto fail0;
 
@@ -956,6 +967,55 @@ fail0:
 	return (result < 0) ? result : num;
 }
 
+static void i2c_imx_prepare_recovery(struct i2c_adapter *adap)
+{
+	struct imx_i2c_struct *i2c_imx;
+
+	i2c_imx = container_of(adap, struct imx_i2c_struct, adapter);
+
+	pinctrl_select_state(i2c_imx->pinctrl, i2c_imx->pinctrl_pins_gpio);
+}
+
+static void i2c_imx_unprepare_recovery(struct i2c_adapter *adap)
+{
+	struct imx_i2c_struct *i2c_imx;
+
+	i2c_imx = container_of(adap, struct imx_i2c_struct, adapter);
+
+	pinctrl_select_state(i2c_imx->pinctrl, i2c_imx->pinctrl_pins_default);
+}
+
+static void i2c_imx_init_recovery_info(struct imx_i2c_struct *i2c_imx,
+		struct platform_device *pdev)
+{
+	struct i2c_bus_recovery_info *rinfo = &i2c_imx->rinfo;
+
+	i2c_imx->pinctrl_pins_default = pinctrl_lookup_state(i2c_imx->pinctrl,
+			PINCTRL_STATE_DEFAULT);
+	i2c_imx->pinctrl_pins_gpio = pinctrl_lookup_state(i2c_imx->pinctrl,
+			"gpio");
+	rinfo->sda_gpio = of_get_named_gpio_flags(pdev->dev.of_node,
+			"sda-gpios", 0, NULL);
+	rinfo->scl_gpio = of_get_named_gpio_flags(pdev->dev.of_node,
+			"scl-gpios", 0, NULL);
+
+	if (!gpio_is_valid(rinfo->sda_gpio) ||
+	    !gpio_is_valid(rinfo->scl_gpio) ||
+	    IS_ERR(i2c_imx->pinctrl_pins_default) ||
+	    IS_ERR(i2c_imx->pinctrl_pins_gpio)) {
+		dev_dbg(&pdev->dev, "recovery information incomplete\n");
+		return;
+	}
+
+	dev_dbg(&pdev->dev, "using scl-gpio %d and sda-gpio %d for recovery\n",
+			rinfo->sda_gpio, rinfo->scl_gpio);
+
+	rinfo->prepare_recovery = i2c_imx_prepare_recovery;
+	rinfo->unprepare_recovery = i2c_imx_unprepare_recovery;
+	rinfo->recover_bus = i2c_generic_gpio_recovery;
+	i2c_imx->adapter.bus_recovery_info = rinfo;
+}
+
 static u32 i2c_imx_func(struct i2c_adapter *adapter)
 {
 	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL
@@ -1023,6 +1083,13 @@ static int i2c_imx_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "can't enable I2C clock\n");
 		return ret;
 	}
+
+	i2c_imx->pinctrl = devm_pinctrl_get(&pdev->dev);
+	if (IS_ERR(i2c_imx->pinctrl)) {
+		ret = PTR_ERR(i2c_imx->pinctrl);
+		goto clk_disable;
+	}
+
 	/* Request IRQ */
 	ret = devm_request_irq(&pdev->dev, irq, i2c_imx_isr, 0,
 				pdev->name, i2c_imx);
@@ -1037,6 +1104,8 @@ static int i2c_imx_probe(struct platform_device *pdev)
 	/* Set up adapter data */
 	i2c_set_adapdata(&i2c_imx->adapter, i2c_imx);
 
+	i2c_imx_init_recovery_info(i2c_imx, pdev);
+
 	/* Set up clock divider */
 	i2c_imx->bitrate = IMX_I2C_BIT_RATE;
 	ret = of_property_read_u32(pdev->dev.of_node,
-- 
2.5.1


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
