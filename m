From: agnel.joel@gmail.com (Joel Fernandes)
Date: Sat, 8 Oct 2016 20:43:51 -0700
Subject: [PATCH] mm/vmalloc: reduce the number of lazy_max_pages to reduce
 latency
In-Reply-To: <20160929081818.GE28107@nuc-i3427.alporthouse.com>
References: <20160929073411.3154-1-jszhang@marvell.com>
 <20160929081818.GE28107@nuc-i3427.alporthouse.com>
Message-ID: <CAD=GYpYKL9=uY=Fks2xO6oK3bJ772yo4EiJ1tJkVU9PheSD+Cw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 29, 2016 at 1:18 AM, Chris Wilson <chris@chris-wilson.co.uk> wrote:
> On Thu, Sep 29, 2016 at 03:34:11PM +0800, Jisheng Zhang wrote:
>> On Marvell berlin arm64 platforms, I see the preemptoff tracer report
>> a max 26543 us latency at __purge_vmap_area_lazy, this latency is an
>> awfully bad for STB. And the ftrace log also shows __free_vmap_area
>> contributes most latency now. I noticed that Joel mentioned the same
>> issue[1] on x86 platform and gave two solutions, but it seems no patch
>> is sent out for this purpose.
>>
>> This patch adopts Joel's first solution, but I use 16MB per core
>> rather than 8MB per core for the number of lazy_max_pages. After this
>> patch, the preemptoff tracer reports a max 6455us latency, reduced to
>> 1/4 of original result.
>
> My understanding is that
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 91f44e78c516..3f7c6d6969ac 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -626,7 +626,6 @@ void set_iounmap_nonlazy(void)
>  static void __purge_vmap_area_lazy(unsigned long *start, unsigned long *end,
>                                         int sync, int force_flush)
>  {
> -       static DEFINE_SPINLOCK(purge_lock);
>         struct llist_node *valist;
>         struct vmap_area *va;
>         struct vmap_area *n_va;
> @@ -637,12 +636,6 @@ static void __purge_vmap_area_lazy(unsigned long *start, unsigned long *end,
>          * should not expect such behaviour. This just simplifies locking for
>          * the case that isn't actually used at the moment anyway.
>          */
> -       if (!sync && !force_flush) {
> -               if (!spin_trylock(&purge_lock))
> -                       return;
> -       } else
> -               spin_lock(&purge_lock);
> -
>         if (sync)
>                 purge_fragmented_blocks_allcpus();
>
> @@ -667,7 +660,6 @@ static void __purge_vmap_area_lazy(unsigned long *start, unsigned long *end,
>                         __free_vmap_area(va);
>                 spin_unlock(&vmap_area_lock);
>         }
> -       spin_unlock(&purge_lock);
>  }
>
[..]
> should now be safe. That should significantly reduce the preempt-disabled
> section, I think.

I believe that the purge_lock is supposed to prevent concurrent purges
from happening.

For the case where if you have another concurrent overflow happen in
alloc_vmap_area() between the spin_unlock and purge :

spin_unlock(&vmap_area_lock);
if (!purged)
   purge_vmap_area_lazy();

Then the 2 purges would happen at the same time and could subtract
vmap_lazy_nr twice.

I had proposed to change it to mutex in [1]. How do you feel about
that? Let me know your suggestions, thanks. I am also Ok with reducing
the lazy_max_pages value.

[1] http://lkml.iu.edu/hypermail/linux/kernel/1603.2/04803.html

Regards,
Joel
