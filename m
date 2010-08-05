From: kmpark@infradead.org (Kyungmin Park)
Date: Thu, 05 Aug 2010 16:25:38 +0900
Subject: [PATCH 2/5] ARM: Samsung: Introduce group field for GPIOs
Message-ID: <20100805072538.GA22266@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

The GPIOs are consisted of several groups at Samsung SoCs.
Basically GPIOs support interrupt feature but some GPISs don't support.
In case of external interrupt it's alive at any case and support wakeup feature.

Using group field it can assign the group number.
e.g., GPA0 has group 0. GPA1 has group 1, and so on.
On the other hand, GPH0 will start with group 0 in case of external interrupt.

With this group field, it can calculate the gpio offset and interrupt number easily.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/plat-samsung/include/plat/gpio-core.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/gpio-core.h b/arch/arm/plat-samsung/include/plat/gpio-core.h
index e358c7d..56aa136 100644
--- a/arch/arm/plat-samsung/include/plat/gpio-core.h
+++ b/arch/arm/plat-samsung/include/plat/gpio-core.h
@@ -45,6 +45,7 @@ struct s3c_gpio_cfg;
  * @base: The base pointer to the gpio configuration registers.
  * @config: special function and pull-resistor control information.
  * @lock: Lock for exclusive access to this gpio bank.
+ * @group: The interrupt group number either GPIO or external
  * @pm_save: Save information for suspend/resume support.
  *
  * This wrapper provides the necessary information for the Samsung
@@ -64,6 +65,7 @@ struct s3c_gpio_chip {
 	struct s3c_gpio_pm	*pm;
 	void __iomem		*base;
 	spinlock_t		 lock;
+	int			group;
 #ifdef CONFIG_PM
 	u32			pm_save[4];
 #endif
-- 
1.5.3.3
