From: agnel.joel@gmail.com (Joel Fernandes)
Date: Mon, 10 Oct 2016 22:34:07 -0700
Subject: [PATCH] mm/vmalloc: reduce the number of lazy_max_pages to reduce
 latency
In-Reply-To: <CAD=GYpZQOQYE7x0kGTmLSeybh4Tn-CCEDouzkFVkdevq02j3SA@mail.gmail.com>
References: <20160929073411.3154-1-jszhang@marvell.com>
 <20160929081818.GE28107@nuc-i3427.alporthouse.com>
 <CAD=GYpYKL9=uY=Fks2xO6oK3bJ772yo4EiJ1tJkVU9PheSD+Cw@mail.gmail.com>
 <20161009124242.GA2718@nuc-i3427.alporthouse.com>
 <CAEi0qNnozbib-92NwWpUV=_YiiUHYGzzBuuY8kDZY9gaZm-W7Q@mail.gmail.com>
 <20161009192610.GB2718@nuc-i3427.alporthouse.com>
 <CAD=GYpZQOQYE7x0kGTmLSeybh4Tn-CCEDouzkFVkdevq02j3SA@mail.gmail.com>
Message-ID: <CAD=GYpbJmrcpNmtxfAdN6fFihWJwwOpDEk+zkZxUDrS8gB_LGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 10, 2016 at 10:06 PM, Joel Fernandes <agnel.joel@gmail.com> wrote:
> On Sun, Oct 9, 2016 at 12:26 PM, Chris Wilson <chris@chris-wilson.co.uk> wrote:
>> On Sun, Oct 09, 2016 at 12:00:31PM -0700, Joel Fernandes wrote:
>>> Ok. So I'll submit a patch with mutex for purge_lock and use
>>> cond_resched_lock for the vmap_area_lock as you suggested. I'll also
>>> drop the lazy_max_pages to 8MB as Andi suggested to reduce the lock
>>> hold time. Let me know if you have any objections.
>>
>> The downside of using a mutex here though, is that we may be called
>> from contexts that cannot sleep (alloc_vmap_area), or reschedule for
>> that matter! If we change the notion of purged, we can forgo the mutex
>> in favour of spinning on the direct reclaim path. That just leaves the
>> complication of whether to use cond_resched_lock() or a lock around
>> the individual __free_vmap_area().
>
> Good point. I agree with you. I think we still need to know if purging
> is in progress to preserve previous trylock behavior. How about
> something like the following diff? (diff is untested).
>
> This drops the purge lock and uses a ref count to indicate if purging
> is in progress, so that callers who don't want to purge if purging is
> already in progress can be kept happy. Also I am reducing vmap_lazy_nr
> as we go, and, not all at once, so that we don't reduce the counter
> too soon as we're not holding purge lock anymore. Lastly, I added the
> cond_resched as you suggested.
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index f2481cb..5616ca4 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -626,7 +626,7 @@ void set_iounmap_nonlazy(void)
>  static void __purge_vmap_area_lazy(unsigned long *start, unsigned long *end,
>                                         int sync, int force_flush)
>  {
> -       static DEFINE_SPINLOCK(purge_lock);
> +       static atomic_t purging;
>         struct llist_node *valist;
>         struct vmap_area *va;
>         struct vmap_area *n_va;
> @@ -638,10 +638,10 @@ static void __purge_vmap_area_lazy(unsigned long
> *start, unsigned long *end,
>          * the case that isn't actually used at the moment anyway.
>          */
>         if (!sync && !force_flush) {
> -               if (!spin_trylock(&purge_lock))
> +               if (atomic_cmpxchg(&purging, 0, 1))
>                         return;
>         } else
> -               spin_lock(&purge_lock);
> +               atomic_inc(&purging);
>
>         if (sync)
>                 purge_fragmented_blocks_allcpus();
> @@ -655,9 +655,6 @@ static void __purge_vmap_area_lazy(unsigned long
> *start, unsigned long *end,
>                 nr += (va->va_end - va->va_start) >> PAGE_SHIFT;
>         }
>
> -       if (nr)
> -               atomic_sub(nr, &vmap_lazy_nr);
> -
>         if (nr || force_flush)
>                 flush_tlb_kernel_range(*start, *end);
>
> @@ -665,9 +662,11 @@ static void __purge_vmap_area_lazy(unsigned long
> *start, unsigned long *end,
>                 spin_lock(&vmap_area_lock);
>                 llist_for_each_entry_safe(va, n_va, valist, purge_list)
>                         __free_vmap_area(va);
> +               atomic_sub(1, &vmap_lazy_nr);
> +               cond_resched_lock(&vmap_area_lock);
>                 spin_unlock(&vmap_area_lock);

For this particular hunk, I forgot the braces. sorry, I meant to say:

 @@ -665,9 +662,11 @@ static void __purge_vmap_area_lazy(unsigned long
 *start, unsigned long *end,
                 spin_lock(&vmap_area_lock);
-                llist_for_each_entry_safe(va, n_va, valist, purge_list)
+                llist_for_each_entry_safe(va, n_va, valist,
purge_list) {
                   __free_vmap_area(va);
+                  atomic_sub(1, &vmap_lazy_nr);
+                  cond_resched_lock(&vmap_area_lock);
+                }
                 spin_unlock(&vmap_area_lock);


Regards,
Joel
