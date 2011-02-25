From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 25 Feb 2011 13:21:09 +0100
Subject: MMC quirks relating to performance/lifetime.
In-Reply-To: <AANLkTikWKk0kE=Hh4gfA6Mwt+-65TVFnBcOYy_eRuQfw@mail.gmail.com>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com>
	<201102241024.01437.arnd@arndb.de>
	<AANLkTikWKk0kE=Hh4gfA6Mwt+-65TVFnBcOYy_eRuQfw@mail.gmail.com>
Message-ID: <201102251321.09232.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 25 February 2011, Andrei Warkentin wrote:
> Yup. I understand :-).  That's the strategy I'm going to follow. For
> page_size-alignment/splitting I'm looking at the block layer now. Is
> that the right approach or should I still submit a (cleaned up) patch
> to mmc/card/block.c for that performance improvement.

I guess it should live in block/cfq-iosched in the long run, but I don't
know how easy it is to implement it there for test purposes.

It may be easier to prototype it in the mmc code, since you are more
familiar with that already, post that patch together with benchmark
results and then do a new patch for the final solution. We'll need
more benchmarking to figure out if that should be applied for
all nonrotational storage, or if there are cases where it actually
hurts performance to split requests on page boundaries.

If it turns out to be a good idea in general, we won't even need a
sysfs interface for enabling it, just one for reading/writing the
underlying page size.

> The other (Toshiba quirk) is obviously a quirk belonging to mmc/card/block.c.

Makes sense.

	Arnd
