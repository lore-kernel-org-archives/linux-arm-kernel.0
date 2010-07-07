From: will.deacon@arm.com (Will Deacon)
Date: Wed,  7 Jul 2010 17:22:57 +0100
Subject: [PATCH 1/4] ARM: hw-breakpoint: add mechanism for hooking into
	prefetch aborts
In-Reply-To: <1278519780-13317-1-git-send-email-will.deacon@arm.com>
References: <1278519780-13317-1-git-send-email-will.deacon@arm.com>
Message-ID: <1278519780-13317-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ARM processors with hardware breakpoint and watchpoint support,
triggering these events results in a debug exception. These manifest
as prefetch and data aborts respectively.

arch/arm/mm/fault.c already provides hook_fault_code for hooking
into data aborts dependent on the DFSR. This patch adds a new function,
hook_ifault_code for hooking into prefetch aborts in the same manner.

Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: S. Karthikeyan <informkarthik@gmail.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/system.h |    3 +++
 arch/arm/mm/fault.c           |   11 +++++++++++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index 5f4f480..42da2f8 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -84,6 +84,9 @@ void arm_notify_die(const char *str, struct pt_regs *regs, struct siginfo *info,
 void hook_fault_code(int nr, int (*fn)(unsigned long, unsigned int,
 				       struct pt_regs *),
 		     int sig, const char *name);
+void hook_ifault_code(int nr, int (*fn)(unsigned long, unsigned int,
+				       struct pt_regs *),
+		     int sig, const char *name);
 
 #define xchg(ptr,x) \
 	((__typeof__(*(ptr)))__xchg((unsigned long)(x),(ptr),sizeof(*(ptr))))
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index cbfb2ed..fb7cbe7 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -575,6 +575,17 @@ static struct fsr_info ifsr_info[] = {
 	{ do_bad,		SIGBUS,  0,		"unknown 31"			   },
 };
 
+void __init
+hook_ifault_code(int nr, int (*fn)(unsigned long, unsigned int, struct pt_regs *),
+			int sig, const char *name)
+{
+	if (nr >= 0 && nr < ARRAY_SIZE(ifsr_info)) {
+		ifsr_info[nr].fn   = fn;
+		ifsr_info[nr].sig  = sig;
+		ifsr_info[nr].name = name;
+	}
+}
+
 asmlinkage void __exception
 do_PrefetchAbort(unsigned long addr, unsigned int ifsr, struct pt_regs *regs)
 {
-- 
1.6.3.3
