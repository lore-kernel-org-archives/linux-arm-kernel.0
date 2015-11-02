From: ynorov@caviumnetworks.com (Yury Norov)
Date: Tue, 3 Nov 2015 02:30:37 +0300
Subject: [PATCH v6 08/17] arm64:ilp32: share HWCAP between LP64 and ILP32
In-Reply-To: <1446507046-24604-1-git-send-email-ynorov@caviumnetworks.com>
References: <1446507046-24604-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <1446507046-24604-9-git-send-email-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Pinski <apinski@cavium.com>

Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
Signed-off-by: Andrew Pinski <Andrew.Pinski@caviumnetworks.com>
Reviewed-by: David Daney <david.daney@cavium.com>
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
2.1.4
