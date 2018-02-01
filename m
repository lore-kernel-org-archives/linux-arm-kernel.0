From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu,  1 Feb 2018 11:07:34 +0000
Subject: [PATCH v4 2/6] arm: Invalidate BTB on prefetch abort outside of user
 mapping on Cortex A8, A9, A12 and A17
In-Reply-To: <20180201110738.5421-1-marc.zyngier@arm.com>
References: <20180201110738.5421-1-marc.zyngier@arm.com>
Message-ID: <20180201110738.5421-3-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to prevent aliasing attacks on the branch predictor,
invalidate the BTB on CPUs that are known to be affected when taking
a prefetch abort on a address that is outside of a user task limit.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/cp15.h |  2 ++
 arch/arm/mm/fault.c         | 25 ++++++++++++++++
 arch/arm/mm/fsr-2level.c    |  4 +--
 arch/arm/mm/fsr-3level.c    | 69 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 98 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/cp15.h b/arch/arm/include/asm/cp15.h
index 4c9fa72b59f5..9e900ae855aa 100644
--- a/arch/arm/include/asm/cp15.h
+++ b/arch/arm/include/asm/cp15.h
@@ -65,6 +65,8 @@
 #define __write_sysreg(v, r, w, c, t)	asm volatile(w " " c : : "r" ((t)(v)))
 #define write_sysreg(v, ...)		__write_sysreg(v, __VA_ARGS__)
 
+#define BPIALL				__ACCESS_CP15(c7, 0, c5, 6)
+
 extern unsigned long cr_alignment;	/* defined in entry-armv.S */
 
 static inline unsigned long get_cr(void)
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 42f585379e19..2f945c994e25 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -21,6 +21,7 @@
 #include <linux/highmem.h>
 #include <linux/perf_event.h>
 
+#include <asm/cp15.h>
 #include <asm/exception.h>
 #include <asm/pgtable.h>
 #include <asm/system_misc.h>
@@ -396,12 +397,36 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	__do_kernel_fault(mm, addr, fsr, regs);
 	return 0;
 }
+
+static int __maybe_unused
+do_pabt_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
+{
+#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
+	if (addr > TASK_SIZE) {
+		switch (read_cpuid_part()) {
+		case ARM_CPU_PART_CORTEX_A8:
+		case ARM_CPU_PART_CORTEX_A9:
+		case ARM_CPU_PART_CORTEX_A12:
+		case ARM_CPU_PART_CORTEX_A17:
+			write_sysreg(0, BPIALL);
+			break;
+		}
+	}
+#endif
+	return do_page_fault(addr, fsr, regs);
+}
 #else					/* CONFIG_MMU */
 static int
 do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 {
 	return 0;
 }
