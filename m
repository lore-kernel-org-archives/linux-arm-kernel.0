From: james.morse@arm.com (James Morse)
Date: Thu, 16 Feb 2017 18:29:14 +0000
Subject: [PATCH v4 0/3] arm64: usercopy: Implement stack frame object
 validation
Message-ID: <20170216182917.19637-1-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This version of Sahara's arch_within_stack_frames() series replaces the
open-coded stack walker with a call to arm64's existing walker.

Patch 2 can be tested independently with this change[0].

lkdtm's use of unallocated stack regions is a separate problem, patch 3
tries to address this.

Sahara, it would be good to get your review of this!
I'm afraid I omitted your patch-3 as it stopped the lkdtm test from working,
I suspect its not tricking the compiler, but I haven't investigated.


Thanks,

James

[0] Change to lkdtm to generate accesses that overlap stack frames.
--------------%<--------------
diff --git a/drivers/misc/lkdtm_usercopy.c b/drivers/misc/lkdtm_usercopy.c
index 1dd611423d8b..fcbba3a14387 100644
--- a/drivers/misc/lkdtm_usercopy.c
+++ b/drivers/misc/lkdtm_usercopy.c
@@ -57,7 +57,8 @@ static noinline void do_usercopy_stack(bool to_user, bool bad_frame)
 
        /* This is a pointer to outside our current stack frame. */
        if (bad_frame) {
-               bad_stack = do_usercopy_stack_callee((uintptr_t)&bad_stack);
+               bad_stack = __builtin_frame_address(0);
+               bad_stack -= sizeof(good_stack)/2;
        } else {
                /* Put start address just inside stack. */
                bad_stack = task_stack_page(current) + THREAD_SIZE;
--------------%<--------------


James Morse (2):
  arm64: Add arch_within_stack_frames() for hardened usercopy
  arm64/uaccess: Add hardened usercopy check for bad stack accesses

Sahara (1):
  usercopy: create enum stack_type

 arch/arm64/Kconfig                   |  1 +
 arch/arm64/include/asm/thread_info.h |  7 ++++-
 arch/arm64/include/asm/uaccess.h     | 20 +++++++++++++
 arch/arm64/kernel/stacktrace.c       | 54 ++++++++++++++++++++++++++++++++++--
 arch/x86/include/asm/thread_info.h   | 19 +++++++------
 include/linux/thread_info.h          | 13 +++++++--
 mm/usercopy.c                        |  8 +-----
 7 files changed, 99 insertions(+), 23 deletions(-)

-- 
2.10.1
