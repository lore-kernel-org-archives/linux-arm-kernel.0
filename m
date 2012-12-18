From: pratikp@codeaurora.org (pratikp at codeaurora.org)
Date: Tue, 18 Dec 2012 11:19:25 -0800
Subject: [RFC 8/8] coresight: add CoreSight ETM driver
In-Reply-To: <1355858365-11849-1-git-send-email-pratikp@codeaurora.org>
References: <1355858365-11849-1-git-send-email-pratikp@codeaurora.org>
Message-ID: <1355858365-11849-9-git-send-email-pratikp@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pratik Patel <pratikp@codeaurora.org>

This driver manages CoreSight ETM (Embedded Trace Macrocell) that
supports processor tracing. Currently it supports ARM PFT
(Program Flow Trace) v1.1 specification but can be extended to
support other ETM or PFT versions.

Signed-off-by: Pratik Patel <pratikp@codeaurora.org>
---
 .../devicetree/bindings/arm/coresight.txt          |    2 +
 arch/arm/include/asm/hardware/cp14.h               |  540 ++++++
 drivers/coresight/Kconfig                          |   21 +
 drivers/coresight/Makefile                         |    1 +
 drivers/coresight/coresight-etm-cp14.c             |  510 ++++++
 drivers/coresight/coresight-etm.c                  | 1752 ++++++++++++++++++++
 6 files changed, 2826 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/include/asm/hardware/cp14.h
 create mode 100644 drivers/coresight/coresight-etm-cp14.c
 create mode 100644 drivers/coresight/coresight-etm.c

diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
index 031f760..e3efbe4 100644
--- a/Documentation/devicetree/bindings/arm/coresight.txt
+++ b/Documentation/devicetree/bindings/arm/coresight.txt
@@ -32,6 +32,7 @@ Optional properties:
 - coresight-child-ports : list of input port numbers of the children
 - coresight-default-sink : represents the default compile time CoreSight sink
 - arm,buffer-size : size of contiguous buffer space for TMC ETR
+- arm,cp14 : cp14 access to ETM registers is implemented and should be used
 
 Examples:
 
@@ -105,4 +106,5 @@ Examples:
 		coresight-outports = <0>;
 		coresight-child-list = <&funnel_kpss>;
 		coresight-child-ports = <0>;
+		arm,cp14;
 	};
