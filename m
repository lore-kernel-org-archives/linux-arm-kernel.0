From: chris@chris-wilson.co.uk (Chris Wilson)
Date: Sun, 9 Oct 2016 20:26:11 +0100
Subject: [PATCH] mm/vmalloc: reduce the number of lazy_max_pages to
 reduce latency
In-Reply-To: <CAEi0qNnozbib-92NwWpUV=_YiiUHYGzzBuuY8kDZY9gaZm-W7Q@mail.gmail.com>
References: <20160929073411.3154-1-jszhang@marvell.com>
 <20160929081818.GE28107@nuc-i3427.alporthouse.com>
 <CAD=GYpYKL9=uY=Fks2xO6oK3bJ772yo4EiJ1tJkVU9PheSD+Cw@mail.gmail.com>
 <20161009124242.GA2718@nuc-i3427.alporthouse.com>
 <CAEi0qNnozbib-92NwWpUV=_YiiUHYGzzBuuY8kDZY9gaZm-W7Q@mail.gmail.com>
Message-ID: <20161009192610.GB2718@nuc-i3427.alporthouse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 09, 2016 at 12:00:31PM -0700, Joel Fernandes wrote:
> Ok. So I'll submit a patch with mutex for purge_lock and use
> cond_resched_lock for the vmap_area_lock as you suggested. I'll also
> drop the lazy_max_pages to 8MB as Andi suggested to reduce the lock
> hold time. Let me know if you have any objections.

The downside of using a mutex here though, is that we may be called
from contexts that cannot sleep (alloc_vmap_area), or reschedule for
that matter! If we change the notion of purged, we can forgo the mutex
in favour of spinning on the direct reclaim path. That just leaves the
complication of whether to use cond_resched_lock() or a lock around
the individual __free_vmap_area().
-Chris

-- 
Chris Wilson, Intel Open Source Technology Centre
