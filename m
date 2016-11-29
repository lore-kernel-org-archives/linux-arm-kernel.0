From: labbott@redhat.com (Laura Abbott)
Date: Tue, 29 Nov 2016 10:55:20 -0800
Subject: [PATCHv4 01/10] lib/Kconfig.debug: Add ARCH_HAS_DEBUG_VIRTUAL
In-Reply-To: <1480445729-27130-1-git-send-email-labbott@redhat.com>
References: <1480445729-27130-1-git-send-email-labbott@redhat.com>
Message-ID: <1480445729-27130-2-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


DEBUG_VIRTUAL currently depends on DEBUG_KERNEL && X86. arm64 is getting
the same support. Rather than add a list of architectures, switch this
to ARCH_HAS_DEBUG_VIRTUAL and let architectures select it as
appropriate.

Acked-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v4: No changes, just Acks
---
 arch/x86/Kconfig  | 1 +
 lib/Kconfig.debug | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index bada636..f533321 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -23,6 +23,7 @@ config X86
 	select ARCH_CLOCKSOURCE_DATA
 	select ARCH_DISCARD_MEMBLOCK
 	select ARCH_HAS_ACPI_TABLE_UPGRADE if ACPI
+	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_FAST_MULTIPLIER
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index a6c8db1..be65e04 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -603,9 +603,12 @@ config DEBUG_VM_PGFLAGS
 
 	  If unsure, say N.
 
+config ARCH_HAS_DEBUG_VIRTUAL
+	bool
+
 config DEBUG_VIRTUAL
 	bool "Debug VM translations"
-	depends on DEBUG_KERNEL && X86
+	depends on DEBUG_KERNEL && ARCH_HAS_DEBUG_VIRTUAL
 	help
 	  Enable some costly sanity checks in virtual to page code. This can
 	  catch mistakes with virt_to_page() and friends.
-- 
2.7.4
