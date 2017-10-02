From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Mon,  2 Oct 2017 15:14:30 +0900
Subject: [PATCH v4 09/10] arm64: enable KEXEC_FILE config
In-Reply-To: <20171002061431.11117-1-takahiro.akashi@linaro.org>
References: <20171002061431.11117-1-takahiro.akashi@linaro.org>
Message-ID: <20171002061431.11117-10-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Modify arm64/Kconfig and Makefile to enable kexec_file_load support.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/Kconfig | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 0df64a6a56d4..e37be8a59a88 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -757,6 +757,28 @@ config KEXEC
 	  but it is independent of the system firmware.   And like a reboot
 	  you can start any kernel with it, not just Linux.
 
+config KEXEC_FILE
+	bool "kexec file based system call"
+	select KEXEC_CORE
+	select BUILD_BIN2C
+	---help---
+	  This is new version of kexec system call. This system call is
+	  file based and takes file descriptors as system call argument
+	  for kernel and initramfs as opposed to list of segments as
+	  accepted by previous system call.
+
+	  In addition to this option, you need to enable a specific type
+	  of image support.
+
+config KEXEC_VERIFY_SIG
+	bool "Verify kernel signature during kexec_file_load() syscall"
+	depends on KEXEC_FILE
+	select SYSTEM_DATA_VERIFICATION
+	---help---
+	  Select this option to verify a signature with loaded kernel
+	  image. If configured, any attempt of loading a image without
+	  valid signature will fail.
+
 config CRASH_DUMP
 	bool "Build kdump crash kernel"
 	help
-- 
2.14.1
