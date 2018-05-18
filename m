From: bp@alien8.de (Borislav Petkov)
Date: Fri, 18 May 2018 13:20:28 +0200
Subject: [PATCH] EDAC, ghes: Make platform-based whitelisting x86-only
In-Reply-To: <20180518111132.GC17285@pd.tnic>
References: <1526039543-180996-1-git-send-email-zhengqiang10@huawei.com>
 <20180511121901.GA12705@pd.tnic> <5AF90C70.408@huawei.com>
 <20180514094709.GC23049@pd.tnic>
 <cb24735c-d251-4dd2-a02f-91e476776824@arm.com>
 <20180514164720.GH23049@pd.tnic>
 <da776696-ddbf-c35e-1dd4-b6e0ce91aed6@arm.com>
 <20180516182958.GB17092@pd.tnic>
 <8602b133-e0fa-57e2-5159-9d34a1ded85f@arm.com>
 <20180518111132.GC17285@pd.tnic>
Message-ID: <20180518112028.GD17285@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Borislav Petkov <bp@suse.de>

ARM machines all have DMI tables so if they request hw error reporting
through GHES, then the driver should be able to detect DIMMs and report
errors successfully (famous last words :)).

Make the platform-based list x86-specific so that ghes_edac can load on
ARM.

Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: James Morse <james.morse@arm.com>
Tested-by: James Morse <james.morse@arm.com>
Cc: Qiang Zheng <zhengqiang10@huawei.com>
Link: https://lkml.kernel.org/r/1526039543-180996-1-git-send-email-zhengqiang10 at huawei.com
---
 drivers/edac/ghes_edac.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 863fbf3db29f..473aeec4b1da 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -440,12 +440,16 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 	struct mem_ctl_info *mci;
 	struct edac_mc_layer layers[1];
 	struct ghes_edac_dimm_fill dimm_fill;
-	int idx;
+	int idx = -1;
 
-	/* Check if safe to enable on this system */
-	idx = acpi_match_platform_list(plat_list);
-	if (!force_load && idx < 0)
-		return -ENODEV;
+	if (IS_ENABLED(CONFIG_X86)) {
+		/* Check if safe to enable on this system */
+		idx = acpi_match_platform_list(plat_list);
+		if (!force_load && idx < 0)
+			return -ENODEV;
+	} else {
+		idx = 0;
+	}
 
 	/*
 	 * We have only one logical memory controller to which all DIMMs belong.
-- 
2.17.0.391.g1f1cddd558b5


-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
