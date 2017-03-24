From: opendmb@gmail.com (Doug Berger)
Date: Fri, 24 Mar 2017 07:46:24 -0700
Subject: [PATCH 1/9] arm64: mm: Allow installation of memory abort handlers
In-Reply-To: <20170324144632.5896-1-opendmb@gmail.com>
References: <20170324144632.5896-1-opendmb@gmail.com>
Message-ID: <20170324144632.5896-2-opendmb@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Florian Fainelli <f.fainelli@gmail.com>

Similarly to what the ARM/Linux kernel provides, add a hook_fault_code()
function which allows drivers or other parts of the kernel to install
custom memory abort handlers. This is useful when a given SoC's busing
does not propagate the exact faulting physical address, but there is a
way to read it through e.g: a special arbiter driver.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm64/include/asm/system_misc.h |  3 +++
 arch/arm64/mm/fault.c                | 15 ++++++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/system_misc.h b/arch/arm64/include/asm/system_misc.h
index bc812435bc76..e05f5b8c7c1c 100644
--- a/arch/arm64/include/asm/system_misc.h
+++ b/arch/arm64/include/asm/system_misc.h
@@ -38,6 +38,9 @@ void arm64_notify_die(const char *str, struct pt_regs *regs,
 void hook_debug_fault_code(int nr, int (*fn)(unsigned long, unsigned int,
 					     struct pt_regs *),
 			   int sig, int code, const char *name);
+void hook_fault_code(int nr, int (*fn)(unsigned long, unsigned int,
+				       struct pt_regs *),
+		     int sig, int code, const char *name);
 
 struct mm_struct;
 extern void show_pte(struct mm_struct *mm, unsigned long addr);
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 4bf899fb451b..cdf1260f1005 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -488,7 +488,7 @@ static int do_bad(unsigned long addr, unsigned int esr, struct pt_regs *regs)
 	return 1;
 }
 
-static const struct fault_info {
+static struct fault_info {
 	int	(*fn)(unsigned long addr, unsigned int esr, struct pt_regs *regs);
 	int	sig;
 	int	code;
@@ -560,6 +560,19 @@ static const struct fault_info {
 	{ do_bad,		SIGBUS,  0,		"unknown 63"			},
 };
 
+void __init hook_fault_code(int nr,
+			    int (*fn)(unsigned long, unsigned int, struct pt_regs *),
+			    int sig, int code, const char *name)
+{
+	BUG_ON(nr < 0 || nr >= ARRAY_SIZE(fault_info));
+
+	fault_info[nr].fn	= fn;
+	fault_info[nr].sig	= sig;
+	fault_info[nr].code	= code;
+	fault_info[nr].name	= name;
+}
+
+
 static const char *fault_name(unsigned int esr)
 {
 	const struct fault_info *inf = fault_info + (esr & 63);
-- 
2.12.0
