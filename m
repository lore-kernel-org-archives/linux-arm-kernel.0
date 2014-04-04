From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Fri, 4 Apr 2014 09:32:32 -0700
Subject: [PATCH v4 2/3] i2c: Add driver for Cadence I2C controller
In-Reply-To: <20140404143847.GA5529@katana>
References: <1396547967-19260-1-git-send-email-soren.brinkmann@xilinx.com>
 <1396547967-19260-2-git-send-email-soren.brinkmann@xilinx.com>
 <20140404143847.GA5529@katana>
Message-ID: <53e29fb2-2a42-4cbf-9c15-490d81ee0de4@CH1EHSMHS005.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-04-04 at 04:38PM +0200, Wolfram Sang wrote:
> On Thu, Apr 03, 2014 at 10:59:26AM -0700, Soren Brinkmann wrote:
> > Add a driver for the Cadence I2C controller. This controller is for
> > example found in Xilinx Zynq.
> > 
> > Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> > Tested-by: Michal Simek <michal.simek@xilinx.com>
> > Reviewed-by: Harini Katakam <harinik@xilinx.com>
> 
> Only minor stuff, but since you resend anyhow because of 400kHz issue...
> 
> > +static void cdns_i2c_mrecv(struct cdns_i2c *id)
> > +{
> > +	unsigned int ctrl_reg;
> > +	unsigned int isr_status;
> > +
> > +	id->p_recv_buf = id->p_msg->buf;
> > +	id->recv_count = id->p_msg->len;
> > +
> > +	/* Put the controller in master receive mode and clear the FIFO */
> > +	ctrl_reg = cdns_i2c_readreg(CDNS_I2C_CR_OFFSET);
> > +	ctrl_reg |= CDNS_I2C_CR_RW | CDNS_I2C_CR_CLR_FIFO;
> > +
> > +	if ((id->p_msg->flags & I2C_M_RECV_LEN) == I2C_M_RECV_LEN)
> 
> 'if (id->p_msg->flags & I2C_M_RECV_LEN)' is enough.
> 
> > +		/* Report the other error interrupts to application as EIO */
> > +		if (id->err_status & (CDNS_I2C_IXR_RX_UNF |
> > +				      CDNS_I2C_IXR_TX_OVF |
> > +				      CDNS_I2C_IXR_RX_OVF |
> > +				      CDNS_I2C_IXR_NACK)) {
> > +			cdns_i2c_master_reset(adap);
> > +			return -EIO;
> > +		}
> 
> NACK is returned as -ENXIO. Check 'Documentation/i2c/fault-codes' for
> standard patterns. I'd think the rest is EIO, though.

Okay, I'll put this into the next version:
diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
index 43af8c351c8b..63f3f03ecc9b 100644
--- a/drivers/i2c/busses/i2c-cadence.c
+++ b/drivers/i2c/busses/i2c-cadence.c
@@ -311,7 +311,7 @@ static void cdns_i2c_mrecv(struct cdns_i2c *id)
        ctrl_reg = cdns_i2c_readreg(CDNS_I2C_CR_OFFSET);
        ctrl_reg |= CDNS_I2C_CR_RW | CDNS_I2C_CR_CLR_FIFO;
 
-       if ((id->p_msg->flags & I2C_M_RECV_LEN) == I2C_M_RECV_LEN)
+       if (id->p_msg->flags & I2C_M_RECV_LEN)
                id->recv_count = I2C_SMBUS_BLOCK_MAX + 1;
 
        /*
@@ -531,12 +531,13 @@ static int cdns_i2c_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
                if (ret)
                        return ret;
 
-               /* Report the other error interrupts to application as EIO */
-               if (id->err_status & (CDNS_I2C_IXR_RX_UNF |
-                                     CDNS_I2C_IXR_TX_OVF |
-                                     CDNS_I2C_IXR_RX_OVF |
-                                     CDNS_I2C_IXR_NACK)) {
+               /* Report the other error interrupts to application */
+               if (id->err_status) {
                        cdns_i2c_master_reset(adap);
+
+                       if (id->err_status & CDNS_I2C_IXR_NACK)
+                               return -ENXIO;
+
                        return -EIO;
                }
        }

	Thanks,
	S?ren
