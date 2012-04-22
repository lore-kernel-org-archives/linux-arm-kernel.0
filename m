From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 22 Apr 2012 13:39:17 +0000
Subject: [PATCH] arm: at91: fix build-error for board-dt
In-Reply-To: <20120422015059.GE9142@game.jcrosoft.org>
References: <1335004105-3162-1-git-send-email-w.sang@pengutronix.de>
 <201204211839.15535.arnd@arndb.de> <20120422015059.GE9142@game.jcrosoft.org>
Message-ID: <201204221339.18385.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 22 April 2012, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 18:39 Sat 21 Apr     , Arnd Bergmann wrote:
> > On Saturday 21 April 2012, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > > > Ok, we can discard this patch and see it as a bug report.
> > > > Since you know best what you'd like, would you send a patch?
> > > I'll fix on 3.5 by make it depends on AT91SAM9
> > 
> > I think it should be fixed for v3.4, especially since it's so easy
> > to trigger and the fix will be trivial.
> The symbol does not exist before
> 
> and the board-dt is sam9 only

How about this patch for v3.4 then? It ensures that we don't try to build
ARCH_AT91RM9200 or ARCH_AT91X40 with MACH_AT91SAM_DT, which would be broken
in v3.4-rc4 as Wolfram pointed out.

8<----
ARM: at91: fix DT-enabled builds for non-DT chips

The ARCH_AT91RM9200 and ARCH_AT91X40 variants do not support booting with
DT yet, so we must not let the user select MACH_AT91SAM_DT in order
to avoid build errors.

It's still possible to enable USE_OF, and we should provide a few stub
functions for that case for restart and clock_init.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 45db05d..b9d9410 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -457,6 +457,7 @@ endif
 
 # ----------------------------------------------------------
 
+if !ARCH_AT91RM9200 && !ARCH_AT91X40
 comment "Generic Board Type"
 
 config MACH_AT91SAM_DT
@@ -465,6 +466,7 @@ config MACH_AT91SAM_DT
 	help
 	  Select this if you want to experiment device-tree with
 	  an Atmel Evaluation Kit.
+endif
 
 # ----------------------------------------------------------
 
diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
index dd9b346..1355b44 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -55,7 +55,8 @@ extern void __init at91sam9g45_set_console_clock(int id);
 extern int __init at91_clock_init(unsigned long main_clock);
 extern int __init at91_dt_clock_init(void);
 #else
-static int inline at91_clock_init(unsigned long main_clock) { return 0; }
+static inline int at91_clock_init(unsigned long main_clock) { return 0; }
+static inline int at91_dt_clock_init(void) { return 0; }
 #endif
 struct device;
 
@@ -68,8 +69,16 @@ extern void at91sam9_idle(void);
 
 /* reset */
 extern void at91_ioremap_rstc(u32 base_addr);
+#ifdef CONFIG_AT91_SAM9_ALT_RESET
 extern void at91sam9_alt_restart(char, const char *);
+#else
+static inline void at91sam9_alt_restart(char c, const char *s) { }
+#endif
+#ifdef CONFIG_AT91_SAM9G45_RESET
 extern void at91sam9g45_restart(char, const char *);
+#else
+static inline void at91sam9g45_restart(char c, const char *s) { }
+#endif
 
 /* shutdown */
 extern void at91_ioremap_shdwc(u32 base_addr);
