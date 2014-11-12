From: kyle@redhat.com (Kyle McMartin)
Date: Wed, 12 Nov 2014 16:07:44 -0500
Subject: [PATCH] arm64: __clear_user: handle exceptions on strb
Message-ID: <20141112210744.GC6869@redacted.bos.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM64 currently doesn't fix up faults on the single-byte (strb) case of
__clear_user... which means that we can cause a nasty kernel panic as an
ordinary user with any multiple PAGE_SIZE+1 read from /dev/zero.
i.e.: dd if=/dev/zero of=foo ibs=1 count=1 (or ibs=65537, etc.)

This is a pretty obscure bug in the general case since we'll only
__do_kernel_fault (since there's no extable entry for pc) if the
mmap_sem is contended. However, with CONFIG_DEBUG_VM enabled, we'll
always fault.

if (!down_read_trylock(&mm->mmap_sem)) {
	if (!user_mode(regs) && !search_exception_tables(regs->pc))
		goto no_context;
retry:
	down_read(&mm->mmap_sem);
} else {
	/*
	 * The above down_read_trylock() might have succeeded in
	 * which
	 * case, we'll have missed the might_sleep() from
	 * down_read().
	 */
	might_sleep();
#ifdef CONFIG_DEBUG_VM
	if (!user_mode(regs) && !search_exception_tables(regs->pc))
		goto no_context;
#endif
}

Fix that by adding an extable entry for the strb instruction, since it
touches user memory, similar to the other stores in __clear_user.

Signed-off-by: Kyle McMartin <kyle@redhat.com>
Cc: stable at vger.kernel.org

--- a/arch/arm64/lib/clear_user.S
+++ b/arch/arm64/lib/clear_user.S
@@ -46,7 +46,7 @@ USER(9f, strh	wzr, [x0], #2	)
 	sub	x1, x1, #2
 4:	adds	x1, x1, #1
 	b.mi	5f
-	strb	wzr, [x0]
+USER(9f, strb	wzr, [x0]	)
 5:	mov	x0, #0
 	ret
 ENDPROC(__clear_user)
