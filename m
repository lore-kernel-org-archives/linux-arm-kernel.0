From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 15 Nov 2018 22:41:58 +0000
Subject: [PATCH 1/6] linkage: add generic GLOBAL() macro
In-Reply-To: <20181115224203.24847-1-mark.rutland@arm.com>
References: <20181115224203.24847-1-mark.rutland@arm.com>
Message-ID: <20181115224203.24847-2-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Declaring a global symbol in assembly is tedious, error-prone, and
painful to read. While ENTRY() exists, this is supposed to be used for
function entry points, and this affects alignment in a potentially
undesireable manner.

Instead, let's add a generic GLOBAL() macro for this, as x86 added
locally in commit:

  95695547a7db44b8 ("x86: asm linkage - introduce GLOBAL macro")

... thus allowing us to use this more freely in the kernel.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Torsten Duwe <duwe@suse.de>
Cc: Will Deacon <will.deacon@arm.com>
---
 include/linux/linkage.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/linkage.h b/include/linux/linkage.h
index 7c47b1a471d4..7e020782ade2 100644
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -79,6 +79,12 @@
 #define ALIGN __ALIGN
 #define ALIGN_STR __ALIGN_STR
 
+#ifndef GLOBAL
+#define GLOBAL(name) \
+	.globl name ASM_NL \
+	name:
+#endif
+
 #ifndef ENTRY
 #define ENTRY(name) \
 	.globl name ASM_NL \
-- 
2.11.0
