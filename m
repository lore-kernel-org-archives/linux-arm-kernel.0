From: zhouqiao@marvell.com (Qiao Zhou)
Date: Tue, 3 Dec 2013 18:43:20 +0800
Subject: Build warning in drivers/dma/mmp_tdma.c
In-Reply-To: <529D4273.10602@gmail.com>
References: <CAPcyv4i1i+3ia5qcYA-LR4TFq1MOCXTHLhW2u5maq6Us9kyATg@mail.gmail.com>
 <CAMj5Bkjk6v_2Op1oph8GGw2mf8w40c-L3JhBRPNsRewiFxQHpw@mail.gmail.com>
 <529C37F3.1040205@marvell.com>
 <CAPcyv4jfk+JBv7WY_njuYtx8hERZHhoCAij=FOfqxAhLJAHnFA@mail.gmail.com>
 <CAMj5Bkjkndq1-AJSm0k9Mm8xeaWEGktoFb6nZ3kr7RackFdcaw@mail.gmail.com>
 <529D4273.10602@gmail.com>
Message-ID: <529DB5C8.1010500@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/03/2013 10:31 AM, Haojian Zhuang wrote:
> I prefer to add CONFIG_MMP_SRAM instead, since sram isn't available in
> pxa168.
Hi Dan,

I have two patches. Could you help check whether it can fix the issue?

BTW, actually the 2nd alone is enough. The 1st patch is just in case 
that you still want to use the old sram driver, and you need to enable 
MMP_SRAM.

All, please help review the patches.

 From 94601015d525db6d2baf47f4d517f38ae2e5e802 Mon Sep 17 00:00:00 2001
From: Qiao Zhou <zhouqiao@marvell.com>
Date: Tue, 3 Dec 2013 11:06:29 +0800
Subject: [PATCH 1/2] arm: mmp: build sram driver alone

sram driver can be used by many chips besides CPU_MMP2, and so build
it alone.

Signed-off-by: Qiao Zhou <zhouqiao@marvell.com>
---
  arch/arm/mach-mmp/Makefile |    3 ++-
  1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mmp/Makefile b/arch/arm/mach-mmp/Makefile
index 9b702a1..98f0f63 100644
--- a/arch/arm/mach-mmp/Makefile
+++ b/arch/arm/mach-mmp/Makefile
@@ -7,7 +7,8 @@ obj-y				+= common.o devices.o time.o
  # SoC support
  obj-$(CONFIG_CPU_PXA168)	+= pxa168.o
  obj-$(CONFIG_CPU_PXA910)	+= pxa910.o
-obj-$(CONFIG_CPU_MMP2)		+= mmp2.o sram.o
+obj-$(CONFIG_CPU_MMP2)		+= mmp2.o
+obj-$(CONFIG_MMP_SRAM)		+= sram.o

  ifeq ($(CONFIG_COMMON_CLK), )
  obj-y				+= clock.o
-- 
1.7.0.4


 From 5396b1bffd574dbe778387979ecc24c51ee0c7a4 Mon Sep 17 00:00:00 2001
From: Qiao Zhou <zhouqiao@marvell.com>
Date: Tue, 3 Dec 2013 18:17:02 +0800
Subject: [PATCH 2/2] dma: mmp-tdma: use gen_pool to get asram

use generic pool to get audio sram, instead of sram driver

Signed-off-by: nhcao <nhcao@marvell.com>
Signed-off-by: Qiao Zhou <zhouqiao@marvell.com>
---
  drivers/dma/Kconfig    |    1 +
  drivers/dma/mmp_tdma.c |   22 +++++++++++++++++-----
  2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index dd2874e..eeffe3c 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -288,6 +288,7 @@ config MMP_TDMA
  	bool "MMP Two-Channel DMA support"
  	depends on ARCH_MMP
  	select DMA_ENGINE
+	select GENERIC_ALLOCATOR
  	help
  	  Support the MMP Two-Channel DMA engine.
  	  This engine used for MMP Audio DMA and pxa910 SQU.
