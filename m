From: cgagneraud@techworks.ie (Christian Gagneraud)
Date: Sun, 04 Oct 2009 02:14:19 +0100
Subject: [PATCH v1.0 1/4] EP93XX: Allow to force nF bit in control reg
In-Reply-To: <20091004011413.12578.89897.stgit@localhost.localdomain>
References: <20091004011413.12578.89897.stgit@localhost.localdomain>
Message-ID: <20091004011418.12578.67140.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Usually this is set by the bootrom.  If it is not set, then the CPU
core will run from HCLK instead of FCLK, and performance will suffer.

Signed-off-by: Matthieu Crapet <mcrapet@gmail.com>
Signed-off-by: Christian Gagneraud <cgagneraud@techworks.ie>
---

 arch/arm/mach-ep93xx/Kconfig |    9 +++++++++
 arch/arm/mm/proc-arm920.S    |    3 +++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ep93xx/Kconfig b/arch/arm/mach-ep93xx/Kconfig
index 9167c3d..303c4f8 100644
--- a/arch/arm/mach-ep93xx/Kconfig
+++ b/arch/arm/mach-ep93xx/Kconfig
@@ -7,6 +7,15 @@ config CRUNCH
 	help
 	  Enable kernel support for MaverickCrunch.
 
+config CR1_NFBIT
+       bool "Turn on nF bit in ControlRegister 1"
+       help
+         Say 'Y' here to force the nF bit on.  Usually this is set
+         by the bootrom.  If it is not set, then the CPU core will
+         run from HCLK instead of FCLK, and performance will suffer.
+         If you see BogoMIPS of about 1/4 of your CPU clock, try
+         turning this on; your performance should double.
+
 comment "EP93xx Platforms"
 
 choice
diff --git a/arch/arm/mm/proc-arm920.S b/arch/arm/mm/proc-arm920.S
index 914d688..9f030ee 100644
--- a/arch/arm/mm/proc-arm920.S
+++ b/arch/arm/mm/proc-arm920.S
@@ -373,6 +373,9 @@ __arm920_setup:
 	mrc	p15, 0, r0, c1, c0		@ get control register v4
 	bic	r0, r0, r5
 	orr	r0, r0, r6
+#ifdef CONFIG_CR1_NFBIT
+	orr     r0, r0, #0x40000000             @ set nF
+#endif
 	mov	pc, lr
 	.size	__arm920_setup, . - __arm920_setup
 
