From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 6 Jun 2011 12:28:55 +0200
Subject: MMC and reliable write - was: since when does ARM map the
	kernel memory in sections?
In-Reply-To: <20110503080414.GH5832@shareable.org>
References: <201104122052.17453.pwaechtler@mac.com>
	<201104262100.42670.pwaechtler@mac.com>
	<20110426190719.GA5832@shareable.org>
	<201104262238.02979.pwaechtler@mac.com>
	<20110426224546.GC5832@shareable.org>
	<BANLkTimTsBARiHmbY37bA6oahacs7zbORA@mail.gmail.com>
	<20110427130719.GE5832@shareable.org>
	<BANLkTimMvGfkmcXKrM=vtFNGqdoUJpqwcw@mail.gmail.com>
	<20110503080414.GH5832@shareable.org>
Message-ID: <20110606102855.GA5820@atrey.karlin.mff.cuni.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > So basically add a new REQ_ flag - something like REQ_SAFE, which
> > would ensure that data
> > on block storage is not corrupted due to interrupting this write (or
> > even, after the write, if the card does some optimizations). We
> > already have a flag that ensures corruptions don't occur
> > because of local-to-disk caches - REQ_FUA, so this would just thinking
> > about what effects REQ_FUA  already has that's not considered. On a
> > (spinning) disk, I can't image that interrupting a REQ_FUA write would
> > cause data loss somewhere other than where data was written.
> > 
> > Then it would be as simple as a mount flag that would ensure all
> > (write) accesses are FUA accesses, to ensure desired behavior for
> > platforms where power could be cut at any moment.
> 
> I think you're mixing up different concepts.
> 
> On a spinning hard disk, _all_ writes don't cause data loss other than
> where data is written, rounded up to the sector (512 or 4096 bytes).

...

Yes, so on mmc there are two different problems:

* reliability of write itself (REL_WRITE solves that)

* reliability of data around write (there are for bits "controlling"
  it in 4.4.1 MMC specs, unfortunately they are only writable by card
  manufacturer AFAICS).
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
