From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 18 Apr 2010 14:45:02 +0100
Subject: [PATCH 2/3] i2c/pxa: only define 'blue_murder'-function if
	DEBUG is #defined
In-Reply-To: <20100418132251.GB21364@pengutronix.de>
References: <20100224110044.GB15181@pengutronix.de>
	<1267009306-17227-2-git-send-email-u.kleine-koenig@pengutronix.de>
	<20100228155502.GB16745@n2100.arm.linux.org.uk>
	<20100418132251.GB21364@pengutronix.de>
Message-ID: <20100418134502.GA15452@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 18, 2010 at 03:22:51PM +0200, Wolfram Sang wrote:
> 
> Sorry to bump this old thread, it dropped off my todo-list :(
> 
> On Sun, Feb 28, 2010 at 03:55:02PM +0000, Russell King - ARM Linux wrote:
> > On Wed, Feb 24, 2010 at 12:01:45PM +0100, Uwe Kleine-K?nig wrote:
> > > From: Wolfram Sang <w.sang@pengutronix.de>
> > > 
> > > This talkative function is also called on timeouts. As timeouts can
> > > happen on regular writes to EEPROMs (no error case), this creates false
> > > positives.  Giving lots of details is interesting only for developers
> > > anyhow, so just use the function if DEBUG is #defined.
> > 
> > Are you sure this is safe?  If you time out the write before it completes,
> > how do you know if the write was successful?
> > 
> > I don't think this is "no error code" nor "false positive".  If the timeout
> > is too short for your EEPROMs, then the timeout needs to be increased.
> 
> I am sure this is safe because we have retries. The eeprom driver first tries
> to write data without a delay, because EEPROMs often have buffers. Once the
> buffers are full, the chip will not answer to the next write request which will
> result in a timeout for this write request. This is expected, so it will be
> retried after some delay. Something like -EBUSY. Only if another "outer"
> timeout passed after some retries, then we have a problem and this should be
> user visible. But the timeout for the write request is nothing exceptional and
> the user doesn't need to be informed about it, especially not in this detail.
> This is what the patch is addressing.

And what if it's not an EEPROM that you're talking to?
