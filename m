From: oleg@redhat.com (Oleg Nesterov)
Date: Tue, 8 Apr 2014 17:27:35 +0200
Subject: [RFC PATCH] ARM: uprobes need icache flush after xol write
In-Reply-To: <20140408133039.GH16119@n2100.arm.linux.org.uk>
References: <1396926260-7705-1-git-send-email-victor.kamensky@linaro.org>
 <1396926260-7705-2-git-send-email-victor.kamensky@linaro.org>
 <20140408082444.GA3598@e103592.cambridge.arm.com>
 <20140408114619.GE16119@n2100.arm.linux.org.uk> <5343F42D.5090205@linaro.org>
 <20140408133039.GH16119@n2100.arm.linux.org.uk>
Message-ID: <20140408152735.GA30076@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry, I din't read the whole thread yet...

On 04/08, Russell King - ARM Linux wrote:
> On Tue, Apr 08, 2014 at 09:05:49AM -0400, David Long wrote:
> > Unfortunately copy_to_user_page() also needs a pointer to a vma struct
> > so, while it presumably provides the model to follow, it can't simply be
> > dropped in.
>
> Well, isn't this code doing the same thing as ptrace?  It seems to want
> to modify a page in userspace of another process to change instructions
> that are going to be executed. That's what ptrace does, and ptrace
> already copes with all the issues there.

Yes, but it does get_user_pages(&vma) and thus it knows vma.

> Given that we've already solved that problem, wouldn't it be a good idea
> if the tracing code would stop trying to reinvent broken solutions to
> problems we have already solved?

But uprobes can't do this. Of course, I am not saying this is impossible,
but it would be nice to avoid mmap_sem/find_vma/etc.

Almost nobody (iirc only sparc?) actually uses this "vma" arguments. And
at least the supported architectures do not (at least this is what I think
after the quick grep).

Perhaps we can rolerate the hack below?

Oleg.

--- x/kernel/events/uprobes.c
+++ x/kernel/events/uprobes.c
@@ -1295,10 +1295,10 @@ static unsigned long xol_get_insn_slot(s
 	copy_to_page(area->page, xol_vaddr,
 			&uprobe->arch.ixol, sizeof(uprobe->arch.ixol));
 	/*
-	 * We probably need flush_icache_user_range() but it needs vma.
-	 * This should work on supported architectures too.
+	 * The architectures we currently support do not really use vma.
 	 */
-	flush_dcache_page(area->page);
+	flush_icache_user_range(NULL /* vma */, area->page,
+				xol_vaddr, sizeof(uprobe->arch.ixol));
 
 	return xol_vaddr;
 }
