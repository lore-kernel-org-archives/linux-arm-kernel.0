From: yifan.zhangm@gmail.com (Yifan Zhang)
Date: Thu, 16 Oct 2014 17:19:43 +0800
Subject: [PATCH] arm64: mm: use macro instead of if judgement of ZONE_DMA
Message-ID: <CAGZxSSRsYYNURnVB1fpGSTMA7WJMdy=Cmt1pj0Q=69ahHEsO1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

if disable CONFIG_ZONE_DMA, ZONE_DMA becomes undefined.



Signed-off-by: Yifan Zhang <zhangyf@marvell.com>

---

 arch/arm64/mm/init.c |   12 +++++++-----

 1 file changed, 7 insertions(+), 5 deletions(-)



diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c index
494297c..887ca5d 100644

--- a/arch/arm64/mm/init.c

+++ b/arch/arm64/mm/init.c

@@ -82,10 +82,10 @@ static void __init zone_sizes_init(unsigned long
min, unsigned long max)

        memset(zone_size, 0, sizeof(zone_size));



        /* 4GB maximum for 32-bit only capable devices */

-        if (IS_ENABLED(CONFIG_ZONE_DMA)) {

-                 max_dma = PFN_DOWN(max_zone_dma_phys());

-                 zone_size[ZONE_DMA] = max_dma - min;

-        }

+#ifdef CONFIG_ZONE_DMA

+       max_dma = PFN_DOWN(max_zone_dma_phys());

+       zone_size[ZONE_DMA] = max_dma - min;

+#endif

        zone_size[ZONE_NORMAL] = max - max_dma;



       memcpy(zhole_size, zone_size, sizeof(zhole_size)); @@ -97,10
+97,12 @@ static void __init zone_sizes_init(unsigned long min,
unsigned long max)

                 if (start >= max)

                           continue;



-                 if (IS_ENABLED(CONFIG_ZONE_DMA) && start < max_dma) {

+#ifdef CONFIG_ZONE_DMA

+                if (start < max_dma) {

                           unsigned long dma_end = min(end, max_dma);

                           zhole_size[ZONE_DMA] -= dma_end - start;

                 }

+#endif



                 if (end > max_dma) {

                           unsigned long normal_end = min(end, max);

--

1.7.9.5
