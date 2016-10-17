From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 17 Oct 2016 16:18:39 +0100
Subject: [PATCH] arm64: kaslr: keep modules close to the kernel when
 DYNAMIC_FTRACE=y
Message-ID: <1476717519-28424-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The RANDOMIZE_MODULE_REGION_FULL Kconfig option allows KASLR to be
configured in such a way that kernel modules and the core kernel are
allocated completely independently, which implies that modules are likely
to require branches via PLT entries to reach the core kernel. The dynamic
ftrace code does not expect that, and assumes that it can patch module
code to perform a relative branch to anywhere in the core kernel. This
may result in errors such as

  branch_imm_common: offset out of range
  ------------[ cut here ]------------
  WARNING: CPU: 3 PID: 196 at kernel/trace/ftrace.c:1995 ftrace_bug+0x220/0x2e8
  Modules linked in:

  CPU: 3 PID: 196 Comm: systemd-udevd Not tainted 4.8.0-22-generic #24
  Hardware name: AMD Seattle/Seattle, BIOS 10:34:40 Oct  6 2016
  task: ffff8d1bef7dde80 task.stack: ffff8d1bef6b0000
  PC is at ftrace_bug+0x220/0x2e8
  LR is at ftrace_process_locs+0x330/0x430

So make RANDOMIZE_MODULE_REGION_FULL mutually exclusive with DYNAMIC_FTRACE
at the Kconfig level.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 30398dbc940a..969ef880d234 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -915,7 +915,7 @@ config RANDOMIZE_BASE
 
 config RANDOMIZE_MODULE_REGION_FULL
 	bool "Randomize the module region independently from the core kernel"
-	depends on RANDOMIZE_BASE
+	depends on RANDOMIZE_BASE && !DYNAMIC_FTRACE
 	default y
 	help
 	  Randomizes the location of the module region without considering the
-- 
2.7.4
