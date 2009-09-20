From: sebastian@breakpoint.cc (Sebastian Andrzej Siewior)
Date: Sun, 20 Sep 2009 21:40:12 +0200
Subject: [PATCH v2] arm: export "W" macro just for assembly code
In-Reply-To: <20090918193422.GA6601@n2100.arm.linux.org.uk>
References: <20090917091237.8258.29171.stgit@pc1117.cambridge.arm.com>
	<20090918193422.GA6601@n2100.arm.linux.org.uk>
Message-ID: <20090920194012.GA22062@Chamillionaire.breakpoint.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexey Dobriyan <adobriyan@gmail.com>

The W macro which got introduced in 0becb08 aka "Thumb-2: Add macros for
the unified assembler syntax" clashes with the W function in
crypto/cast6.c since commit 8b59278 aka "Thumb-2: Implement the unified
arch/arm/lib functions" due to the following include path:
|arch/arm/include/asm/unified.h <---
|arch/arm/include/asm/uaccess.h:20
|include/linux/uaccess.h:5
|include/linux/crypto.h:26
|crypto/cast6.c:23

This patch allows the usage of the new W macro only in assembly files
since it is the place where it is used.

[sebastian at breakpoint]: patch description
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
---
Russel, I've added a new patch description for this patch since my
rename edition was a little larger.

 arch/arm/include/asm/unified.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/unified.h b/arch/arm/include/asm/unified.h
index 073e85b..bc63116 100644
--- a/arch/arm/include/asm/unified.h
+++ b/arch/arm/include/asm/unified.h
@@ -35,7 +35,9 @@
 
 #define ARM(x...)
 #define THUMB(x...)	x
+#ifdef __ASSEMBLY__
 #define W(instr)	instr.w
+#endif
 #define BSYM(sym)	sym + 1
 
 #else	/* !CONFIG_THUMB2_KERNEL */
@@ -45,7 +47,9 @@
 
 #define ARM(x...)	x
 #define THUMB(x...)
+#ifdef __ASSEMBLY__
 #define W(instr)	instr
+#endif
 #define BSYM(sym)	sym
 
 #endif	/* CONFIG_THUMB2_KERNEL */
