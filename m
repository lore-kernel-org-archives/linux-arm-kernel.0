From: thomas@m3y3r.de (Thomas Meyer)
Date: Sat, 18 Nov 2017 14:37:32 +0100
Subject: Relevant for 3.18.x?
Message-ID: <20171118133732.mimo2u6vubut34ql@olymp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I played around a bit with the source code of the linux version running on
my phone and I stumbled upon this patch and I wanted to ask if this
patch is maybe also relevant for linux-stable 3.18.x?

commit 6a5e04b6af54fdea2a8b5815f18632d74da471b2
Author: Stepan Moskovchenko <stepanm@codeaurora.org>
Date:   Wed May 14 16:51:06 2014 -0700

    arm64: Call EDAC error handler on system error
    
    One possible cause of a system error exception is an ECC
    error in the CPU's caches. Call the ARM64 EDAC error
    handler from the system error exception handler to print
    EDAC error syndrome information to the kernel log.
    
    Change-Id: If8757eda0c7fc82b0fccee573cf09627a752fdf3
    Signed-off-by: Stepan Moskovchenko <stepanm@codeaurora.org>

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 605f8249325d..ec0d4b22e91e 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -37,6 +37,8 @@
 #include <asm/stacktrace.h>
 #include <asm/exception.h>
 #include <asm/system_misc.h>
+#include <asm/esr.h>
+#include <asm/edac.h>
 
 #include <trace/events/exception.h>
 
@@ -442,6 +444,12 @@ asmlinkage void bad_mode(struct pt_regs *regs, int reason, unsigned int esr)
 	info.si_code  = ILL_ILLOPC;
 	info.si_addr  = pc;
 
+	if (esr >> ESR_EL1_EC_SHIFT == ESR_EL1_EC_SERROR) {
+		pr_crit("System error detected. ESR.ISS = %08x\n",
+			esr & 0xffffff);
+		arm64_check_cache_ecc(NULL);
+	}
+
 	arm64_notify_die("Oops - bad mode", regs, &info, 0);
 }
 
And I just realized while writing this email that master and stable-3.18 seem to completely miss the
cortex EDAC driver:
https://source.codeaurora.org/quic/la/kernel/msm/log/drivers/edac/cortex_arm64_edac.c?h=aosp-new/android-msm-marlin-3.18-oreo

so never mind.

with kind regards
thomas
