From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Fri, 11 Apr 2014 07:26:51 -0700
Subject: [RFC PATCH] uprobes: copy to user-space xol page with proper
 cache flushing
In-Reply-To: <20140411.003636.272212797007496394.davem@davemloft.net>
References: <20140409184507.GA1058@redhat.com>
 <CAA3XUr3w_9318mT2_9+J-nf3wDv5bic+v0H4nVfsYof7wWZs9Q@mail.gmail.com>
 <5347655B.3080307@linaro.org>
 <20140411.003636.272212797007496394.davem@davemloft.net>
Message-ID: <CAA3XUr0-KqtBw0WCFvws8g5ChK49d+X+7Un9ngq1UZg-oROx+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 April 2014 21:36, David Miller <davem@davemloft.net> wrote:
> From: David Long <dave.long@linaro.org>
> Date: Thu, 10 Apr 2014 23:45:31 -0400
>
>> Replace memcpy and dcache flush in generic uprobes with a call to
>> copy_to_user_page(), which will do a proper flushing of kernel and
>> user cache.  Also modify the inmplementation of copy_to_user_page
>> to assume a NULL vma pointer means the user icache corresponding
>> to this right is stale and needs to be flushed.  Note that this patch
>> does not fix copy_to_user page for the sh, alpha, sparc, or mips
>> architectures (which do not currently support uprobes).
>>
>> Signed-off-by: David A. Long <dave.long@linaro.org>
>
> You really need to pass the proper VMA down to the call site
> rather than pass NULL, that's extremely ugly and totally
> unnecesary.

Agreed that VMA is really needed.

Here is variant that I tried while waiting for Oleg's response:

>From 4a6a9043e0910041dd8842835a528cbdc39fad34 Mon Sep 17 00:00:00 2001
From: Victor Kamensky <victor.kamensky@linaro.org>
Date: Thu, 10 Apr 2014 17:06:39 -0700
Subject: [PATCH] uprobes: use copy_to_user_page function to copy instr to xol
 area

Use copy_to_user_page function to copy instruction into xol area.
copy_to_user_page function guarantee that all caches are correctly
flushed during such write (including icache as well if needed).

Because copy_to_user_page needs vm_area_struct, vma
field was added into struct xol_area. It holds cached vma value
for xol_area.

Also using copy_to_user_page we make sure that we use the same
code that ptrace write code uses.

Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
---
 kernel/events/uprobes.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 04709b6..1ae4563 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -117,6 +117,7 @@ struct xol_area {
      * the vma go away, and we must handle that reasonably gracefully.
      */
     unsigned long         vaddr;        /* Page(s) of instruction slots */
+    struct vm_area_struct    *vma;        /* VMA that holds above address */
 };

 /*
@@ -1150,6 +1151,7 @@ static int xol_add_vma(struct mm_struct *mm,
struct xol_area *area)

     ret = install_special_mapping(mm, area->vaddr, PAGE_SIZE,
                 VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO, &area->page);
+    area->vma = find_vma(mm, area->vaddr);
     if (ret)
         goto fail;

@@ -1287,6 +1289,7 @@ static unsigned long xol_get_insn_slot(struct
uprobe *uprobe)
 {
     struct xol_area *area;
     unsigned long xol_vaddr;
+    void *xol_page_kaddr;

     area = get_xol_area();
     if (!area)
@@ -1297,8 +1300,11 @@ static unsigned long xol_get_insn_slot(struct
uprobe *uprobe)
         return 0;

     /* Initialize the slot */
-    copy_to_page(area->page, xol_vaddr,
-            &uprobe->arch.ixol, sizeof(uprobe->arch.ixol));
+    xol_page_kaddr = kmap_atomic(area->page);
+    copy_to_user_page(area->vma, area->page, xol_vaddr,
+              xol_page_kaddr + (xol_vaddr & ~PAGE_MASK),
+              &uprobe->arch.ixol, sizeof(uprobe->arch.ixol));
+    kunmap_atomic(xol_page_kaddr);
     /*
      * We probably need flush_icache_user_range() but it needs vma.
      * This should work on supported architectures too.
-- 
1.8.1.4

Now while waiting for Oleg's response I am trying to run some performance
tests between different solution to understand situation better.

One of my concerns was ARM smp function call that
could be reached from copy_to_user_page. But I have hard time
finding CPU that really doing it ... It does not look such call
will happen on relatively modern ARM CPUs (tried Arndale,
and Pandaboard ES). So my issues with use
of copy_to_user_page are quite elevated.

Thanks,
Victor
