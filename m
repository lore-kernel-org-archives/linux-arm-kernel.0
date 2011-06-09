From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 08 Jun 2011 21:40:47 -0400 (EDT)
Subject: [PATCH] ARM: DT: don't try to access physical address zero
Message-ID: <alpine.LFD.2.00.1106082138420.2142@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Pitre <nicolas.pitre@linaro.org>

If the DT physical address is zero, this is equivalent to no DT.
Especially when the actual RAM physical address is not located at zero,
the result of phys_to_virt() would point to la-la-land and crash the
kernel, which crash is completely silent this early during boot.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
CC: Grant Likely <grant.likely@secretlab.ca>
---
diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index a701e42..0cdd7b4 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -76,6 +76,9 @@ struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
 	unsigned long dt_root;
 	const char *model;
 
+	if (!dt_phys)
+		return NULL;
+
 	devtree = phys_to_virt(dt_phys);
 
 	/* check device tree validity */
