From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 15 Jan 2015 12:59:57 +0100
Subject: [PATCH v3 2/3] i2c: iproc: Add Broadcom iProc I2C Driver
In-Reply-To: <54B5D0F9.8030902@broadcom.com>
References: <rjui@broadcom.com>
 <1418183832-24793-1-git-send-email-rjui@broadcom.com>
 <1418183832-24793-3-git-send-email-rjui@broadcom.com>
 <20150113225012.GK22880@pengutronix.de>
 <54B5D0F9.8030902@broadcom.com>
Message-ID: <20150115115957.GA2549@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >> +	case M_CMD_STATUS_LOST_ARB:
> >> +		dev_err(dev->device, "lost bus arbitration\n");
> > I wouldn't dev_err that, only dev_dbg. I'm not sure how usual the errors
> > for the next two cases is, maybe degrade them to dev_dbg, too?
> > 
> These errors are rare, and it's nice to keep them at the dev_err level
> so the user will be more aware.

This is wrong. Arbitration lost and NACK is pretty standard stuff on an
I2C bus. User doesn't need to know about it, it is just noise in the
logs. Timeout is different, you can report that (although I should
probably move such a message into the core). Please also use the proper
errno codes defined in Documentation/i2c/fault-codes. They should be
distinct enough to drop the messages.

> 
> >> +		return -EREMOTEIO;
> >> +
> >> +	case M_CMD_STATUS_NACK_ADDR:
> >> +		dev_err(dev->device, "NAK addr:0x%02x\n", dev->msg->addr);
> >> +		return -EREMOTEIO;
> >> +
> >> +	case M_CMD_STATUS_NACK_DATA:
> >> +		dev_err(dev->device, "NAK data\n");
> >> +		return -EREMOTEIO;
> >> +
> >> +	case M_CMD_STATUS_TIMEOUT:
> >> +		dev_err(dev->device, "bus timeout\n");
> >> +		return -ETIMEDOUT;
> >> +
> >> +	default:
> >> +		dev_err(dev->device, "unknown error code=%d\n", val);
> >> +		return -EREMOTEIO;
> >> +	}
> >> +
> >> +	return -EREMOTEIO;
> >> +}
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150115/bb1f03f7/attachment.sig>
