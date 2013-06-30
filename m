From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 30 Jun 2013 14:04:56 +0100
Subject: [PATCH RFC 1/3] DRM: Armada: Add Armada DRM driver
In-Reply-To: <20130630123741.GJ18285@phenom.ffwll.local>
References: <20130629225210.GF3353@n2100.arm.linux.org.uk>
 <E1Ut41C-0000wl-Ff@rmk-PC.arm.linux.org.uk>
 <20130630123741.GJ18285@phenom.ffwll.local>
Message-ID: <20130630130456.GI3353@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 30, 2013 at 02:37:41PM +0200, Daniel Vetter wrote:
> On Sat, Jun 29, 2013 at 11:53:22PM +0100, Russell King wrote:
> > +		mutex_lock(&dev->struct_mutex);
> > +		free = drm_mm_search_free(&priv->linear, size, align, 0);
> > +		if (free)
> > +			obj->linear = drm_mm_get_block(free, size, align);
> > +		mutex_unlock(&dev->struct_mutex);
> 
> The two-stage search_free+get_block drm_mm interface is something I'd like
> to remove since it' complicates the interface for no gain. And the
> preallocation trick for atomic contexts is pretty racy as-is. Can you
> please convert this over to the insert_node interfaces which take a
> preallocate drm_mm_node?

Yes and no.  This is only racy if it is callable from atomic contexts,
which the above isn't, because it takes a mutex, and the above is the
only place which allocations against that pool are done.  Mutexes can't
be taken in atomic contexts.  Plus it's using the non-atomic drm_mm_*
interfaces.

However, the insert_node interfaces appear not to solve any kind of race.
All they do is allow the kmalloc to be moved out of this region into
the user of this code sequence, while offering no additional locking or
safety.  So the mutex lock around a call to drm_mm_insert_node*() is
still required.

As the kmalloc() happens beneath the mutex lock, another thread can't race
with an allocation in the above code anyway.  The *only* reason I'll change
this is that it is nicer to the system not to hold locks while allocating
memory.
