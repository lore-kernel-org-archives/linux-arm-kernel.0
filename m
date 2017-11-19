From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Sun, 19 Nov 2017 09:45:03 +0530
Subject: [PATCH 4/5 v3] ASoC: intel: sst: Handle return value of
 platform_get_irq
In-Reply-To: <082d4479211d425219f4ab275ecc12e1011eca2f.1511062844.git.arvind.yadav.cs@gmail.com>
References: <082d4479211d425219f4ab275ecc12e1011eca2f.1511062844.git.arvind.yadav.cs@gmail.com>
Message-ID: <ab173ba649ad4990ec95c10ccb455a495b6b8651.1511062844.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

platform_get_irq() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes in v2 :
              Add failure case '<= 0' instead of '< 0'. IRQ0 is not valid.
changes in v3 :
              Return EIO insted of ctx->irq_num.

 sound/soc/intel/atom/sst/sst_acpi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index 32d6e02..5e46d06f 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -236,6 +236,9 @@ static int sst_platform_get_resources(struct intel_sst_drv *ctx)
 	/* Find the IRQ */
 	ctx->irq_num = platform_get_irq(pdev,
 				ctx->pdata->res_info->acpi_ipc_irq_index);
+	if (ctx->irq_num <= 0)
+		return -EIO;
+
 	return 0;
 }
 
-- 
2.7.4
