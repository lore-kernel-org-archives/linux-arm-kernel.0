From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 19 Mar 2015 12:48:42 +0100
Subject: [PATCH] spi: trigger trace event for message-done before
 mesg->complete
In-Reply-To: <20150319112430.GP2869@sirena.org.uk>
References: <1426674448-8246-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20150318113635.GB2869@sirena.org.uk>
 <20150318133226.GR10068@pengutronix.de>
 <20150318135854.GI2869@sirena.org.uk>
 <20150318144854.GS10068@pengutronix.de>
 <20150319112430.GP2869@sirena.org.uk>
Message-ID: <20150319114842.GU10068@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mark,

On Thu, Mar 19, 2015 at 11:24:30AM +0000, Mark Brown wrote:
> On Wed, Mar 18, 2015 at 03:48:54PM +0100, Uwe Kleine-K?nig wrote:
> > On Wed, Mar 18, 2015 at 01:58:54PM +0000, Mark Brown wrote:
> 
> > > My point here is that the analysis of the issue shouldn't depend on
> > > spidev in particular, if you need to call out the specific driver you're
> > > working with that's an alarm sign that it's doing something weird and
> > > perhaps the problem is with the driver.
> 
> > This just happens to be the driver I saw the problem with. Don't have
> > another spi device on that bus to cross check with other drivers. I
> > wouldn't be too concerned here.
> 
> Sure, but it's better to write it up in terms of a generic driver - it's
> the difference between "let's work around this driver" and "the core
> isn't doing the right thing for drivers here".
OK, so something like:

------------>8------------
spi: trigger trace event for message-done before mesg->complete

The message's complete callback might (permissibly) free the memory that
holds the message. As recording the trace event for the end of a
transfer accesses this message the recording is better done first.

This fixes an oops observed on a 3.14-rt system with bus activity using
spidev after

        echo 1 > /sys/kernel/debug/tracing/events/spi/enable

. (For spidev mesg->complete points to spidev_complete. Calling that
unblocks spidev_sync and so spidev_sync_write (or spidev_sync_read).
This in turn leaves the scope of the local variable that holds the
message.)
------------>8------------

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
