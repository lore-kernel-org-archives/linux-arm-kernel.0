From: dave.long@linaro.org (David Long)
Date: Wed, 16 Apr 2014 16:24:18 -0400
Subject: [RFC PATCH v4] ARM: uprobes xol write directly to userspace
In-Reply-To: <20140416.153734.675854782374654510.davem@davemloft.net>
References: <20140416164310.GA15739@redhat.com>
 <20140416.133831.364304583096073299.davem@davemloft.net>
 <20140416191825.GA22246@redhat.com>
 <20140416.153734.675854782374654510.davem@davemloft.net>
Message-ID: <534EE6F2.3050005@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/16/14 15:37, David Miller wrote:
> From: Oleg Nesterov <oleg@redhat.com>
> Date: Wed, 16 Apr 2014 21:18:25 +0200
> 
>> The last question... area->page = alloc_page(GFP_HIGHUSER), and I am
>> not sure that arch/arm/mm/highmem.c:kmap_atomic() can't break the
>> aliasing, __fix_to_virt() in this case will use the same (per-cpu) idx.
>>
>> Looks like, __kunmap_atomic()->__cpuc_flush_dcache_area() should take
>> care, but could you please ack/nack my understanding?
> 
> Good point, it might therefore make sense to use a low-mem page.
> 

The following test code seems to have the same problems with stale user
icache.  It works if I put the dcache flush back in.  Am I missing
something?

-dl



diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 04709b6..10ad973 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -34,6 +34,7 @@
 #include <linux/ptrace.h>      /* user_enable_single_step */
 #include <linux/kdebug.h>      /* notifier mechanism */
 #include "../../mm/internal.h" /* munlock_vma_page */
+#include <linux/mman.h>
 #include <linux/percpu-rwsem.h>
 #include <linux/task_work.h>
 
@@ -1141,7 +1142,7 @@ static int xol_add_vma(struct mm_struct *mm, struct xol_area *area)
        if (!area->vaddr) {
                /* Try to map as high as possible, this is only a hint. */
                area->vaddr = get_unmapped_area(NULL, TASK_SIZE - PAGE_SIZE,
-                                               PAGE_SIZE, 0, 0);
+                                               PAGE_SIZE, page_to_pfn(area->page), MAP_SHARED);
                if (area->vaddr & ~PAGE_MASK) {
                        ret = area->vaddr;
                        goto fail;
@@ -1175,7 +1176,7 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
        if (!area->bitmap)
                goto free_area;
 
-       area->page = alloc_page(GFP_HIGHUSER);
+       area->page = alloc_page(GFP_USER);
        if (!area->page)
                goto free_bitmap;
 
@@ -1299,11 +1300,8 @@ static unsigned long xol_get_insn_slot(struct uprobe *uprobe)
        /* Initialize the slot */
        copy_to_page(area->page, xol_vaddr,
                        &uprobe->arch.ixol, sizeof(uprobe->arch.ixol));
-       /*
-        * We probably need flush_icache_user_range() but it needs vma.
-        * This should work on supported architectures too.
-        */
-       flush_dcache_page(area->page);
+/* Temporary hard-core icache flush for testing */
+       __flush_icache_all();
 
        return xol_vaddr;
 }
