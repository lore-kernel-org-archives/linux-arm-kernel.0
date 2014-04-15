From: dave.long@linaro.org (David Long)
Date: Tue, 15 Apr 2014 13:19:27 -0400
Subject: [RFC PATCH] uprobes: copy to user-space xol page with proper
 cache flushing
In-Reply-To: <20140415154637.GA3560@redhat.com>
References: <CAA3XUr3w_9318mT2_9+J-nf3wDv5bic+v0H4nVfsYof7wWZs9Q@mail.gmail.com>
 <5347655B.3080307@linaro.org>
 <20140411.003636.272212797007496394.davem@davemloft.net>
 <20140411145625.GA27493@redhat.com> <20140411152207.GA28188@redhat.com>
 <20140411153041.GQ16119@n2100.arm.linux.org.uk>
 <20140411172456.GA20506@redhat.com>
 <CA+55aFx=1O67Wi85g_3qiUzxyxfFU0RZQMkMj4_kOB=2T09jwQ@mail.gmail.com>
 <20140414185916.GA30672@redhat.com>
 <CAA3XUr3BGA55JF_cgH=cqbo1wAK0773P1fvnG9dBjLU2KzBdKA@mail.gmail.com>
 <20140415154637.GA3560@redhat.com>
Message-ID: <534D6A1F.70102@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/15/14 11:46, Oleg Nesterov wrote:
> 
> But. Please do not add copy_to_user_page() into copy_to_page() (as your patch
> did). This is certainly not what uprobe_write_opcode() wants, we do not want
> or need "flush" in this case. The same for __create_xol_area().
> 

It looked me like a call to a new __copy_to_user_page(current->mm, ...) in xol_get_insn_slot()
would be in line with David Miller's suggestion and would cure the problem on ARM (and hopefuly
be more philosophically correct for all architectures):


diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 04709b6..b418626 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1287,6 +1287,7 @@ static unsigned long xol_get_insn_slot(struct uprobe *uprobe)
 {
        struct xol_area *area;
        unsigned long xol_vaddr;
+       void *kaddr;
 
        area = get_xol_area();
        if (!area)
@@ -1297,13 +1298,11 @@ static unsigned long xol_get_insn_slot(struct uprobe *uprobe)
                return 0;
 
        /* Initialize the slot */
-       copy_to_page(area->page, xol_vaddr,
-                       &uprobe->arch.ixol, sizeof(uprobe->arch.ixol));
-       /*
-        * We probably need flush_icache_user_range() but it needs vma.
-        * This should work on supported architectures too.
-        */
-       flush_dcache_page(area->page);
+       kaddr = kmap_atomic(area->page);
+       __copy_to_user_page(current->mm, area->page, xol_vaddr,
+                       kaddr + (xol_vaddr & ~PAGE_MASK),
+                       &uprobe->arch.ixol, sizeof(uprobe->arch.ixol), true);
+       kunmap_atomic(kaddr);
 
        return xol_vaddr;
 }


Opinions?  It's possible this approach isn't good enough.  Cache operations and VM
are not my strong suit.

-dl
