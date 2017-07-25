From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 25 Jul 2017 17:20:09 +0100
Subject: [PATCH] scripts/dtc: fix '%zx' warning
Message-ID: <E1da2Z7-0008GG-AV@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dtc uses an incorrect format specifier for printing a uint64_t value.
uint64_t may be either 'unsigned long' or 'unsigned long long' depending
on the host architecture.

Fix this by using %llx and casting to unsigned long long, which ensures
that we always have a wide enough variable to print 64 bits of hex.

  HOSTCC  scripts/dtc/checks.o
scripts/dtc/checks.c: In function 'check_simple_bus_reg':
scripts/dtc/checks.c:876:2: warning: format '%zx' expects argument of type 'size_t', but argument 4 has type 'uint64_t' [-Wformat=]
  snprintf(unit_addr, sizeof(unit_addr), "%zx", reg);
  ^
scripts/dtc/checks.c:876:2: warning: format '%zx' expects argument of type 'size_t', but argument 4 has type 'uint64_t' [-Wformat=]

Fixes: 828d4cdd012c ("dtc: check.c fix compile error")
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 scripts/dtc/checks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

I've been carrying this patch for some time, but I guess hardly anyone
builds DT based kernels on 32-bit x86 boxes anymore as it has remained
unfixed.

diff --git a/scripts/dtc/checks.c b/scripts/dtc/checks.c
index 4b72b530c84f..62ea8f83d4a0 100644
--- a/scripts/dtc/checks.c
+++ b/scripts/dtc/checks.c
@@ -873,7 +873,7 @@ static void check_simple_bus_reg(struct check *c, struct dt_info *dti, struct no
 	while (size--)
 		reg = (reg << 32) | fdt32_to_cpu(*(cells++));
 
-	snprintf(unit_addr, sizeof(unit_addr), "%zx", reg);
+	snprintf(unit_addr, sizeof(unit_addr), "%llx", (unsigned long long)reg);
 	if (!streq(unitname, unit_addr))
 		FAIL(c, dti, "Node %s simple-bus unit address format error, expected \"%s\"",
 		     node->fullpath, unit_addr);
-- 
2.7.4
