From: oleg@redhat.com (Oleg Nesterov)
Date: Fri, 11 Apr 2014 17:22:07 +0200
Subject: [RFC PATCH] uprobes: copy to user-space xol page with proper
 cache flushing
In-Reply-To: <20140411145625.GA27493@redhat.com>
References: <20140409184507.GA1058@redhat.com>
 <CAA3XUr3w_9318mT2_9+J-nf3wDv5bic+v0H4nVfsYof7wWZs9Q@mail.gmail.com>
 <5347655B.3080307@linaro.org>
 <20140411.003636.272212797007496394.davem@davemloft.net>
 <20140411145625.GA27493@redhat.com>
Message-ID: <20140411152207.GA28188@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11, Oleg Nesterov wrote:
>
> Can't we do _something_
> like below?

If not, I'd propose the patch below.

I can be easily wrong, but it seems that arch/arm can reimplement
arch_uprobe_flush_xol_icache() and do flush_ptrace_access()-like
code. It needs kaddr, but this is not a problem.

Btw. From arch/arm/include/asm/cacheflush.h

	#define flush_icache_user_range(vma,page,addr,len) \
		flush_dcache_page(page)

but it has no users?

And I am just curious, why arm's copy_to_user_page() disables premption
before memcpy?

Oleg.

--- x/kernel/events/uprobes.c
+++ x/kernel/events/uprobes.c
@@ -1274,6 +1274,17 @@ static unsigned long xol_take_insn_slot(
 	return slot_addr;
 }
 
+void __weak arch_uprobe_flush_xol_icache(struct page *page,
+					 unsigned long vaddr, int len)
+{
+	/*
+	 * We need copy_to_user_page/flush_icache_user_range but this
+	 * needs vma. If this doesn't work on your arch, reimplement.
+	 */
+	flush_dcache_page(area->page);
+
+}
+
 /*
  * xol_get_insn_slot - allocate a slot for xol.
  * Returns the allocated slot address or 0.
@@ -1294,11 +1305,8 @@ static unsigned long xol_get_insn_slot(s
 	/* Initialize the slot */
 	copy_to_page(area->page, xol_vaddr,
 			&uprobe->arch.ixol, sizeof(uprobe->arch.ixol));
-	/*
-	 * We probably need flush_icache_user_range() but it needs vma.
-	 * This should work on supported architectures too.
-	 */
-	flush_dcache_page(area->page);
+	arch_uprobe_flush_xol_icache(area->page, xol_vaddr,
+			sizeof(uprobe->arch.ixol));
 
 	return xol_vaddr;
 }
