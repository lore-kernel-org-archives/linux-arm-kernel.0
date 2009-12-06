From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 6 Dec 2009 22:08:05 +0100
Subject: [PATCH 1/1] Remove suspend/resume functionality, add dynamic
	clocking
In-Reply-To: <20091206210225.GA20887@pengutronix.de>
References: <083DF309106F364B939360100EC290F804F55C9225@eu1rdcrdc1wx030.exi.nxp.com>
	<20091126090252.GB12179@pengutronix.de>
	<083DF309106F364B939360100EC290F804F5659CFF@eu1rdcrdc1wx030.exi.nxp.com>
	<20091206084731.GE2766@ucw.cz>
	<20091206210225.GA20887@pengutronix.de>
Message-ID: <20091206210739.GE10184@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun 2009-12-06 22:02:25, Uwe Kleine-K?nig wrote:
> Hi,
> 
> On Sun, Dec 06, 2009 at 09:47:31AM +0100, Pavel Machek wrote:
> > Hi!
> > 
> > > > Subject: Re: [PATCH 1/1] Remove suspend/resume functionality, add dynamic
> > > > clocking
> > > > 
> > > > Hello,
> > > > 
> > > > can you please add something like "i2c-pnx: " to the subject?
> > > > (Actually it's a great strategy *not* to put it into the Subject.  This
> > > > way it attracts far more attention :-)
> > > > 
> > > 
> > > Good point!
> > > 
> > > > > Remove suspend/resume functionality, I2C driver gates clock on
> > > > > only when an I2C transaction is in progress
> > > > What happens when the machine suspends while a transfer is in progress?
> > > > (This might be a problem that already existed before.)  If this is
> > > > really a problem the easiest "fix" is to let the suspend callback return
> > > > -EBUSY in this case.
> > > 
> > > The suspend callback is now removed. It's actually not needed with this
> > > change. The I2C clocks will turn on prior to a transaction and then turn
> > > off at the completion.
> > 
> > Are you sure its unneeded? What if someone attempts to suspend the
> > system when a transaction is running?
> That's exactly my question.  I think the machine will suspend and the
> transaction fail.  So no suspend callback isn't optimal, but maybe OK?!

Having failures just because suspend happened at wrong time is
bad. .suspend() should just wait for end of transaction.

										Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
