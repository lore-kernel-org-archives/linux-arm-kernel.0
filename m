From: cgagneraud@techworks.ie (Christian Gagneraud)
Date: Sun, 04 Oct 2009 02:14:24 +0100
Subject: [PATCH v1.0 2/4] TS72XX: Allow to override machine ID
In-Reply-To: <20091004011413.12578.89897.stgit@localhost.localdomain>
References: <20091004011413.12578.89897.stgit@localhost.localdomain>
Message-ID: <20091004011424.12578.79467.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Matthieu Crapet <mcrapet@gmail.com>

In early days Technologic Systems fixed the 0x163 value in redboot
instead of 0x2a1, this patch allow to overwrite it.

Signed-off-by: Matthieu Crapet <mcrapet@gmail.com>
Signed-off-by: Christian Gagneraud <cgagneraud@techworks.ie>
---

 arch/arm/kernel/head.S       |    3 +++
 arch/arm/mach-ep93xx/Kconfig |    7 +++++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 38ccbe1..c2e4514 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -82,6 +82,9 @@ ENTRY(stext)
 	bl	__lookup_processor_type		@ r5=procinfo r9=cpuid
 	movs	r10, r5				@ invalid processor (r5=0)?
 	beq	__error_p			@ yes, error 'p'
+#ifdef CONFIG_MACH_TS72XX_FORCE_MACHINEID
+	ldr r1, =0x2a1
+#endif
 	bl	__lookup_machine_type		@ r5=machinfo
 	movs	r8, r5				@ invalid machine (r5=0)?
 	beq	__error_a			@ yes, error 'a'
diff --git a/arch/arm/mach-ep93xx/Kconfig b/arch/arm/mach-ep93xx/Kconfig
index 303c4f8..a909303 100644
--- a/arch/arm/mach-ep93xx/Kconfig
+++ b/arch/arm/mach-ep93xx/Kconfig
@@ -191,6 +191,13 @@ config EP93XX_EARLY_UART3
 
 endchoice
 
+config MACH_TS72XX_FORCE_MACHINEID
+	bool "Force Machine ID"
+	depends on MACH_TS72XX
+	help
+	  Say 'Y' here to force Machine ID to 0x2A1 (MACH_TYPE_TS72XX legacy value)
+	  In early days Technologic Systems fixed the 0x163 value in redboot.
+
 endmenu
 
 endif
