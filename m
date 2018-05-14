From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 14 May 2018 10:46:38 +0100
Subject: [PATCH 16/18] arm64: use SYSCALL_DEFINE6() for mmap
In-Reply-To: <20180514094640.27569-1-mark.rutland@arm.com>
References: <20180514094640.27569-1-mark.rutland@arm.com>
Message-ID: <20180514094640.27569-17-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We don't currently annotate our mmap implementation as a syscall, as we
need to do to use pt_regs syscall wrappers.

Let's mark it as a real syscall.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/sys.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/sys.c b/arch/arm64/kernel/sys.c
index a82c3f7a9a90..2ad1497a184e 100644
--- a/arch/arm64/kernel/sys.c
+++ b/arch/arm64/kernel/sys.c
@@ -27,9 +27,9 @@
 #include <linux/syscalls.h>
 #include <asm/cpufeature.h>
 
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
