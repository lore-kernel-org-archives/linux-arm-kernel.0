From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 28 Jun 2017 11:20:24 +0200
Subject: [PATCH v5] drm/sun4i: hdmi: Implement I2C adapter for A10s DDC bus
In-Reply-To: <20170627143652.13075-1-net147@gmail.com>
References: <20170627143652.13075-1-net147@gmail.com>
Message-ID: <20170628092024.ejxy6itqj3hx6yew@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 28, 2017 at 12:36:52AM +1000, Jonathan Liu wrote:
> +#define SUN4I_HDMI_DDC_INT_STATUS_ERROR_MASK ( \
> +	SUN4I_HDMI_DDC_INT_STATUS_ILLEGAL_FIFO_OPERATION | \
> +	SUN4I_HDMI_DDC_INT_STATUS_DDC_RX_FIFO_UNDERFLOW | \
> +	SUN4I_HDMI_DDC_INT_STATUS_DDC_TX_FIFO_OVERFLOW | \
> +	SUN4I_HDMI_DDC_INT_STATUS_ARBITRATION_ERROR | \
> +	SUN4I_HDMI_DDC_INT_STATUS_ACK_ERROR | \
> +	SUN4I_HDMI_DDC_INT_STATUS_BUS_ERROR \
> +)
> +
> +static bool is_err_status(u32 int_status)
> +{
> +	return !!(int_status & SUN4I_HDMI_DDC_INT_STATUS_ERROR_MASK);
> +}
> +
> +static bool is_fifo_flag_unset(struct sun4i_hdmi *hdmi, u32 *fifo_status,
> +			       u32 flag)
> +{
> +	*fifo_status = readl(hdmi->base + SUN4I_HDMI_DDC_FIFO_STATUS_REG);
> +	return !(*fifo_status & flag);
> +}
> +
> +static int fifo_transfer(struct sun4i_hdmi *hdmi, u8 *buf, int len, bool read)
> +{
> +	/* 1 byte takes 9 clock cycles (8 bits + 1 ACK) */
> +	unsigned long byte_time = DIV_ROUND_UP(USEC_PER_SEC,
> +					       clk_get_rate(hdmi->ddc_clk)) * 9;

There's no real need for it to be dynamic. The clock rate will not
change, and the order of magnitude is roughly 100us, so let's just use
that (and make a comment).

> +	u32 int_status;
> +	u32 fifo_status;
> +	/* Read needs empty flag unset, write needs full flag unset */
> +	u32 flag = read ? SUN4I_HDMI_DDC_FIFO_STATUS_EMPTY :
> +			  SUN4I_HDMI_DDC_FIFO_STATUS_FULL;
> +	int ret;
> +
> +	/* Wait until error or FIFO ready */
> +	ret = readl_poll_timeout(hdmi->base + SUN4I_HDMI_DDC_INT_STATUS_REG,
> +				 int_status,
> +				 is_err_status(int_status) ||
> +				 is_fifo_flag_unset(hdmi, &fifo_status, flag),
> +				 min(len, SUN4I_HDMI_DDC_FIFO_SIZE) * byte_time,
> +				 100000);
> +
> +	if (is_err_status(int_status))
> +		return -EIO;
> +	if (ret)
> +		return -ETIMEDOUT;

Why not just have
ret = readl_poll_timeout(hdmi->base + SUN4I_HDMI_DDC_FIFO_STATUS_REG, reg,
			 !(reg & flag), 100, 100000);

if (ret < 0)
	if (is_err_status())
		return -EIO;
	return ret;


> +
> +	/* Read FIFO level */
> +	int level = (int)(fifo_status & SUN4I_HDMI_DDC_FIFO_STATUS_LEVEL_MASK);

and explicitly read the fifo status here. That will make you remove
that function that does two things while claiming that it does only
one, and it will be more obvious.

You can also just use reg at this point, instead of reading it once
again.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170628/52598f2f/attachment.sig>