+
+static int
+do_pabt_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
+{
+	return 0;
+}
 #endif					/* CONFIG_MMU */
 
 /*
diff --git a/arch/arm/mm/fsr-2level.c b/arch/arm/mm/fsr-2level.c
index f2be95197265..ca07f72d8624 100644
--- a/arch/arm/mm/fsr-2level.c
+++ b/arch/arm/mm/fsr-2level.c
@@ -51,7 +51,7 @@ static struct fsr_info ifsr_info[] = {
 	{ do_bad,		SIGBUS,  0,		"unknown 4"			   },
 	{ do_translation_fault,	SIGSEGV, SEGV_MAPERR,	"section translation fault"	   },
 	{ do_bad,		SIGSEGV, SEGV_ACCERR,	"page access flag fault"	   },
-	{ do_page_fault,	SIGSEGV, SEGV_MAPERR,	"page translation fault"	   },
+	{ do_pabt_page_fault,	SIGSEGV, SEGV_MAPERR,	"page translation fault"	   },
 	{ do_bad,		SIGBUS,	 0,		"external abort on non-linefetch"  },
 	{ do_bad,		SIGSEGV, SEGV_ACCERR,	"section domain fault"		   },
 	{ do_bad,		SIGBUS,  0,		"unknown 10"			   },
@@ -59,7 +59,7 @@ static struct fsr_info ifsr_info[] = {
 	{ do_bad,		SIGBUS,	 0,		"external abort on translation"	   },
 	{ do_sect_fault,	SIGSEGV, SEGV_ACCERR,	"section permission fault"	   },
 	{ do_bad,		SIGBUS,	 0,		"external abort on translation"	   },
-	{ do_page_fault,	SIGSEGV, SEGV_ACCERR,	"page permission fault"		   },
+	{ do_pabt_page_fault,	SIGSEGV, SEGV_ACCERR,	"page permission fault"		   },
 	{ do_bad,		SIGBUS,  0,		"unknown 16"			   },
 	{ do_bad,		SIGBUS,  0,		"unknown 17"			   },
 	{ do_bad,		SIGBUS,  0,		"unknown 18"			   },
diff --git a/arch/arm/mm/fsr-3level.c b/arch/arm/mm/fsr-3level.c
index d0ae2963656a..329cf7c2d811 100644
--- a/arch/arm/mm/fsr-3level.c
+++ b/arch/arm/mm/fsr-3level.c
@@ -66,4 +66,73 @@ static struct fsr_info fsr_info[] = {
 	{ do_bad,		SIGBUS,  0,		"unknown 63"			},
 };
 
+#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
+static struct fsr_info ifsr_info[] = {
+	{ do_bad,		SIGBUS,  0,		"unknown 0"			},
+	{ do_bad,		SIGBUS,  0,		"unknown 1"			},
+	{ do_bad,		SIGBUS,  0,		"unknown 2"			},
+	{ do_bad,		SIGBUS,  0,		"unknown 3"			},
+	{ do_bad,		SIGBUS,  0,		"reserved translation fault"	},
+	{ do_translation_fault,	SIGSEGV, SEGV_MAPERR,	"level 1 translation fault"	},
+	{ do_translation_fault,	SIGSEGV, SEGV_MAPERR,	"level 2 translation fault"	},
+	{ do_pabt_page_fault,	SIGSEGV, SEGV_MAPERR,	"level 3 translation fault"	},
+	{ do_bad,		SIGBUS,  0,		"reserved access flag fault"	},
+	{ do_bad,		SIGSEGV, SEGV_ACCERR,	"level 1 access flag fault"	},
+	{ do_pabt_page_fault,	SIGSEGV, SEGV_ACCERR,	"level 2 access flag fault"	},
+	{ do_pabt_page_fault,	SIGSEGV, SEGV_ACCERR,	"level 3 access flag fault"	},
+	{ do_bad,		SIGBUS,  0,		"reserved permission fault"	},
+	{ do_bad,		SIGSEGV, SEGV_ACCERR,	"level 1 permission fault"	},
+	{ do_pabt_page_fault,	SIGSEGV, SEGV_ACCERR,	"level 2 permission fault"	},
+	{ do_pabt_page_fault,	SIGSEGV, SEGV_ACCERR,	"level 3 permission fault"	},
+	{ do_bad,		SIGBUS,  0,		"synchronous external abort"	},
+	{ do_bad,		SIGBUS,  0,		"asynchronous external abort"	},
+	{ do_bad,		SIGBUS,  0,		"unknown 18"			},
+	{ do_bad,		SIGBUS,  0,		"unknown 19"			},
+	{ do_bad,		SIGBUS,  0,		"synchronous abort (translation table walk)" },
+	{ do_bad,		SIGBUS,  0,		"synchronous abort (translation table walk)" },
+	{ do_bad,		SIGBUS,  0,		"synchronous abort (translation table walk)" },
+	{ do_bad,		SIGBUS,  0,		"synchronous abort (translation table walk)" },
+	{ do_bad,		SIGBUS,  0,		"synchronous parity error"	},
+	{ do_bad,		SIGBUS,  0,		"asynchronous parity error"	},
+	{ do_bad,		SIGBUS,  0,		"unknown 26"			},
+	{ do_bad,		SIGBUS,  0,		"unknown 27"			},
+	{ do_bad,		SIGBUS,  0,		"synchronous parity error (translation table walk" },
+	{ do_bad,		SIGBUS,  0,		"synchronous parity error (translation table walk" },
+	{ do_bad,		SIGBUS,  0,		"synchronous parity error (translation table walk" },
+	{ do_bad,		SIGBUS,  0,		"synchronous parity error (translation table walk" },
+	{ do_bad,		SIGBUS,  0,		"unknown 32"			},
+	{ do_bad,		SIGBUS,  BUS_ADRALN,	"alignment fault"		},
+	{ do_bad,		SIGBUS,  0,		"debug event"			},
+	{ do_bad,		SIGBUS,  0,		"unknown 35"			},
+	{ do_bad,		SIGBUS,  0,		"unknown 36"			},
+	{ do_bad,		SIGBUS,  0,		"unknown 37"			},
+	{ do_bad,		SIGBUS,  0,		"unknown 38"			},
+	{ do_bad,		SIGBUS,  0,		"unknown 39"			},
+	{ do_bad,		SIGBUS,  0,		"unknown 40"			},
+	{ do_bad,		SIGBUS,  0,		"unknown 41"			},
+	{ do_bad,		SIGBUS,  0,		"unknown 42"			},
+	{ do_bad,		SIGBUS,  0,		"unknown 43"			},
+	{ do_bad,		SIGBUS,  0,		"unknown 44"			},
+	{ do_bad,		SIGBUS,  0,		"unknown 45"			},
+	{ do_bad,		SIGBUS,  0,		"unknown 46"			},
+	{ do_bad,		SIGBUS,  0,		"unknown 47"			},
+	{ do_bad,		SIGBUS,  0,		"unknown 48"			},
+	{ do_bad,		SIGBUS,  0,		"unknown 49"			},
+	{ do_bad,		SIGBUS,  0,		"unknown 50"			},
+	{ do_bad,		SIGBUS,  0,		"unknown 51"			},
+	{ do_bad,		SIGBUS,  0,		"implementation fault (lockdown abort)" },
+	{ do_bad,		SIGBUS,  0,		"unknown 53"			},
+	{ do_bad,		SIGBUS,  0,		"unknown 54"			},
+	{ do_bad,		SIGBUS,  0,		"unknown 55"			},
+	{ do_bad,		SIGBUS,  0,		"unknown 56"			},
+	{ do_bad,		SIGBUS,  0,		"unknown 57"			},
+	{ do_bad,		SIGBUS,  0,		"implementation fault (coprocessor abort)" },
+	{ do_bad,		SIGBUS,  0,		"unknown 59"			},
+	{ do_bad,		SIGBUS,  0,		"unknown 60"			},
+	{ do_bad,		SIGBUS,  0,		"unknown 61"			},
+	{ do_bad,		SIGBUS,  0,		"unknown 62"			},
+	{ do_bad,		SIGBUS,  0,		"unknown 63"			},
+};
+#else
 #define ifsr_info	fsr_info
+#endif
-- 
2.14.2
