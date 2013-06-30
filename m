From: daniel@ffwll.ch (Daniel Vetter)
Date: Sun, 30 Jun 2013 18:58:48 +0200
Subject: [PATCH RFC 1/3] DRM: Armada: Add Armada DRM driver
In-Reply-To: <20130630134151.GJ3353@n2100.arm.linux.org.uk>
References: <20130629225210.GF3353@n2100.arm.linux.org.uk>
 <E1Ut41C-0000wl-Ff@rmk-PC.arm.linux.org.uk>
 <20130630123741.GJ18285@phenom.ffwll.local>
 <20130630130456.GI3353@n2100.arm.linux.org.uk>
 <20130630134151.GJ3353@n2100.arm.linux.org.uk>
Message-ID: <CAKMK7uHVQd7wF3pYwGWf7k=Xjas9qTKTmGhjARrLVENNZLkVJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 30, 2013 at 3:41 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sun, Jun 30, 2013 at 02:04:56PM +0100, Russell King - ARM Linux wrote:
>> On Sun, Jun 30, 2013 at 02:37:41PM +0200, Daniel Vetter wrote:
>> > On Sat, Jun 29, 2013 at 11:53:22PM +0100, Russell King wrote:
>> > > +         mutex_lock(&dev->struct_mutex);
>> > > +         free = drm_mm_search_free(&priv->linear, size, align, 0);
>> > > +         if (free)
>> > > +                 obj->linear = drm_mm_get_block(free, size, align);
>> > > +         mutex_unlock(&dev->struct_mutex);
>> >
>> > The two-stage search_free+get_block drm_mm interface is something I'd like
>> > to remove since it' complicates the interface for no gain. And the
>> > preallocation trick for atomic contexts is pretty racy as-is. Can you
>> > please convert this over to the insert_node interfaces which take a
>> > preallocate drm_mm_node?
>>
>> Yes and no.  This is only racy if it is callable from atomic contexts,
>> which the above isn't, because it takes a mutex, and the above is the
>> only place which allocations against that pool are done.  Mutexes can't
>> be taken in atomic contexts.  Plus it's using the non-atomic drm_mm_*
>> interfaces.
>>
>> However, the insert_node interfaces appear not to solve any kind of race.
>> All they do is allow the kmalloc to be moved out of this region into
>> the user of this code sequence, while offering no additional locking or
>> safety.  So the mutex lock around a call to drm_mm_insert_node*() is
>> still required.
>>
>> As the kmalloc() happens beneath the mutex lock, another thread can't race
>> with an allocation in the above code anyway.  The *only* reason I'll change
>> this is that it is nicer to the system not to hold locks while allocating
>> memory.
>
> Err.  There's bugs here in the other drivers such as i915 which follow
> your suggestion.  The problem is this:
>
> Every time they allocate using drm_mm_insert_node(), they kmalloc a new
> struct drm_mm_node for this function to fill in and attach.
>
> When they've done with the allocation, they call drm_mm_put_block().
> This places the node onto the mm's unused_nodes list provided we don't
> already have MM_UNUSED_TARGET nodes on that list.

Yeah, for drivers that never use the atomic alloc stuff it's pointless
waste of memory.

> So, we end up filling up the unused nodes list to MM_UNUSED_TARGET,
> at which point we then start freeing any further nodes - and with no
> way to pull these off that list, they all just sit there not being
> used.
>
> The only function which takes nodes off that list is drm_mm_kmalloc(),
> which is declared statically, and so isn't available to drivers.
>
> Are drivers which use the drm_mm_insert_node() function expected to
> also use drm_mm_remove_node(), kfreeing the node after that call,
> rather than using drm_mm_put_block() ?

Yeah, with the insert_node interface deallocing the node is the
driver's responsibility.

> Either way, I think someone needs to fix the other drivers and Cc those
> patches to Stable...

Yeah, I think it's time that I move that item up my todo list a lot.
And also add some decent kerneldoc to the drm_mm stuff.
-Daniel
--
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
