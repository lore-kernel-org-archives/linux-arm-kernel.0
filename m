From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Sun, 4 Aug 2013 10:45:00 +0200
Subject: [PATCH v3 1/2] ARM: OMAP: Add secure function omap_smc3() which
 calling instruction smc #1
In-Reply-To: <20130712102430.GA3249@localhost.localdomain>
References: <531356997.66774.1373571839852.JavaMail.apache@mail81.abv.bg>
 <51DF0D7A.4090008@ti.com> <20130712102430.GA3249@localhost.localdomain>
Message-ID: <201308041045.00698@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here is new version (v3) of omap secure part patch:

Other secure functions omap_smc1() and omap_smc2() calling instruction smc #0
but Nokia RX-51 board needs to call smc #1 for PPA access.

Signed-off-by: Ivaylo Dimitrov <freemangordon@abv.bg>
Signed-off-by: Pali Roh?r <pali.rohar@gmail.com>
---
diff --git a/arch/arm/mach-omap2/omap-secure.h b/arch/arm/mach-omap2/omap-secure.h
index 0e72917..c4586f4 100644
--- a/arch/arm/mach-omap2/omap-secure.h
+++ b/arch/arm/mach-omap2/omap-secure.h
@@ -51,6 +51,7 @@
 extern u32 omap_secure_dispatcher(u32 idx, u32 flag, u32 nargs,
 				u32 arg1, u32 arg2, u32 arg3, u32 arg4);
 extern u32 omap_smc2(u32 id, u32 falg, u32 pargs);
+extern u32 omap_smc3(u32 id, u32 process, u32 flag, u32 pargs);
 extern phys_addr_t omap_secure_ram_mempool_base(void);
 extern int omap_secure_ram_reserve_memblock(void);
 
diff --git a/arch/arm/mach-omap2/omap-smc.S b/arch/arm/mach-omap2/omap-smc.S
index f6441c1..7bbc043 100644
--- a/arch/arm/mach-omap2/omap-smc.S
+++ b/arch/arm/mach-omap2/omap-smc.S
@@ -1,9 +1,11 @@
 /*
- * OMAP44xx secure APIs file.
+ * OMAP34xx and OMAP44xx secure APIs file.
  *
  * Copyright (C) 2010 Texas Instruments, Inc.
  * Written by Santosh Shilimkar <santosh.shilimkar@ti.com>
  *
+ * Copyright (C) 2012 Ivaylo Dimitrov <freemangordon@abv.bg>
+ * Copyright (C) 2013 Pali Roh?r <pali.rohar@gmail.com>
  *
  * This program is free software,you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -54,6 +56,23 @@ ENTRY(omap_smc2)
 	ldmfd   sp!, {r4-r12, pc}
 ENDPROC(omap_smc2)
 
+/**
+ * u32 omap_smc3(u32 service_id, u32 process_id, u32 flag, u32 pargs)
+ * Low level common routine for secure HAL and PPA APIs via smc #1
+ * r0 - @service_id: Secure Service ID
+ * r1 - @process_id: Process ID
+ * r2 - @flag: Flag to indicate the criticality of operation
+ * r3 - @pargs: Physical address of parameter list
+ */
+ENTRY(omap_smc3)
+	stmfd	sp!, {r4-r11, lr}
+	mov	r12, r0		@ Copy the secure service ID
+	mov	r6, #0xff	@ Indicate new Task call
+	dsb			@ Memory Barrier
+	smc	#1		@ Call PPA service
+	ldmfd	sp!, {r4-r11, pc}
+ENDPROC(omap_smc3)
+
 ENTRY(omap_modify_auxcoreboot0)
 	stmfd   sp!, {r1-r12, lr}
 	ldr	r12, =0x104

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130804/c2ba9517/attachment.sig>
