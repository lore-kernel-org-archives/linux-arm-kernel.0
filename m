From: adrienverge@gmail.com (=?UTF-8?q?Adrien=20Verg=C3=A9?=)
Date: Fri, 24 Jan 2014 11:40:54 -0500
Subject: [PATCH V2 4/6] ARM: Make PID_IN_CONTEXTIDR incompatible with PID_NS
In-Reply-To: <1390581656-16372-1-git-send-email-adrienverge@gmail.com>
References: <1390581656-16372-1-git-send-email-adrienverge@gmail.com>
Message-ID: <1390581656-16372-5-git-send-email-adrienverge@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When using namespaces, different processes can have the same PID.
It makes no sense to store a PID value in the Context ID register
to track a specific process, when others share the same value.

Consequently, PID_IN_CONTEXTIDR (which is used for tracing and
debugging processes) should not be compatible with PID_NS.

Signed-off-by: Adrien Verg? <adrienverge@gmail.com>
---
 arch/arm/Kconfig.debug   | 2 +-
 arch/arm64/Kconfig.debug | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 5765abf..ed46748 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1143,7 +1143,7 @@ config ARM_KPROBES_TEST
 
 config PID_IN_CONTEXTIDR
 	bool "Write the current PID to the CONTEXTIDR register"
-	depends on CPU_COPY_V6
+	depends on CPU_COPY_V6 && !PID_NS
 	help
 	  Enabling this option causes the kernel to write the current PID to
 	  the PROCID field of the CONTEXTIDR register, at the expense of some
diff --git a/arch/arm64/Kconfig.debug b/arch/arm64/Kconfig.debug
index 835c559..06b2633b 100644
--- a/arch/arm64/Kconfig.debug
+++ b/arch/arm64/Kconfig.debug
@@ -17,6 +17,7 @@ config EARLY_PRINTK
 
 config PID_IN_CONTEXTIDR
 	bool "Write the current PID to the CONTEXTIDR register"
+	depends on !PID_NS
 	help
 	  Enabling this option causes the kernel to write the current PID to
 	  the CONTEXTIDR register, at the expense of some additional
-- 
1.8.5.2
