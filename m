From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 23 Nov 2015 15:09:36 +0000
Subject: [PATCH] arm64: mm: fix fault_info table xFSC decoding
Message-ID: <1448291376-16411-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We are missing descriptions for some valid xFSC values in the fault info
table (e.g. "TLB conflict abort"), and have erroneous descriptions for
reserved values (e.g. "asynchronous external abort", "debug event").

This patch adds the missing xFSC values, and removes erroneous decoding
of values reserved by the architecture, as described in ARM DDI 0487A.h.

At the same time, fixed the unbalanced brackets for the synchronous
parity error strings in the table.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/mm/fault.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 19211c4..92ddac1 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -393,16 +393,16 @@ static struct fault_info {
 	{ do_translation_fault,	SIGSEGV, SEGV_MAPERR,	"level 1 translation fault"	},
 	{ do_translation_fault,	SIGSEGV, SEGV_MAPERR,	"level 2 translation fault"	},
 	{ do_page_fault,	SIGSEGV, SEGV_MAPERR,	"level 3 translation fault"	},
-	{ do_bad,		SIGBUS,  0,		"reserved access flag fault"	},
+	{ do_bad,		SIGBUS,  0,		"unknown 8"			},
 	{ do_page_fault,	SIGSEGV, SEGV_ACCERR,	"level 1 access flag fault"	},
 	{ do_page_fault,	SIGSEGV, SEGV_ACCERR,	"level 2 access flag fault"	},
 	{ do_page_fault,	SIGSEGV, SEGV_ACCERR,	"level 3 access flag fault"	},
-	{ do_bad,		SIGBUS,  0,		"reserved permission fault"	},
+	{ do_bad,		SIGBUS,  0,		"unknown 12"			},
 	{ do_page_fault,	SIGSEGV, SEGV_ACCERR,	"level 1 permission fault"	},
 	{ do_page_fault,	SIGSEGV, SEGV_ACCERR,	"level 2 permission fault"	},
 	{ do_page_fault,	SIGSEGV, SEGV_ACCERR,	"level 3 permission fault"	},
 	{ do_bad,		SIGBUS,  0,		"synchronous external abort"	},
-	{ do_bad,		SIGBUS,  0,		"asynchronous external abort"	},
+	{ do_bad,		SIGBUS,  0,		"unknown 17"			},
 	{ do_bad,		SIGBUS,  0,		"unknown 18"			},
 	{ do_bad,		SIGBUS,  0,		"unknown 19"			},
 	{ do_bad,		SIGBUS,  0,		"synchronous abort (translation table walk)" },
@@ -410,16 +410,16 @@ static struct fault_info {
 	{ do_bad,		SIGBUS,  0,		"synchronous abort (translation table walk)" },
 	{ do_bad,		SIGBUS,  0,		"synchronous abort (translation table walk)" },
 	{ do_bad,		SIGBUS,  0,		"synchronous parity error"	},
-	{ do_bad,		SIGBUS,  0,		"asynchronous parity error"	},
+	{ do_bad,		SIGBUS,  0,		"unknown 25"			},
 	{ do_bad,		SIGBUS,  0,		"unknown 26"			},
 	{ do_bad,		SIGBUS,  0,		"unknown 27"			},
-	{ do_bad,		SIGBUS,  0,		"synchronous parity error (translation table walk" },
-	{ do_bad,		SIGBUS,  0,		"synchronous parity error (translation table walk" },
-	{ do_bad,		SIGBUS,  0,		"synchronous parity error (translation table walk" },
-	{ do_bad,		SIGBUS,  0,		"synchronous parity error (translation table walk" },
+	{ do_bad,		SIGBUS,  0,		"synchronous parity error (translation table walk)" },
+	{ do_bad,		SIGBUS,  0,		"synchronous parity error (translation table walk)" },
+	{ do_bad,		SIGBUS,  0,		"synchronous parity error (translation table walk)" },
+	{ do_bad,		SIGBUS,  0,		"synchronous parity error (translation table walk)" },
 	{ do_bad,		SIGBUS,  0,		"unknown 32"			},
 	{ do_bad,		SIGBUS,  BUS_ADRALN,	"alignment fault"		},
-	{ do_bad,		SIGBUS,  0,		"debug event"			},
+	{ do_bad,		SIGBUS,  0,		"unknown 34"			},
 	{ do_bad,		SIGBUS,  0,		"unknown 35"			},
 	{ do_bad,		SIGBUS,  0,		"unknown 36"			},
 	{ do_bad,		SIGBUS,  0,		"unknown 37"			},
@@ -433,21 +433,21 @@ static struct fault_info {
 	{ do_bad,		SIGBUS,  0,		"unknown 45"			},
 	{ do_bad,		SIGBUS,  0,		"unknown 46"			},
 	{ do_bad,		SIGBUS,  0,		"unknown 47"			},
-	{ do_bad,		SIGBUS,  0,		"unknown 48"			},
+	{ do_bad,		SIGBUS,  0,		"TLB conflict abort"		},
 	{ do_bad,		SIGBUS,  0,		"unknown 49"			},
 	{ do_bad,		SIGBUS,  0,		"unknown 50"			},
 	{ do_bad,		SIGBUS,  0,		"unknown 51"			},
 	{ do_bad,		SIGBUS,  0,		"implementation fault (lockdown abort)" },
-	{ do_bad,		SIGBUS,  0,		"unknown 53"			},
+	{ do_bad,		SIGBUS,  0,		"implementation fault (unsupported exclusive)" },
 	{ do_bad,		SIGBUS,  0,		"unknown 54"			},
 	{ do_bad,		SIGBUS,  0,		"unknown 55"			},
 	{ do_bad,		SIGBUS,  0,		"unknown 56"			},
 	{ do_bad,		SIGBUS,  0,		"unknown 57"			},
-	{ do_bad,		SIGBUS,  0,		"implementation fault (coprocessor abort)" },
+	{ do_bad,		SIGBUS,  0,		"unknown 58" 			},
 	{ do_bad,		SIGBUS,  0,		"unknown 59"			},
 	{ do_bad,		SIGBUS,  0,		"unknown 60"			},
-	{ do_bad,		SIGBUS,  0,		"unknown 61"			},
-	{ do_bad,		SIGBUS,  0,		"unknown 62"			},
+	{ do_bad,		SIGBUS,  0,		"section domain fault"		},
+	{ do_bad,		SIGBUS,  0,		"page domain fault"		},
 	{ do_bad,		SIGBUS,  0,		"unknown 63"			},
 };
 
-- 
1.9.1
