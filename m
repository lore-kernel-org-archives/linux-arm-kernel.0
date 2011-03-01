From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 1 Mar 2011 20:51:13 +0100
Subject: MMC quirks relating to performance/lifetime.
In-Reply-To: <4D6D45D2.2020900@kernel.dk>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com>
	<201103012011.51855.arnd@arndb.de> <4D6D45D2.2020900@kernel.dk>
Message-ID: <201103012051.13768.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 01 March 2011 20:15:30 Jens Axboe wrote:
> Thanks for the recap. One way to handle this would be to have a dm
> target that ensures that requests are never built up to violate any of
> the above items. Doing splitting is a little silly, when you can prevent
> it from happening in the first place.

Ok, that sounds good. I didn't know that it's possible to prevent
bios from getting created that violate this.

I'm actually trying to do a device mapper target that does much more than
this, see
https://wiki.linaro.org/WorkingGroups/KernelConsolidation/Projects/FlashDeviceMapper
for an early draft. The design has moved on since I wrote that, but
the basic idea is still the same: all blocks get written in a way that
fills up entire 4MB segments before moving to another segment,
independent of what the logical block numbers are, and a little space
is used to store a lookup table for the logical-to-physical block mapping.

> Alternatively, a queue ->merge_bvec_fn() with a settings table could
> provide the same.

That's probably better for the common case. The device mapper target
would be useful for those that want the best case write performance,
but if I understand you correctly, the merge_bvec_fn() could be used
per block driver, so we could simply add that to the SCSI (for USB and
consumer SSD) case and MMC block drivers.

The point that this does not solve is submitting all outstanding writes
for an erase block together, which is needed to reduce the garbage
collection overhead. When you do a partial update of an erase block
(4MB typically) and then start writing to another erase block, the
drive will have to copy all data you did not write in order to free
up internal resources.

> As this is of limited scope, I would prefer having this done via a
> plugin of some sort (like a dm target).

I'm not sure what you mean with limited scope. This is certainly not
as important for the classic server environment (aside from USB boot
drives), but I assume that it is highly relevant for the a large
portion of new embedded designs as people move from raw flash to
eMMC and similar "technologies".

	Arnd
