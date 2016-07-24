From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sun, 24 Jul 2016 11:30:29 -0400
Subject: [PATCH v5 15/15] ARM: enable binfmt_flat on systems with an MMU
In-Reply-To: <1469374229-21585-1-git-send-email-nicolas.pitre@linaro.org>
References: <1469374229-21585-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1469374229-21585-16-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the generic changes are in place, this can be enabled on ARM
with the use of proper user space accessors in the flat_get_addr_from_rp()
and flat_put_addr_at_rp() handlers as rp actually holds a user space
address.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/include/asm/flat.h | 5 +++--
 fs/Kconfig.binfmt           | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/flat.h b/arch/arm/include/asm/flat.h
index e847d23351..acf1d14b89 100644
--- a/arch/arm/include/asm/flat.h
+++ b/arch/arm/include/asm/flat.h
@@ -8,8 +8,9 @@
 #define	flat_argvp_envp_on_stack()		1
 #define	flat_old_ram_flag(flags)		(flags)
 #define	flat_reloc_valid(reloc, size)		((reloc) <= (size))
-#define	flat_get_addr_from_rp(rp, relval, flags, persistent) ((void)persistent,get_unaligned(rp))
-#define	flat_put_addr_at_rp(rp, val, relval)	put_unaligned(val,rp)
+#define	flat_get_addr_from_rp(rp, relval, flags, persistent) \
+	({ unsigned long __val; __get_user_unaligned(__val, rp); __val; })
+#define	flat_put_addr_at_rp(rp, val, relval)	__put_user_unaligned(val, rp)
 #define	flat_get_relocate_addr(rel)		(rel)
 #define	flat_set_persistent(relval, p)		0
 
diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
index c7efddf6e0..4c09d93d95 100644
--- a/fs/Kconfig.binfmt
+++ b/fs/Kconfig.binfmt
@@ -89,7 +89,7 @@ config BINFMT_SCRIPT
 
 config BINFMT_FLAT
 	bool "Kernel support for flat binaries"
-	depends on !MMU || M68K
+	depends on !MMU || ARM || M68K
 	depends on !FRV || BROKEN
 	help
 	  Support uClinux FLAT format binaries.
-- 
2.7.4
