From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 26 Mar 2015 17:28:52 +0900
Subject: [PATCH 4/5] arm64: add kdump support
In-Reply-To: <1427358533-3754-1-git-send-email-takahiro.akashi@linaro.org>
References: <1427358533-3754-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1427358533-3754-5-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please read the following commits for arm64-specific constraints:
    arm64: kdump: reserve memory for crash dump kernel
    arm64: kdump: do not go into EL2 before starting a crash dump kernel

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 Documentation/kdump/kdump.txt |   31 ++++++++++++++++++++++++++++++-
 arch/arm64/Kconfig            |   12 ++++++++++++
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/Documentation/kdump/kdump.txt b/Documentation/kdump/kdump.txt
index bc4bd5a..f9cf6f5 100644
--- a/Documentation/kdump/kdump.txt
+++ b/Documentation/kdump/kdump.txt
@@ -18,7 +18,7 @@ memory image to a dump file on the local disk, or across the network to
 a remote system.
 
 Kdump and kexec are currently supported on the x86, x86_64, ppc64, ia64,
-s390x and arm architectures.
+s390x, arm and arm64 architectures.
 
 When the system kernel boots, it reserves a small section of memory for
 the dump-capture kernel. This ensures that ongoing Direct Memory Access
@@ -249,6 +249,29 @@ Dump-capture kernel config options (Arch Dependent, arm)
 
     AUTO_ZRELADDR=y
 
+Dump-capture kernel config options (Arch Dependent, arm64)
+----------------------------------------------------------
+
+1) Disable symmetric multi-processing support under "Processor type and
+   features":
+
+   CONFIG_SMP=n
+
+   (If CONFIG_SMP=y, then specify maxcpus=1 on the kernel command line
+   when loading the dump-capture kernel, see section "Load the Dump-capture
+   Kernel".)
+
+2) Under uefi, the maximum memory size on the dump-capture kernel must be
+   limited by specifying:
+
+   mem=X[MG]
+
+   where X should be less than or equal to the size in "crashkernel="
+   boot parameter. Kexec-tools will automatically add this.
+
+3) Currently, kvm will not be initialized on the dump-capture kernel even
+   if it is configured.
+
 Extended crashkernel syntax
 ===========================
 
@@ -312,6 +335,7 @@ Boot into System Kernel
    any space below the alignment point may be overwritten by the dump-capture kernel,
    which means it is possible that the vmcore is not that precise as expected.
 
+   On arm64, use "crashkernel=Y at X".
 
 Load the Dump-capture Kernel
 ============================
@@ -334,6 +358,8 @@ For s390x:
 	- Use image or bzImage
 For arm:
 	- Use zImage
+For arm64:
+	- Use vmlinux
 
 If you are using a uncompressed vmlinux image then use following command
 to load dump-capture kernel.
@@ -377,6 +403,9 @@ For s390x:
 For arm:
 	"1 maxcpus=1 reset_devices"
 
+For arm64:
+	"1 maxcpus=1 mem=X[MG] reset_devices"
+
 Notes on loading the dump-capture kernel:
 
 * By default, the ELF headers are stored in ELF64 format to support
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5a606d1..06a6ed4 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -537,6 +537,18 @@ config KEXEC
 	  but it is independent of the system firmware.   And like a reboot
 	  you can start any kernel with it, not just Linux.
 
+config CRASH_DUMP
+	bool "Build kdump crash kernel"
+	help
+	  Generate crash dump after being started by kexec. This should
+	  be normally only set in special crash dump kernels which are
+	  loaded in the main kernel with kexec-tools into a specially
+	  reserved region and then later executed after a crash by
+	  kdump/kexec. The crash dump kernel must be compiled to a
+	  memory address not used by the main kernel.
+
+	  For more details see Documentation/kdump/kdump.txt
+
 config XEN_DOM0
 	def_bool y
 	depends on XEN
-- 
1.7.9.5
