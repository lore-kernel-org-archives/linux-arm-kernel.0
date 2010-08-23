From: will.deacon@arm.com (Will Deacon)
Date: Mon, 23 Aug 2010 16:54:54 +0100
Subject: [PATCH 1/4] ARM: hw-breakpoint: add mechanism for hooking into
	prefetch aborts
In-Reply-To: <1282578897-23247-1-git-send-email-will.deacon@arm.com>
References: <1282578897-23247-1-git-send-email-will.deacon@arm.com>
Message-ID: <1282578897-23247-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ARM processors with hardware breakpoint and watchpoint support,
triggering these events results in a debug exception. These manifest
as prefetch and data aborts respectively.

arch/arm/mm/fault.c already provides hook_fault_code for hooking
into data aborts dependent on the DFSR. This patch adds a new function,
hook_ifault_code for hooking into prefetch aborts in the same manner.

Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: S. Karthikeyan <informkarthik@gmail.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/system.h |    4 ++++
 arch/arm/mm/fault.c           |   13 +++++++++++++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index 8ba1ccf..b516cde 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -85,6 +85,10 @@ void hook_fault_code(int nr, int (*fn)(unsigned long, unsigned int,
 				       struct pt_regs *),
 		     int sig, int code, const char *name);
 
+void hook_ifault_code(int nr, int (*fn)(unsigned long, unsigned int,
+				       struct pt_regs *),
+		     int sig, int code, const char *name);
+
 #define xchg(ptr,x) \
 	((__typeof__(*(ptr)))__xchg((unsigned long)(x),(ptr),sizeof(*(ptr))))
 
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 23b0b03..1e21e12 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -581,6 +581,19 @@ static struct fsr_info ifsr_info[] = {
 	{ do_bad,		SIGBUS,  0,		"unknown 31"			   },
 };
 
+void __init
+hook_ifault_code(int nr, int (*fn)(unsigned long, unsigned int, struct pt_regs *),
+		 int sig, int code, const char *name)
+{
+	if (nr < 0 || nr >= ARRAY_SIZE(ifsr_info))
+		BUG();
+
+	ifsr_info[nr].fn   = fn;
+	ifsr_info[nr].sig  = sig;
+	ifsr_info[nr].code = code;
+	ifsr_info[nr].name = name;
+}
+
 asmlinkage void __exception
 do_PrefetchAbort(unsigned long addr, unsigned int ifsr, struct pt_regs *regs)
 {
-- 
1.6.3.3