diff --git a/arch/arm/include/asm/hardware/cp14.h b/arch/arm/include/asm/hardware/cp14.h
new file mode 100644
index 0000000..8acf0c7
--- /dev/null
+++ b/arch/arm/include/asm/hardware/cp14.h
@@ -0,0 +1,540 @@
+/* Copyright (c) 2011-2012, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __ASM_HARDWARE_CP14_H
+#define __ASM_HARDWARE_CP14_H
+
+#include <linux/types.h>
+
+/* Accessors for CP14 registers */
+#define dbg_read(reg)			RCP14_##reg()
+#define dbg_write(val, reg)		WCP14_##reg(val)
+#define etm_read(reg)			RCP14_##reg()
+#define etm_write(val, reg)		WCP14_##reg(val)
+
+/* MRC14 and MCR14 */
+#define MRC14(op1, crn, crm, op2)					\
+({									\
+uint32_t val;								\
+asm volatile("mrc p14, "#op1", %0, "#crn", "#crm", "#op2 : "=r" (val));	\
+val;									\
+})
+
+#define MCR14(val, op1, crn, crm, op2)					\
+({									\
+asm volatile("mcr p14, "#op1", %0, "#crn", "#crm", "#op2 : : "r" (val));\
+})
+
+/* Debug Registers
+ *
+ * Available only in DBGv7
+ * DBGECR, DBGDSCCR, DBGDSMCR, DBGDRCR
+ *
+ * Available only in DBGv7.1
+ * DBGBXVRm, DBGOSDLR, DBGDEVID2, DBGDEVID1
+ *
+ * Read only
+ * DBGDIDR, DBGDSCRint, DBGDTRRXint, DBGDRAR, DBGOSLSR, DBGOSSRR, DBGPRSR,
+ * DBGPRSR, DBGDSAR, DBGAUTHSTATUS, DBGDEVID2, DBGDEVID1, DBGDEVID
+ *
+ * Write only
+ * DBGDTRTXint, DBGOSLAR
+ */
+#define RCP14_DBGDIDR()			MRC14(0, c0, c0, 0)
+#define RCP14_DBGDSCRint()		MRC14(0, c0, c1, 0)
+#define RCP14_DBGDTRRXint()		MRC14(0, c0, c5, 0)
+#define RCP14_DBGWFAR()			MRC14(0, c0, c6, 0)
+#define RCP14_DBGVCR()			MRC14(0, c0, c7, 0)
+#define RCP14_DBGECR()			MRC14(0, c0, c9, 0)
+#define RCP14_DBGDSCCR()		MRC14(0, c0, c10, 0)
+#define RCP14_DBGDSMCR()		MRC14(0, c0, c11, 0)
+#define RCP14_DBGDTRRXext()		MRC14(0, c0, c0, 2)
+#define RCP14_DBGDSCRext()		MRC14(0, c0, c2, 2)
+#define RCP14_DBGDTRTXext()		MRC14(0, c0, c3, 2)
+#define RCP14_DBGDRCR()			MRC14(0, c0, c4, 2)
+#define RCP14_DBGBVR0()			MRC14(0, c0, c0, 4)
+#define RCP14_DBGBVR1()			MRC14(0, c0, c1, 4)
+#define RCP14_DBGBVR2()			MRC14(0, c0, c2, 4)
+#define RCP14_DBGBVR3()			MRC14(0, c0, c3, 4)
+#define RCP14_DBGBVR4()			MRC14(0, c0, c4, 4)
+#define RCP14_DBGBVR5()			MRC14(0, c0, c5, 4)
+#define RCP14_DBGBVR6()			MRC14(0, c0, c6, 4)
+#define RCP14_DBGBVR7()			MRC14(0, c0, c7, 4)
+#define RCP14_DBGBVR8()			MRC14(0, c0, c8, 4)
+#define RCP14_DBGBVR9()			MRC14(0, c0, c9, 4)
+#define RCP14_DBGBVR10()		MRC14(0, c0, c10, 4)
+#define RCP14_DBGBVR11()		MRC14(0, c0, c11, 4)
+#define RCP14_DBGBVR12()		MRC14(0, c0, c12, 4)
+#define RCP14_DBGBVR13()		MRC14(0, c0, c13, 4)
+#define RCP14_DBGBVR14()		MRC14(0, c0, c14, 4)
+#define RCP14_DBGBVR15()		MRC14(0, c0, c15, 4)
+#define RCP14_DBGBCR0()			MRC14(0, c0, c0, 5)
+#define RCP14_DBGBCR1()			MRC14(0, c0, c1, 5)
+#define RCP14_DBGBCR2()			MRC14(0, c0, c2, 5)
+#define RCP14_DBGBCR3()			MRC14(0, c0, c3, 5)
+#define RCP14_DBGBCR4()			MRC14(0, c0, c4, 5)
+#define RCP14_DBGBCR5()			MRC14(0, c0, c5, 5)
+#define RCP14_DBGBCR6()			MRC14(0, c0, c6, 5)
+#define RCP14_DBGBCR7()			MRC14(0, c0, c7, 5)
+#define RCP14_DBGBCR8()			MRC14(0, c0, c8, 5)
+#define RCP14_DBGBCR9()			MRC14(0, c0, c9, 5)
+#define RCP14_DBGBCR10()		MRC14(0, c0, c10, 5)
+#define RCP14_DBGBCR11()		MRC14(0, c0, c11, 5)
+#define RCP14_DBGBCR12()		MRC14(0, c0, c12, 5)
+#define RCP14_DBGBCR13()		MRC14(0, c0, c13, 5)
+#define RCP14_DBGBCR14()		MRC14(0, c0, c14, 5)
+#define RCP14_DBGBCR15()		MRC14(0, c0, c15, 5)
+#define RCP14_DBGWVR0()			MRC14(0, c0, c0, 6)
+#define RCP14_DBGWVR1()			MRC14(0, c0, c1, 6)
+#define RCP14_DBGWVR2()			MRC14(0, c0, c2, 6)
+#define RCP14_DBGWVR3()			MRC14(0, c0, c3, 6)
+#define RCP14_DBGWVR4()			MRC14(0, c0, c4, 6)
+#define RCP14_DBGWVR5()			MRC14(0, c0, c5, 6)
+#define RCP14_DBGWVR6()			MRC14(0, c0, c6, 6)
+#define RCP14_DBGWVR7()			MRC14(0, c0, c7, 6)
+#define RCP14_DBGWVR8()			MRC14(0, c0, c8, 6)
+#define RCP14_DBGWVR9()			MRC14(0, c0, c9, 6)
+#define RCP14_DBGWVR10()		MRC14(0, c0, c10, 6)
+#define RCP14_DBGWVR11()		MRC14(0, c0, c11, 6)
+#define RCP14_DBGWVR12()		MRC14(0, c0, c12, 6)
+#define RCP14_DBGWVR13()		MRC14(0, c0, c13, 6)
+#define RCP14_DBGWVR14()		MRC14(0, c0, c14, 6)
+#define RCP14_DBGWVR15()		MRC14(0, c0, c15, 6)
+#define RCP14_DBGWCR0()			MRC14(0, c0, c0, 7)
+#define RCP14_DBGWCR1()			MRC14(0, c0, c1, 7)
+#define RCP14_DBGWCR2()			MRC14(0, c0, c2, 7)
+#define RCP14_DBGWCR3()			MRC14(0, c0, c3, 7)
+#define RCP14_DBGWCR4()			MRC14(0, c0, c4, 7)
+#define RCP14_DBGWCR5()			MRC14(0, c0, c5, 7)
+#define RCP14_DBGWCR6()			MRC14(0, c0, c6, 7)
+#define RCP14_DBGWCR7()			MRC14(0, c0, c7, 7)
+#define RCP14_DBGWCR8()			MRC14(0, c0, c8, 7)
+#define RCP14_DBGWCR9()			MRC14(0, c0, c9, 7)
+#define RCP14_DBGWCR10()		MRC14(0, c0, c10, 7)
+#define RCP14_DBGWCR11()		MRC14(0, c0, c11, 7)
+#define RCP14_DBGWCR12()		MRC14(0, c0, c12, 7)
+#define RCP14_DBGWCR13()		MRC14(0, c0, c13, 7)
+#define RCP14_DBGWCR14()		MRC14(0, c0, c14, 7)
+#define RCP14_DBGWCR15()		MRC14(0, c0, c15, 7)
+#define RCP14_DBGDRAR()			MRC14(0, c1, c0, 0)
+#define RCP14_DBGBXVR0()		MRC14(0, c1, c0, 1)
+#define RCP14_DBGBXVR1()		MRC14(0, c1, c1, 1)
+#define RCP14_DBGBXVR2()		MRC14(0, c1, c2, 1)
+#define RCP14_DBGBXVR3()		MRC14(0, c1, c3, 1)
+#define RCP14_DBGBXVR4()		MRC14(0, c1, c4, 1)
+#define RCP14_DBGBXVR5()		MRC14(0, c1, c5, 1)
+#define RCP14_DBGBXVR6()		MRC14(0, c1, c6, 1)
+#define RCP14_DBGBXVR7()		MRC14(0, c1, c7, 1)
+#define RCP14_DBGBXVR8()		MRC14(0, c1, c8, 1)
+#define RCP14_DBGBXVR9()		MRC14(0, c1, c9, 1)
+#define RCP14_DBGBXVR10()		MRC14(0, c1, c10, 1)
+#define RCP14_DBGBXVR11()		MRC14(0, c1, c11, 1)
+#define RCP14_DBGBXVR12()		MRC14(0, c1, c12, 1)
+#define RCP14_DBGBXVR13()		MRC14(0, c1, c13, 1)
+#define RCP14_DBGBXVR14()		MRC14(0, c1, c14, 1)
+#define RCP14_DBGBXVR15()		MRC14(0, c1, c15, 1)
+#define RCP14_DBGOSLSR()		MRC14(0, c1, c1, 4)
+#define RCP14_DBGOSSRR()		MRC14(0, c1, c2, 4)
+#define RCP14_DBGOSDLR()		MRC14(0, c1, c3, 4)
+#define RCP14_DBGPRCR()			MRC14(0, c1, c4, 4)
+#define RCP14_DBGPRSR()			MRC14(0, c1, c5, 4)
+#define RCP14_DBGDSAR()			MRC14(0, c2, c0, 0)
+#define RCP14_DBGITCTRL()		MRC14(0, c7, c0, 4)
+#define RCP14_DBGCLAIMSET()		MRC14(0, c7, c8, 6)
+#define RCP14_DBGCLAIMCLR()		MRC14(0, c7, c9, 6)
+#define RCP14_DBGAUTHSTATUS()		MRC14(0, c7, c14, 6)
+#define RCP14_DBGDEVID2()		MRC14(0, c7, c0, 7)
+#define RCP14_DBGDEVID1()		MRC14(0, c7, c1, 7)
+#define RCP14_DBGDEVID()		MRC14(0, c7, c2, 7)
+
+#define WCP14_DBGDTRTXint(val)		MCR14(val, 0, c0, c5, 0)
+#define WCP14_DBGWFAR(val)		MCR14(val, 0, c0, c6, 0)
+#define WCP14_DBGVCR(val)		MCR14(val, 0, c0, c7, 0)
+#define WCP14_DBGECR(val)		MCR14(val, 0, c0, c9, 0)
+#define WCP14_DBGDSCCR(val)		MCR14(val, 0, c0, c10, 0)
+#define WCP14_DBGDSMCR(val)		MCR14(val, 0, c0, c11, 0)
+#define WCP14_DBGDTRRXext(val)		MCR14(val, 0, c0, c0, 2)
+#define WCP14_DBGDSCRext(val)		MCR14(val, 0, c0, c2, 2)
+#define WCP14_DBGDTRTXext(val)		MCR14(val, 0, c0, c3, 2)
+#define WCP14_DBGDRCR(val)		MCR14(val, 0, c0, c4, 2)
+#define WCP14_DBGBVR0(val)		MCR14(val, 0, c0, c0, 4)
+#define WCP14_DBGBVR1(val)		MCR14(val, 0, c0, c1, 4)
+#define WCP14_DBGBVR2(val)		MCR14(val, 0, c0, c2, 4)
+#define WCP14_DBGBVR3(val)		MCR14(val, 0, c0, c3, 4)
+#define WCP14_DBGBVR4(val)		MCR14(val, 0, c0, c4, 4)
+#define WCP14_DBGBVR5(val)		MCR14(val, 0, c0, c5, 4)
+#define WCP14_DBGBVR6(val)		MCR14(val, 0, c0, c6, 4)
+#define WCP14_DBGBVR7(val)		MCR14(val, 0, c0, c7, 4)
+#define WCP14_DBGBVR8(val)		MCR14(val, 0, c0, c8, 4)
+#define WCP14_DBGBVR9(val)		MCR14(val, 0, c0, c9, 4)
+#define WCP14_DBGBVR10(val)		MCR14(val, 0, c0, c10, 4)
+#define WCP14_DBGBVR11(val)		MCR14(val, 0, c0, c11, 4)
+#define WCP14_DBGBVR12(val)		MCR14(val, 0, c0, c12, 4)
+#define WCP14_DBGBVR13(val)		MCR14(val, 0, c0, c13, 4)
+#define WCP14_DBGBVR14(val)		MCR14(val, 0, c0, c14, 4)
+#define WCP14_DBGBVR15(val)		MCR14(val, 0, c0, c15, 4)
+#define WCP14_DBGBCR0(val)		MCR14(val, 0, c0, c0, 5)
+#define WCP14_DBGBCR1(val)		MCR14(val, 0, c0, c1, 5)
+#define WCP14_DBGBCR2(val)		MCR14(val, 0, c0, c2, 5)
+#define WCP14_DBGBCR3(val)		MCR14(val, 0, c0, c3, 5)
+#define WCP14_DBGBCR4(val)		MCR14(val, 0, c0, c4, 5)
+#define WCP14_DBGBCR5(val)		MCR14(val, 0, c0, c5, 5)
+#define WCP14_DBGBCR6(val)		MCR14(val, 0, c0, c6, 5)
+#define WCP14_DBGBCR7(val)		MCR14(val, 0, c0, c7, 5)
+#define WCP14_DBGBCR8(val)		MCR14(val, 0, c0, c8, 5)
+#define WCP14_DBGBCR9(val)		MCR14(val, 0, c0, c9, 5)
+#define WCP14_DBGBCR10(val)		MCR14(val, 0, c0, c10, 5)
+#define WCP14_DBGBCR11(val)		MCR14(val, 0, c0, c11, 5)
+#define WCP14_DBGBCR12(val)		MCR14(val, 0, c0, c12, 5)
+#define WCP14_DBGBCR13(val)		MCR14(val, 0, c0, c13, 5)
+#define WCP14_DBGBCR14(val)		MCR14(val, 0, c0, c14, 5)
+#define WCP14_DBGBCR15(val)		MCR14(val, 0, c0, c15, 5)
+#define WCP14_DBGWVR0(val)		MCR14(val, 0, c0, c0, 6)
+#define WCP14_DBGWVR1(val)		MCR14(val, 0, c0, c1, 6)
+#define WCP14_DBGWVR2(val)		MCR14(val, 0, c0, c2, 6)
+#define WCP14_DBGWVR3(val)		MCR14(val, 0, c0, c3, 6)
+#define WCP14_DBGWVR4(val)		MCR14(val, 0, c0, c4, 6)
+#define WCP14_DBGWVR5(val)		MCR14(val, 0, c0, c5, 6)
+#define WCP14_DBGWVR6(val)		MCR14(val, 0, c0, c6, 6)
+#define WCP14_DBGWVR7(val)		MCR14(val, 0, c0, c7, 6)
+#define WCP14_DBGWVR8(val)		MCR14(val, 0, c0, c8, 6)
+#define WCP14_DBGWVR9(val)		MCR14(val, 0, c0, c9, 6)
+#define WCP14_DBGWVR10(val)		MCR14(val, 0, c0, c10, 6)
+#define WCP14_DBGWVR11(val)		MCR14(val, 0, c0, c11, 6)
+#define WCP14_DBGWVR12(val)		MCR14(val, 0, c0, c12, 6)
+#define WCP14_DBGWVR13(val)		MCR14(val, 0, c0, c13, 6)
+#define WCP14_DBGWVR14(val)		MCR14(val, 0, c0, c14, 6)
+#define WCP14_DBGWVR15(val)		MCR14(val, 0, c0, c15, 6)
+#define WCP14_DBGWCR0(val)		MCR14(val, 0, c0, c0, 7)
+#define WCP14_DBGWCR1(val)		MCR14(val, 0, c0, c1, 7)
+#define WCP14_DBGWCR2(val)		MCR14(val, 0, c0, c2, 7)
+#define WCP14_DBGWCR3(val)		MCR14(val, 0, c0, c3, 7)
+#define WCP14_DBGWCR4(val)		MCR14(val, 0, c0, c4, 7)
+#define WCP14_DBGWCR5(val)		MCR14(val, 0, c0, c5, 7)
+#define WCP14_DBGWCR6(val)		MCR14(val, 0, c0, c6, 7)
+#define WCP14_DBGWCR7(val)		MCR14(val, 0, c0, c7, 7)
+#define WCP14_DBGWCR8(val)		MCR14(val, 0, c0, c8, 7)
+#define WCP14_DBGWCR9(val)		MCR14(val, 0, c0, c9, 7)
+#define WCP14_DBGWCR10(val)		MCR14(val, 0, c0, c10, 7)
+#define WCP14_DBGWCR11(val)		MCR14(val, 0, c0, c11, 7)
+#define WCP14_DBGWCR12(val)		MCR14(val, 0, c0, c12, 7)
+#define WCP14_DBGWCR13(val)		MCR14(val, 0, c0, c13, 7)
+#define WCP14_DBGWCR14(val)		MCR14(val, 0, c0, c14, 7)
+#define WCP14_DBGWCR15(val)		MCR14(val, 0, c0, c15, 7)
+#define WCP14_DBGBXVR0(val)		MCR14(val, 0, c1, c0, 1)
+#define WCP14_DBGBXVR1(val)		MCR14(val, 0, c1, c1, 1)
+#define WCP14_DBGBXVR2(val)		MCR14(val, 0, c1, c2, 1)
+#define WCP14_DBGBXVR3(val)		MCR14(val, 0, c1, c3, 1)
+#define WCP14_DBGBXVR4(val)		MCR14(val, 0, c1, c4, 1)
+#define WCP14_DBGBXVR5(val)		MCR14(val, 0, c1, c5, 1)
+#define WCP14_DBGBXVR6(val)		MCR14(val, 0, c1, c6, 1)
+#define WCP14_DBGBXVR7(val)		MCR14(val, 0, c1, c7, 1)
+#define WCP14_DBGBXVR8(val)		MCR14(val, 0, c1, c8, 1)
+#define WCP14_DBGBXVR9(val)		MCR14(val, 0, c1, c9, 1)
+#define WCP14_DBGBXVR10(val)		MCR14(val, 0, c1, c10, 1)
+#define WCP14_DBGBXVR11(val)		MCR14(val, 0, c1, c11, 1)
+#define WCP14_DBGBXVR12(val)		MCR14(val, 0, c1, c12, 1)
+#define WCP14_DBGBXVR13(val)		MCR14(val, 0, c1, c13, 1)
+#define WCP14_DBGBXVR14(val)		MCR14(val, 0, c1, c14, 1)
+#define WCP14_DBGBXVR15(val)		MCR14(val, 0, c1, c15, 1)
+#define WCP14_DBGOSLAR(val)		MCR14(val, 0, c1, c0, 4)
+#define WCP14_DBGOSSRR(val)		MCR14(val, 0, c1, c2, 4)
+#define WCP14_DBGOSDLR(val)		MCR14(val, 0, c1, c3, 4)
+#define WCP14_DBGPRCR(val)		MCR14(val, 0, c1, c4, 4)
+#define WCP14_DBGITCTRL(val)		MCR14(val, 0, c7, c0, 4)
+#define WCP14_DBGCLAIMSET(val)		MCR14(val, 0, c7, c8, 6)
+#define WCP14_DBGCLAIMCLR(val)		MCR14(val, 0, c7, c9, 6)
+
+/* ETM Registers
+ *
+ * Available only in ETMv3.3, 3.4, 3.5
+ * ETMASICCR, ETMTECR2, ETMFFRR, ETMVDEVR, ETMVDCR1, ETMVDCR2, ETMVDCR3,
+ * ETMDCVRn, ETMDCMRn
+ *
+ * Available only in ETMv3.5 as read only
+ * ETMIDR2
+ *
+ * Available only in ETMv3.5, PFTv1.0, 1.1
+ * ETMTSEVR, ETMVMIDCVR, ETMPDCR
+ *
+ * Read only
+ * ETMCCR, ETMSCR, ETMIDR, ETMCCER, ETMOSLSR
+ * ETMLSR, ETMAUTHSTATUS, ETMDEVID, ETMDEVTYPE, ETMPIDR4, ETMPIDR5, ETMPIDR6,
+ * ETMPIDR7, ETMPIDR0, ETMPIDR1, ETMPIDR2, ETMPIDR2, ETMPIDR3, ETMCIDR0,
+ * ETMCIDR1, ETMCIDR2, ETMCIDR3
+ *
+ * Write only
+ * ETMOSLAR, ETMLAR
+ * Note: ETMCCER[11] controls WO nature of certain regs. Refer ETM arch spec.
+ */
+#define RCP14_ETMCR()			MRC14(1, c0, c0, 0)
+#define RCP14_ETMCCR()			MRC14(1, c0, c1, 0)
+#define RCP14_ETMTRIGGER()		MRC14(1, c0, c2, 0)
+#define RCP14_ETMASICCR()		MRC14(1, c0, c3, 0)
+#define RCP14_ETMSR()			MRC14(1, c0, c4, 0)
+#define RCP14_ETMSCR()			MRC14(1, c0, c5, 0)
+#define RCP14_ETMTSSCR()		MRC14(1, c0, c6, 0)
+#define RCP14_ETMTECR2()		MRC14(1, c0, c7, 0)
+#define RCP14_ETMTEEVR()		MRC14(1, c0, c8, 0)
+#define RCP14_ETMTECR1()		MRC14(1, c0, c9, 0)
+#define RCP14_ETMFFRR()			MRC14(1, c0, c10, 0)
+#define RCP14_ETMFFLR()			MRC14(1, c0, c11, 0)
+#define RCP14_ETMVDEVR()		MRC14(1, c0, c12, 0)
+#define RCP14_ETMVDCR1()		MRC14(1, c0, c13, 0)
+#define RCP14_ETMVDCR2()		MRC14(1, c0, c14, 0)
+#define RCP14_ETMVDCR3()		MRC14(1, c0, c15, 0)
+#define RCP14_ETMACVR0()		MRC14(1, c0, c0, 1)
+#define RCP14_ETMACVR1()		MRC14(1, c0, c1, 1)
+#define RCP14_ETMACVR2()		MRC14(1, c0, c2, 1)
+#define RCP14_ETMACVR3()		MRC14(1, c0, c3, 1)
+#define RCP14_ETMACVR4()		MRC14(1, c0, c4, 1)
+#define RCP14_ETMACVR5()		MRC14(1, c0, c5, 1)
+#define RCP14_ETMACVR6()		MRC14(1, c0, c6, 1)
+#define RCP14_ETMACVR7()		MRC14(1, c0, c7, 1)
+#define RCP14_ETMACVR8()		MRC14(1, c0, c8, 1)
+#define RCP14_ETMACVR9()		MRC14(1, c0, c9, 1)
+#define RCP14_ETMACVR10()		MRC14(1, c0, c10, 1)
+#define RCP14_ETMACVR11()		MRC14(1, c0, c11, 1)
+#define RCP14_ETMACVR12()		MRC14(1, c0, c12, 1)
+#define RCP14_ETMACVR13()		MRC14(1, c0, c13, 1)
+#define RCP14_ETMACVR14()		MRC14(1, c0, c14, 1)
+#define RCP14_ETMACVR15()		MRC14(1, c0, c15, 1)
+#define RCP14_ETMACTR0()		MRC14(1, c0, c0, 2)
+#define RCP14_ETMACTR1()		MRC14(1, c0, c1, 2)
+#define RCP14_ETMACTR2()		MRC14(1, c0, c2, 2)
+#define RCP14_ETMACTR3()		MRC14(1, c0, c3, 2)
+#define RCP14_ETMACTR4()		MRC14(1, c0, c4, 2)
+#define RCP14_ETMACTR5()		MRC14(1, c0, c5, 2)
+#define RCP14_ETMACTR6()		MRC14(1, c0, c6, 2)
+#define RCP14_ETMACTR7()		MRC14(1, c0, c7, 2)
+#define RCP14_ETMACTR8()		MRC14(1, c0, c8, 2)
+#define RCP14_ETMACTR9()		MRC14(1, c0, c9, 2)
+#define RCP14_ETMACTR10()		MRC14(1, c0, c10, 2)
+#define RCP14_ETMACTR11()		MRC14(1, c0, c11, 2)
+#define RCP14_ETMACTR12()		MRC14(1, c0, c12, 2)
+#define RCP14_ETMACTR13()		MRC14(1, c0, c13, 2)
+#define RCP14_ETMACTR14()		MRC14(1, c0, c14, 2)
+#define RCP14_ETMACTR15()		MRC14(1, c0, c15, 2)
+#define RCP14_ETMDCVR0()		MRC14(1, c0, c0, 3)
+#define RCP14_ETMDCVR2()		MRC14(1, c0, c2, 3)
+#define RCP14_ETMDCVR4()		MRC14(1, c0, c4, 3)
+#define RCP14_ETMDCVR6()		MRC14(1, c0, c6, 3)
+#define RCP14_ETMDCVR8()		MRC14(1, c0, c8, 3)
+#define RCP14_ETMDCVR10()		MRC14(1, c0, c10, 3)
+#define RCP14_ETMDCVR12()		MRC14(1, c0, c12, 3)
+#define RCP14_ETMDCVR14()		MRC14(1, c0, c14, 3)
+#define RCP14_ETMDCMR0()		MRC14(1, c0, c0, 4)
+#define RCP14_ETMDCMR2()		MRC14(1, c0, c2, 4)
+#define RCP14_ETMDCMR4()		MRC14(1, c0, c4, 4)
+#define RCP14_ETMDCMR6()		MRC14(1, c0, c6, 4)
+#define RCP14_ETMDCMR8()		MRC14(1, c0, c8, 4)
+#define RCP14_ETMDCMR10()		MRC14(1, c0, c10, 4)
+#define RCP14_ETMDCMR12()		MRC14(1, c0, c12, 4)
+#define RCP14_ETMDCMR14()		MRC14(1, c0, c14, 4)
+#define RCP14_ETMCNTRLDVR0()		MRC14(1, c0, c0, 5)
+#define RCP14_ETMCNTRLDVR1()		MRC14(1, c0, c1, 5)
+#define RCP14_ETMCNTRLDVR2()		MRC14(1, c0, c2, 5)
+#define RCP14_ETMCNTRLDVR3()		MRC14(1, c0, c3, 5)
+#define RCP14_ETMCNTENR0()		MRC14(1, c0, c4, 5)
+#define RCP14_ETMCNTENR1()		MRC14(1, c0, c5, 5)
+#define RCP14_ETMCNTENR2()		MRC14(1, c0, c6, 5)
+#define RCP14_ETMCNTENR3()		MRC14(1, c0, c7, 5)
+#define RCP14_ETMCNTRLDEVR0()		MRC14(1, c0, c8, 5)
+#define RCP14_ETMCNTRLDEVR1()		MRC14(1, c0, c9, 5)
+#define RCP14_ETMCNTRLDEVR2()		MRC14(1, c0, c10, 5)
+#define RCP14_ETMCNTRLDEVR3()		MRC14(1, c0, c11, 5)
+#define RCP14_ETMCNTVR0()		MRC14(1, c0, c12, 5)
+#define RCP14_ETMCNTVR1()		MRC14(1, c0, c13, 5)
+#define RCP14_ETMCNTVR2()		MRC14(1, c0, c14, 5)
+#define RCP14_ETMCNTVR3()		MRC14(1, c0, c15, 5)
+#define RCP14_ETMSQ12EVR()		MRC14(1, c0, c0, 6)
+#define RCP14_ETMSQ21EVR()		MRC14(1, c0, c1, 6)
+#define RCP14_ETMSQ23EVR()		MRC14(1, c0, c2, 6)
+#define RCP14_ETMSQ31EVR()		MRC14(1, c0, c3, 6)
+#define RCP14_ETMSQ32EVR()		MRC14(1, c0, c4, 6)
+#define RCP14_ETMSQ13EVR()		MRC14(1, c0, c5, 6)
+#define RCP14_ETMSQR()			MRC14(1, c0, c7, 6)
+#define RCP14_ETMEXTOUTEVR0()		MRC14(1, c0, c8, 6)
+#define RCP14_ETMEXTOUTEVR1()		MRC14(1, c0, c9, 6)
+#define RCP14_ETMEXTOUTEVR2()		MRC14(1, c0, c10, 6)
+#define RCP14_ETMEXTOUTEVR3()		MRC14(1, c0, c11, 6)
+#define RCP14_ETMCIDCVR0()		MRC14(1, c0, c12, 6)
+#define RCP14_ETMCIDCVR1()		MRC14(1, c0, c13, 6)
+#define RCP14_ETMCIDCVR2()		MRC14(1, c0, c14, 6)
+#define RCP14_ETMCIDCMR()		MRC14(1, c0, c15, 6)
+#define RCP14_ETMIMPSPEC0()		MRC14(1, c0, c0, 7)
+#define RCP14_ETMIMPSPEC1()		MRC14(1, c0, c1, 7)
+#define RCP14_ETMIMPSPEC2()		MRC14(1, c0, c2, 7)
+#define RCP14_ETMIMPSPEC3()		MRC14(1, c0, c3, 7)
+#define RCP14_ETMIMPSPEC4()		MRC14(1, c0, c4, 7)
+#define RCP14_ETMIMPSPEC5()		MRC14(1, c0, c5, 7)
+#define RCP14_ETMIMPSPEC6()		MRC14(1, c0, c6, 7)
+#define RCP14_ETMIMPSPEC7()		MRC14(1, c0, c7, 7)
+#define RCP14_ETMSYNCFR()		MRC14(1, c0, c8, 7)
+#define RCP14_ETMIDR()			MRC14(1, c0, c9, 7)
+#define RCP14_ETMCCER()			MRC14(1, c0, c10, 7)
+#define RCP14_ETMEXTINSELR()		MRC14(1, c0, c11, 7)
+#define RCP14_ETMTESSEICR()		MRC14(1, c0, c12, 7)
+#define RCP14_ETMEIBCR()		MRC14(1, c0, c13, 7)
+#define RCP14_ETMTSEVR()		MRC14(1, c0, c14, 7)
+#define RCP14_ETMAUXCR()		MRC14(1, c0, c15, 7)
+#define RCP14_ETMTRACEIDR()		MRC14(1, c1, c0, 0)
+#define RCP14_ETMIDR2()			MRC14(1, c1, c2, 0)
+#define RCP14_ETMVMIDCVR()		MRC14(1, c1, c0, 1)
+#define RCP14_ETMOSLSR()		MRC14(1, c1, c1, 4)
+/* not available in PFTv1.1 */
+#define RCP14_ETMOSSRR()		MRC14(1, c1, c2, 4)
+#define RCP14_ETMPDCR()			MRC14(1, c1, c4, 4)
+#define RCP14_ETMPDSR()			MRC14(1, c1, c5, 4)
+#define RCP14_ETMITCTRL()		MRC14(1, c7, c0, 4)
+#define RCP14_ETMCLAIMSET()		MRC14(1, c7, c8, 6)
+#define RCP14_ETMCLAIMCLR()		MRC14(1, c7, c9, 6)
+#define RCP14_ETMLSR()			MRC14(1, c7, c13, 6)
+#define RCP14_ETMAUTHSTATUS()		MRC14(1, c7, c14, 6)
+#define RCP14_ETMDEVID()		MRC14(1, c7, c2, 7)
+#define RCP14_ETMDEVTYPE()		MRC14(1, c7, c3, 7)
+#define RCP14_ETMPIDR4()		MRC14(1, c7, c4, 7)
+#define RCP14_ETMPIDR5()		MRC14(1, c7, c5, 7)
+#define RCP14_ETMPIDR6()		MRC14(1, c7, c6, 7)
+#define RCP14_ETMPIDR7()		MRC14(1, c7, c7, 7)
+#define RCP14_ETMPIDR0()		MRC14(1, c7, c8, 7)
+#define RCP14_ETMPIDR1()		MRC14(1, c7, c9, 7)
+#define RCP14_ETMPIDR2()		MRC14(1, c7, c10, 7)
+#define RCP14_ETMPIDR3()		MRC14(1, c7, c11, 7)
+#define RCP14_ETMCIDR0()		MRC14(1, c7, c12, 7)
+#define RCP14_ETMCIDR1()		MRC14(1, c7, c13, 7)
+#define RCP14_ETMCIDR2()		MRC14(1, c7, c14, 7)
+#define RCP14_ETMCIDR3()		MRC14(1, c7, c15, 7)
+
+#define WCP14_ETMCR(val)		MCR14(val, 1, c0, c0, 0)
+#define WCP14_ETMTRIGGER(val)		MCR14(val, 1, c0, c2, 0)
+#define WCP14_ETMASICCR(val)		MCR14(val, 1, c0, c3, 0)
+#define WCP14_ETMSR(val)		MCR14(val, 1, c0, c4, 0)
+#define WCP14_ETMTSSCR(val)		MCR14(val, 1, c0, c6, 0)
+#define WCP14_ETMTECR2(val)		MCR14(val, 1, c0, c7, 0)
+#define WCP14_ETMTEEVR(val)		MCR14(val, 1, c0, c8, 0)
+#define WCP14_ETMTECR1(val)		MCR14(val, 1, c0, c9, 0)
+#define WCP14_ETMFFRR(val)		MCR14(val, 1, c0, c10, 0)
+#define WCP14_ETMFFLR(val)		MCR14(val, 1, c0, c11, 0)
+#define WCP14_ETMVDEVR(val)		MCR14(val, 1, c0, c12, 0)
+#define WCP14_ETMVDCR1(val)		MCR14(val, 1, c0, c13, 0)
+#define WCP14_ETMVDCR2(val)		MCR14(val, 1, c0, c14, 0)
+#define WCP14_ETMVDCR3(val)		MCR14(val, 1, c0, c15, 0)
+#define WCP14_ETMACVR0(val)		MCR14(val, 1, c0, c0, 1)
+#define WCP14_ETMACVR1(val)		MCR14(val, 1, c0, c1, 1)
+#define WCP14_ETMACVR2(val)		MCR14(val, 1, c0, c2, 1)
+#define WCP14_ETMACVR3(val)		MCR14(val, 1, c0, c3, 1)
+#define WCP14_ETMACVR4(val)		MCR14(val, 1, c0, c4, 1)
+#define WCP14_ETMACVR5(val)		MCR14(val, 1, c0, c5, 1)
+#define WCP14_ETMACVR6(val)		MCR14(val, 1, c0, c6, 1)
+#define WCP14_ETMACVR7(val)		MCR14(val, 1, c0, c7, 1)
+#define WCP14_ETMACVR8(val)		MCR14(val, 1, c0, c8, 1)
+#define WCP14_ETMACVR9(val)		MCR14(val, 1, c0, c9, 1)
+#define WCP14_ETMACVR10(val)		MCR14(val, 1, c0, c10, 1)
+#define WCP14_ETMACVR11(val)		MCR14(val, 1, c0, c11, 1)
+#define WCP14_ETMACVR12(val)		MCR14(val, 1, c0, c12, 1)
+#define WCP14_ETMACVR13(val)		MCR14(val, 1, c0, c13, 1)
+#define WCP14_ETMACVR14(val)		MCR14(val, 1, c0, c14, 1)
+#define WCP14_ETMACVR15(val)		MCR14(val, 1, c0, c15, 1)
+#define WCP14_ETMACTR0(val)		MCR14(val, 1, c0, c0, 2)
+#define WCP14_ETMACTR1(val)		MCR14(val, 1, c0, c1, 2)
+#define WCP14_ETMACTR2(val)		MCR14(val, 1, c0, c2, 2)
+#define WCP14_ETMACTR3(val)		MCR14(val, 1, c0, c3, 2)
+#define WCP14_ETMACTR4(val)		MCR14(val, 1, c0, c4, 2)
+#define WCP14_ETMACTR5(val)		MCR14(val, 1, c0, c5, 2)
+#define WCP14_ETMACTR6(val)		MCR14(val, 1, c0, c6, 2)
+#define WCP14_ETMACTR7(val)		MCR14(val, 1, c0, c7, 2)
+#define WCP14_ETMACTR8(val)		MCR14(val, 1, c0, c8, 2)
+#define WCP14_ETMACTR9(val)		MCR14(val, 1, c0, c9, 2)
+#define WCP14_ETMACTR10(val)		MCR14(val, 1, c0, c10, 2)
+#define WCP14_ETMACTR11(val)		MCR14(val, 1, c0, c11, 2)
+#define WCP14_ETMACTR12(val)		MCR14(val, 1, c0, c12, 2)
+#define WCP14_ETMACTR13(val)		MCR14(val, 1, c0, c13, 2)
+#define WCP14_ETMACTR14(val)		MCR14(val, 1, c0, c14, 2)
+#define WCP14_ETMACTR15(val)		MCR14(val, 1, c0, c15, 2)
+#define WCP14_ETMDCVR0(val)		MCR14(val, 1, c0, c0, 3)
+#define WCP14_ETMDCVR2(val)		MCR14(val, 1, c0, c2, 3)
+#define WCP14_ETMDCVR4(val)		MCR14(val, 1, c0, c4, 3)
+#define WCP14_ETMDCVR6(val)		MCR14(val, 1, c0, c6, 3)
+#define WCP14_ETMDCVR8(val)		MCR14(val, 1, c0, c8, 3)
+#define WCP14_ETMDCVR10(val)		MCR14(val, 1, c0, c10, 3)
+#define WCP14_ETMDCVR12(val)		MCR14(val, 1, c0, c12, 3)
+#define WCP14_ETMDCVR14(val)		MCR14(val, 1, c0, c14, 3)
+#define WCP14_ETMDCMR0(val)		MCR14(val, 1, c0, c0, 4)
+#define WCP14_ETMDCMR2(val)		MCR14(val, 1, c0, c2, 4)
+#define WCP14_ETMDCMR4(val)		MCR14(val, 1, c0, c4, 4)
+#define WCP14_ETMDCMR6(val)		MCR14(val, 1, c0, c6, 4)
+#define WCP14_ETMDCMR8(val)		MCR14(val, 1, c0, c8, 4)
+#define WCP14_ETMDCMR10(val)		MCR14(val, 1, c0, c10, 4)
+#define WCP14_ETMDCMR12(val)		MCR14(val, 1, c0, c12, 4)
+#define WCP14_ETMDCMR14(val)		MCR14(val, 1, c0, c14, 4)
+#define WCP14_ETMCNTRLDVR0(val)		MCR14(val, 1, c0, c0, 5)
+#define WCP14_ETMCNTRLDVR1(val)		MCR14(val, 1, c0, c1, 5)
+#define WCP14_ETMCNTRLDVR2(val)		MCR14(val, 1, c0, c2, 5)
+#define WCP14_ETMCNTRLDVR3(val)		MCR14(val, 1, c0, c3, 5)
+#define WCP14_ETMCNTENR0(val)		MCR14(val, 1, c0, c4, 5)
+#define WCP14_ETMCNTENR1(val)		MCR14(val, 1, c0, c5, 5)
+#define WCP14_ETMCNTENR2(val)		MCR14(val, 1, c0, c6, 5)
+#define WCP14_ETMCNTENR3(val)		MCR14(val, 1, c0, c7, 5)
+#define WCP14_ETMCNTRLDEVR0(val)	MCR14(val, 1, c0, c8, 5)
+#define WCP14_ETMCNTRLDEVR1(val)	MCR14(val, 1, c0, c9, 5)
+#define WCP14_ETMCNTRLDEVR2(val)	MCR14(val, 1, c0, c10, 5)
+#define WCP14_ETMCNTRLDEVR3(val)	MCR14(val, 1, c0, c11, 5)
+#define WCP14_ETMCNTVR0(val)		MCR14(val, 1, c0, c12, 5)
+#define WCP14_ETMCNTVR1(val)		MCR14(val, 1, c0, c13, 5)
+#define WCP14_ETMCNTVR2(val)		MCR14(val, 1, c0, c14, 5)
+#define WCP14_ETMCNTVR3(val)		MCR14(val, 1, c0, c15, 5)
+#define WCP14_ETMSQ12EVR(val)		MCR14(val, 1, c0, c0, 6)
+#define WCP14_ETMSQ21EVR(val)		MCR14(val, 1, c0, c1, 6)
+#define WCP14_ETMSQ23EVR(val)		MCR14(val, 1, c0, c2, 6)
+#define WCP14_ETMSQ31EVR(val)		MCR14(val, 1, c0, c3, 6)
+#define WCP14_ETMSQ32EVR(val)		MCR14(val, 1, c0, c4, 6)
+#define WCP14_ETMSQ13EVR(val)		MCR14(val, 1, c0, c5, 6)
+#define WCP14_ETMSQR(val)		MCR14(val, 1, c0, c7, 6)
+#define WCP14_ETMEXTOUTEVR0(val)	MCR14(val, 1, c0, c8, 6)
+#define WCP14_ETMEXTOUTEVR1(val)	MCR14(val, 1, c0, c9, 6)
+#define WCP14_ETMEXTOUTEVR2(val)	MCR14(val, 1, c0, c10, 6)
+#define WCP14_ETMEXTOUTEVR3(val)	MCR14(val, 1, c0, c11, 6)
+#define WCP14_ETMCIDCVR0(val)		MCR14(val, 1, c0, c12, 6)
+#define WCP14_ETMCIDCVR1(val)		MCR14(val, 1, c0, c13, 6)
+#define WCP14_ETMCIDCVR2(val)		MCR14(val, 1, c0, c14, 6)
+#define WCP14_ETMCIDCMR(val)		MCR14(val, 1, c0, c15, 6)
+#define WCP14_ETMIMPSPEC0(val)		MCR14(val, 1, c0, c0, 7)
+#define WCP14_ETMIMPSPEC1(val)		MCR14(val, 1, c0, c1, 7)
+#define WCP14_ETMIMPSPEC2(val)		MCR14(val, 1, c0, c2, 7)
+#define WCP14_ETMIMPSPEC3(val)		MCR14(val, 1, c0, c3, 7)
+#define WCP14_ETMIMPSPEC4(val)		MCR14(val, 1, c0, c4, 7)
+#define WCP14_ETMIMPSPEC5(val)		MCR14(val, 1, c0, c5, 7)
+#define WCP14_ETMIMPSPEC6(val)		MCR14(val, 1, c0, c6, 7)
+#define WCP14_ETMIMPSPEC7(val)		MCR14(val, 1, c0, c7, 7)
+/* can be read only in ETMv3.4, ETMv3.5 */
+#define WCP14_ETMSYNCFR(val)		MCR14(val, 1, c0, c8, 7)
+#define WCP14_ETMEXTINSELR(val)		MCR14(val, 1, c0, c11, 7)
+#define WCP14_ETMTESSEICR(val)		MCR14(val, 1, c0, c12, 7)
+#define WCP14_ETMEIBCR(val)		MCR14(val, 1, c0, c13, 7)
+#define WCP14_ETMTSEVR(val)		MCR14(val, 1, c0, c14, 7)
+#define WCP14_ETMAUXCR(val)		MCR14(val, 1, c0, c15, 7)
+#define WCP14_ETMTRACEIDR(val)		MCR14(val, 1, c1, c0, 0)
+#define WCP14_ETMIDR2(val)		MCR14(val, 1, c1, c2, 0)
+#define WCP14_ETMVMIDCVR(val)		MCR14(val, 1, c1, c0, 1)
+#define WCP14_ETMOSLAR(val)		MCR14(val, 1, c1, c0, 4)
+/* not available in PFTv1.1 */
+#define WCP14_ETMOSSRR(val)		MCR14(val, 1, c1, c2, 4)
+#define WCP14_ETMPDCR(val)		MCR14(val, 1, c1, c4, 4)
+#define WCP14_ETMPDSR(val)		MCR14(val, 1, c1, c5, 4)
+#define WCP14_ETMITCTRL(val)		MCR14(val, 1, c7, c0, 4)
+#define WCP14_ETMCLAIMSET(val)		MCR14(val, 1, c7, c8, 6)
+#define WCP14_ETMCLAIMCLR(val)		MCR14(val, 1, c7, c9, 6)
+/* writes to this from CP14 interface are ignored */
+#define WCP14_ETMLAR(val)		MCR14(val, 1, c7, c12, 6)
+
+#endif
diff --git a/drivers/coresight/Kconfig b/drivers/coresight/Kconfig
index 5a715e8..196f16b 100644
--- a/drivers/coresight/Kconfig
+++ b/drivers/coresight/Kconfig
@@ -36,4 +36,25 @@ config CORESIGHT_SOURCE_STM_DEFAULT_ENABLE
 	  If unsure, say 'N' here to avoid potential power, performance and
 	  memory penalty.
 
+config CORESIGHT_SOURCE_ETM
+	bool "CoreSight Embedded Trace Macrocell driver"
+	depends on !OC_ETM
+	select CORESIGHT_LINKS_AND_SINKS
+	help
+	  This driver provides support for processor tracing which allows
+	  tracing the instructions that the processor is executing. This is
+	  primarily useful for instruction level tracing.
+
+
+config CORESIGHT_SOURCE_ETM_DEFAULT_ENABLE
+	bool "Turn on CoreSight ETM tracing by default"
+	depends on CORESIGHT_SOURCE_ETM
+	help
+	  Turns on CoreSight ETM tracing (processor tracing) by default.
+	  Otherwise, tracing is disabled by default but can be enabled via
+	  sysfs.
+
+	  If unsure, say 'N' here to avoid potential power, performance and
+	  memory penalty.
+
 endif
diff --git a/drivers/coresight/Makefile b/drivers/coresight/Makefile
index 750aa7c..ccbbd59 100644
--- a/drivers/coresight/Makefile
+++ b/drivers/coresight/Makefile
@@ -5,3 +5,4 @@ obj-$(CONFIG_CORESIGHT) += coresight.o
 obj-$(CONFIG_OF) += of_coresight.o
 obj-$(CONFIG_CORESIGHT_LINKS_AND_SINKS) += coresight-tmc.o coresight-tpiu.o coresight-etb.o coresight-funnel.o coresight-replicator.o
 obj-$(CONFIG_CORESIGHT_SOURCE_STM) += coresight-stm.o
+obj-$(CONFIG_CORESIGHT_SOURCE_ETM) += coresight-etm.o coresight-etm-cp14.o
diff --git a/drivers/coresight/coresight-etm-cp14.c b/drivers/coresight/coresight-etm-cp14.c
new file mode 100644
index 0000000..9a6c13a
--- /dev/null
+++ b/drivers/coresight/coresight-etm-cp14.c
@@ -0,0 +1,510 @@
+/* Copyright (c) 2012, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <asm/hardware/cp14.h>
+
+static unsigned int etm_read_reg(uint32_t reg)
+{
+	switch (reg) {
+	case 0x0:
+		return etm_read(ETMCR);
+	case 0x1:
+		return etm_read(ETMCCR);
+	case 0x2:
+		return etm_read(ETMTRIGGER);
+	case 0x4:
+		return etm_read(ETMSR);
+	case 0x5:
+		return etm_read(ETMSCR);
+	case 0x6:
+		return etm_read(ETMTSSCR);
+	case 0x8:
+		return etm_read(ETMTEEVR);
+	case 0x9:
+		return etm_read(ETMTECR1);
+	case 0xB:
+		return etm_read(ETMFFLR);
+	case 0x10:
+		return etm_read(ETMACVR0);
+	case 0x11:
+		return etm_read(ETMACVR1);
+	case 0x12:
+		return etm_read(ETMACVR2);
+	case 0x13:
+		return etm_read(ETMACVR3);
+	case 0x14:
+		return etm_read(ETMACVR4);
+	case 0x15:
+		return etm_read(ETMACVR5);
+	case 0x16:
+		return etm_read(ETMACVR6);
+	case 0x17:
+		return etm_read(ETMACVR7);
+	case 0x18:
+		return etm_read(ETMACVR8);
+	case 0x19:
+		return etm_read(ETMACVR9);
+	case 0x1A:
+		return etm_read(ETMACVR10);
+	case 0x1B:
+		return etm_read(ETMACVR11);
+	case 0x1C:
+		return etm_read(ETMACVR12);
+	case 0x1D:
+		return etm_read(ETMACVR13);
+	case 0x1E:
+		return etm_read(ETMACVR14);
+	case 0x1F:
+		return etm_read(ETMACVR15);
+	case 0x20:
+		return etm_read(ETMACTR0);
+	case 0x21:
+		return etm_read(ETMACTR1);
+	case 0x22:
+		return etm_read(ETMACTR2);
+	case 0x23:
+		return etm_read(ETMACTR3);
+	case 0x24:
+		return etm_read(ETMACTR4);
+	case 0x25:
+		return etm_read(ETMACTR5);
+	case 0x26:
+		return etm_read(ETMACTR6);
+	case 0x27:
+		return etm_read(ETMACTR7);
+	case 0x28:
+		return etm_read(ETMACTR8);
+	case 0x29:
+		return etm_read(ETMACTR9);
+	case 0x2A:
+		return etm_read(ETMACTR10);
+	case 0x2B:
+		return etm_read(ETMACTR11);
+	case 0x2C:
+		return etm_read(ETMACTR12);
+	case 0x2D:
+		return etm_read(ETMACTR13);
+	case 0x2E:
+		return etm_read(ETMACTR14);
+	case 0x2F:
+		return etm_read(ETMACTR15);
+	case 0x50:
+		return etm_read(ETMCNTRLDVR0);
+	case 0x51:
+		return etm_read(ETMCNTRLDVR1);
+	case 0x52:
+		return etm_read(ETMCNTRLDVR2);
+	case 0x53:
+		return etm_read(ETMCNTRLDVR3);
+	case 0x54:
+		return etm_read(ETMCNTENR0);
+	case 0x55:
+		return etm_read(ETMCNTENR1);
+	case 0x56:
+		return etm_read(ETMCNTENR2);
+	case 0x57:
+		return etm_read(ETMCNTENR3);
+	case 0x58:
+		return etm_read(ETMCNTRLDEVR0);
+	case 0x59:
+		return etm_read(ETMCNTRLDEVR1);
+	case 0x5A:
+		return etm_read(ETMCNTRLDEVR2);
+	case 0x5B:
+		return etm_read(ETMCNTRLDEVR3);
+	case 0x5C:
+		return etm_read(ETMCNTVR0);
+	case 0x5D:
+		return etm_read(ETMCNTVR1);
+	case 0x5E:
+		return etm_read(ETMCNTVR2);
+	case 0x5F:
+		return etm_read(ETMCNTVR3);
+	case 0x60:
+		return etm_read(ETMSQ12EVR);
+	case 0x61:
+		return etm_read(ETMSQ21EVR);
+	case 0x62:
+		return etm_read(ETMSQ23EVR);
+	case 0x63:
+		return etm_read(ETMSQ31EVR);
+	case 0x64:
+		return etm_read(ETMSQ32EVR);
+	case 0x65:
+		return etm_read(ETMSQ13EVR);
+	case 0x67:
+		return etm_read(ETMSQR);
+	case 0x68:
+		return etm_read(ETMEXTOUTEVR0);
+	case 0x69:
+		return etm_read(ETMEXTOUTEVR1);
+	case 0x6A:
+		return etm_read(ETMEXTOUTEVR2);
+	case 0x6B:
+		return etm_read(ETMEXTOUTEVR3);
+	case 0x6C:
+		return etm_read(ETMCIDCVR0);
+	case 0x6D:
+		return etm_read(ETMCIDCVR1);
+	case 0x6E:
+		return etm_read(ETMCIDCVR2);
+	case 0x6F:
+		return etm_read(ETMCIDCMR);
+	case 0x70:
+		return etm_read(ETMIMPSPEC0);
+	case 0x71:
+		return etm_read(ETMIMPSPEC1);
+	case 0x72:
+		return etm_read(ETMIMPSPEC2);
+	case 0x73:
+		return etm_read(ETMIMPSPEC3);
+	case 0x74:
+		return etm_read(ETMIMPSPEC4);
+	case 0x75:
+		return etm_read(ETMIMPSPEC5);
+	case 0x76:
+		return etm_read(ETMIMPSPEC6);
+	case 0x77:
+		return etm_read(ETMIMPSPEC7);
+	case 0x78:
+		return etm_read(ETMSYNCFR);
+	case 0x79:
+		return etm_read(ETMIDR);
+	case 0x7A:
+		return etm_read(ETMCCER);
+	case 0x7B:
+		return etm_read(ETMEXTINSELR);
+	case 0x7C:
+		return etm_read(ETMTESSEICR);
+	case 0x7D:
+		return etm_read(ETMEIBCR);
+	case 0x7E:
+		return etm_read(ETMTSEVR);
+	case 0x7F:
+		return etm_read(ETMAUXCR);
+	case 0x80:
+		return etm_read(ETMTRACEIDR);
+	case 0x90:
+		return etm_read(ETMVMIDCVR);
+	case 0xC1:
+		return etm_read(ETMOSLSR);
+	case 0xC2:
+		return etm_read(ETMOSSRR);
+	case 0xC4:
+		return etm_read(ETMPDCR);
+	case 0xC5:
+		return etm_read(ETMPDSR);
+	default:
+		WARN(1, "invalid CP14 access to ETM reg: %lx",
+							(unsigned long)reg);
+		return 0;
+	}
+}
+
+static void etm_write_reg(uint32_t val, uint32_t reg)
+{
+	switch (reg) {
+	case 0x0:
+		etm_write(val, ETMCR);
+		return;
+	case 0x2:
+		etm_write(val, ETMTRIGGER);
+		return;
+	case 0x4:
+		etm_write(val, ETMSR);
+		return;
+	case 0x6:
+		etm_write(val, ETMTSSCR);
+		return;
+	case 0x8:
+		etm_write(val, ETMTEEVR);
+		return;
+	case 0x9:
+		etm_write(val, ETMTECR1);
+		return;
+	case 0xB:
+		etm_write(val, ETMFFLR);
+		return;
+	case 0x10:
+		etm_write(val, ETMACVR0);
+		return;
+	case 0x11:
+		etm_write(val, ETMACVR1);
+		return;
+	case 0x12:
+		etm_write(val, ETMACVR2);
+		return;
+	case 0x13:
+		etm_write(val, ETMACVR3);
+		return;
+	case 0x14:
+		etm_write(val, ETMACVR4);
+		return;
+	case 0x15:
+		etm_write(val, ETMACVR5);
+		return;
+	case 0x16:
+		etm_write(val, ETMACVR6);
+		return;
+	case 0x17:
+		etm_write(val, ETMACVR7);
+		return;
+	case 0x18:
+		etm_write(val, ETMACVR8);
+		return;
+	case 0x19:
+		etm_write(val, ETMACVR9);
+		return;
+	case 0x1A:
+		etm_write(val, ETMACVR10);
+		return;
+	case 0x1B:
+		etm_write(val, ETMACVR11);
+		return;
+	case 0x1C:
+		etm_write(val, ETMACVR12);
+		return;
+	case 0x1D:
+		etm_write(val, ETMACVR13);
+		return;
+	case 0x1E:
+		etm_write(val, ETMACVR14);
+		return;
+	case 0x1F:
+		etm_write(val, ETMACVR15);
+		return;
+	case 0x20:
+		etm_write(val, ETMACTR0);
+		return;
+	case 0x21:
+		etm_write(val, ETMACTR1);
+		return;
+	case 0x22:
+		etm_write(val, ETMACTR2);
+		return;
+	case 0x23:
+		etm_write(val, ETMACTR3);
+		return;
+	case 0x24:
+		etm_write(val, ETMACTR4);
+		return;
+	case 0x25:
+		etm_write(val, ETMACTR5);
+		return;
+	case 0x26:
+		etm_write(val, ETMACTR6);
+		return;
+	case 0x27:
+		etm_write(val, ETMACTR7);
+		return;
+	case 0x28:
+		etm_write(val, ETMACTR8);
+		return;
+	case 0x29:
+		etm_write(val, ETMACTR9);
+		return;
+	case 0x2A:
+		etm_write(val, ETMACTR10);
+		return;
+	case 0x2B:
+		etm_write(val, ETMACTR11);
+		return;
+	case 0x2C:
+		etm_write(val, ETMACTR12);
+		return;
+	case 0x2D:
+		etm_write(val, ETMACTR13);
+		return;
+	case 0x2E:
+		etm_write(val, ETMACTR14);
+		return;
+	case 0x2F:
+		etm_write(val, ETMACTR15);
+		return;
+	case 0x50:
+		etm_write(val, ETMCNTRLDVR0);
+		return;
+	case 0x51:
+		etm_write(val, ETMCNTRLDVR1);
+		return;
+	case 0x52:
+		etm_write(val, ETMCNTRLDVR2);
+		return;
+	case 0x53:
+		etm_write(val, ETMCNTRLDVR3);
+		return;
+	case 0x54:
+		etm_write(val, ETMCNTENR0);
+		return;
+	case 0x55:
+		etm_write(val, ETMCNTENR1);
+		return;
+	case 0x56:
+		etm_write(val, ETMCNTENR2);
+		return;
+	case 0x57:
+		etm_write(val, ETMCNTENR3);
+		return;
+	case 0x58:
+		etm_write(val, ETMCNTRLDEVR0);
+		return;
+	case 0x59:
+		etm_write(val, ETMCNTRLDEVR1);
+		return;
+	case 0x5A:
+		etm_write(val, ETMCNTRLDEVR2);
+		return;
+	case 0x5B:
+		etm_write(val, ETMCNTRLDEVR3);
+		return;
+	case 0x5C:
+		etm_write(val, ETMCNTVR0);
+		return;
+	case 0x5D:
+		etm_write(val, ETMCNTVR1);
+		return;
+	case 0x5E:
+		etm_write(val, ETMCNTVR2);
+		return;
+	case 0x5F:
+		etm_write(val, ETMCNTVR3);
+		return;
+	case 0x60:
+		etm_write(val, ETMSQ12EVR);
+		return;
+	case 0x61:
+		etm_write(val, ETMSQ21EVR);
+		return;
+	case 0x62:
+		etm_write(val, ETMSQ23EVR);
+		return;
+	case 0x63:
+		etm_write(val, ETMSQ31EVR);
+		return;
+	case 0x64:
+		etm_write(val, ETMSQ32EVR);
+		return;
+	case 0x65:
+		etm_write(val, ETMSQ13EVR);
+		return;
+	case 0x67:
+		etm_write(val, ETMSQR);
+		return;
+	case 0x68:
+		etm_write(val, ETMEXTOUTEVR0);
+		return;
+	case 0x69:
+		etm_write(val, ETMEXTOUTEVR1);
+		return;
+	case 0x6A:
+		etm_write(val, ETMEXTOUTEVR2);
+		return;
+	case 0x6B:
+		etm_write(val, ETMEXTOUTEVR3);
+		return;
+	case 0x6C:
+		etm_write(val, ETMCIDCVR0);
+		return;
+	case 0x6D:
+		etm_write(val, ETMCIDCVR1);
+		return;
+	case 0x6E:
+		etm_write(val, ETMCIDCVR2);
+		return;
+	case 0x6F:
+		etm_write(val, ETMCIDCMR);
+		return;
+	case 0x70:
+		etm_write(val, ETMIMPSPEC0);
+		return;
+	case 0x71:
+		etm_write(val, ETMIMPSPEC1);
+		return;
+	case 0x72:
+		etm_write(val, ETMIMPSPEC2);
+		return;
+	case 0x73:
+		etm_write(val, ETMIMPSPEC3);
+		return;
+	case 0x74:
+		etm_write(val, ETMIMPSPEC4);
+		return;
+	case 0x75:
+		etm_write(val, ETMIMPSPEC5);
+		return;
+	case 0x76:
+		etm_write(val, ETMIMPSPEC6);
+		return;
+	case 0x77:
+		etm_write(val, ETMIMPSPEC7);
+		return;
+	case 0x78:
+		etm_write(val, ETMSYNCFR);
+		return;
+	case 0x7B:
+		etm_write(val, ETMEXTINSELR);
+		return;
+	case 0x7C:
+		etm_write(val, ETMTESSEICR);
+		return;
+	case 0x7D:
+		etm_write(val, ETMEIBCR);
+		return;
+	case 0x7E:
+		etm_write(val, ETMTSEVR);
+		return;
+	case 0x7F:
+		etm_write(val, ETMAUXCR);
+		return;
+	case 0x80:
+		etm_write(val, ETMTRACEIDR);
+		return;
+	case 0x90:
+		etm_write(val, ETMVMIDCVR);
+		return;
+	case 0xC0:
+		etm_write(val, ETMOSLAR);
+		return;
+	case 0xC2:
+		etm_write(val, ETMOSSRR);
+		return;
+	case 0xC4:
+		etm_write(val, ETMPDCR);
+		return;
+	case 0xC5:
+		etm_write(val, ETMPDSR);
+		return;
+	default:
+		WARN(1, "invalid CP14 access to ETM reg: %lx",
+							(unsigned long)reg);
+		return;
+	}
+}
+
+static inline uint32_t offset_to_reg_num(uint32_t off)
+{
+	return off >> 2;
+}
+
+unsigned int etm_readl_cp14(uint32_t off)
+{
+	uint32_t reg = offset_to_reg_num(off);
+	return etm_read_reg(reg);
+}
+
+void etm_writel_cp14(uint32_t val, uint32_t off)
+{
+	uint32_t reg = offset_to_reg_num(off);
+	etm_write_reg(val, reg);
+}
diff --git a/drivers/coresight/coresight-etm.c b/drivers/coresight/coresight-etm.c
new file mode 100644
index 0000000..e15763f
--- /dev/null
+++ b/drivers/coresight/coresight-etm.c
@@ -0,0 +1,1752 @@
+/* Copyright (c) 2011-2012, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/err.h>
+#include <linux/fs.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/smp.h>
+#include <linux/sysfs.h>
+#include <linux/stat.h>
+#include <linux/spinlock.h>
+#include <linux/clk.h>
+#include <linux/cpu.h>
+#include <linux/of.h>
+#include <linux/of_coresight.h>
+#include <linux/coresight.h>
+#include <asm/sections.h>
+
+#include "coresight-priv.h"
+
+#define etm_writel_mm(drvdata, val, off)  \
+			__raw_writel((val), drvdata->base + off)
+#define etm_readl_mm(drvdata, off)        \
+			__raw_readl(drvdata->base + off)
+
+#define etm_writel(drvdata, val, off)					\
+({									\
+	if (drvdata->use_cp14)						\
+		etm_writel_cp14(val, off);				\
+	else								\
+		etm_writel_mm(drvdata, val, off);			\
+})
+#define etm_readl(drvdata, off)						\
+({									\
+	uint32_t val;							\
+	if (drvdata->use_cp14)						\
+		val = etm_readl_cp14(off);				\
+	else								\
+		val = etm_readl_mm(drvdata, off);			\
+	val;								\
+})
+
+#define ETM_LOCK(drvdata)						\
+do {									\
+	/*
+	 * Recommended by spec to ensure ETM writes are committed prior
+	 * to resuming execution
+	 */								\
+	mb();								\
+	isb();								\
+	etm_writel_mm(drvdata, 0x0, CORESIGHT_LAR);			\
+} while (0)
+#define ETM_UNLOCK(drvdata)						\
+do {									\
+	etm_writel_mm(drvdata, CORESIGHT_UNLOCK, CORESIGHT_LAR);	\
+	/*
+	 * Ensure unlock and any pending writes are committed prior to
+	 * programming ETM registers
+	 */								\
+	mb();								\
+	isb();								\
+} while (0)
+
+/*
+ * Device registers:
+ * 0x000 - 0x2FC: Trace		registers
+ * 0x300 - 0x314: Management	registers
+ * 0x318 - 0xEFC: Trace		registers
+ *
+ * Coresight registers
+ * 0xF00 - 0xF9C: Management	registers
+ * 0xFA0 - 0xFA4: Management	registers in PFTv1.0
+ *		  Trace		registers in PFTv1.1
+ * 0xFA8 - 0xFFC: Management	registers
+ */
+
+/* Trace registers (0x000-0x2FC) */
+#define ETMCR			(0x000)
+#define ETMCCR			(0x004)
+#define ETMTRIGGER		(0x008)
+#define ETMSR			(0x010)
+#define ETMSCR			(0x014)
+#define ETMTSSCR		(0x018)
+#define ETMTEEVR		(0x020)
+#define ETMTECR1		(0x024)
+#define ETMFFLR			(0x02C)
+#define ETMACVRn(n)		(0x040 + (n * 4))
+#define ETMACTRn(n)		(0x080 + (n * 4))
+#define ETMCNTRLDVRn(n)		(0x140 + (n * 4))
+#define ETMCNTENRn(n)		(0x150 + (n * 4))
+#define ETMCNTRLDEVRn(n)	(0x160 + (n * 4))
+#define ETMCNTVRn(n)		(0x170 + (n * 4))
+#define ETMSQ12EVR		(0x180)
+#define ETMSQ21EVR		(0x184)
+#define ETMSQ23EVR		(0x188)
+#define ETMSQ31EVR		(0x18C)
+#define ETMSQ32EVR		(0x190)
+#define ETMSQ13EVR		(0x194)
+#define ETMSQR			(0x19C)
+#define ETMEXTOUTEVRn(n)	(0x1A0 + (n * 4))
+#define ETMCIDCVRn(n)		(0x1B0 + (n * 4))
+#define ETMCIDCMR		(0x1BC)
+#define ETMIMPSPEC0		(0x1C0)
+#define ETMIMPSPEC1		(0x1C4)
+#define ETMIMPSPEC2		(0x1C8)
+#define ETMIMPSPEC3		(0x1CC)
+#define ETMIMPSPEC4		(0x1D0)
+#define ETMIMPSPEC5		(0x1D4)
+#define ETMIMPSPEC6		(0x1D8)
+#define ETMIMPSPEC7		(0x1DC)
+#define ETMSYNCFR		(0x1E0)
+#define ETMIDR			(0x1E4)
+#define ETMCCER			(0x1E8)
+#define ETMEXTINSELR		(0x1EC)
+#define ETMTESSEICR		(0x1F0)
+#define ETMEIBCR		(0x1F4)
+#define ETMTSEVR		(0x1F8)
+#define ETMAUXCR		(0x1FC)
+#define ETMTRACEIDR		(0x200)
+#define ETMVMIDCVR		(0x240)
+/* Management registers (0x300-0x314) */
+#define ETMOSLAR		(0x300)
+#define ETMOSLSR		(0x304)
+#define ETMOSSRR		(0x308)
+#define ETMPDCR			(0x310)
+#define ETMPDSR			(0x314)
+
+#define ETM_MAX_ADDR_CMP	(16)
+#define ETM_MAX_CNTR		(4)
+#define ETM_MAX_CTXID_CMP	(3)
+
+#define ETM_MODE_EXCLUDE	BIT(0)
+#define ETM_MODE_CYCACC		BIT(1)
+#define ETM_MODE_STALL		BIT(2)
+#define ETM_MODE_TIMESTAMP	BIT(3)
+#define ETM_MODE_CTXID		BIT(4)
+#define ETM_MODE_ALL		(0x1F)
+
+#define ETM_EVENT_MASK		(0x1FFFF)
+#define ETM_SYNC_MASK		(0xFFF)
+#define ETM_ALL_MASK		(0xFFFFFFFF)
+
+#define ETM_SEQ_STATE_MAX_VAL	(0x2)
+
+enum etm_addr_type {
+	ETM_ADDR_TYPE_NONE,
+	ETM_ADDR_TYPE_SINGLE,
+	ETM_ADDR_TYPE_RANGE,
+	ETM_ADDR_TYPE_START,
+	ETM_ADDR_TYPE_STOP,
+};
+
+#ifdef CONFIG_CORESIGHT_SOURCE_ETM_DEFAULT_ENABLE
+static int boot_enable = 1;
+#else
+static int boot_enable;
+#endif
+module_param_named(
+	boot_enable, boot_enable, int, S_IRUGO
+);
+
+struct etm_drvdata {
+	void __iomem			*base;
+	struct device			*dev;
+	struct coresight_device		*csdev;
+	struct clk			*clk;
+	spinlock_t			spinlock;
+	int				cpu;
+	uint8_t				arch;
+	bool				use_cp14;
+	bool				enable;
+	bool				sticky_enable;
+	bool				boot_enable;
+	bool				os_unlock;
+	uint8_t				nr_addr_cmp;
+	uint8_t				nr_cntr;
+	uint8_t				nr_ext_inp;
+	uint8_t				nr_ext_out;
+	uint8_t				nr_ctxid_cmp;
+	uint8_t				reset;
+	uint32_t			mode;
+	uint32_t			ctrl;
+	uint32_t			trigger_event;
+	uint32_t			startstop_ctrl;
+	uint32_t			enable_event;
+	uint32_t			enable_ctrl1;
+	uint32_t			fifofull_level;
+	uint8_t				addr_idx;
+	uint32_t			addr_val[ETM_MAX_ADDR_CMP];
+	uint32_t			addr_acctype[ETM_MAX_ADDR_CMP];
+	uint32_t			addr_type[ETM_MAX_ADDR_CMP];
+	uint8_t				cntr_idx;
+	uint32_t			cntr_rld_val[ETM_MAX_CNTR];
+	uint32_t			cntr_event[ETM_MAX_CNTR];
+	uint32_t			cntr_rld_event[ETM_MAX_CNTR];
+	uint32_t			cntr_val[ETM_MAX_CNTR];
+	uint32_t			seq_12_event;
+	uint32_t			seq_21_event;
+	uint32_t			seq_23_event;
+	uint32_t			seq_31_event;
+	uint32_t			seq_32_event;
+	uint32_t			seq_13_event;
+	uint32_t			seq_curr_state;
+	uint8_t				ctxid_idx;
+	uint32_t			ctxid_val[ETM_MAX_CTXID_CMP];
+	uint32_t			ctxid_mask;
+	uint32_t			sync_freq;
+	uint32_t			timestamp_event;
+};
+
+static struct etm_drvdata *etmdrvdata[NR_CPUS];
+
+/*
+ * Memory mapped writes to clear os lock are not supported on some processors
+ * and OS lock must be unlocked before any memory mapped access on such
+ * processors, otherwise memory mapped reads/writes will be invalid.
+ */
+static void etm_os_unlock(void *info)
+{
+	etm_writel_cp14(0x0, ETMOSLAR);
+	isb();
+}
+
+static void etm_set_pwrdwn(struct etm_drvdata *drvdata)
+{
+	uint32_t etmcr;
+
+	/* Ensure pending cp14 accesses complete before setting pwrdwn */
+	mb();
+	isb();
+	etmcr = etm_readl(drvdata, ETMCR);
+	etmcr |= BIT(0);
+	etm_writel(drvdata, etmcr, ETMCR);
+}
+
+static void etm_clr_pwrdwn(struct etm_drvdata *drvdata)
+{
+	uint32_t etmcr;
+
+	etmcr = etm_readl(drvdata, ETMCR);
+	etmcr &= ~BIT(0);
+	etm_writel(drvdata, etmcr, ETMCR);
+	/* Ensure pwrup completes before subsequent cp14 accesses */
+	mb();
+	isb();
+}
+
+static void etm_set_pwrup(struct etm_drvdata *drvdata)
+{
+	uint32_t etmpdcr;
+
+	etmpdcr = etm_readl_mm(drvdata, ETMPDCR);
+	etmpdcr |= BIT(3);
+	etm_writel_mm(drvdata, etmpdcr, ETMPDCR);
+	/* Ensure pwrup completes before subsequent cp14 accesses */
+	mb();
+	isb();
+}
+
+static void etm_clr_pwrup(struct etm_drvdata *drvdata)
+{
+	uint32_t etmpdcr;
+
+	/* Ensure pending cp14 accesses complete before clearing pwrup */
+	mb();
+	isb();
+	etmpdcr = etm_readl_mm(drvdata, ETMPDCR);
+	etmpdcr &= ~BIT(3);
+	etm_writel_mm(drvdata, etmpdcr, ETMPDCR);
+}
+
+static void etm_set_prog(struct etm_drvdata *drvdata)
+{
+	uint32_t etmcr;
+	int count;
+
+	etmcr = etm_readl(drvdata, ETMCR);
+	etmcr |= BIT(10);
+	etm_writel(drvdata, etmcr, ETMCR);
+	/*
+	 * Recommended by spec for cp14 accesses to ensure etmcr write is
+	 * complete before polling etmsr
+	 */
+	isb();
+	for (count = TIMEOUT_US; BVAL(etm_readl(drvdata, ETMSR), 1) != 1
+				&& count > 0; count--)
+		udelay(1);
+	WARN(count == 0, "timeout while setting prog bit, ETMSR: %#x\n",
+	     etm_readl(drvdata, ETMSR));
+}
+
+static void etm_clr_prog(struct etm_drvdata *drvdata)
+{
+	uint32_t etmcr;
+	int count;
+
+	etmcr = etm_readl(drvdata, ETMCR);
+	etmcr &= ~BIT(10);
+	etm_writel(drvdata, etmcr, ETMCR);
+	/*
+	 * Recommended by spec for cp14 accesses to ensure etmcr write is
+	 * complete before polling etmsr
+	 */
+	isb();
+	for (count = TIMEOUT_US; BVAL(etm_readl(drvdata, ETMSR), 1) != 0
+				&& count > 0; count--)
+		udelay(1);
+	WARN(count == 0, "timeout while clearing prog bit, ETMSR: %#x\n",
+	     etm_readl(drvdata, ETMSR));
+}
+
+static void __etm_enable(void *info)
+{
+	int i;
+	uint32_t etmcr;
+	struct etm_drvdata *drvdata = info;
+
+	ETM_UNLOCK(drvdata);
+	/* Vote for ETM power/clock enable */
+	etm_set_pwrup(drvdata);
+	/*
+	 * Clear power down bit since when this bit is set writes to
+	 * certain registers might be ignored. This is also a pre-requisite
+	 * for trace enable.
+	 */
+	etm_clr_pwrdwn(drvdata);
+	etm_clr_pwrup(drvdata);
+	etm_set_prog(drvdata);
+
+	etmcr = etm_readl(drvdata, ETMCR);
+	etmcr &= (BIT(10) | BIT(0));
+	etm_writel(drvdata, drvdata->ctrl | etmcr, ETMCR);
+	etm_writel(drvdata, drvdata->trigger_event, ETMTRIGGER);
+	etm_writel(drvdata, drvdata->startstop_ctrl, ETMTSSCR);
+	etm_writel(drvdata, drvdata->enable_event, ETMTEEVR);
+	etm_writel(drvdata, drvdata->enable_ctrl1, ETMTECR1);
+	etm_writel(drvdata, drvdata->fifofull_level, ETMFFLR);
+	for (i = 0; i < drvdata->nr_addr_cmp; i++) {
+		etm_writel(drvdata, drvdata->addr_val[i], ETMACVRn(i));
+		etm_writel(drvdata, drvdata->addr_acctype[i], ETMACTRn(i));
+	}
+	for (i = 0; i < drvdata->nr_cntr; i++) {
+		etm_writel(drvdata, drvdata->cntr_rld_val[i], ETMCNTRLDVRn(i));
+		etm_writel(drvdata, drvdata->cntr_event[i], ETMCNTENRn(i));
+		etm_writel(drvdata, drvdata->cntr_rld_event[i],
+			   ETMCNTRLDEVRn(i));
+		etm_writel(drvdata, drvdata->cntr_val[i], ETMCNTVRn(i));
+	}
+	etm_writel(drvdata, drvdata->seq_12_event, ETMSQ12EVR);
+	etm_writel(drvdata, drvdata->seq_21_event, ETMSQ21EVR);
+	etm_writel(drvdata, drvdata->seq_23_event, ETMSQ23EVR);
+	etm_writel(drvdata, drvdata->seq_31_event, ETMSQ31EVR);
+	etm_writel(drvdata, drvdata->seq_32_event, ETMSQ32EVR);
+	etm_writel(drvdata, drvdata->seq_13_event, ETMSQ13EVR);
+	etm_writel(drvdata, drvdata->seq_curr_state, ETMSQR);
+	for (i = 0; i < drvdata->nr_ext_out; i++)
+		etm_writel(drvdata, 0x0000406F, ETMEXTOUTEVRn(i));
+	for (i = 0; i < drvdata->nr_ctxid_cmp; i++)
+		etm_writel(drvdata, drvdata->ctxid_val[i], ETMCIDCVRn(i));
+	etm_writel(drvdata, drvdata->ctxid_mask, ETMCIDCMR);
+	etm_writel(drvdata, drvdata->sync_freq, ETMSYNCFR);
+	etm_writel(drvdata, 0x00000000, ETMEXTINSELR);
+	etm_writel(drvdata, drvdata->timestamp_event, ETMTSEVR);
+	etm_writel(drvdata, 0x00000000, ETMAUXCR);
+	etm_writel(drvdata, drvdata->cpu + 1, ETMTRACEIDR);
+	etm_writel(drvdata, 0x00000000, ETMVMIDCVR);
+
+	etm_clr_prog(drvdata);
+	ETM_LOCK(drvdata);
+
+	dev_dbg(drvdata->dev, "cpu: %d enable smp call done\n", drvdata->cpu);
+}
+
+static int etm_enable(struct coresight_device *csdev)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	int ret;
+
+	ret = clk_prepare_enable(drvdata->clk);
+	if (ret)
+		goto err_clk;
+
+	spin_lock(&drvdata->spinlock);
+
+	/*
+	 * Executing __etm_enable on the cpu whose ETM is being enabled
+	 * ensures that register writes occur when cpu is powered.
+	 */
+	ret = smp_call_function_single(drvdata->cpu, __etm_enable, drvdata, 1);
+	if (ret)
+		goto err;
+	drvdata->enable = true;
+	drvdata->sticky_enable = true;
+
+	spin_unlock(&drvdata->spinlock);
+
+	dev_info(drvdata->dev, "ETM tracing enabled\n");
+	return 0;
+err:
+	spin_unlock(&drvdata->spinlock);
+	clk_disable_unprepare(drvdata->clk);
+err_clk:
+	return ret;
+}
+
+static void __etm_disable(void *info)
+{
+	struct etm_drvdata *drvdata = info;
+
+	ETM_UNLOCK(drvdata);
+	etm_set_prog(drvdata);
+
+	/* Program trace enable to low by using always false event */
+	etm_writel(drvdata, 0x6F | BIT(14), ETMTEEVR);
+
+	etm_set_pwrdwn(drvdata);
+	ETM_LOCK(drvdata);
+
+	dev_dbg(drvdata->dev, "cpu: %d disable smp call done\n", drvdata->cpu);
+}
+
+static void etm_disable(struct coresight_device *csdev)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	/*
+	 * Taking hotplug lock here protects from clocks getting disabled
+	 * with tracing being left on (crash scenario) if user disable occurs
+	 * after cpu online mask indicates the cpu is offline but before the
+	 * DYING hotplug callback is serviced by the ETM driver.
+	 */
+	get_online_cpus();
+	spin_lock(&drvdata->spinlock);
+
+	/*
+	 * Executing __etm_disable on the cpu whose ETM is being disabled
+	 * ensures that register writes occur when cpu is powered.
+	 */
+	smp_call_function_single(drvdata->cpu, __etm_disable, drvdata, 1);
+	drvdata->enable = false;
+
+	spin_unlock(&drvdata->spinlock);
+	put_online_cpus();
+
+	clk_disable_unprepare(drvdata->clk);
+
+	dev_info(drvdata->dev, "ETM tracing disabled\n");
+}
+
+static const struct coresight_ops_source etm_source_ops = {
+	.enable		= etm_enable,
+	.disable	= etm_disable,
+};
+
+static const struct coresight_ops etm_cs_ops = {
+	.source_ops	= &etm_source_ops,
+};
+
+static ssize_t etm_show_nr_addr_cmp(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val = drvdata->nr_addr_cmp;
+
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+}
+static DEVICE_ATTR(nr_addr_cmp, S_IRUGO, etm_show_nr_addr_cmp, NULL);
+
+static ssize_t etm_show_nr_cntr(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val = drvdata->nr_cntr;
+
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+}
+static DEVICE_ATTR(nr_cntr, S_IRUGO, etm_show_nr_cntr, NULL);
+
+static ssize_t etm_show_nr_ctxid_cmp(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val = drvdata->nr_ctxid_cmp;
+
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+}
+static DEVICE_ATTR(nr_ctxid_cmp, S_IRUGO, etm_show_nr_ctxid_cmp, NULL);
+
+static ssize_t etm_show_reset(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val = drvdata->reset;
+
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+}
+
+/* Reset to trace everything i.e. exclude nothing. */
+static ssize_t etm_store_reset(struct device *dev,
+			       struct device_attribute *attr, const char *buf,
+			       size_t size)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	int i;
+	unsigned long val;
+
+	if (sscanf(buf, "%lx", &val) != 1)
+		return -EINVAL;
+
+	spin_lock(&drvdata->spinlock);
+	if (val) {
+		drvdata->mode = ETM_MODE_EXCLUDE;
+		drvdata->ctrl = 0x0;
+		drvdata->trigger_event = 0x406F;
+		drvdata->startstop_ctrl = 0x0;
+		drvdata->enable_event = 0x6F;
+		drvdata->enable_ctrl1 = 0x1000000;
+		drvdata->fifofull_level = 0x28;
+		drvdata->addr_idx = 0x0;
+		for (i = 0; i < drvdata->nr_addr_cmp; i++) {
+			drvdata->addr_val[i] = 0x0;
+			drvdata->addr_acctype[i] = 0x0;
+			drvdata->addr_type[i] = ETM_ADDR_TYPE_NONE;
+		}
+		drvdata->cntr_idx = 0x0;
+		for (i = 0; i < drvdata->nr_cntr; i++) {
+			drvdata->cntr_rld_val[i] = 0x0;
+			drvdata->cntr_event[i] = 0x406F;
+			drvdata->cntr_rld_event[i] = 0x406F;
+			drvdata->cntr_val[i] = 0x0;
+		}
+		drvdata->seq_12_event = 0x406F;
+		drvdata->seq_21_event = 0x406F;
+		drvdata->seq_23_event = 0x406F;
+		drvdata->seq_31_event = 0x406F;
+		drvdata->seq_32_event = 0x406F;
+		drvdata->seq_13_event = 0x406F;
+		drvdata->seq_curr_state = 0x0;
+		drvdata->ctxid_idx = 0x0;
+		for (i = 0; i < drvdata->nr_ctxid_cmp; i++)
+			drvdata->ctxid_val[i] = 0x0;
+		drvdata->ctxid_mask = 0x0;
+		drvdata->sync_freq = 0x100;
+		drvdata->timestamp_event = 0x406F;
+	}
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+static DEVICE_ATTR(reset, S_IRUGO | S_IWUSR, etm_show_reset, etm_store_reset);
+
+static ssize_t etm_show_mode(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val = drvdata->mode;
+
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+}
+
+static ssize_t etm_store_mode(struct device *dev, struct device_attribute *attr,
+			      const char *buf, size_t size)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (sscanf(buf, "%lx", &val) != 1)
+		return -EINVAL;
+
+	spin_lock(&drvdata->spinlock);
+	drvdata->mode = val & ETM_MODE_ALL;
+
+	if (drvdata->mode & ETM_MODE_EXCLUDE)
+		drvdata->enable_ctrl1 |= BIT(24);
+	else
+		drvdata->enable_ctrl1 &= ~BIT(24);
+
+	if (drvdata->mode & ETM_MODE_CYCACC)
+		drvdata->ctrl |= BIT(12);
+	else
+		drvdata->ctrl &= ~BIT(12);
+
+	if (drvdata->mode & ETM_MODE_STALL)
+		drvdata->ctrl |= BIT(7);
+	else
+		drvdata->ctrl &= ~BIT(7);
+
+	if (drvdata->mode & ETM_MODE_TIMESTAMP)
+		drvdata->ctrl |= BIT(28);
+	else
+		drvdata->ctrl &= ~BIT(28);
+
+	if (drvdata->mode & ETM_MODE_CTXID)
+		drvdata->ctrl |= (BIT(14) | BIT(15));
+	else
+		drvdata->ctrl &= ~(BIT(14) | BIT(15));
+	spin_unlock(&drvdata->spinlock);
+
+	return size;
+}
+static DEVICE_ATTR(mode, S_IRUGO | S_IWUSR, etm_show_mode, etm_store_mode);
+
+static ssize_t etm_show_trigger_event(struct device *dev,
+				      struct device_attribute *attr, char *buf)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val = drvdata->trigger_event;
+
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+}
+
+static ssize_t etm_store_trigger_event(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf, size_t size)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (sscanf(buf, "%lx", &val) != 1)
+		return -EINVAL;
+
+	drvdata->trigger_event = val & ETM_EVENT_MASK;
+	return size;
+}
+static DEVICE_ATTR(trigger_event, S_IRUGO | S_IWUSR, etm_show_trigger_event,
+		   etm_store_trigger_event);
+
+static ssize_t etm_show_enable_event(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val = drvdata->enable_event;
+
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+}
+
+static ssize_t etm_store_enable_event(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t size)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (sscanf(buf, "%lx", &val) != 1)
+		return -EINVAL;
+
+	drvdata->enable_event = val & ETM_EVENT_MASK;
+	return size;
+}
+static DEVICE_ATTR(enable_event, S_IRUGO | S_IWUSR, etm_show_enable_event,
+		   etm_store_enable_event);
+
+static ssize_t etm_show_fifofull_level(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val = drvdata->fifofull_level;
+
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+}
+
+static ssize_t etm_store_fifofull_level(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t size)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (sscanf(buf, "%lx", &val) != 1)
+		return -EINVAL;
+
+	drvdata->fifofull_level = val;
+	return size;
+}
+static DEVICE_ATTR(fifofull_level, S_IRUGO | S_IWUSR, etm_show_fifofull_level,
+		   etm_store_fifofull_level);
+
+static ssize_t etm_show_addr_idx(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val = drvdata->addr_idx;
+
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+}
+
+static ssize_t etm_store_addr_idx(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t size)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (sscanf(buf, "%lx", &val) != 1)
+		return -EINVAL;
+	if (val >= drvdata->nr_addr_cmp)
+		return -EINVAL;
+
+	/*
+	 * Use spinlock to ensure index doesn't change while it gets
+	 * dereferenced multiple times within a spinlock block elsewhere.
+	 */
+	spin_lock(&drvdata->spinlock);
+	drvdata->addr_idx = val;
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+static DEVICE_ATTR(addr_idx, S_IRUGO | S_IWUSR, etm_show_addr_idx,
+		   etm_store_addr_idx);
+
+static ssize_t etm_show_addr_single(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+	uint8_t idx;
+
+	spin_lock(&drvdata->spinlock);
+	idx = drvdata->addr_idx;
+	if (!(drvdata->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
+	      drvdata->addr_type[idx] == ETM_ADDR_TYPE_SINGLE)) {
+		spin_unlock(&drvdata->spinlock);
+		return -EPERM;
+	}
+
+	val = drvdata->addr_val[idx];
+	spin_unlock(&drvdata->spinlock);
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+}
+
+static ssize_t etm_store_addr_single(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t size)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+	uint8_t idx;
+
+	if (sscanf(buf, "%lx", &val) != 1)
+		return -EINVAL;
+
+	spin_lock(&drvdata->spinlock);
+	idx = drvdata->addr_idx;
+	if (!(drvdata->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
+	      drvdata->addr_type[idx] == ETM_ADDR_TYPE_SINGLE)) {
+		spin_unlock(&drvdata->spinlock);
+		return -EPERM;
+	}
+
+	drvdata->addr_val[idx] = val;
+	drvdata->addr_type[idx] = ETM_ADDR_TYPE_SINGLE;
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+static DEVICE_ATTR(addr_single, S_IRUGO | S_IWUSR, etm_show_addr_single,
+		   etm_store_addr_single);
+
+static ssize_t etm_show_addr_range(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val1, val2;
+	uint8_t idx;
+
+	spin_lock(&drvdata->spinlock);
+	idx = drvdata->addr_idx;
+	if (idx % 2 != 0) {
+		spin_unlock(&drvdata->spinlock);
+		return -EPERM;
+	}
+	if (!((drvdata->addr_type[idx] == ETM_ADDR_TYPE_NONE &&
+	       drvdata->addr_type[idx + 1] == ETM_ADDR_TYPE_NONE) ||
+	      (drvdata->addr_type[idx] == ETM_ADDR_TYPE_RANGE &&
+	       drvdata->addr_type[idx + 1] == ETM_ADDR_TYPE_RANGE))) {
+		spin_unlock(&drvdata->spinlock);
+		return -EPERM;
+	}
+
+	val1 = drvdata->addr_val[idx];
+	val2 = drvdata->addr_val[idx + 1];
+	spin_unlock(&drvdata->spinlock);
+	return scnprintf(buf, PAGE_SIZE, "%#lx %#lx\n", val1, val2);
+}
+
+static ssize_t etm_store_addr_range(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t size)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val1, val2;
+	uint8_t idx;
+
+	if (sscanf(buf, "%lx %lx", &val1, &val2) != 2)
+		return -EINVAL;
+	/* Lower address comparator cannot have a higher address value */
+	if (val1 > val2)
+		return -EINVAL;
+
+	spin_lock(&drvdata->spinlock);
+	idx = drvdata->addr_idx;
+	if (idx % 2 != 0) {
+		spin_unlock(&drvdata->spinlock);
+		return -EPERM;
+	}
+	if (!((drvdata->addr_type[idx] == ETM_ADDR_TYPE_NONE &&
+	       drvdata->addr_type[idx + 1] == ETM_ADDR_TYPE_NONE) ||
+	      (drvdata->addr_type[idx] == ETM_ADDR_TYPE_RANGE &&
+	       drvdata->addr_type[idx + 1] == ETM_ADDR_TYPE_RANGE))) {
+		spin_unlock(&drvdata->spinlock);
+		return -EPERM;
+	}
+
+	drvdata->addr_val[idx] = val1;
+	drvdata->addr_type[idx] = ETM_ADDR_TYPE_RANGE;
+	drvdata->addr_val[idx + 1] = val2;
+	drvdata->addr_type[idx + 1] = ETM_ADDR_TYPE_RANGE;
+	drvdata->enable_ctrl1 |= (1 << (idx/2));
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+static DEVICE_ATTR(addr_range, S_IRUGO | S_IWUSR, etm_show_addr_range,
+		   etm_store_addr_range);
+
+static ssize_t etm_show_addr_start(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+	uint8_t idx;
+
+	spin_lock(&drvdata->spinlock);
+	idx = drvdata->addr_idx;
+	if (!(drvdata->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
+	      drvdata->addr_type[idx] == ETM_ADDR_TYPE_START)) {
+		spin_unlock(&drvdata->spinlock);
+		return -EPERM;
+	}
+
+	val = drvdata->addr_val[idx];
+	spin_unlock(&drvdata->spinlock);
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+}
+
+static ssize_t etm_store_addr_start(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t size)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+	uint8_t idx;
+
+	if (sscanf(buf, "%lx", &val) != 1)
+		return -EINVAL;
+
+	spin_lock(&drvdata->spinlock);
+	idx = drvdata->addr_idx;
+	if (!(drvdata->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
+	      drvdata->addr_type[idx] == ETM_ADDR_TYPE_START)) {
+		spin_unlock(&drvdata->spinlock);
+		return -EPERM;
+	}
+
+	drvdata->addr_val[idx] = val;
+	drvdata->addr_type[idx] = ETM_ADDR_TYPE_START;
+	drvdata->startstop_ctrl |= (1 << idx);
+	drvdata->enable_ctrl1 |= BIT(25);
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+static DEVICE_ATTR(addr_start, S_IRUGO | S_IWUSR, etm_show_addr_start,
+		   etm_store_addr_start);
+
+static ssize_t etm_show_addr_stop(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+	uint8_t idx;
+
+	spin_lock(&drvdata->spinlock);
+	idx = drvdata->addr_idx;
+	if (!(drvdata->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
+	      drvdata->addr_type[idx] == ETM_ADDR_TYPE_STOP)) {
+		spin_unlock(&drvdata->spinlock);
+		return -EPERM;
+	}
+
+	val = drvdata->addr_val[idx];
+	spin_unlock(&drvdata->spinlock);
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+}
+
+static ssize_t etm_store_addr_stop(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t size)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+	uint8_t idx;
+
+	if (sscanf(buf, "%lx", &val) != 1)
+		return -EINVAL;
+
+	spin_lock(&drvdata->spinlock);
+	idx = drvdata->addr_idx;
+	if (!(drvdata->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
+	      drvdata->addr_type[idx] == ETM_ADDR_TYPE_STOP)) {
+		spin_unlock(&drvdata->spinlock);
+		return -EPERM;
+	}
+
+	drvdata->addr_val[idx] = val;
+	drvdata->addr_type[idx] = ETM_ADDR_TYPE_STOP;
+	drvdata->startstop_ctrl |= (1 << (idx + 16));
+	drvdata->enable_ctrl1 |= BIT(25);
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+static DEVICE_ATTR(addr_stop, S_IRUGO | S_IWUSR, etm_show_addr_stop,
+		   etm_store_addr_stop);
+
+static ssize_t etm_show_addr_acctype(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	spin_lock(&drvdata->spinlock);
+	val = drvdata->addr_acctype[drvdata->addr_idx];
+	spin_unlock(&drvdata->spinlock);
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+}
+
+static ssize_t etm_store_addr_acctype(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t size)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (sscanf(buf, "%lx", &val) != 1)
+		return -EINVAL;
+
+	spin_lock(&drvdata->spinlock);
+	drvdata->addr_acctype[drvdata->addr_idx] = val;
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+static DEVICE_ATTR(addr_acctype, S_IRUGO | S_IWUSR, etm_show_addr_acctype,
+		   etm_store_addr_acctype);
+
+static ssize_t etm_show_cntr_idx(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val = drvdata->addr_idx;
+
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+}
+
+static ssize_t etm_store_cntr_idx(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t size)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (sscanf(buf, "%lx", &val) != 1)
+		return -EINVAL;
+	if (val >= drvdata->nr_cntr)
+		return -EINVAL;
+
+	/*
+	 * Use spinlock to ensure index doesn't change while it gets
+	 * dereferenced multiple times within a spinlock block elsewhere.
+	 */
+	spin_lock(&drvdata->spinlock);
+	drvdata->cntr_idx = val;
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+static DEVICE_ATTR(cntr_idx, S_IRUGO | S_IWUSR, etm_show_cntr_idx,
+		   etm_store_cntr_idx);
+
+static ssize_t etm_show_cntr_rld_val(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	spin_lock(&drvdata->spinlock);
+	val = drvdata->cntr_rld_val[drvdata->cntr_idx];
+	spin_unlock(&drvdata->spinlock);
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+}
+
+static ssize_t etm_store_cntr_rld_val(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t size)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (sscanf(buf, "%lx", &val) != 1)
+		return -EINVAL;
+
+	spin_lock(&drvdata->spinlock);
+	drvdata->cntr_rld_val[drvdata->cntr_idx] = val;
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+static DEVICE_ATTR(cntr_rld_val, S_IRUGO | S_IWUSR, etm_show_cntr_rld_val,
+		   etm_store_cntr_rld_val);
+
+static ssize_t etm_show_cntr_event(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	spin_lock(&drvdata->spinlock);
+	val = drvdata->cntr_event[drvdata->cntr_idx];
+	spin_unlock(&drvdata->spinlock);
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+}
+
+static ssize_t etm_store_cntr_event(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t size)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (sscanf(buf, "%lx", &val) != 1)
+		return -EINVAL;
+
+	spin_lock(&drvdata->spinlock);
+	drvdata->cntr_event[drvdata->cntr_idx] = val & ETM_EVENT_MASK;
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+static DEVICE_ATTR(cntr_event, S_IRUGO | S_IWUSR, etm_show_cntr_event,
+		   etm_store_cntr_event);
+
+static ssize_t etm_show_cntr_rld_event(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	spin_lock(&drvdata->spinlock);
+	val = drvdata->cntr_rld_event[drvdata->cntr_idx];
+	spin_unlock(&drvdata->spinlock);
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+}
+
+static ssize_t etm_store_cntr_rld_event(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t size)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (sscanf(buf, "%lx", &val) != 1)
+		return -EINVAL;
+
+	spin_lock(&drvdata->spinlock);
+	drvdata->cntr_rld_event[drvdata->cntr_idx] = val & ETM_EVENT_MASK;
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+static DEVICE_ATTR(cntr_rld_event, S_IRUGO | S_IWUSR, etm_show_cntr_rld_event,
+		   etm_store_cntr_rld_event);
+
+static ssize_t etm_show_cntr_val(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	spin_lock(&drvdata->spinlock);
+	val = drvdata->cntr_val[drvdata->cntr_idx];
+	spin_unlock(&drvdata->spinlock);
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+}
+
+static ssize_t etm_store_cntr_val(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t size)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (sscanf(buf, "%lx", &val) != 1)
+		return -EINVAL;
+
+	spin_lock(&drvdata->spinlock);
+	drvdata->cntr_val[drvdata->cntr_idx] = val;
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+static DEVICE_ATTR(cntr_val, S_IRUGO | S_IWUSR, etm_show_cntr_val,
+		   etm_store_cntr_val);
+
+static ssize_t etm_show_seq_12_event(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val = drvdata->seq_12_event;
+
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+}
+
+static ssize_t etm_store_seq_12_event(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t size)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (sscanf(buf, "%lx", &val) != 1)
+		return -EINVAL;
+
+	drvdata->seq_12_event = val & ETM_EVENT_MASK;
+	return size;
+}
+static DEVICE_ATTR(seq_12_event, S_IRUGO | S_IWUSR, etm_show_seq_12_event,
+		   etm_store_seq_12_event);
+
+static ssize_t etm_show_seq_21_event(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val = drvdata->seq_21_event;
+
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+}
+
+static ssize_t etm_store_seq_21_event(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t size)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (sscanf(buf, "%lx", &val) != 1)
+		return -EINVAL;
+
+	drvdata->seq_21_event = val & ETM_EVENT_MASK;
+	return size;
+}
+static DEVICE_ATTR(seq_21_event, S_IRUGO | S_IWUSR, etm_show_seq_21_event,
+		   etm_store_seq_21_event);
+
+static ssize_t etm_show_seq_23_event(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val = drvdata->seq_23_event;
+
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+}
+
+static ssize_t etm_store_seq_23_event(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t size)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (sscanf(buf, "%lx", &val) != 1)
+		return -EINVAL;
+
+	drvdata->seq_23_event = val & ETM_EVENT_MASK;
+	return size;
+}
+static DEVICE_ATTR(seq_23_event, S_IRUGO | S_IWUSR, etm_show_seq_23_event,
+		   etm_store_seq_23_event);
+
+static ssize_t etm_show_seq_31_event(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val = drvdata->seq_31_event;
+
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+}
+
+static ssize_t etm_store_seq_31_event(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t size)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (sscanf(buf, "%lx", &val) != 1)
+		return -EINVAL;
+
+	drvdata->seq_31_event = val & ETM_EVENT_MASK;
+	return size;
+}
+static DEVICE_ATTR(seq_31_event, S_IRUGO | S_IWUSR, etm_show_seq_31_event,
+		   etm_store_seq_31_event);
+
+static ssize_t etm_show_seq_32_event(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val = drvdata->seq_32_event;
+
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+}
+
+static ssize_t etm_store_seq_32_event(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t size)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (sscanf(buf, "%lx", &val) != 1)
+		return -EINVAL;
+
+	drvdata->seq_32_event = val & ETM_EVENT_MASK;
+	return size;
+}
+static DEVICE_ATTR(seq_32_event, S_IRUGO | S_IWUSR, etm_show_seq_32_event,
+		   etm_store_seq_32_event);
+
+static ssize_t etm_show_seq_13_event(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val = drvdata->seq_13_event;
+
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+}
+
+static ssize_t etm_store_seq_13_event(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t size)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (sscanf(buf, "%lx", &val) != 1)
+		return -EINVAL;
+
+	drvdata->seq_13_event = val & ETM_EVENT_MASK;
+	return size;
+}
+static DEVICE_ATTR(seq_13_event, S_IRUGO | S_IWUSR, etm_show_seq_13_event,
+		   etm_store_seq_13_event);
+
+static ssize_t etm_show_seq_curr_state(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val = drvdata->seq_curr_state;
+
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+}
+
+static ssize_t etm_store_seq_curr_state(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t size)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (sscanf(buf, "%lx", &val) != 1)
+		return -EINVAL;
+	if (val > ETM_SEQ_STATE_MAX_VAL)
+		return -EINVAL;
+
+	drvdata->seq_curr_state = val;
+	return size;
+}
+static DEVICE_ATTR(seq_curr_state, S_IRUGO | S_IWUSR, etm_show_seq_curr_state,
+		   etm_store_seq_curr_state);
+
+static ssize_t etm_show_ctxid_idx(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val = drvdata->ctxid_idx;
+
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+}
+
+static ssize_t etm_store_ctxid_idx(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t size)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (sscanf(buf, "%lx", &val) != 1)
+		return -EINVAL;
+	if (val >= drvdata->nr_ctxid_cmp)
+		return -EINVAL;
+
+	/*
+	 * Use spinlock to ensure index doesn't change while it gets
+	 * dereferenced multiple times within a spinlock block elsewhere.
+	 */
+	spin_lock(&drvdata->spinlock);
+	drvdata->ctxid_idx = val;
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+static DEVICE_ATTR(ctxid_idx, S_IRUGO | S_IWUSR, etm_show_ctxid_idx,
+		   etm_store_ctxid_idx);
+
+static ssize_t etm_show_ctxid_val(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	spin_lock(&drvdata->spinlock);
+	val = drvdata->ctxid_val[drvdata->ctxid_idx];
+	spin_unlock(&drvdata->spinlock);
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+}
+
+static ssize_t etm_store_ctxid_val(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t size)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (sscanf(buf, "%lx", &val) != 1)
+		return -EINVAL;
+
+	spin_lock(&drvdata->spinlock);
+	drvdata->ctxid_val[drvdata->ctxid_idx] = val;
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+static DEVICE_ATTR(ctxid_val, S_IRUGO | S_IWUSR, etm_show_ctxid_val,
+		   etm_store_ctxid_val);
+
+static ssize_t etm_show_ctxid_mask(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val = drvdata->ctxid_mask;
+
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+}
+
+static ssize_t etm_store_ctxid_mask(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t size)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (sscanf(buf, "%lx", &val) != 1)
+		return -EINVAL;
+
+	drvdata->ctxid_mask = val;
+	return size;
+}
+static DEVICE_ATTR(ctxid_mask, S_IRUGO | S_IWUSR, etm_show_ctxid_mask,
+		   etm_store_ctxid_mask);
+
+static ssize_t etm_show_sync_freq(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val = drvdata->sync_freq;
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+}
+
+static ssize_t etm_store_sync_freq(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t size)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (sscanf(buf, "%lx", &val) != 1)
+		return -EINVAL;
+
+	drvdata->sync_freq = val & ETM_SYNC_MASK;
+	return size;
+}
+static DEVICE_ATTR(sync_freq, S_IRUGO | S_IWUSR, etm_show_sync_freq,
+		   etm_store_sync_freq);
+
+static ssize_t etm_show_timestamp_event(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val = drvdata->timestamp_event;
+
+	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+}
+
+static ssize_t etm_store_timestamp_event(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf, size_t size)
+{
+	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if (sscanf(buf, "%lx", &val) != 1)
+		return -EINVAL;
+
+	drvdata->timestamp_event = val & ETM_EVENT_MASK;
+	return size;
+}
+static DEVICE_ATTR(timestamp_event, S_IRUGO | S_IWUSR, etm_show_timestamp_event,
+		   etm_store_timestamp_event);
+
+static struct attribute *etm_attrs[] = {
+	&dev_attr_nr_addr_cmp.attr,
+	&dev_attr_nr_cntr.attr,
+	&dev_attr_nr_ctxid_cmp.attr,
+	&dev_attr_reset.attr,
+	&dev_attr_mode.attr,
+	&dev_attr_trigger_event.attr,
+	&dev_attr_enable_event.attr,
+	&dev_attr_fifofull_level.attr,
+	&dev_attr_addr_idx.attr,
+	&dev_attr_addr_single.attr,
+	&dev_attr_addr_range.attr,
+	&dev_attr_addr_start.attr,
+	&dev_attr_addr_stop.attr,
+	&dev_attr_addr_acctype.attr,
+	&dev_attr_cntr_idx.attr,
+	&dev_attr_cntr_rld_val.attr,
+	&dev_attr_cntr_event.attr,
+	&dev_attr_cntr_rld_event.attr,
+	&dev_attr_cntr_val.attr,
+	&dev_attr_seq_12_event.attr,
+	&dev_attr_seq_21_event.attr,
+	&dev_attr_seq_23_event.attr,
+	&dev_attr_seq_31_event.attr,
+	&dev_attr_seq_32_event.attr,
+	&dev_attr_seq_13_event.attr,
+	&dev_attr_seq_curr_state.attr,
+	&dev_attr_ctxid_idx.attr,
+	&dev_attr_ctxid_val.attr,
+	&dev_attr_ctxid_mask.attr,
+	&dev_attr_sync_freq.attr,
+	&dev_attr_timestamp_event.attr,
+	NULL,
+};
+
+static struct attribute_group etm_attr_grp = {
+	.attrs = etm_attrs,
+};
+
+static const struct attribute_group *etm_attr_grps[] = {
+	&etm_attr_grp,
+	NULL,
+};
+
+static int etm_cpu_callback(struct notifier_block *nfb, unsigned long action,
+			    void *hcpu)
+{
+	unsigned int cpu = (unsigned long)hcpu;
+
+	if (!etmdrvdata[cpu])
+		goto out;
+
+	switch (action & (~CPU_TASKS_FROZEN)) {
+	case CPU_STARTING:
+		spin_lock(&etmdrvdata[cpu]->spinlock);
+		if (!etmdrvdata[cpu]->os_unlock) {
+			etm_os_unlock(etmdrvdata[cpu]);
+			etmdrvdata[cpu]->os_unlock = true;
+		}
+
+		if (etmdrvdata[cpu]->enable)
+			__etm_enable(etmdrvdata[cpu]);
+		spin_unlock(&etmdrvdata[cpu]->spinlock);
+		break;
+
+	case CPU_ONLINE:
+		if (etmdrvdata[cpu]->boot_enable &&
+		    !etmdrvdata[cpu]->sticky_enable)
+			coresight_enable(etmdrvdata[cpu]->csdev);
+
+	case CPU_DYING:
+		spin_lock(&etmdrvdata[cpu]->spinlock);
+		if (etmdrvdata[cpu]->enable)
+			__etm_disable(etmdrvdata[cpu]);
+		spin_unlock(&etmdrvdata[cpu]->spinlock);
+		break;
+	}
+out:
+	return NOTIFY_OK;
+}
+
+static struct notifier_block etm_cpu_notifier = {
+	.notifier_call = etm_cpu_callback,
+};
+
+static bool __devinit etm_arch_supported(uint8_t arch)
+{
+	switch (arch) {
+	case PFT_ARCH_V1_1:
+		break;
+	default:
+		return false;
+	}
+	return true;
+}
+
+static void __devinit etm_init_arch_data(void *info)
+{
+	uint32_t etmidr;
+	uint32_t etmccr;
+	struct etm_drvdata *drvdata = info;
+
+	ETM_UNLOCK(drvdata);
+	/* Vote for ETM power/clock enable */
+	etm_set_pwrup(drvdata);
+	/*
+	 * Clear power down bit since when this bit is set writes to
+	 * certain registers might be ignored.
+	 */
+	etm_clr_pwrdwn(drvdata);
+	etm_clr_pwrup(drvdata);
+	/*
+	 * Set prog bit. It will be set from reset but this is included to
+	 * ensure it is set
+	 */
+	etm_set_prog(drvdata);
+
+	/* Find all capabilities */
+	etmidr = etm_readl(drvdata, ETMIDR);
+	drvdata->arch = BMVAL(etmidr, 4, 11);
+
+	etmccr = etm_readl(drvdata, ETMCCR);
+	drvdata->nr_addr_cmp = BMVAL(etmccr, 0, 3) * 2;
+	drvdata->nr_cntr = BMVAL(etmccr, 13, 15);
+	drvdata->nr_ext_inp = BMVAL(etmccr, 17, 19);
+	drvdata->nr_ext_out = BMVAL(etmccr, 20, 22);
+	drvdata->nr_ctxid_cmp = BMVAL(etmccr, 24, 25);
+
+	etm_set_pwrdwn(drvdata);
+	ETM_LOCK(drvdata);
+}
+
+static void __devinit etm_copy_arch_data(struct etm_drvdata *drvdata)
+{
+	drvdata->arch = etmdrvdata[0]->arch;
+	drvdata->nr_addr_cmp = etmdrvdata[0]->nr_addr_cmp;
+	drvdata->nr_cntr = etmdrvdata[0]->nr_cntr;
+	drvdata->nr_ext_inp = etmdrvdata[0]->nr_ext_inp;
+	drvdata->nr_ext_out = etmdrvdata[0]->nr_ext_out;
+	drvdata->nr_ctxid_cmp = etmdrvdata[0]->nr_ctxid_cmp;
+}
+
+static void __devinit etm_init_default_data(struct etm_drvdata *drvdata)
+{
+	int i;
+
+	drvdata->trigger_event = 0x406F;
+	drvdata->enable_event = 0x6F;
+	drvdata->enable_ctrl1 = 0x1;
+	drvdata->fifofull_level	= 0x28;
+	if (drvdata->nr_addr_cmp >= 2) {
+		drvdata->addr_val[0] = (uint32_t) _stext;
+		drvdata->addr_val[1] = (uint32_t) _etext;
+		drvdata->addr_type[0] = ETM_ADDR_TYPE_RANGE;
+		drvdata->addr_type[1] = ETM_ADDR_TYPE_RANGE;
+	}
+	for (i = 0; i < drvdata->nr_cntr; i++) {
+		drvdata->cntr_event[i] = 0x406F;
+		drvdata->cntr_rld_event[i] = 0x406F;
+	}
+	drvdata->seq_12_event = 0x406F;
+	drvdata->seq_21_event = 0x406F;
+	drvdata->seq_23_event = 0x406F;
+	drvdata->seq_31_event = 0x406F;
+	drvdata->seq_32_event = 0x406F;
+	drvdata->seq_13_event = 0x406F;
+	drvdata->sync_freq = 0x100;
+	drvdata->timestamp_event = 0x406F;
+}
+
+static int __devinit etm_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct device *dev = &pdev->dev;
+	struct coresight_platform_data *pdata;
+	struct etm_drvdata *drvdata;
+	struct resource *res;
+	static int count;
+	struct coresight_desc *desc;
+
+	if (pdev->dev.of_node) {
+		pdata = of_get_coresight_platform_data(dev, pdev->dev.of_node);
+		if (IS_ERR(pdata))
+			return PTR_ERR(pdata);
+		pdev->dev.platform_data = pdata;
+		drvdata->use_cp14 = of_property_read_bool(pdev->dev.of_node,
+							  "arm,cp14");
+	}
+
+	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
+	if (!drvdata)
+		return -ENOMEM;
+	drvdata->dev = &pdev->dev;
+	platform_set_drvdata(pdev, drvdata);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	drvdata->base = devm_ioremap(dev, res->start, resource_size(res));
+	if (!drvdata->base)
+		return -ENOMEM;
+
+	spin_lock_init(&drvdata->spinlock);
+
+	drvdata->clk = devm_clk_get(dev, "core_clk");
+	if (IS_ERR(drvdata->clk))
+		return PTR_ERR(drvdata->clk);
+
+	ret = clk_set_rate(drvdata->clk, CORESIGHT_CLK_RATE_TRACE);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(drvdata->clk);
+	if (ret)
+		return ret;
+
+	drvdata->cpu = count++;
+
+	get_online_cpus();
+	etmdrvdata[drvdata->cpu] = drvdata;
+
+	if (!smp_call_function_single(drvdata->cpu, etm_os_unlock, NULL, 1))
+		drvdata->os_unlock = true;
+	/*
+	 * Use CPU0 to populate read-only configuration data for ETM0. For
+	 * other ETMs copy it over from ETM0.
+	 */
+	if (drvdata->cpu == 0) {
+		register_hotcpu_notifier(&etm_cpu_notifier);
+		if (smp_call_function_single(drvdata->cpu, etm_init_arch_data,
+					     drvdata, 1))
+			dev_err(dev, "ETM arch init failed\n");
+	} else {
+		etm_copy_arch_data(drvdata);
+	}
+
+	put_online_cpus();
+
+	if (etm_arch_supported(drvdata->arch) == false) {
+		clk_disable_unprepare(drvdata->clk);
+		return -EINVAL;
+	}
+	etm_init_default_data(drvdata);
+
+	clk_disable_unprepare(drvdata->clk);
+
+	desc = devm_kzalloc(dev, sizeof(*desc), GFP_KERNEL);
+	if (!desc) {
+		ret = -ENOMEM;
+		goto err;
+	}
+	desc->type = CORESIGHT_DEV_TYPE_SOURCE;
+	desc->subtype.source_subtype = CORESIGHT_DEV_SUBTYPE_SOURCE_PROC;
+	desc->ops = &etm_cs_ops;
+	desc->pdata = pdev->dev.platform_data;
+	desc->dev = &pdev->dev;
+	desc->groups = etm_attr_grps;
+	desc->owner = THIS_MODULE;
+	drvdata->csdev = coresight_register(desc);
+	if (IS_ERR(drvdata->csdev)) {
+		ret = PTR_ERR(drvdata->csdev);
+		goto err;
+	}
+
+	dev_info(dev, "ETM initialized\n");
+
+	if (boot_enable) {
+		coresight_enable(drvdata->csdev);
+		drvdata->boot_enable = true;
+	}
+
+	return 0;
+err:
+	if (drvdata->cpu == 0)
+		unregister_hotcpu_notifier(&etm_cpu_notifier);
+	return ret;
+}
+
+static int __devexit etm_remove(struct platform_device *pdev)
+{
+	struct etm_drvdata *drvdata = platform_get_drvdata(pdev);
+
+	coresight_unregister(drvdata->csdev);
+	if (drvdata->cpu == 0)
+		unregister_hotcpu_notifier(&etm_cpu_notifier);
+	return 0;
+}
+
+static struct of_device_id etm_match[] = {
+	{.compatible = "arm,coresight-etm"},
+	{}
+};
+
+static struct platform_driver etm_driver = {
+	.probe          = etm_probe,
+	.remove         = __devexit_p(etm_remove),
+	.driver         = {
+		.name   = "coresight-etm",
+		.owner	= THIS_MODULE,
+		.of_match_table = etm_match,
+	},
+};
+
+int __init etm_init(void)
+{
+	return platform_driver_register(&etm_driver);
+}
+module_init(etm_init);
+
+void __exit etm_exit(void)
+{
+	platform_driver_unregister(&etm_driver);
+}
+module_exit(etm_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("CoreSight Program Flow Trace driver");
-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