diff --git a/drivers/dma/mmp_tdma.c b/drivers/dma/mmp_tdma.c
index d3b6358..93537d1 100644
--- a/drivers/dma/mmp_tdma.c
+++ b/drivers/dma/mmp_tdma.c
@@ -20,7 +20,7 @@
  #include <linux/platform_device.h>
  #include <linux/device.h>
  #include <mach/regs-icu.h>
-#include <linux/platform_data/dma-mmp_tdma.h>
+#include <linux/genalloc.h>
  #include <linux/of_device.h>

  #include "dmaengine.h"
@@ -121,6 +121,7 @@ struct mmp_tdma_chan {
  	size_t				buf_len;
  	size_t				period_len;
  	size_t				pos;
+	struct gen_pool			*pool;
  };

  #define TDMA_CHANNEL_NUM 2
@@ -296,7 +297,7 @@ static void mmp_tdma_free_descriptor(struct 
mmp_tdma_chan *tdmac)
  	struct gen_pool *gpool;
  	int size = tdmac->desc_num * sizeof(struct mmp_tdma_desc);

-	gpool = sram_get_gpool("asram");
+	gpool = tdmac->pool;
  	if (tdmac->desc_arr)
  		gen_pool_free(gpool, (unsigned long)tdmac->desc_arr,
  				size);
@@ -346,7 +347,7 @@ struct mmp_tdma_desc 
*mmp_tdma_alloc_descriptor(struct mmp_tdma_chan *tdmac)
  	struct gen_pool *gpool;
  	int size = tdmac->desc_num * sizeof(struct mmp_tdma_desc);

-	gpool = sram_get_gpool("asram");
+	gpool = tdmac->pool;
  	if (!gpool)
  		return NULL;

@@ -477,7 +478,8 @@ static int mmp_tdma_remove(struct platform_device *pdev)
  }

  static int mmp_tdma_chan_init(struct mmp_tdma_device *tdev,
-						int idx, int irq, int type)
+					int idx, int irq,
+					int type, struct gen_pool *pool)
  {
  	struct mmp_tdma_chan *tdmac;

@@ -498,6 +500,7 @@ static int mmp_tdma_chan_init(struct mmp_tdma_device 
*tdev,
  	tdmac->chan.device = &tdev->device;
  	tdmac->idx	   = idx;
  	tdmac->type	   = type;
+	tdmac->pool	   = pool;
  	tdmac->reg_base	   = (unsigned long)tdev->base + idx * 4;
  	tdmac->status = DMA_SUCCESS;
  	tdev->tdmac[tdmac->idx] = tdmac;
@@ -525,6 +528,8 @@ static int mmp_tdma_probe(struct platform_device *pdev)
  	int i, ret;
  	int irq = 0, irq_num = 0;
  	int chan_num = TDMA_CHANNEL_NUM;
+	struct device_node *np = pdev->dev.of_node;
+	struct gen_pool *pool;

  	of_id = of_match_device(mmp_tdma_dt_ids, &pdev->dev);
  	if (of_id)
@@ -551,6 +556,13 @@ static int mmp_tdma_probe(struct platform_device *pdev)

  	INIT_LIST_HEAD(&tdev->device.channels);

+	/* Get audio sram from device tree or platform data */
+	pool = of_get_named_gen_pool(np, "asram", 0);
+	if (!pool) {
+		dev_err(&pdev->dev, "asram pool not available\n");
+		return -ENOMEM;
+	}
+
  	if (irq_num != chan_num) {
  		irq = platform_get_irq(pdev, 0);
  		ret = devm_request_irq(&pdev->dev, irq,
@@ -562,7 +574,7 @@ static int mmp_tdma_probe(struct platform_device *pdev)
  	/* initialize channel parameters */
  	for (i = 0; i < chan_num; i++) {
  		irq = (irq_num != chan_num) ? 0 : platform_get_irq(pdev, i);
-		ret = mmp_tdma_chan_init(tdev, i, irq, type);
+		ret = mmp_tdma_chan_init(tdev, i, irq, type, pool);
  		if (ret)
  			return ret;
  	}
-- 
1.7.0.4

-- 

Best Regards
Qiao
