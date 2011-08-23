From: will.deacon@arm.com (Will Deacon)
Date: Tue, 23 Aug 2011 22:30:39 +0100
Subject: [PATCH v2 2/5] ARM: debug: augment DEBUG_LL Kconfig help to clarify
	behaviour
In-Reply-To: <1314135042-19908-1-git-send-email-will.deacon@arm.com>
References: <1314135042-19908-1-git-send-email-will.deacon@arm.com>
Message-ID: <1314135042-19908-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enabled DEBUG_LL hardcodes the UART address into the kernel and results
in a non-portable kernel image. Since this option is only intended for
use when debugging early boot failures, supporting multiple platforms
in such a configuration is not the intended use-case.

This patch documents this limitation in the DEBUG_LL Kconfig help text,
so that users are aware of the portability restrictions that are associated
with enabling low-level debugging support.

Reported-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/Kconfig.debug |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 11604c9..60d1846 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -65,13 +65,18 @@ config DEBUG_USER
 
 # These options are only for real kernel hackers who want to get their hands dirty.
 config DEBUG_LL
-	bool "Kernel low-level debugging functions"
+	bool "Kernel low-level debugging functions (read help!)"
 	depends on DEBUG_KERNEL
 	help
 	  Say Y here to include definitions of printascii, printch, printhex
 	  in the kernel.  This is helpful if you are debugging code that
 	  executes before the console is initialized.
 
+	  Note that selecting this option will limit the kernel to a single
+	  UART definition, as specified below. Attempting to boot the kernel
+	  image on a different platform *will not work*, so this option should
+	  not be enabled for kernels that are intended to be portable.
+
 choice
 	prompt "Kernel low-level debugging port"
 	depends on DEBUG_LL
-- 
1.7.0.4
