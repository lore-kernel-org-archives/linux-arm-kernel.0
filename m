From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 16 Nov 2011 00:48:41 -0500
Subject: [PATCH 23/23] ARM: move VMALLOC_END down temporarily for shmobile
In-Reply-To: <1321422521-1138-1-git-send-email-nico@fluxnic.net>
References: <1321422521-1138-1-git-send-email-nico@fluxnic.net>
Message-ID: <1321422521-1138-24-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Pitre <nicolas.pitre@linaro.org>

THIS IS A TEMPORARY HACK.  The purpose of this is _only_ to avoid a
regression on an existing machine while a better fix is implemented.

On shmobile the consistent DMA memory area was set to 158MB in commit
28f0721a79 with no explanation.  The documented size for this area should
vary between 2MB and 14MB, and none of the other ARM targets exceed that.

The included #warning is therefore meant to be noisy on purpose to get
shmobile maintainers attention and this commit reverted once this
consistent DMA size conflict is resolved.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Magnus Damm <damm@opensource.se>
Cc: Paul Mundt <lethal@linux-sh.org>
---
 arch/arm/include/asm/pgtable.h |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 6cdd55cb0b..bcae9b81a6 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -37,6 +37,13 @@
 #define VMALLOC_START		(((unsigned long)high_memory + VMALLOC_OFFSET) & ~(VMALLOC_OFFSET-1))
 #define VMALLOC_END		0xff000000UL
 
+/* This is a temporary hack until shmobile's DMA area size is sorted out */
+#ifdef CONFIG_ARCH_SHMOBILE
+#warning "SH-Mobile's consistent DMA size conflicts with VMALLOC_END by 144MB"
+#undef VMALLOC_END
+#define VMALLOC_END		0xF6000000UL
+#endif
+
 #define LIBRARY_TEXT_START	0x0c000000
 
 #ifndef __ASSEMBLY__
-- 
1.7.7.1.431.g10b2a
