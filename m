From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 19 Apr 2013 11:48:10 +0100
Subject: v7_flush_kern_cache_louis flushes up to L2?
In-Reply-To: <20130419102142.GI14496@n2100.arm.linux.org.uk>
References: <CABYn4sxUCoWhC_4qydzbCtZdQdetqFZ_u5WtXsghprQget9f5g@mail.gmail.com>
 <51655248.7000401@arm.com>
 <CABYn4swK_FB+nPO4vKZM8khp+mjaPwkAv_GF+XDg5SYz0VLf0Q@mail.gmail.com>
 <51656A89.9090600@arm.com> <20130419102142.GI14496@n2100.arm.linux.org.uk>
Message-ID: <20130419104810.GJ14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 19, 2013 at 11:21:42AM +0100, Russell King - ARM Linux wrote:
> On Wed, Apr 10, 2013 at 02:35:05PM +0100, Jonathan Austin wrote:
> > Note that on SMP, you would also need to clean/flush again after turning  
> > off the caches, as read-speculation could have sucked dirty data from  
> > another cache in to your cache, which would need to be written back  
> > before sleeping.
> 
> Err, no.  If you read data into a cache, it is always populated in a clean
> state.  You never suck dirty data out of one cache, remove it there and
> place it immediately in a dirty state in an upper level cache.
> 
> So, if we start from the idea that reads will populate the upper level
> cache with clean data, that cache is populated merely with a _copy_ of
> the data held elsewhere in the system.

Hmm, Will tells me that later ARM cores can migrate dirty cache lines up
the cache tree, which means that we're potentially into deep problems
with CPU hotplug and suspend paths, because it means there's potentially
no way to ensure that we cleanly push data out the caches and shut the
caches down before the CPU goes down.

Combine this cache behaviour with the implementation specific details
about SCTRL.C (whether caches are just prevented from being allocated,
or whether it also affects the caches being searched) and you have a
recipe for multiple chunks of complex platform specific and CPU
specific code - especially when combined with things like removal of
CPU power and synchronisation of that in the hotplug case.

I do hope that ARM Ltd have thought about this, and have a way that we
can shut CPU caches down sanely, but I'm fearing that they haven't
really considered that to be something anyone really wants to do in a
generic way.
