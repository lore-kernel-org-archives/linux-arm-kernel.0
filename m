From: tom.leiming@gmail.com (Ming Lei)
Date: Fri, 16 Dec 2011 21:24:25 +0800
Subject: [QUESTION] How to set static/dynamic dependency between clock domains
Message-ID: <CACVXFVMe7T2WJiDwc9DFz9ifUPQG4pcYzFtx6O=gs7pFgrkNJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I found that face detection module(fdif) can't be enabled successfully
without the
change in [1].

Looks like it is not a good way to do it because the dynamic dependency of
CD_CAM on l3_2 is disabled at default, not like other ones, so I guess that
it may work if the dynamic dependency is enabled by setting bit L3_2_DYNDEP
to CM_CAM_DYNAMICDEP.  After greping over arch/arm/mach-omap2 and
arch/arm/plat-omap, I did not find any operations on CM_*_DYNAMICDEP
register, so I am wondering if dynamic dependency is not used on omap4 at all
now.

Also I have tried to add 'l3_2_clkdm' into dependency table of iss_clkdm in [2],
and it doesn't work.

How could I cope with the clock domain dependency so that fdif can be
enabled successfully?


thanks,--?Ming Lei
[1], add static dependency
diff --git a/arch/arm/mach-omap2/pm44xx.c
b/arch/arm/mach-omap2/pm44xx.cindex c264ef7..23e1f8c 100644---
a/arch/arm/mach-omap2/pm44xx.c+++ b/arch/arm/mach-omap2/pm44xx.c@@
-198,6 +198,7 @@ static int __init omap4_pm_init(void)?	int ret;
	struct clockdomain *emif_clkdm, *mpuss_clkdm, *l3_1_clkdm;?	struct
clockdomain *ducati_clkdm, *l3_2_clkdm, *l4_per_clkdm;+	struct
clockdomain *iss_clkdm;??	if (!cpu_is_omap44xx())?		return -ENODEV;@@
-227,8 +228,10 @@ static int __init omap4_pm_init(void)?	l3_2_clkdm =
clkdm_lookup("l3_2_clkdm");?	l4_per_clkdm =
clkdm_lookup("l4_per_clkdm");?	ducati_clkdm =
clkdm_lookup("ducati_clkdm");+	iss_clkdm = clkdm_lookup("iss_clkdm");
	if ((!mpuss_clkdm) || (!emif_clkdm) || (!l3_1_clkdm)
||-		(!l3_2_clkdm) || (!ducati_clkdm) ||
(!l4_per_clkdm))+		(!l3_2_clkdm) || (!ducati_clkdm) || (!l4_per_clkdm)
||+		(!iss_clkdm))?		goto err2;??	ret = clkdm_add_wkdep(mpuss_clkdm,
emif_clkdm);@@ -237,6 +240,7 @@ static int __init omap4_pm_init(void)
	ret |= clkdm_add_wkdep(mpuss_clkdm, l4_per_clkdm);?	ret |=
clkdm_add_wkdep(ducati_clkdm, l3_1_clkdm);?	ret |=
clkdm_add_wkdep(ducati_clkdm, l3_2_clkdm);+	ret |=
clkdm_add_wkdep(iss_clkdm, l3_2_clkdm);?	if (ret) {?		pr_err("Failed
to add MPUSS -> L3/EMIF/L4PER, DUCATI -> L3 "?				"wakeup
dependency\n");
[2],

diff --git a/arch/arm/mach-omap2/clockdomains44xx_data.c
b/arch/arm/mach-omap2/clockdomains44xx_data.c
index 9299ac2..3f8f6a9 100644
--- a/arch/arm/mach-omap2/clockdomains44xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains44xx_data.c
@@ -65,6 +65,7 @@ static struct clkdm_dep ducati_wkup_sleep_deps[] = {
 static struct clkdm_dep iss_wkup_sleep_deps[] = {
        { .clkdm_name = "ivahd_clkdm" },
        { .clkdm_name = "l3_1_clkdm" },
+       { .clkdm_name = "l3_2_clkdm" },
        { .clkdm_name = "l3_emif_clkdm" },
        { NULL },
 };
