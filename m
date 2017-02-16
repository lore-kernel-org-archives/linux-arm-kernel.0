From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Wed, 15 Feb 2017 17:54:08 -0800
Subject: [PATCH] arm64: print a fault message when attempting to write RO
 memory
Message-ID: <20170216015408.12933-1-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If a page is marked read only we should print out that fact,
instead of printing out that there was a page fault. Right now we
get a cryptic error message that something went wrong with an
unhandled fault, but we don't evaluate the esr to figure out that
it was a read/write permission fault.

Instead of seeing:

  Unable to handle kernel paging request at virtual address ffff000008e460d8
  pgd = ffff800003504000
  [ffff000008e460d8] *pgd=0000000083473003, *pud=0000000083503003, *pmd=0000000000000000
  Internal error: Oops: 9600004f [#1] PREEMPT SMP

we'll see:

  Internal error: Attempting to write read-only memory: 9600004f [#1] PREEMPT SMP

Cc: Laura Abbott <labbott@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---
 arch/arm64/mm/fault.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 156169c6981b..752507fa80ec 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -331,6 +331,11 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 
 		if (!search_exception_tables(regs->pc))
 			die("Accessing user space memory outside uaccess.h routines", regs, esr);
+	} else if (is_permission_fault(esr, regs)) {
+		if (esr & ESR_ELx_WNR)
+			die("Attempting to write read-only memory", regs, esr);
+		else
+			die("Attempting to read unreadable memory", regs, esr);
 	}
 
 	/*
-- 
2.10.0.297.gf6727b0
