From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 Feb 2011 18:16:56 +0100
Subject: MMC quirks relating to performance/lifetime.
In-Reply-To: <AANLkTinPtiwXmtRy9qS2zZXwuhQDOyO-H8-wmF=fSNnJ@mail.gmail.com>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com>
	<201102142122.54766.arnd@arndb.de>
	<AANLkTinPtiwXmtRy9qS2zZXwuhQDOyO-H8-wmF=fSNnJ@mail.gmail.com>
Message-ID: <201102151816.57104.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 14 February 2011, Andrei Warkentin wrote:
> > There are multiple ways how this could be implemented:
> >
> > 1. Have one exception cache for all "special" blocks. This would normally
> >   be for FAT32 subdirectory updates, which always write to the same
> >   few blocks. This means you can do small writes efficiently anywhere
> >   on the card, but only up to a (small) fixed number of block addresses.
> >   If you overflow the table, the card still needs to go through an
> >   extra PE for each new entry you write, in order to free up an entry.
> >
> > 2. Have a small number of AUs that can be in a special mode with efficient
> >   small writes but inefficient large writes. This means that when you
> >   alternate between small and large writes in the same AU, it has to go
> >   through a PE on every switch. Similarly, if you do small writes to
> >   more than the maximum number of AUs that can be held in this mode, you
> >   get the same effect. This number can be as small as one, because that
> >   is what FAT32 requires.
> >
> > In both cases, you don't actually have a solution for the problem, you just
> > make it less likely for specific workloads.
> 
> Aha, ok. By the way, I did find out that either suggestion works. So
> I'll pull out the reversing portion of the patch. No need to
> overcomplicate :).

BTW, what file system are you using? I could imagine that each of ext4, btrfs
and nilfs2 give you very different results here. It could be that if your
patch is optimizing for one file system, it is actually pessimising for
another one.

What benchmark do you use to find out of your optimizations actually help you?

	Arnd
