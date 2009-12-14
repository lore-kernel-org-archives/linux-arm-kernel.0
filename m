From: jpihet@mvista.com (Jean Pihet)
Date: Mon, 14 Dec 2009 12:40:11 +0100
Subject: [PATCH] ARMv7: fix Oprofile events count
Message-ID: <1260790811.8106.2.camel@def-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is a patch that fixes the oprofile events count.
If it is OK I will submit it to the patch system.

Any thought?

Regards,
Jean

---
ARMv7: fix Oprofile events count
    
    On Oprofile ARMv7 the PMNC_D bit was set to lower the PMU IRQs
    and so to decrease the risk of errata #628216 from appearing.
    The effect of setting the PMNC_D bit is that the CCNT counter
    is divided by 64, making the program counter events count
    inaccurate.
    The new OMAP3 r4 cores should have that errata fixed.
    
    The PMNC_D bit should not be set, this patch fixes it.
    
    Signed-off-by: Jean Pihet <jpihet@mvista.com>

diff --git a/arch/arm/oprofile/op_model_v7.c
b/arch/arm/oprofile/op_model_v7.c
index f20295f..2088a6c 100644
--- a/arch/arm/oprofile/op_model_v7.c
+++ b/arch/arm/oprofile/op_model_v7.c
@@ -191,12 +191,8 @@ int armv7_setup_pmnc(void)
                return -EBUSY;
        }
 
-       /*
-        * Initialize & Reset PMNC: C bit, D bit and P bit.
-        *  Note: Using a slower count for CCNT (D bit: divide by 64)
results
-        *   in a more stable system
-        */
-       armv7_pmnc_write(PMNC_P | PMNC_C | PMNC_D);
+       /* Initialize & Reset PMNC: C bit and P bit */
+       armv7_pmnc_write(PMNC_P | PMNC_C);
 
 
        for (cnt = CCNT; cnt < CNTMAX; cnt++) {
