From: lina.iyer@linaro.org (Lina Iyer)
Date: Fri, 26 Jun 2015 21:02:26 -0600
Subject: [PATCH RFC v2 06/16] arm: domain: Make CPU genpd IRQ safe
In-Reply-To: <1435374156-19214-1-git-send-email-lina.iyer@linaro.org>
References: <1435374156-19214-1-git-send-email-lina.iyer@linaro.org>
Message-ID: <1435374156-19214-7-git-send-email-lina.iyer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Generic PM domains that support runtime suspend/resume in IRQ safe
contexts should define GENPD_FLAG_IRQ_SAFE flag for the genpd.

CPUIdle powers off the CPUs in an IRQ safe context and therefore CPU
domains that use CPUIlde for runtime suspend/resume would need to
operate as IRQ safe domains. Define GENPD_FLAG_IRQ_SAFE for CPU domains.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 arch/arm/kernel/domains.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/kernel/domains.c b/arch/arm/kernel/domains.c
index 3248409..a27f825 100644
--- a/arch/arm/kernel/domains.c
+++ b/arch/arm/kernel/domains.c
@@ -90,6 +90,7 @@ static int arm_domain_init(void)
 		pd->genpd.name = kstrdup(np->name, GFP_KERNEL);
 		pd->genpd.power_off = arm_pd_power_down;
 		pd->genpd.power_on = arm_pd_power_up;
+		pd->genpd.flags |= GENPD_FLAG_IRQ_SAFE;
 		platform_set_drvdata(pdev, pd);
 
 		dev_dbg(dev, "adding as generic power domain.\n");
-- 
2.1.4
