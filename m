From: Dave.Martin@arm.com (Dave Martin)
Date: Wed,  9 Oct 2013 15:29:53 +0100
Subject: [RFC PATCH 4/4] drivers/bus: arm-cci: Fix CCI enable code for BE32
In-Reply-To: <1381328993-12724-1-git-send-email-Dave.Martin@arm.com>
References: <1381328993-12724-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1381328993-12724-5-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CCI control registers are always little-endian.

This patch ensures that data is transferred to/from those registers
using the correct byte order in the low-level asm code of
cci_enable_port_for_self().

This is required for CCI to work correctly with BE8 kernels.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 drivers/bus/arm-cci.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index 2009266..b205a97 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -20,11 +20,13 @@
 #include <linux/of_address.h>
 #include <linux/slab.h>
 
+#include <asm/assembler.h>
 #include <asm/cacheflush.h>
 #include <asm/smp_plat.h>
 
 #define CCI_PORT_CTRL		0x0
 #define CCI_CTRL_STATUS		0xc
+#define CCI_CHANGE_PENDING	(1 << 0)	/* change pending in CCI_CTRL_STATUS */
 
 #define CCI_ENABLE_SNOOP_REQ	0x1
 #define CCI_ENABLE_DVM_REQ	0x2
@@ -280,7 +282,7 @@ asmlinkage void __naked cci_enable_port_for_self(void)
 
 	/* Enable the CCI port */
 "	ldr	r0, [r0, %[offsetof_port_phys]] \n"
-"	mov	r3, #"__stringify(CCI_ENABLE_REQ)" \n"
+"	mov	r3, #"__asm_cpu_to_le32(__stringify(CCI_ENABLE_REQ))" \n"
 "	str	r3, [r0, #"__stringify(CCI_PORT_CTRL)"] \n"
 
 	/* poll the status reg for completion */
@@ -288,7 +290,7 @@ asmlinkage void __naked cci_enable_port_for_self(void)
 "	ldr	r0, [r1] \n"
 "	ldr	r0, [r0, r1]		@ cci_ctrl_base \n"
 "4:	ldr	r1, [r0, #"__stringify(CCI_CTRL_STATUS)"] \n"
-"	tst	r1, #1 \n"
+"	tst	r1, #"__asm_cpu_to_le32(__stringify(CCI_CHANGE_PENDING))" \n"
 "	bne	4b \n"
 
 "	mov	r0, #0 \n"
-- 
1.7.9.5
