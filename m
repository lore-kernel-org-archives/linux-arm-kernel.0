From: w.sang@pengutronix.de (Wolfram Sang)
Date: Sun, 18 Apr 2010 16:05:48 +0200
Subject: [PATCH 2/3] i2c/pxa: only define 'blue_murder'-function if
	DEBUG is #defined
In-Reply-To: <20100418134502.GA15452@n2100.arm.linux.org.uk>
References: <20100224110044.GB15181@pengutronix.de>
	<1267009306-17227-2-git-send-email-u.kleine-koenig@pengutronix.de>
	<20100228155502.GB16745@n2100.arm.linux.org.uk>
	<20100418132251.GB21364@pengutronix.de>
	<20100418134502.GA15452@n2100.arm.linux.org.uk>
Message-ID: <20100418140548.GC21364@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > I am sure this is safe because we have retries. The eeprom driver first tries
> > to write data without a delay, because EEPROMs often have buffers. Once the
> > buffers are full, the chip will not answer to the next write request which will
> > result in a timeout for this write request. This is expected, so it will be
> > retried after some delay. Something like -EBUSY. Only if another "outer"
> > timeout passed after some retries, then we have a problem and this should be
> > user visible. But the timeout for the write request is nothing exceptional and
> > the user doesn't need to be informed about it, especially not in this detail.
> > This is what the patch is addressing.
> 
> And what if it's not an EEPROM that you're talking to?

That's up to the corresponding driver. The driver is still notified via the
return value how many i2c-messages could be transmitted. If this is not equal
to what the driver intended, then it can decide to retry or notify the user.
And that is the apropriate level. Doing all this printout at the bus-driver
level is only interesting for developers. Users are frightened by the "timeout"
in their logs although everything might be as expected. A bus driver can't
know.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100418/b4e5ff85/attachment.sig>
