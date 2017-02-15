From: tbaicar@codeaurora.org (Tyler Baicar)
Date: Wed, 15 Feb 2017 12:51:16 -0700
Subject: [PATCH V10 04/10] arm64: exception: handle Synchronous External Abort
In-Reply-To: <1487188282-2568-1-git-send-email-tbaicar@codeaurora.org>
References: <1487188282-2568-1-git-send-email-tbaicar@codeaurora.org>
Message-ID: <1487188282-2568-5-git-send-email-tbaicar@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SEA exceptions are often caused by an uncorrected hardware
error, and are handled when data abort and instruction abort
exception classes have specific values for their Fault Status
Code.
When SEA occurs, before killing the process, report the error
in the kernel logs.
Update fault_info[] with specific SEA faults so that the
new SEA handler is used.

Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
Signed-off-by: Jonathan (Zhixiong) Zhang <zjzhang@codeaurora.org>
Signed-off-by: Naveen Kaje <nkaje@codeaurora.org>
Reviewed-by: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/esr.h |  1 +
 arch/arm64/mm/fault.c        | 43 +++++++++++++++++++++++++++++++++----------
 2 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index d14c478..f20c64a 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -83,6 +83,7 @@
 #define ESR_ELx_WNR		(UL(1) << 6)
 
 /* Shared ISS field definitions for Data/Instruction aborts */
+#define ESR_ELx_FnV		(UL(1) << 10)
 #define ESR_ELx_EA		(UL(1) << 9)
 #define ESR_ELx_S1PTW		(UL(1) << 7)
 
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 156169c..d178dc0 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -487,6 +487,29 @@ static int do_bad(unsigned long addr, unsigned int esr, struct pt_regs *regs)
 	return 1;
 }
 
+/*
+ * This abort handler deals with Synchronous External Abort.
+ * It calls notifiers, and then returns "fault".
+ */
+static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
+{
+	struct siginfo info;
+
+	pr_err("Synchronous External Abort: %s (0x%08x)@0x%016lx\n",
+		 fault_name(esr), esr, addr);
+
+	info.si_signo = SIGBUS;
+	info.si_errno = 0;
+	info.si_code  = 0;
+	if (esr & ESR_ELx_FnV)
+		info.si_addr = 0;
+	else
+		info.si_addr  = (void __user *)addr;
+	arm64_notify_die("", regs, &info, esr);
+
+	return 0;
+}
+
 static const struct fault_info {
 	int	(*fn)(unsigned long addr, unsigned int esr, struct pt_regs *regs);
 	int	sig;
@@ -509,22 +532,22 @@ static int do_bad(unsigned long addr, unsigned int esr, struct pt_regs *regs)
 	{ do_page_fault,	SIGSEGV, SEGV_ACCERR,	"level 1 permission fault"	},
 	{ do_page_fault,	SIGSEGV, SEGV_ACCERR,	"level 2 permission fault"	},
 	{ do_page_fault,	SIGSEGV, SEGV_ACCERR,	"level 3 permission fault"	},
-	{ do_bad,		SIGBUS,  0,		"synchronous external abort"	},
+	{ do_sea,		SIGBUS,  0,		"synchronous external abort"	},
 	{ do_bad,		SIGBUS,  0,		"unknown 17"			},
 	{ do_bad,		SIGBUS,  0,		"unknown 18"			},
 	{ do_bad,		SIGBUS,  0,		"unknown 19"			},
-	{ do_bad,		SIGBUS,  0,		"synchronous external abort (translation table walk)" },
-	{ do_bad,		SIGBUS,  0,		"synchronous external abort (translation table walk)" },
-	{ do_bad,		SIGBUS,  0,		"synchronous external abort (translation table walk)" },
-	{ do_bad,		SIGBUS,  0,		"synchronous external abort (translation table walk)" },
-	{ do_bad,		SIGBUS,  0,		"synchronous parity error"	},
+	{ do_sea,		SIGBUS,  0,		"level 0 (translation table walk)"	},
+	{ do_sea,		SIGBUS,  0,		"level 1 (translation table walk)"	},
+	{ do_sea,		SIGBUS,  0,		"level 2 (translation table walk)"	},
+	{ do_sea,		SIGBUS,  0,		"level 3 (translation table walk)"	},
+	{ do_sea,		SIGBUS,  0,		"synchronous parity or ECC error" },
 	{ do_bad,		SIGBUS,  0,		"unknown 25"			},
 	{ do_bad,		SIGBUS,  0,		"unknown 26"			},
 	{ do_bad,		SIGBUS,  0,		"unknown 27"			},
-	{ do_bad,		SIGBUS,  0,		"synchronous parity error (translation table walk)" },
-	{ do_bad,		SIGBUS,  0,		"synchronous parity error (translation table walk)" },
-	{ do_bad,		SIGBUS,  0,		"synchronous parity error (translation table walk)" },
-	{ do_bad,		SIGBUS,  0,		"synchronous parity error (translation table walk)" },
+	{ do_sea,		SIGBUS,  0,		"level 0 synchronous parity error (translation table walk)"	},
+	{ do_sea,		SIGBUS,  0,		"level 1 synchronous parity error (translation table walk)"	},
+	{ do_sea,		SIGBUS,  0,		"level 2 synchronous parity error (translation table walk)"	},
+	{ do_sea,		SIGBUS,  0,		"level 3 synchronous parity error (translation table walk)"	},
 	{ do_bad,		SIGBUS,  0,		"unknown 32"			},
 	{ do_alignment_fault,	SIGBUS,  BUS_ADRALN,	"alignment fault"		},
 	{ do_bad,		SIGBUS,  0,		"unknown 34"			},
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
