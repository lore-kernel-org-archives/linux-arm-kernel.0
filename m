From: luto@amacapital.net (Andy Lutomirski)
Date: Fri, 18 Jul 2014 15:32:00 -0700
Subject: [PATCH v2 8/7] seccomp: Document two-phase seccomp and arch-provided
 seccomp_data
In-Reply-To: <cover.1405717901.git.luto@amacapital.net>
References: <cover.1405717901.git.luto@amacapital.net>
Message-ID: <0a79fe55572054ac3b533548481ad1d2b6104eb6.1405722642.git.luto@amacapital.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The description of how arches should implement seccomp filters was
still strictly correct, but it failed to describe the newly
available optimizations.

Signed-off-by: Andy Lutomirski <luto@amacapital.net>
---

I lost this somehow.  Here it as an an extra patch.  If I end up sending
a v3, I'll fold it in.

 arch/Kconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 0eae9df..05d7a8a 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -323,6 +323,17 @@ config HAVE_ARCH_SECCOMP_FILTER
 	    results in the system call being skipped immediately.
 	  - seccomp syscall wired up
 
+	  For best performance, an arch should use seccomp_phase1 and
+	  seccomp_phase2 directly.  It should call seccomp_phase1 for all
+	  syscalls if TIF_SECCOMP is set, but seccomp_phase1 does not
+	  need to be called from a ptrace-safe context.  It must then
+	  call seccomp_phase2 if seccomp_phase1 returns anything other
+	  than SECCOMP_PHASE1_OK or SECCOMP_PHASE1_SKIP.
+
+	  As an additional optimization, an arch may provide seccomp_data
+	  directly to seccomp_phase1; this avoids multiple calls
+	  to the syscall_xyz helpers for every syscall.
+
 config SECCOMP_FILTER
 	def_bool y
 	depends on HAVE_ARCH_SECCOMP_FILTER && SECCOMP && NET
-- 
1.9.3
