From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 8 Dec 2015 09:19:24 +0100
Subject: [PATCH v3 09/10] PM / Hibernate: Publish pages restored in-place
 to arch code
In-Reply-To: <56656D6C.5010004@arm.com>
References: <1448559168-8363-1-git-send-email-james.morse@arm.com>
 <1448559168-8363-10-git-send-email-james.morse@arm.com>
 <20151205093534.GA7569@amd> <56656D6C.5010004@arm.com>
Message-ID: <20151208081923.GA22680@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > Umm. Could the copy function be modified to do the neccessary
> > flushing, instead?
> 
> The copying is done by load_image_lzo() using memcpy() if you have
> compression enabled, and by load_image() using swap_read_page() if you
> don't.
> 
> I didn't do it here as it would clean every page copied, which was the
> worrying part of the previous approach. If there is an architecture
> where this cache-clean operation is expensive, it would slow down
> restore. I was trying to benchmark the impact of this on 32bit arm when
> I spotted it was broken.

You have just loaded the page from slow storage (hard drive,
MMC). Cleaning a page should be pretty fast compared to that.

> This allocated-same-page code path doesn't happen very often, so we
> don't want this to have an impact on the 'normal' code path. On 32bit
> arm I saw ~20 of these allocations out of ~60,000 pages.
> 
> This new way allocates a few extra pages during restore, and doesn't
> assume that flush_cache_range() needs calling. It should have no impact
> on architectures that aren't using the new list.

It is also complex.

> > Alternatively, can you just clean the whole cache before jumping to
> > the new kernel?
> 
> On arm64, cleaning the whole cache means cleaning all of memory by
> virtual address, which would be a high price to pay when we only need to
> clean the pages we copied. The current implementation does clean all

How high price to pay? I mean, hibernation/restore takes
_seconds_. Paying miliseconds to have cleaner code is acceptable
price.


									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
