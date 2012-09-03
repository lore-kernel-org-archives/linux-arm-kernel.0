From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Mon, 3 Sep 2012 20:42:27 +0800
Subject: [PATCH v2] gpio/omap: fix possible memory leak in
 omap2_gpio_dev_init()
Message-ID: <CAPgLHd-XS_AtLr+8R6yNkSXdNxO3i-NapK7o5zBUado-7R99=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

pdata and pdata->regs have been allocated in this function and 
should be freed before leaving it, and in the other error handling
cases too.

spatch with a semantic match is used to found this problem.
(http://coccinelle.lip6.fr/)

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/arm/mach-omap2/gpio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index 9ad7d48..fe626e90 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -60,6 +60,7 @@ static int __init omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 	pdata->regs = kzalloc(sizeof(struct omap_gpio_reg_offs), GFP_KERNEL);
 	if (!pdata->regs) {
 		pr_err("gpio%d: Memory allocation failed\n", id);
+		kfree(pdata);
 		return -ENOMEM;
 	}
 
@@ -121,6 +122,7 @@ static int __init omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 		break;
 	default:
 		WARN(1, "Invalid gpio bank_type\n");
+		kfree(pdata->regs);
 		kfree(pdata);
 		return -EINVAL;
 	}
