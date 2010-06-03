From: ext-phil.2.carmody@nokia.com (Phil Carmody)
Date: Thu,  3 Jun 2010 15:17:22 +0300
Subject: [PATCH 3/3] ARM: module - additional unwind tables for exit/devexit
	sections
In-Reply-To: <1275567442-11370-3-git-send-email-ext-phil.2.carmody@nokia.com>
References: <1275567442-11370-1-git-send-email-ext-phil.2.carmody@nokia.com>
	<1275567442-11370-2-git-send-email-ext-phil.2.carmody@nokia.com>
	<1275567442-11370-3-git-send-email-ext-phil.2.carmody@nokia.com>
Message-ID: <1275567442-11370-4-git-send-email-ext-phil.2.carmody@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without these, exit functions cannot be stack-traced, so to speak.
This implies that module unloads that perform allocations (don't
laugh) will cause noisy warnings on the console when kmemleak is
enabled, as it presumes that all code's call chains are traceable.
Similarly, BUGs and WARN_ONs will give additional console spam.

Signed-off-by: Phil Carmody <ext-phil.2.carmody@nokia.com>
---
 arch/arm/include/asm/module.h |    2 ++
 arch/arm/kernel/module.c      |    8 ++++++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/module.h b/arch/arm/include/asm/module.h
index 2164061..fcff0d2 100644
--- a/arch/arm/include/asm/module.h
+++ b/arch/arm/include/asm/module.h
@@ -17,6 +17,8 @@ enum {
 	ARM_SEC_INIT,
 	ARM_SEC_DEVINIT,
 	ARM_SEC_CORE,
+	ARM_SEC_EXIT,
+	ARM_SEC_DEVEXIT,
 	ARM_SEC_MAX,
 };
 struct mod_arch_specific {
diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index bcf928e..8eaff1c 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -80,12 +80,20 @@ int module_frob_arch_sections(Elf_Ehdr *hdr,
 			maps[ARM_SEC_DEVINIT].unw_sec = s;
 		else if (strcmp(".ARM.exidx", secname) == 0)
 			maps[ARM_SEC_CORE].unw_sec = s;
+		else if (strcmp(".ARM.exidx.exit.text", secname) == 0)
+			maps[ARM_SEC_EXIT].unw_sec = s;
+		else if (strcmp(".ARM.exidx.devexit.text", secname) == 0)
+			maps[ARM_SEC_DEVEXIT].unw_sec = s;
 		else if (strcmp(".init.text", secname) == 0)
 			maps[ARM_SEC_INIT].sec_text = s;
 		else if (strcmp(".devinit.text", secname) == 0)
 			maps[ARM_SEC_DEVINIT].sec_text = s;
 		else if (strcmp(".text", secname) == 0)
 			maps[ARM_SEC_CORE].sec_text = s;
+		else if (strcmp(".exit.text", secname) == 0)
+			maps[ARM_SEC_EXIT].sec_text = s;
+		else if (strcmp(".devexit.text", secname) == 0)
+			maps[ARM_SEC_DEVEXIT].sec_text = s;
 	}
 #endif
 	return 0;
-- 
1.6.0.4
