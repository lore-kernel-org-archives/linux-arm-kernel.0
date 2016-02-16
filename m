From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 16 Feb 2016 13:52:33 +0100
Subject: [PATCH v6sub1 02/11] of/fdt: factor out assignment of
 initrd_start/initrd_end
In-Reply-To: <1455627162-31600-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1455627162-31600-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1455627162-31600-3-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since architectures may not yet have their linear mapping up and running
when the initrd address is discovered from the DT, factor out the
assignment of initrd_start and initrd_end, so that an architecture can
override it and use the translation it needs.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/of/fdt.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 1f98156f8996..3e90bce70545 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -760,6 +760,16 @@ const void * __init of_flat_dt_match_machine(const void *default_match,
 }
 
 #ifdef CONFIG_BLK_DEV_INITRD
+#ifndef __early_init_dt_declare_initrd
+static void __early_init_dt_declare_initrd(unsigned long start,
+					   unsigned long end)
+{
+	initrd_start = (unsigned long)__va(start);
+	initrd_end = (unsigned long)__va(end);
+	initrd_below_start_ok = 1;
+}
+#endif
+
 /**
  * early_init_dt_check_for_initrd - Decode initrd location from flat tree
  * @node: reference to node containing initrd location ('chosen')
@@ -782,9 +792,7 @@ static void __init early_init_dt_check_for_initrd(unsigned long node)
 		return;
 	end = of_read_number(prop, len/4);
 
-	initrd_start = (unsigned long)__va(start);
-	initrd_end = (unsigned long)__va(end);
-	initrd_below_start_ok = 1;
+	__early_init_dt_declare_initrd(start, end);
 
 	pr_debug("initrd_start=0x%llx  initrd_end=0x%llx\n",
 		 (unsigned long long)start, (unsigned long long)end);
-- 
2.5.0
