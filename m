From: labbott@redhat.com (Laura Abbott)
Date: Tue,  5 Jul 2016 15:22:52 -0700
Subject: [PATCHv3] Better kernel instruction abort handling
Message-ID: <1467757373-31242-1-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is v3 of the patch to make instruction aborts print a nicer more standard\
error message (i.e. no more bad mode)

Mark Rutland pointed out in v2 that we need to audit do_mem_abort paths. Of the
functions that do_mem_abort can call, do_bad, do_translation_fault, and
do_alignment_fault all mostly reduce to calling do_bad_area which should call
__do_kernel_fault directly. This makes do_page_fault and __do_kernel_fault the
only cases to review.

Mark raised the problem of taking an instruction abort with a fixup handler.
Any fixup handler being run would not exist in the exception table so there
should be no risk of looping. Another instruction abort would just reduce to
the case of an instruction abort without a fixup handler. The fixup handlers
are expecting data aborts, not instruction aborts though so while they could
run successfully, it wouldn't be for the precise right reason. Practically
speaking, I don't think it matters but to be on the safe side, the fixup
handlers are not run in __do_kernel_fault if the abort is an instruction abort.
This should cover__do_kernel_fault.

do_page_fault gets a little bit more complicated. A fault on a kernel address
should just end up in __do_kernel_fault. Extending is_permission_fault to
cover instruction aborts should be sufficient, mostly because addr == regs->pc
and there should never be a userspace address in the exception table and there
should never be a userspace address in the exception table.

So I think this should cover all cases. The sample LKDTM test cases all work
now.

Thanks,
Laura

Laura Abbott (1):
  arm64: Handle el1 synchronous instruction aborts cleanly

 arch/arm64/kernel/entry.S | 18 ++++++++++++++++++
 arch/arm64/mm/fault.c     | 11 +++++++++--
 2 files changed, 27 insertions(+), 2 deletions(-)

-- 
2.7.4
