From: philipp.tomsich@theobroma-systems.com (Philipp Tomsich)
Date: Mon, 13 Apr 2015 21:44:23 +0200
Subject: [PATCH v4 13/24] arm64:ilp32: share HWCAP between LP64 and ILP32
In-Reply-To: <cover.1428953303.git.philipp.tomsich@theobroma-systems.com>
References: <cover.1428953303.git.philipp.tomsich@theobroma-systems.com>
Message-ID: <b71c8bc95c2c134ba73e4f742d35b8205220405e.1428953303.git.philipp.tomsich@theobroma-systems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Pinski <apinski@cavium.com>

Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
---
 arch/arm64/include/asm/hwcap.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.h
index 0ad7351..1e5361e 100644
--- a/arch/arm64/include/asm/hwcap.h
+++ b/arch/arm64/include/asm/hwcap.h
@@ -47,9 +47,17 @@
 #define ELF_HWCAP		(elf_hwcap)
 
 #ifdef CONFIG_COMPAT
-#define COMPAT_ELF_HWCAP	(compat_elf_hwcap)
-#define COMPAT_ELF_HWCAP2	(compat_elf_hwcap2)
 extern unsigned int compat_elf_hwcap, compat_elf_hwcap2;
+#define COMPAT_ELF_HWCAP	\
+	(is_a32_compat_task()	\
+	  ? compat_elf_hwcap	\
+	  : elf_hwcap)
+
+#define COMPAT_ELF_HWCAP2	\
+	(is_a32_compat_task()	\
+	  ? compat_elf_hwcap2	\
+	  : 0)
+
 #endif
 
 extern unsigned long elf_hwcap;
-- 
1.9.1
