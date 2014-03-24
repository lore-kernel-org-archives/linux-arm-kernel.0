From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 24 Mar 2014 18:01:31 +0100
Subject: [PATCH v3] i2c: new bus driver for efm32
In-Reply-To: <1395414236-22647-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1395414236-22647-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20140324170131.GB7524@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/i2c-efm32.txt
> @@ -0,0 +1,34 @@
> +* Energymicro efm32 i2c controller
> +
> +Required properties :
> +
> + - reg : Offset and length of the register set for the device
> + - compatible : should be "efm32,i2c"

Ehrm, come to think of it, shouldn't that actually be "energymicro, efm32-i2c"
or similar to match the "vendor,product" pattern?

> +config I2C_EFM32
> +	tristate "EFM32 I2C controller"
> +	depends on OF && (ARCH_EFM32 || COMPILE_TEST)

Is EFM32 DT only? Do we need the dependency on OF?

> +	help
> +	  This driver supports the i2c block found in Energy Micro's EFM32
> +	  SoCs.
> +

...

> +static void efm32_i2c_send_next_byte(struct efm32_i2c_ddata *ddata)
> +{
> +	struct i2c_msg *cur_msg = &ddata->msgs[ddata->current_msg];

Missing newline.

> +	if (ddata->current_word >= cur_msg->len) {
> +		/* cur_msg completely transferred */
> +		ddata->current_word = 0;
> +		ddata->current_msg += 1;
> +
> +		if (ddata->current_msg >= ddata->num_msgs) {
> +			efm32_i2c_write32(ddata, REG_CMD, REG_CMD_STOP);
> +			complete(&ddata->done);
> +		} else {
> +			efm32_i2c_send_next_msg(ddata);
> +		}
> +	} else {
> +		efm32_i2c_write32(ddata, REG_TXDATA,
> +				cur_msg->buf[ddata->current_word++]);
> +	}
> +}
> +

...


> +static int efm32_i2c_master_xfer(struct i2c_adapter *adap,
> +		struct i2c_msg *msgs, int num)
> +{
> +	struct efm32_i2c_ddata *ddata = i2c_get_adapdata(adap);
> +	int ret;
> +
> +	if (ddata->msgs)
> +		return -EBUSY;
> +
> +	ddata->msgs = msgs;
> +	ddata->num_msgs = num;
> +	ddata->current_word = 0;
> +	ddata->current_msg = 0;
> +	ddata->retval = -EIO;
> +
> +	reinit_completion(&ddata->done);
> +
> +	dev_dbg(&ddata->adapter.dev, "state: %08x, status: %08x\n",
> +			efm32_i2c_read32(ddata, REG_STATE),
> +			efm32_i2c_read32(ddata, REG_STATUS));
> +
> +	efm32_i2c_send_next_msg(ddata);
> +
> +	wait_for_completion(&ddata->done);
> +
> +	if (ddata->current_msg >= ddata->num_msgs)
> +		ret = ddata->num_msgs;
> +	else
> +		ret = ddata->retval;
> +
> +	ddata->msgs = NULL;

Setting NULL should not be needed?

> +
> +	return ret;
> +}
> +

And checkpatch said:

WARNING: braces {} are not necessary for any arm of this statement
#345: FILE: drivers/i2c/busses/i2c-efm32.c:239:
+		if (cur_msg->flags & I2C_M_RD) {
...

Thanks,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140324/fa97762e/attachment.sig>
