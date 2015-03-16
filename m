From: agraf@suse.de (Alexander Graf)
Date: Mon, 16 Mar 2015 17:32:23 +0100
Subject: [PATCH 2/2] arm64: Enable CONFIG_COMPAT also for 64k page size
In-Reply-To: <1426523543-4124-1-git-send-email-agraf@suse.de>
References: <1426523543-4124-1-git-send-email-agraf@suse.de>
Message-ID: <1426523543-4124-3-git-send-email-agraf@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With binutils 2.25 the default alignment for 32bit arm sections changed to
have everything 64k aligned. Armv7 binaries built with this binutils version
run successfully on an arm64 system.

Since effectively there is now the chance to run armv7 code on arm64 even
with 64k page size, it doesn't make sense to block people from enabling
CONFIG_COMPAT on those configurations.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/arm64/Kconfig | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1b8e973..14ff611 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -670,7 +670,7 @@ source "fs/Kconfig.binfmt"
 
 config COMPAT
 	bool "Kernel support for 32-bit EL0"
-	depends on !ARM64_64K_PAGES
+	depends on !ARM64_64K_PAGES || EXPERT
 	select COMPAT_BINFMT_ELF
 	select HAVE_UID16
 	select OLD_SIGSUSPEND3
@@ -681,6 +681,10 @@ config COMPAT
 	  the user helper functions, VFP support and the ptrace interface are
 	  handled appropriately by the kernel.
 
+	  If you also enabled CONFIG_ARM64_64K_PAGES, please be aware that you
+	  will only be able to execute AArch32 binaries that were compiled with
+	  64k aligned segments.
+
 	  If you want to execute 32-bit userspace applications, say Y.
 
 config SYSVIPC_COMPAT
-- 
2.1.4
