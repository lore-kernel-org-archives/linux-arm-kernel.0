From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Wed, 18 Sep 2013 21:43:56 +0200
Subject: [PATCH v4 2/2] RX-51: ARM errata 430973 workaround
In-Reply-To: <20130918192731.GE9994@atomide.com>
References: <1362044548-5398-1-git-send-email-pali.rohar@gmail.com>
 <201309182122.01570@pali> <20130918192731.GE9994@atomide.com>
Message-ID: <201309182143.56555@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Closed and signed Nokia X-Loader bootloader stored in RX-51 nand does not set
IBE bit in ACTLR and starting kernel in non-secure mode. So direct write to
ACTLR by our kernel does not working and the code for ARM errata 430973 in
commit 7ce236fcd6fd45b0441a2d49acb2ceb2de2e8a47 that sets IBE bit is a noop.

In order to have workaround for ARM errata 430973 from non-secure world on
RX-51 we needs Secure Monitor Call to set IBE BIT in ACTLR.

This patch adds RX-51 specific secure support code and sets IBE bit in ACTLR
during board init code for ARM errata 430973 workaround.

Note that new function rx51_secure_dispatcher() differs from existing
omap_secure_dispatcher(). It calling omap_smc3() and param[0] is nargs+1.

ARM errata 430973 workaround is needed for thumb-2 ISA compiled userspace
binaries. Without this workaround thumb-2 binaries crashing. So with this
patch it is possible to recompile and run applications/binaries with thumb-2
ISA on RX-51.

Signed-off-by: Ivaylo Dimitrov <freemangordon@abv.bg>
Signed-off-by: Pali Roh?r <pali.rohar@gmail.com>
---

I added note about difference between rx51_secure_dispatcher and
omap_secure_dispatcher to commit message and also to code.

 arch/arm/mach-omap2/board-rx51.c  |   12 +++++++
 arch/arm/mach-omap2/omap-secure.c |   65 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap-secure.h |   11 +++++++
 3 files changed, 88 insertions(+)

diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index 773510556..db168c9 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -2,6 +2,8 @@
  * Board support file for Nokia N900 (aka RX-51).
  *
  * Copyright (C) 2007, 2008 Nokia
+ * Copyright (C) 2012 Ivaylo Dimitrov <freemangordon@abv.bg>
+ * Copyright (C) 2013 Pali Roh?r <pali.rohar@gmail.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -31,7 +33,9 @@
 #include "mux.h"
 #include "gpmc.h"
 #include "pm.h"
+#include "soc.h"
 #include "sdram-nokia.h"
+#include "omap-secure.h"
 
 #define RX51_GPIO_SLEEP_IND 162
 
@@ -103,6 +107,14 @@ static void __init rx51_init(void)
 	usb_musb_init(&musb_board_data);
 	rx51_peripherals_init();
 
+	if (omap_type() == OMAP2_DEVICE_TYPE_SEC) {
+#ifdef CONFIG_ARM_ERRATA_430973
+		pr_info("RX-51: Enabling ARM errata 430973 workaround\n");
+		/* set IBE to 1 */
+		rx51_secure_update_aux_cr(BIT(6), 0);
+#endif
+	}
+
 	/* Ensure SDRC pins are mux'd for self-refresh */
 	omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
 	omap_mux_init_signal("sdrc_cke1", OMAP_PIN_OUTPUT);
diff --git a/arch/arm/mach-omap2/omap-secure.c b/arch/arm/mach-omap2/omap-secure.c
index b970440..146a7c4 100644
--- a/arch/arm/mach-omap2/omap-secure.c
+++ b/arch/arm/mach-omap2/omap-secure.c
@@ -3,6 +3,8 @@
  *
  * Copyright (C) 2011 Texas Instruments, Inc.
  *	Santosh Shilimkar <santosh.shilimkar@ti.com>
+ * Copyright (C) 2012 Ivaylo Dimitrov <freemangordon@abv.bg>
+ * Copyright (C) 2013 Pali Roh?r <pali.rohar@gmail.com>
  *
  *
  * This program is free software,you can redistribute it and/or modify
@@ -70,3 +72,66 @@ phys_addr_t omap_secure_ram_mempool_base(void)
 {
 	return omap_secure_memblock_base;
 }
