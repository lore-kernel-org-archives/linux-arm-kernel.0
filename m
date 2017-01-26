From: bilal.amarni@gmail.com (Bilal Amarni)
Date: Thu, 26 Jan 2017 14:27:23 +0100
Subject: [PATCH] security/keys: add CONFIG_KEYS_COMPAT to Kconfig
In-Reply-To: <201701262036.mMS7eB5U%fengguang.wu@intel.com>
References: <201701262036.mMS7eB5U%fengguang.wu@intel.com>
Message-ID: <1485437243-9349-1-git-send-email-bilal.amarni@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_KEYS_COMPAT is defined in arch-specific Kconfigs and is missing for
several 64-bit architectures : arm64, mips, parisc, tile.

At the moment and for those architectures, calling in 32-bit userspace the
keyctl syscall would return an ENOSYS error.

This patch moves the CONFIG_KEYS_COMPAT option to security/keys/Kconfig, to
make sure the compatibility wrapper is registered by default for any 64-bit
architecture as long as it is configured with CONFIG_COMPAT.

Signed-off-by: Bilal Amarni <bilal.amarni@gmail.com>
---
 arch/powerpc/Kconfig  | 5 -----
 arch/s390/Kconfig     | 3 ---
 arch/sparc/Kconfig    | 3 ---
 arch/x86/Kconfig      | 4 ----
 security/keys/Kconfig | 4 ++++
 5 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index a8ee573..5947ea2 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -1128,11 +1128,6 @@ source "arch/powerpc/Kconfig.debug"
 
 source "security/Kconfig"
 
-config KEYS_COMPAT
-	bool
-	depends on COMPAT && KEYS
-	default y
-
 source "crypto/Kconfig"
 
 config PPC_LIB_RHEAP
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index c6722112..633f553 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -362,9 +362,6 @@ config COMPAT
 config SYSVIPC_COMPAT
 	def_bool y if COMPAT && SYSVIPC
 
-config KEYS_COMPAT
-	def_bool y if COMPAT && KEYS
-
 config SMP
 	def_bool y
 	prompt "Symmetric multi-processing support"
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index cf4034c..2b07f0a 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -571,9 +571,6 @@ config SYSVIPC_COMPAT
 	depends on COMPAT && SYSVIPC
 	default y
 
-config KEYS_COMPAT
-	def_bool y if COMPAT && KEYS
-
 endmenu
 
 source "net/Kconfig"
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e487493..f93b6ba 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2768,10 +2768,6 @@ config COMPAT_FOR_U64_ALIGNMENT
 config SYSVIPC_COMPAT
 	def_bool y
 	depends on SYSVIPC
-
-config KEYS_COMPAT
-	def_bool y
-	depends on KEYS
 endif
 
 endmenu
diff --git a/security/keys/Kconfig b/security/keys/Kconfig
index d942c7c..f44d8be 100644
--- a/security/keys/Kconfig
+++ b/security/keys/Kconfig
@@ -20,6 +20,10 @@ config KEYS
 
 	  If you are unsure as to whether this is required, answer N.
 
+config KEYS_COMPAT
+	def_bool y
+	depends on COMPAT && KEYS
+
 config PERSISTENT_KEYRINGS
 	bool "Enable register of persistent per-UID keyrings"
 	depends on KEYS
-- 
2.7.2
