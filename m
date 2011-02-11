From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 11 Feb 2011 15:51:15 +0100
Subject: MMC quirks relating to performance/lifetime.
In-Reply-To: <20110211144139.GC3920@ucw.cz>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com>
	<20110211144139.GC3920@ucw.cz>
Message-ID: <201102111551.15508.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 11 February 2011, Pavel Machek wrote:
> Hi!
> 
> > I'm not sure if this is the best place to bring this up, but Russel's
> > name is on a fair share of drivers/mmc code, and there does seem to be
> > quite a bit of MMC-related discussions. Excuse me in advance if this
> > isn't the right forum :-).
> > 
> > Certain MMC vendors (maybe even quite a bit of them) use a pretty
> > rigid buffering scheme when it comes to handling writes. There is
> > usually a buffer A for random accesses, and a buffer B for sequential
> > accesses. For certain Toshiba parts, it looks like buffer A is 8KB
> > wide, with buffer B being 4MB wide, and all accesses larger than 8KB
> > effectively equating to 4MB accesses. Worse, consecutive small (8k)
> > writes are treated as one large sequential access, once again ending
> > up in buffer B, thus necessitating out-of-order writing to work around
> > this.
> 
> Hmmmm, I somehow assumed MMCs would be much more cleverr than this.

No, these devices are incredibly stupid, or extremely optimized to
a specific use case (writing large video files to FAT32), depending on how
you look at them.

> > reorders) them? The thresholds would then be adjustable as
> > module/kernel parameters based on manfid. I'm asking because I have a
> > patch now, but its ugly and hardcoded against a specific manufacturer.
> 
> How big is performance difference?

Several orders of magnitude. It is very easy to get a card that can write
12 MB/s into a case where it writes no more than 30 KB/s, doing only
things that happen frequently with ext3.

	Arnd
