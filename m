From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 11 Jul 2018 14:56:54 +0100
Subject: [PATCHv5 19/21] arm64: use SYSCALL_DEFINE6() for mmap
In-Reply-To: <20180711135656.20670-1-mark.rutland@arm.com>
References: <20180711135656.20670-1-mark.rutland@arm.com>
Message-ID: <20180711135656.20670-20-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We don't currently annotate our mmap implementation as a syscall, as we
need to do to use pt_regs syscall wrappers.

Let's mark it as a real syscall.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/sys.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/sys.c b/arch/arm64/kernel/sys.c
index f4e02f6aceb8..f249d9735f4c 100644
--- a/arch/arm64/kernel/sys.c
+++ b/arch/arm64/kernel/sys.c
@@ -29,9 +29,9 @@
 #include <asm/cpufeature.h>
 #include <asm/syscall.h>
 
-asmlinkage long sys_mmap(unsigned long addr, unsigned long len,
-			 unsigned long prot, unsigned long flags,
-			 unsigned long fd, off_t off)
+SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
+		unsigned long, prot, unsigned long, flags,
+		unsigned long, fd, off_t, off)
 {
 	if (offset_in_page(off) != 0)
 		return -EINVAL;
-- 
2.11.0
