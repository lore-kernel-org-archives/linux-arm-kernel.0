From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 4 Apr 2014 16:38:47 +0200
Subject: [PATCH v4 2/3] i2c: Add driver for Cadence I2C controller
In-Reply-To: <1396547967-19260-2-git-send-email-soren.brinkmann@xilinx.com>
References: <1396547967-19260-1-git-send-email-soren.brinkmann@xilinx.com>
 <1396547967-19260-2-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <20140404143847.GA5529@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 03, 2014 at 10:59:26AM -0700, Soren Brinkmann wrote:
> Add a driver for the Cadence I2C controller. This controller is for
> example found in Xilinx Zynq.
> 
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> Tested-by: Michal Simek <michal.simek@xilinx.com>
> Reviewed-by: Harini Katakam <harinik@xilinx.com>

Only minor stuff, but since you resend anyhow because of 400kHz issue...

> +static void cdns_i2c_mrecv(struct cdns_i2c *id)
> +{
> +	unsigned int ctrl_reg;
> +	unsigned int isr_status;
> +
> +	id->p_recv_buf = id->p_msg->buf;
> +	id->recv_count = id->p_msg->len;
> +
> +	/* Put the controller in master receive mode and clear the FIFO */
> +	ctrl_reg = cdns_i2c_readreg(CDNS_I2C_CR_OFFSET);
> +	ctrl_reg |= CDNS_I2C_CR_RW | CDNS_I2C_CR_CLR_FIFO;
> +
> +	if ((id->p_msg->flags & I2C_M_RECV_LEN) == I2C_M_RECV_LEN)

'if (id->p_msg->flags & I2C_M_RECV_LEN)' is enough.

> +		/* Report the other error interrupts to application as EIO */
> +		if (id->err_status & (CDNS_I2C_IXR_RX_UNF |
> +				      CDNS_I2C_IXR_TX_OVF |
> +				      CDNS_I2C_IXR_RX_OVF |
> +				      CDNS_I2C_IXR_NACK)) {
> +			cdns_i2c_master_reset(adap);
> +			return -EIO;
> +		}

NACK is returned as -ENXIO. Check 'Documentation/i2c/fault-codes' for
standard patterns. I'd think the rest is EIO, though.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140404/8a19dab4/attachment.sig>
