From: ynorov@caviumnetworks.com (Yury Norov)
Date: Fri, 8 Jan 2016 02:34:30 +0300
Subject: [PATCH v6 12/21] arm64:ilp32: share HWCAP between LP64 and ILP32
In-Reply-To: <1452209679-19445-1-git-send-email-ynorov@caviumnetworks.com>
References: <1452209679-19445-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <1452209679-19445-13-git-send-email-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Pinski <apinski@cavium.com>

Signed-off-by: Andrew Pinski <Andrew.Pinski@caviumnetworks.com>
Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
Reviewed-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/arm64/include/asm/hwcap.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.h
index 400b80b..bdb1ae6 100644
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
+	  : (u32) elf_hwcap)
+
+#define COMPAT_ELF_HWCAP2	\
+	(is_a32_compat_task()	\
+	  ? compat_elf_hwcap2	\
+	  : (u32) (elf_hwcap >> 32))
+
 #endif
 
 enum {
-- 
2.5.0
