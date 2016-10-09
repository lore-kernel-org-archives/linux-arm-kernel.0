From: joel.opensrc@gmail.com (Joel Fernandes)
Date: Sun, 9 Oct 2016 12:00:31 -0700
Subject: [PATCH] mm/vmalloc: reduce the number of lazy_max_pages to reduce
 latency
In-Reply-To: <20161009124242.GA2718@nuc-i3427.alporthouse.com>
References: <20160929073411.3154-1-jszhang@marvell.com>
 <20160929081818.GE28107@nuc-i3427.alporthouse.com>
 <CAD=GYpYKL9=uY=Fks2xO6oK3bJ772yo4EiJ1tJkVU9PheSD+Cw@mail.gmail.com>
 <20161009124242.GA2718@nuc-i3427.alporthouse.com>
Message-ID: <CAEi0qNnozbib-92NwWpUV=_YiiUHYGzzBuuY8kDZY9gaZm-W7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 9, 2016 at 5:42 AM, Chris Wilson <chris@chris-wilson.co.uk> wrote:
[..]
>> > My understanding is that
>> >
>> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>> > index 91f44e78c516..3f7c6d6969ac 100644
>> > --- a/mm/vmalloc.c
>> > +++ b/mm/vmalloc.c
>> > @@ -626,7 +626,6 @@ void set_iounmap_nonlazy(void)
>> >  static void __purge_vmap_area_lazy(unsigned long *start, unsigned long *end,
>> >                                         int sync, int force_flush)
>> >  {
>> > -       static DEFINE_SPINLOCK(purge_lock);
>> >         struct llist_node *valist;
>> >         struct vmap_area *va;
>> >         struct vmap_area *n_va;
>> > @@ -637,12 +636,6 @@ static void __purge_vmap_area_lazy(unsigned long *start, unsigned long *end,
>> >          * should not expect such behaviour. This just simplifies locking for
>> >          * the case that isn't actually used at the moment anyway.
>> >          */
>> > -       if (!sync && !force_flush) {
>> > -               if (!spin_trylock(&purge_lock))
>> > -                       return;
>> > -       } else
>> > -               spin_lock(&purge_lock);
>> > -
>> >         if (sync)
>> >                 purge_fragmented_blocks_allcpus();
>> >
>> > @@ -667,7 +660,6 @@ static void __purge_vmap_area_lazy(unsigned long *start, unsigned long *end,
>> >                         __free_vmap_area(va);
>> >                 spin_unlock(&vmap_area_lock);
>> >         }
>> > -       spin_unlock(&purge_lock);
>> >  }
>> >
>> [..]
>> > should now be safe. That should significantly reduce the preempt-disabled
>> > section, I think.
>>
>> I believe that the purge_lock is supposed to prevent concurrent purges
>> from happening.
>>
>> For the case where if you have another concurrent overflow happen in
>> alloc_vmap_area() between the spin_unlock and purge :
>>
>> spin_unlock(&vmap_area_lock);
>> if (!purged)
>>    purge_vmap_area_lazy();
>>
>> Then the 2 purges would happen at the same time and could subtract
>> vmap_lazy_nr twice.
>
> That itself is not the problem, as each instance of
> __purge_vmap_area_lazy() operates on its own freelist, and so there will
> be no double accounting.
>
> However, removing the lock removes the serialisation which does mean
> that alloc_vmap_area() will not block on another thread conducting the
> purge, and so it will try to reallocate before that is complete and the
> free area made available. It also means that we are doing the
> atomic_sub(vmap_lazy_nr) too early.
>
> That supports making the outer lock a mutex as you suggested. But I think
> cond_resched_lock() is better for the vmap_area_lock (just because it
> turns out to be an expensive loop and we may want the reschedule).
> -Chris

Ok. So I'll submit a patch with mutex for purge_lock and use
cond_resched_lock for the vmap_area_lock as you suggested. I'll also
drop the lazy_max_pages to 8MB as Andi suggested to reduce the lock
hold time. Let me know if you have any objections.

Thanks,
Joel