+
+/**
+ * rx51_secure_dispatcher: Routine to dispatch secure PPA API calls
+ * @idx: The PPA API index
+ * @process: Process ID
+ * @flag: The flag indicating criticality of operation
+ * @nargs: Number of valid arguments out of four.
+ * @arg1, arg2, arg3 args4: Parameters passed to secure API
+ *
+ * Return the non-zero error value on failure.
+ *
+ * NOTE: rx51_secure_dispatcher differs from omap_secure_dispatcher because
+ *       it calling omap_smc3() instead omap_smc2() and param[0] is nargs+1
+ */
+u32 rx51_secure_dispatcher(u32 idx, u32 process, u32 flag, u32 nargs,
+			   u32 arg1, u32 arg2, u32 arg3, u32 arg4)
+{
+	u32 ret;
+	u32 param[5];
+
+	param[0] = nargs+1; /* RX-51 needs number of arguments + 1 */
+	param[1] = arg1;
+	param[2] = arg2;
+	param[3] = arg3;
+	param[4] = arg4;
+
+	/*
+	 * Secure API needs physical address
+	 * pointer for the parameters
+	 */
+	local_irq_disable();
+	local_fiq_disable();
+	flush_cache_all();
+	outer_clean_range(__pa(param), __pa(param + 5));
+	ret = omap_smc3(idx, process, flag, __pa(param));
+	flush_cache_all();
+	local_fiq_enable();
+	local_irq_enable();
+
+	return ret;
+}
+
+/**
+ * rx51_secure_update_aux_cr: Routine to modify the contents of Auxiliary Control Register
+ *  @set_bits: bits to set in ACR
+ *  @clr_bits: bits to clear in ACR
+ *
+ * Return the non-zero error value on failure.
+*/
+u32 rx51_secure_update_aux_cr(u32 set_bits, u32 clear_bits)
+{
+	u32 acr;
+
+	/* Read ACR */
+	asm volatile ("mrc p15, 0, %0, c1, c0, 1" : "=r" (acr));
+	acr &= ~clear_bits;
+	acr |= set_bits;
+
+	return rx51_secure_dispatcher(RX51_PPA_WRITE_ACR,
+				      0,
+				      FLAG_START_CRITICAL,
+				      1, acr, 0, 0, 0);
+}
diff --git a/arch/arm/mach-omap2/omap-secure.h b/arch/arm/mach-omap2/omap-secure.h
index c4586f4..51b59c6 100644
--- a/arch/arm/mach-omap2/omap-secure.h
+++ b/arch/arm/mach-omap2/omap-secure.h
@@ -3,6 +3,8 @@
  *
  * Copyright (C) 2011 Texas Instruments, Inc.
  *	Santosh Shilimkar <santosh.shilimkar@ti.com>
+ * Copyright (C) 2012 Ivaylo Dimitrov <freemangordon@abv.bg>
+ * Copyright (C) 2013 Pali Roh?r <pali.rohar@gmail.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -46,6 +48,11 @@
 #define OMAP4_PPA_L2_POR_INDEX		0x23
 #define OMAP4_PPA_CPU_ACTRL_SMP_INDEX	0x25
 
+/* Secure RX-51 PPA (Primary Protected Application) APIs */
+#define RX51_PPA_HWRNG			29
+#define RX51_PPA_L2_INVAL		40
+#define RX51_PPA_WRITE_ACR		42
+
 #ifndef __ASSEMBLER__
 
 extern u32 omap_secure_dispatcher(u32 idx, u32 flag, u32 nargs,
@@ -55,6 +62,10 @@ extern u32 omap_smc3(u32 id, u32 process, u32 flag, u32 pargs);
 extern phys_addr_t omap_secure_ram_mempool_base(void);
 extern int omap_secure_ram_reserve_memblock(void);
 
+extern u32 rx51_secure_dispatcher(u32 idx, u32 process, u32 flag, u32 nargs,
+				  u32 arg1, u32 arg2, u32 arg3, u32 arg4);
+extern u32 rx51_secure_update_aux_cr(u32 set_bits, u32 clear_bits);
+
 #ifdef CONFIG_OMAP4_ERRATA_I688
 extern int omap_barrier_reserve_memblock(void);
 #else
-- 
1.7.10.4
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130918/cb9fc46e/attachment.sig>
