From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sat, 17 Jan 2015 17:01:13 +0100
Subject: [PATCH v4 2/3] i2c: iproc: Add Broadcom iProc I2C Driver
In-Reply-To: <54B98C18.4080807@broadcom.com>
References: <rjui@broadcom.com>
 <1421274213-3544-1-git-send-email-rjui@broadcom.com>
 <1421274213-3544-3-git-send-email-rjui@broadcom.com>
 <20150115084119.GN22880@pengutronix.de>
 <54B98C18.4080807@broadcom.com>
Message-ID: <20150117160113.GA22880@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, Jan 16, 2015 at 02:09:28PM -0800, Ray Jui wrote:
> On 1/15/2015 12:41 AM, Uwe Kleine-K?nig wrote:
> > On Wed, Jan 14, 2015 at 02:23:32PM -0800, Ray Jui wrote:
> >> +	 */
> >> +	val = 1 << M_CMD_START_BUSY_SHIFT;
> >> +	if (msg->flags & I2C_M_RD) {
> >> +		val |= (M_CMD_PROTOCOL_BLK_RD << M_CMD_PROTOCOL_SHIFT) |
> >> +		       (msg->len << M_CMD_RD_CNT_SHIFT);
> >> +	} else {
> >> +		val |= (M_CMD_PROTOCOL_BLK_WR << M_CMD_PROTOCOL_SHIFT);
> >> +	}
> >> +	writel(val, iproc_i2c->base + M_CMD_OFFSET);
> >> +
> >> +	time_left = wait_for_completion_timeout(&iproc_i2c->done, time_left);
> > 
> > When the interrupt fires here after the complete timed out and before
> > you disable the irq you still throw the result away.
> Yes, but then this comes down to the fact that if it has reached the
> point that is determined to be a timeout condition in the driver, one
> should really treat it as timeout error. In a normal condition,
> time_left should never reach zero.
I don't agree here. I'm not sure there is a real technical reason,
though. But still if you're in a "success after timeout already over"
situation it's IMHO better to interpret it as success, not timeout.

> >> +static int bcm_iproc_i2c_remove(struct platform_device *pdev)
> >> +{
> >> +	struct bcm_iproc_i2c_dev *iproc_i2c = platform_get_drvdata(pdev);
> >> +
> >> +	i2c_del_adapter(&iproc_i2c->adapter);
> > You need to free the irq before i2c_del_adapter.
> > 
> Yes. Thanks. Change back to use devm_request_irq, and use disable_irq
> here before removing the adapter.
The more lightweight approach is to set your device's irq-enable
register to zero and call synchronize_irq. (For a shared irq calling
disable_irq is even wrong here.)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
