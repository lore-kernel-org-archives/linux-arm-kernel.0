From: lauraa@codeaurora.org (Laura Abbott)
Date: Tue, 08 Jul 2014 18:43:36 -0700
Subject: arm64 flushing 255GB of vmalloc space takes too long
Message-ID: <53BC9E48.7040809@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I have an arm64 target which has been observed hanging in __purge_vmap_area_lazy
in vmalloc.c The root cause of this 'hang' is that flush_tlb_kernel_range is
attempting to flush 255GB of virtual address space. This takes ~2 seconds and
preemption is disabled at this time thanks to the purge lock. Disabling
preemption for that time is long enough to trigger a watchdog we have setup.

Triggering this is fairly easy:
1) Early in bootup, vmalloc > lazy_max_pages. This gives an address near the
start of the vmalloc range.
2) load a module
3) vfree the vmalloc region from step 1
4) unload the module

The arm64 virtual address layout looks like
vmalloc : 0xffffff8000000000 - 0xffffffbbffff0000   (245759 MB)
vmemmap : 0xffffffbc02400000 - 0xffffffbc03600000   (    18 MB)
modules : 0xffffffbffc000000 - 0xffffffc000000000   (    64 MB)

and the algorithm in __purge_vmap_area_lazy flushes between the lowest address.
Essentially, if we are using a reasonable amount of vmalloc space and a module
unload triggers a vmalloc purge, we will end up triggering our watchdog.

A couple of options I thought of:
1) Increase the timeout of our watchdog to allow the flush to occur. Nobody
I suggested this to likes the idea as the watchdog firing generally catches
behavior that results in poor system performance and disabling preemption
for that long does seem like a problem.
2) Change __purge_vmap_area_lazy to do less work under a spinlock. This would
certainly have a performance impact and I don't even know if it is plausible.
3) Allow module unloading to trigger a vmalloc purge beforehand to help avoid
this case. This would still be racy if another vfree came in during the time
between the purge and the vfree but it might be good enough.
4) Add 'if size > threshold flush entire tlb' (I haven't profiled this yet)


Any other thoughts?

Thanks,
Laura
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
