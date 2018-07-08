From: hofrat@osadl.org (Nicholas Mc Guire)
Date: Sun,  8 Jul 2018 10:32:54 +0200
Subject: [PATCH] ARM: imx: flag failure of of_iomap
Message-ID: <1531038774-24657-1-git-send-email-hofrat@osadl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 imx_set_aips is assuming that the address returned from of_iomap is
valid which it probably is in the normal case - as the call site
is void error propagation is not possible but never the less at least
a WARN_ON() seems warranted here.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: commit e57e4ab5fc2e ("ARM: i.MX: allow disabling supervisor protect via DT")
---

Problem found by experimental coccinelle script

Patch was compiletested with: multi_v7_defconfig

Patch is against 4.18-rc3 (localversion-next is next-20180706)

 arch/arm/mach-imx/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/cpu.c b/arch/arm/mach-imx/cpu.c
index 32969f3..c6b1bf9 100644
--- a/arch/arm/mach-imx/cpu.c
+++ b/arch/arm/mach-imx/cpu.c
@@ -68,6 +68,7 @@ void __init imx_aips_allow_unprivileged_access(
 
 	for_each_compatible_node(np, NULL, compat) {
 		aips_base_addr = of_iomap(np, 0);
+		WARN_ON(!aips_base_addr);
 		imx_set_aips(aips_base_addr);
 	}
 }
-- 
2.1.4
