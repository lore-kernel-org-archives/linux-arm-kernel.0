From: will.deacon@arm.com (Will Deacon)
Date: Thu, 19 Oct 2017 16:55:31 +0100
Subject: [PATCH 1/4] arm64: consistently log ESR and page table
In-Reply-To: <1508428534-20694-1-git-send-email-will.deacon@arm.com>
References: <1508428534-20694-1-git-send-email-will.deacon@arm.com>
Message-ID: <1508428534-20694-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Rutland <mark.rutland@arm.com>

When we take a fault we can't handle, we try to dump some relevant
information, but we're not consistent about doing so.

In do_mem_abort(), we log the full ESR, but don't dump a page table
walk. In __do_kernel_fault, we dump an attempted decoding of the ESR
(but not the ESR itself) along with a page table walk.

Let's try to make things more consistent by dumping the full ESR in
mem_abort_decode(), and having do_mem_abort dump a page table walk. The
existing dump of the ESR in do_mem_abort() is rendered redundant, and
removed.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Julien Thierry <julien.thierry@arm.com>
Cc: Kristina Martsenko <kristina.martsenko@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/mm/fault.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 02d92bdf1c49..eec09c623d8e 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -112,6 +112,7 @@ static void mem_abort_decode(unsigned int esr)
 {
 	pr_alert("Mem abort info:\n");
 
+	pr_alert("  ESR = 0x%08x\n", esr);
 	pr_alert("  Exception class = %s, IL = %u bits\n",
 		 esr_get_class_string(esr),
 		 (esr & ESR_ELx_IL) ? 32 : 16);
@@ -745,11 +746,13 @@ asmlinkage void __exception do_mem_abort(unsigned long addr, unsigned int esr,
 	if (!inf->fn(addr, esr, regs))
 		return;
 
-	pr_alert("Unhandled fault: %s (0x%08x) at 0x%016lx\n",
-		 inf->name, esr, addr);
+	pr_alert("Unhandled fault: %s at 0x%016lx\n",
+		 inf->name, addr);
 
 	mem_abort_decode(esr);
 
+	show_pte(addr);
+
 	info.si_signo = inf->sig;
 	info.si_errno = 0;
 	info.si_code  = inf->code;
-- 
2.1.4
