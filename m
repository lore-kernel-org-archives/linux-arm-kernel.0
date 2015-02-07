From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 7 Feb 2015 18:50:39 +0100
Subject: [PATCH v8 2/3] i2c: iproc: Add Broadcom iProc I2C Driver
In-Reply-To: <1423272507-18459-3-git-send-email-rjui@broadcom.com>
References: <rjui@broadcom.com>
 <1423272507-18459-1-git-send-email-rjui@broadcom.com>
 <1423272507-18459-3-git-send-email-rjui@broadcom.com>
Message-ID: <20150207175039.GB6263@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ray,

On Fri, Feb 06, 2015 at 05:28:26PM -0800, Ray Jui wrote:
> Add initial support to the Broadcom iProc I2C controller found in the
> iProc family of SoCs.
> 
> The iProc I2C controller has separate internal TX and RX FIFOs, each has
> a size of 64 bytes. The iProc I2C controller supports two bus speeds
> including standard mode (100kHz) and fast mode (400kHz)

Mostly looking good.

> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +#include <linux/slab.h>
> +#include <linux/delay.h>

Please sort the includes.

> +static bool bcm_iproc_i2c_bus_busy(struct bcm_iproc_i2c_dev *iproc_i2c)
> +{
> +	if (readl(iproc_i2c->base + M_CMD_OFFSET) &
> +	    (1 << M_CMD_START_BUSY_SHIFT))
> +		return true;
> +	else
> +		return false;
> +}

Minor: return !!(readl(...))? You decide.

> +
> +static int bcm_iproc_i2c_format_addr(struct bcm_iproc_i2c_dev *iproc_i2c,
> +				     struct i2c_msg *msg, u8 *addr)
> +{
> +	*addr = msg->addr << 1;
> +
> +	if (msg->flags & I2C_M_RD)
> +		*addr |= 1;
> +
> +	return 0;
> +}

I'd suggest a oneliner.

*addr = msg->addr << 1 | (msg->flags & I2C_M_RD ? 1 : 0)

Or use !! like above.

Don't do an extra function for that. It is only used once and it also
doesn't need to be int since it can't fail anyhow.

(Note to self: I should make a macro for that in i2c.h)

> +	/* need to reserve one byte in the FIFO for the slave address */
> +	if (msg->len > M_TX_RX_FIFO_SIZE - 1) {
> +		dev_err(iproc_i2c->device,
> +			"only support data length up to %u bytes\n",
> +			M_TX_RX_FIFO_SIZE - 1);
> +		return -EINVAL;

-EOPNOTSUPP

Is it really a HW limitation? Could the driver later be extended to
continue filling the FIFO if a certain threshold is reached?

> +	dev_dbg(iproc_i2c->device, "xfer %c, addr=0x%02x, len=%d\n",
> +		(msg->flags & I2C_M_RD) ? 'R' : 'W', msg->addr,
> +		msg->len);
> +	dev_dbg(iproc_i2c->device, "*** data: %*ph\n", msg->len, msg->buf);

Not really needed. We have tracing for that.

> +	if (bus_speed < 100000) {
> +		dev_err(iproc_i2c->device, "%d Hz bus speed not supported\n",
> +			bus_speed);
> +		dev_err(iproc_i2c->device,
> +			"valid speeds are 100khz and 400khz\n");
> +		return -EINVAL;
> +	} else if (bus_speed < 400000) {
> +		bus_speed = 100000;
> +		speed_bit = 0;
> +	} else {
> +		bus_speed = 400000;
> +		speed_bit = 1;
> +	}
> +
> +	val = readl(iproc_i2c->base + TIM_CFG_OFFSET);
> +	val &= ~(1 << TIM_CFG_MODE_400_SHIFT);
> +	val |= speed_bit << TIM_CFG_MODE_400_SHIFT;

val |= (bus_speed == 400000) ...

and skip speed_bit? You decide.

> +static void bcm_iproc_i2c_enable(struct bcm_iproc_i2c_dev *iproc_i2c)
> +{
> +	u32 val;
> +
> +	val = readl(iproc_i2c->base + CFG_OFFSET);
> +	val |= 1 << CFG_EN_SHIFT;
> +	writel(val, iproc_i2c->base + CFG_OFFSET);
> +}
> +
> +static void bcm_iproc_i2c_disable(struct bcm_iproc_i2c_dev *iproc_i2c)
> +{
> +	u32 val;
> +
> +	val = readl(iproc_i2c->base + CFG_OFFSET);
> +	val &= ~(1 << CFG_EN_SHIFT);
> +	writel(val, iproc_i2c->base + CFG_OFFSET);
> +}

Extra functions? They are self explaining and only used once. You
decide.

Rest looks fine, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150207/e4a4fb2e/attachment-0001.sig>
