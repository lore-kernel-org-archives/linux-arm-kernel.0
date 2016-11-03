From: mark.rutland@arm.com (Mark Rutland)
Date: Thu,  3 Nov 2016 20:23:03 +0000
Subject: [PATCHv2 01/11] arm64: thread_info remove stale items
In-Reply-To: <1478204593-29145-1-git-send-email-mark.rutland@arm.com>
References: <1478204593-29145-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1478204593-29145-2-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have a comment claiming __switch_to() cares about where cpu_context
is located relative to cpu_domain in thread_info. However arm64 has
never had a thread_info::cpu_domain field, and neither __switch_to nor
cpu_switch_to care where the cpu_context field is relative to others.

Additionally, the init_thread_info alias is never used anywhere in the
kernel, and will shortly become problematic when thread_info is moved
into task_struct.

This patch removes both.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Laura Abbott <labbott@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/thread_info.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index e9ea5a6..76a9559 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -42,7 +42,6 @@ typedef unsigned long mm_segment_t;
 
 /*
  * low level task data that entry.S needs immediate access to.
- * __switch_to() assumes cpu_context follows immediately after cpu_domain.
  */
 struct thread_info {
 	unsigned long		flags;		/* low level flags */
@@ -60,7 +59,6 @@ struct thread_info {
 	.addr_limit	= KERNEL_DS,					\
 }
 
-#define init_thread_info	(init_thread_union.thread_info)
 #define init_stack		(init_thread_union.stack)
 
 /*
-- 
2.7.4
