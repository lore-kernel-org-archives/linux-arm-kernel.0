From: gregkh@linuxfoundation.org (gregkh at linuxfoundation.org)
Date: Sat, 28 Jul 2018 12:07:36 +0200
Subject: Patch "soc: imx: gpcv2: Do not pass static memory as platform data"
 has been added to the 4.14-stable tree
Message-ID: <153277245624741@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This is a note to let you know that I've just added the patch titled

    soc: imx: gpcv2: Do not pass static memory as platform data

to the 4.14-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     soc-imx-gpcv2-do-not-pass-static-memory-as-platform-data.patch
and it can be found in the queue-4.14 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


>From foo at baz Sat Jul 28 10:25:26 CEST 2018
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Tue, 10 Apr 2018 11:32:09 -0700
Subject: soc: imx: gpcv2: Do not pass static memory as platform data

From: Andrey Smirnov <andrew.smirnov@gmail.com>

[ Upstream commit 050f810e238f268670f14a8f8b793ba2dbf2e92f ]

Platform device core assumes the ownership of dev.platform_data as
well as that it is dynamically allocated and it will try to kfree it
as a part of platform_device_release(). Change the code to use
platform_device_add_data() n instead of a pointer to a static memory
to avoid causing a BUG() when calling platform_device_put().

The problem can be reproduced by artificially enabling the error path
of platform_device_add() call (around line 357).

Note that this change also allows us to constify imx7_pgc_domains,
since we no longer need to be able to modify it.

Cc: Stefan Agner <stefan@agner.ch>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/soc/imx/gpcv2.c |   22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -155,7 +155,7 @@ static int imx7_gpc_pu_pgc_sw_pdn_req(st
 	return imx7_gpc_pu_pgc_sw_pxx_req(genpd, false);
 }
 
-static struct imx7_pgc_domain imx7_pgc_domains[] = {
+static const struct imx7_pgc_domain imx7_pgc_domains[] = {
 	[IMX7_POWER_DOMAIN_MIPI_PHY] = {
 		.genpd = {
 			.name      = "mipi-phy",
@@ -321,11 +321,6 @@ static int imx_gpcv2_probe(struct platfo
 			continue;
 		}
 
-		domain = &imx7_pgc_domains[domain_index];
-		domain->regmap = regmap;
-		domain->genpd.power_on  = imx7_gpc_pu_pgc_sw_pup_req;
-		domain->genpd.power_off = imx7_gpc_pu_pgc_sw_pdn_req;
-
 		pd_pdev = platform_device_alloc("imx7-pgc-domain",
 						domain_index);
 		if (!pd_pdev) {
@@ -334,7 +329,20 @@ static int imx_gpcv2_probe(struct platfo
 			return -ENOMEM;
 		}
 
-		pd_pdev->dev.platform_data = domain;
+		ret = platform_device_add_data(pd_pdev,
+					       &imx7_pgc_domains[domain_index],
+					       sizeof(imx7_pgc_domains[domain_index]));
+		if (ret) {
+			platform_device_put(pd_pdev);
+			of_node_put(np);
+			return ret;
+		}
+
+		domain = pd_pdev->dev.platform_data;
+		domain->regmap = regmap;
+		domain->genpd.power_on  = imx7_gpc_pu_pgc_sw_pup_req;
+		domain->genpd.power_off = imx7_gpc_pu_pgc_sw_pdn_req;
+
 		pd_pdev->dev.parent = dev;
 		pd_pdev->dev.of_node = np;
 


Patches currently in stable-queue which might be from andrew.smirnov at gmail.com are

queue-4.14/soc-imx-gpcv2-do-not-pass-static-memory-as-platform-data.patch
