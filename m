From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Wed, 29 Nov 2017 21:47:13 +0530
Subject: [PATCH 4/5 v4] ASoC: intel: sst: Handle return value of
 platform_get_irq
In-Reply-To: <4ce907b8389af30eb0677e70cf543a2b795cca12.1511970158.git.arvind.yadav.cs@gmail.com>
References: <4ce907b8389af30eb0677e70cf543a2b795cca12.1511970158.git.arvind.yadav.cs@gmail.com>
Message-ID: <deb09b18d95f81661dbb8136fec947a548af6a77.1511970158.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

platform_get_irq() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes in v2 :
              Add failure case '<= 0' instead of '< 0'. IRQ0 is not valid.
changes in v3 :
              Return -EIO insted of ctx->irq_num.
changes in v4 :
              Add separate error for irq == 0 and irq < 0.

 sound/soc/intel/atom/sst/sst_acpi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index 0e928d5..aec7408 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -236,6 +236,9 @@ static int sst_platform_get_resources(struct intel_sst_drv *ctx)
 	/* Find the IRQ */
 	ctx->irq_num = platform_get_irq(pdev,
 				ctx->pdata->res_info->acpi_ipc_irq_index);
+	if (ctx->irq_num <= 0)
+		return ctx->irq_num < 0 ? ctx->irq_num : -EIO;
+
 	return 0;
 }
 
-- 
2.7.4
