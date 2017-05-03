From: mark.rutland@arm.com (Mark Rutland)
Date: Wed,  3 May 2017 16:09:36 +0100
Subject: [PATCH 4/6] arm64: armv8_deprecated: ensure extension of addr
In-Reply-To: <1493824178-7399-1-git-send-email-mark.rutland@arm.com>
References: <1493824178-7399-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1493824178-7399-5-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our compat swp emulation holds the compat user address in an unsigned
int, which it passes to __user_swpX_asm(). When a 32-bit value is passed
in a register, the upper 32 bits of the register are unknown, and we
must extend the value to 64 bits before we can use it as a base address.

This patch casts the address to unsigned long to ensure it has been
suitably extended, avoiding the potential issue, and silencing a related
warning from clang.

Fixes: bd35a4adc4131c53 ("arm64: Port SWP/SWPB emulation support from arm")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Matthias Kaehlcke <mka@chromium.org>
Cc: Punit Agrawal <punit.agrawal@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/armv8_deprecated.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
index 657977e..f0e6d71 100644
--- a/arch/arm64/kernel/armv8_deprecated.c
+++ b/arch/arm64/kernel/armv8_deprecated.c
@@ -306,7 +306,8 @@ static void __init register_insn_emulation_sysctl(struct ctl_table *table)
 	_ASM_EXTABLE(0b, 4b)					\
 	_ASM_EXTABLE(1b, 4b)					\
 	: "=&r" (res), "+r" (data), "=&r" (temp), "=&r" (temp2)	\
-	: "r" (addr), "i" (-EAGAIN), "i" (-EFAULT),		\
+	: "r" ((unsigned long)addr), "i" (-EAGAIN),		\
+	  "i" (-EFAULT),					\
 	  "i" (__SWP_LL_SC_LOOPS)				\
 	: "memory");						\
 	uaccess_disable();					\
-- 
1.9.1
