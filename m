From: julien.thierry@arm.com (Julien Thierry)
Date: Tue, 17 Oct 2017 14:11:30 +0100
Subject: [PATCH] arm64: Update fault_info table with new exception types
Message-ID: <1508245890-18093-1-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on: ARM Architecture Reference Manual, ARMv8 (DDI 0487B.b).

ARMv8.1 introduces the optional feature ARMv8.1-TTHM which can trigger a
new type of memory abort. This exception is triggered when hardware update
of page table flags is not atomic in regards to other memory accesses.
Replace the corresponding unknown entry with a more accurate one.

Cf: Section D10.2.28 ESR_ELx, Exception Syndrome Register (p D10-2381),
section D4.4.11 Restriction on memory types for hardware updates on page
tables (p D4-2116 - D4-2117).

ARMv8.2 does not add new exception types, however it is worth mentioning
that when obligatory feature RAS (optional for ARMv8.{0,1}) is implemented,
exceptions related to "Synchronous parity or ECC error on memory access,
not on translation table walk" become reserved and should not occur.

Cf: Section D10.2.28 ESR_ELx, Exception Syndrome Register (p D10-2381).

Signed-off-by: Julien Thierry <julien.thierry@arm.com>

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/mm/fault.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index b64958b..a24cd3c 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -668,14 +668,14 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
 	{ do_sea,		SIGBUS,  0,		"level 1 (translation table walk)"	},
 	{ do_sea,		SIGBUS,  0,		"level 2 (translation table walk)"	},
 	{ do_sea,		SIGBUS,  0,		"level 3 (translation table walk)"	},
-	{ do_sea,		SIGBUS,  0,		"synchronous parity or ECC error" },
+	{ do_sea,		SIGBUS,  0,		"synchronous parity or ECC error" },	// Reserved when RAS is implemented
 	{ do_bad,		SIGBUS,  0,		"unknown 25"			},
 	{ do_bad,		SIGBUS,  0,		"unknown 26"			},
 	{ do_bad,		SIGBUS,  0,		"unknown 27"			},
-	{ do_sea,		SIGBUS,  0,		"level 0 synchronous parity error (translation table walk)"	},
-	{ do_sea,		SIGBUS,  0,		"level 1 synchronous parity error (translation table walk)"	},
-	{ do_sea,		SIGBUS,  0,		"level 2 synchronous parity error (translation table walk)"	},
-	{ do_sea,		SIGBUS,  0,		"level 3 synchronous parity error (translation table walk)"	},
+	{ do_sea,		SIGBUS,  0,		"level 0 synchronous parity error (translation table walk)"	},	// Reserved when RAS is implemented
+	{ do_sea,		SIGBUS,  0,		"level 1 synchronous parity error (translation table walk)"	},	// Reserved when RAS is implemented
+	{ do_sea,		SIGBUS,  0,		"level 2 synchronous parity error (translation table walk)"	},	// Reserved when RAS is implemented
+	{ do_sea,		SIGBUS,  0,		"level 3 synchronous parity error (translation table walk)"	},	// Reserved when RAS is implemented
 	{ do_bad,		SIGBUS,  0,		"unknown 32"			},
 	{ do_alignment_fault,	SIGBUS,  BUS_ADRALN,	"alignment fault"		},
 	{ do_bad,		SIGBUS,  0,		"unknown 34"			},
@@ -693,7 +693,7 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
 	{ do_bad,		SIGBUS,  0,		"unknown 46"			},
 	{ do_bad,		SIGBUS,  0,		"unknown 47"			},
 	{ do_bad,		SIGBUS,  0,		"TLB conflict abort"		},
-	{ do_bad,		SIGBUS,  0,		"unknown 49"			},
+	{ do_bad,		SIGBUS,  0,		"Unsupported atomic hardware update fault"	},
 	{ do_bad,		SIGBUS,  0,		"unknown 50"			},
 	{ do_bad,		SIGBUS,  0,		"unknown 51"			},
 	{ do_bad,		SIGBUS,  0,		"implementation fault (lockdown abort)" },
--
1.9.1
