From: pwaechtler@mac.com (Peter Waechtler)
Date: Mon, 6 Jun 2011 22:38:26 +0200
Subject: MMC and reliable write - was: since when does ARM map
	=?iso-8859-1?q?the=09kernel_memory_in?= sections?
In-Reply-To: <20110606102855.GA5820@atrey.karlin.mff.cuni.cz>
References: <201104122052.17453.pwaechtler@mac.com>
	<20110503080414.GH5832@shareable.org>
	<20110606102855.GA5820@atrey.karlin.mff.cuni.cz>
Message-ID: <201106062238.26713.pwaechtler@mac.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 6. Juni 2011, 12:28:55 schrieb Pavel Machek:
> Hi!
> 
> > > So basically add a new REQ_ flag - something like REQ_SAFE, which
> > > would ensure that data
> > > on block storage is not corrupted due to interrupting this write (or
> > > even, after the write, if the card does some optimizations). We
> > > already have a flag that ensures corruptions don't occur
> > > because of local-to-disk caches - REQ_FUA, so this would just thinking
> > > about what effects REQ_FUA  already has that's not considered. On a
> > > (spinning) disk, I can't image that interrupting a REQ_FUA write would
> > > cause data loss somewhere other than where data was written.
> > > 
> > > Then it would be as simple as a mount flag that would ensure all
> > > (write) accesses are FUA accesses, to ensure desired behavior for
> > > platforms where power could be cut at any moment.
> > 
> > I think you're mixing up different concepts.
> > 
> > On a spinning hard disk, _all_ writes don't cause data loss other than
> > where data is written, rounded up to the sector (512 or 4096 bytes).
> 
> ...
> 
> Yes, so on mmc there are two different problems:
> 
> * reliability of write itself (REL_WRITE solves that)
> 
> * reliability of data around write (there are for bits "controlling"
>   it in 4.4.1 MMC specs, unfortunately they are only writable by card
>   manufacturer AFAICS).
> 									Pavel

Yes - and there is another issue (but you could say that it fits to 2):

background operations

After programming a page the "pairing" page should be corrected.
Then there is garbage collection and wear leveling. If this is 
interrupted/disturbed by a sudden power loss "at the wrong moment": user data 
gets possibly corrupted.

The power supply has to give you a signal that power will be lost, say, in 30 
ms. Now a mechanism has to be specified how to tell the device to stop any 
programming in a timely fashion - the HPI (high prio interrupt) comes to mind.

	Peter
