From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 24 Apr 2016 23:10:44 +0200
Subject: [PATCH] i2c: st: Implement i2c_bus_recovery_info callbacks
In-Reply-To: <1460467759-11737-1-git-send-email-peter.griffin@linaro.org>
References: <1460467759-11737-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <20160424211044.GD4317@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +/*
> + * i2c bus recovery routines
> + * get_scl and set_scl must be defined to avoid the recover_bus field of
> + * i2c_bus_recovery_info to be overriden with NULL during the
> + * i2c_add_adapter call
> + */

Oh, that shouldn't be like this. Can you try this patch and remove the
empty functions please?

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 4979728f7fb2de..604936955807e5 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1595,10 +1595,12 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 
 			bri->get_scl = get_scl_gpio_value;
 			bri->set_scl = set_scl_gpio_value;
-		} else if (!bri->set_scl || !bri->get_scl) {
+		} else if (bri->recover_bus == i2c_generic_scl_recovery) {
 			/* Generic SCL recovery */
-			dev_err(&adap->dev, "No {get|set}_gpio() found, not using recovery\n");
-			adap->bus_recovery_info = NULL;
+			if (!bri->set_scl || !bri->get_scl) {
+				dev_err(&adap->dev, "No {get|set}_scl() found, not using recovery\n");
+				adap->bus_recovery_info = NULL;
+			}
 		}
 	}
 

> +static int st_i2c_recover_bus(struct i2c_adapter *i2c_adap)
> +{

Can you describe what the function does? It is not clear to me that it
generates 9 scl pulses.

> +	struct st_i2c_dev *i2c_dev = i2c_get_adapdata(i2c_adap);
> +	u32 ctl;
> +
> +	dev_err(i2c_dev->dev, "Trying to recover bus\n");

This is not an error. Either dev_dbg or drop it, I'd say.

> +
> +	/* Disable interrupts */
> +	writel_relaxed(0, i2c_dev->base + SSC_IEN);
> +
> +	st_i2c_hw_config(i2c_dev);
> +
> +	ctl = SSC_CTL_EN | SSC_CTL_MS |	SSC_CTL_EN_RX_FIFO | SSC_CTL_EN_TX_FIFO;
> +	st_i2c_set_bits(i2c_dev->base + SSC_CTL, ctl);
> +
> +	st_i2c_clr_bits(i2c_dev->base + SSC_I2C, SSC_I2C_I2CM);
> +	usleep_range(8000, 10000);
> +
> +	writel_relaxed(0, i2c_dev->base + SSC_TBUF);
> +	usleep_range(2000, 4000);
> +	st_i2c_set_bits(i2c_dev->base + SSC_I2C, SSC_I2C_I2CM);
> +
> +	return 0;
> +}

Thanks,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160424/93bda987/attachment.sig>
