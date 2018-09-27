From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 27 Sep 2018 12:27:11 -0700
Subject: [PATCH 3/3] soc: bcm: brcmstb: Fix re-entry point with a THUMB2_KERNEL
In-Reply-To: <20180927192711.26455-1-f.fainelli@gmail.com>
References: <20180927192711.26455-1-f.fainelli@gmail.com>
Message-ID: <20180927192711.26455-4-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the kernel is built with CONFIG_THUMB2_KERNEL we would set the
kernel's resume entry point to be a function that is already built as
Thumb-2 code while the boot agent doing the resume is in ARM mode, so
this does not work. There is a header label defined: cpu_resume_arm
which we can use to do the switching for us.

Fixes: 0b741b8234c8 ("soc: bcm: brcmstb: Add support for S2/S3/S5 suspend states (ARM)")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/soc/bcm/brcmstb/pm/pm-arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/bcm/brcmstb/pm/pm-arm.c b/drivers/soc/bcm/brcmstb/pm/pm-arm.c
index a5577dd5eb08..8ee06347447c 100644
--- a/drivers/soc/bcm/brcmstb/pm/pm-arm.c
+++ b/drivers/soc/bcm/brcmstb/pm/pm-arm.c
@@ -404,7 +404,7 @@ noinline int brcmstb_pm_s3_finish(void)
 {
 	struct brcmstb_s3_params *params = ctrl.s3_params;
 	dma_addr_t params_pa = ctrl.s3_params_pa;
-	phys_addr_t reentry = virt_to_phys(&cpu_resume);
+	phys_addr_t reentry = virt_to_phys(&cpu_resume_arm);
 	enum bsp_initiate_command cmd;
 	u32 flags;
 
-- 
2.17.1
