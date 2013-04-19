From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 19 Apr 2013 11:21:42 +0100
Subject: v7_flush_kern_cache_louis flushes up to L2?
In-Reply-To: <51656A89.9090600@arm.com>
References: <CABYn4sxUCoWhC_4qydzbCtZdQdetqFZ_u5WtXsghprQget9f5g@mail.gmail.com>
 <51655248.7000401@arm.com>
 <CABYn4swK_FB+nPO4vKZM8khp+mjaPwkAv_GF+XDg5SYz0VLf0Q@mail.gmail.com>
 <51656A89.9090600@arm.com>
Message-ID: <20130419102142.GI14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 10, 2013 at 02:35:05PM +0100, Jonathan Austin wrote:
> Note that on SMP, you would also need to clean/flush again after turning  
> off the caches, as read-speculation could have sucked dirty data from  
> another cache in to your cache, which would need to be written back  
> before sleeping.

Err, no.  If you read data into a cache, it is always populated in a clean
state.  You never suck dirty data out of one cache, remove it there and
place it immediately in a dirty state in an upper level cache.

So, if we start from the idea that reads will populate the upper level
cache with clean data, that cache is populated merely with a _copy_ of
the data held elsewhere in the system.

In that case, there is no need to clean or flush that cache after turning
it off - if the cache only contains _copies_ of data elsewhere in the
system, then it's perfectly fine for that data to be discarded in any
way - be that by turning the power off to the cache or invalidating it.

There is a step further in this: if the cache is being dirtied by the
local CPU, and that data will only ever be used by the local CPU, again,
in the CPU shutdown path, you really do not need to write that data out -
because the only CPU which cares about it is the local CPU which is going
to be shutdown.  So, loss of that data is not a problem.

In other words, shutdown of a CPU is a process which involves pushing out
data which the rest of the system requires (that's done by an initial
flush).  Once that flush is done, provided the dying CPU does not _write_
to any shared data (this includes spinlocks and such like too), there is
no need to flush the cache anymore.
