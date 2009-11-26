From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 Nov 2009 10:41:07 +0000
Subject: [PATCH 1/1] Remove suspend/resume functionality, add dynamic
	clocking
In-Reply-To: <20091126090252.GB12179@pengutronix.de>
References: <083DF309106F364B939360100EC290F804F55C9225@eu1rdcrdc1wx030.exi.nxp.com>
	<20091126090252.GB12179@pengutronix.de>
Message-ID: <20091126104107.GA2393@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 26, 2009 at 10:02:52AM +0100, Uwe Kleine-K?nig wrote:
> Hello,
> 
> can you please add something like "i2c-pnx: " to the subject?
> (Actually it's a great strategy *not* to put it into the Subject.  This
> way it attracts far more attention :-)
> 
> > Remove suspend/resume functionality, I2C driver gates clock on
> > only when an I2C transaction is in progress
> What happens when the machine suspends while a transfer is in progress?
> (This might be a problem that already existed before.)  If this is
> really a problem the easiest "fix" is to let the suspend callback return
> -EBUSY in this case.

If it's a short-lived event (i2c transfers tend to be) the best thing is
to wait for the event to complete before continuing.  Most of the suspend
callbacks (except the noirq versions) are called in process context and
can sleep.

Returning -EBUSY means you abort the suspend entirely and it has to be
started again from the beginning.  Too bad if the suspend request was
because your battery was just ab............
