From: balbi@ti.com (Felipe Balbi)
Date: Tue, 19 Feb 2013 12:24:23 +0200
Subject: [PATCH 1/2] arm: omap2: mux: fix debugfs file permission
Message-ID: <1361269464-20263-1-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OMAP's debugfs interface creates one file
for each signal in the mux table, such file
provides a read method but didn't provide
read permission. Fix it.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/mux.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 6a217c9..03fa4f4 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -739,8 +739,9 @@ static void __init omap_mux_dbg_create_entry(
 	list_for_each_entry(e, &partition->muxmodes, node) {
 		struct omap_mux *m = &e->mux;
 
-		(void)debugfs_create_file(m->muxnames[0], S_IWUSR, mux_dbg_dir,
-					  m, &omap_mux_dbg_signal_fops);
+		(void)debugfs_create_file(m->muxnames[0], S_IWUSR | S_IRUGO,
+					  mux_dbg_dir, m,
+					  &omap_mux_dbg_signal_fops);
 	}
 }
 
-- 
1.8.1.rc1.5.g7e0651a
