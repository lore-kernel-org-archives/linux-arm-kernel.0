From: broonie@kernel.org (Mark Brown)
Date: Fri, 01 Dec 2017 13:44:00 +0000
Subject: Applied "ASoC: intel: sst: Handle return value of platform_get_irq"
 to the asoc tree
In-Reply-To: <deb09b18d95f81661dbb8136fec947a548af6a77.1511970158.git.arvind.yadav.cs@gmail.com>
Message-ID: <E1eKlbk-0001HK-3L@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: intel: sst: Handle return value of platform_get_irq

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From eee44bfcf931428d7e94a9ae2092d687386a135a Mon Sep 17 00:00:00 2001
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Wed, 29 Nov 2017 21:47:13 +0530
Subject: [PATCH] ASoC: intel: sst: Handle return value of platform_get_irq

platform_get_irq() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/atom/sst/sst_acpi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index 32d6e02e2104..6cd481bec275 100644
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
2.15.0
