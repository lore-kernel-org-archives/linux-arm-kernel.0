From: bp@alien8.de (Borislav Petkov)
Date: Wed, 16 May 2018 20:29:58 +0200
Subject: [PATCH] ghes_edac: enable HIP08 platform edac driver
In-Reply-To: <da776696-ddbf-c35e-1dd4-b6e0ce91aed6@arm.com>
References: <1526039543-180996-1-git-send-email-zhengqiang10@huawei.com>
 <20180511121901.GA12705@pd.tnic> <5AF90C70.408@huawei.com>
 <20180514094709.GC23049@pd.tnic>
 <cb24735c-d251-4dd2-a02f-91e476776824@arm.com>
 <20180514164720.GH23049@pd.tnic>
 <da776696-ddbf-c35e-1dd4-b6e0ce91aed6@arm.com>
Message-ID: <20180516182958.GB17092@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 16, 2018 at 02:38:38PM +0100, James Morse wrote:
> XGene has its own edac driver, but it doesn't probe when booted via ACPI so
> won't conflict with ghes_edac.

Actually it will. EDAC core can have only one EDAC driver loaded. Don't
ask me why - it has been that way since forever. We can change it some
day but frankly, I don't see reasoning for it. One driver can easily
manage *all* error sources on a system, I'd say.

> ... The thing has 4 dimm slots, but only two are populated. I swapped
> them round and the table was regenerated, so I don't think its faking
> it.

Ok.

> So I think we're good to make the whitelist x86 only.
> Your diff-hunk makes 'idx=-1', so we always get the 'Unfortunately' warning. I'd
> like to suppress this unless force_load has been used.

Yeah, we should handle that differently for ARM. Toshi added the idx
thing in

  5deed6b6a479 ("EDAC, ghes: Add platform check")

to dump this when the platform is not whitelisted. So let's do that:

---
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

---

> What is the history behind the fake thing here? It predates 32fa1f53c2d
> "ghes_edac: do a better job of filling EDAC DIMM info", was it to support a
> valid system, or just to ease merging the driver when not all systems had the
> dmi table?

I wouldn't be surprised if there were some, TBH.

Looks to me like it used to fake DIMMs, see

-       /* FIXME: FAKE DATA */
-       dimm->nr_pages = 1000;
-       dimm->grain = 128;
-       dimm->mtype = MEM_UNKNOWN;
-       dimm->dtype = DEV_UNKNOWN;
-       dimm->edac_mode = EDAC_SECDED;

which 32fa1f53c2d removes.

$ git annotate drivers/edac/ghes_edac.c 32fa1f53c2d~1

shows you the driver before the DMI scanning so it looks like initially
it was faking stuff to satisfy EDAC core when it creates sysfs entries
using struct dimm_info descriptors.

> It looks like even the oldest Arm64 ACPI systems have dmi tables, so we can
> probably require DMI or the 'force' flag.

Well, with the hunk above it would still do ghes_edac_count_dimms() on
ARM and if it fails to find something, it will set fake, which is a good
sanity-check as it screams loudly. :)

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
