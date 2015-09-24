From: tanxiaojun@huawei.com (Tan Xiaojun)
Date: Thu, 24 Sep 2015 11:27:47 +0800
Subject: [PATCH RESEND] CMA: fix CONFIG_CMA_SIZE_MBYTES overflow in 64bit
Message-ID: <1443065267-97873-1-git-send-email-tanxiaojun@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In 64bit system, if you set CONFIG_CMA_SIZE_MBYTES>=2048, it will
overflow and size_bytes will be a big wrong number.

Set CONFIG_CMA_SIZE_MBYTES=2048 and you will get an info below
during system boot:

*********
cma: Failed to reserve 17592186042368 MiB
*********

Signed-off-by: Tan Xiaojun <tanxiaojun@huawei.com>
---
 drivers/base/dma-contiguous.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/dma-contiguous.c b/drivers/base/dma-contiguous.c
index 950fff9..426ba27 100644
--- a/drivers/base/dma-contiguous.c
+++ b/drivers/base/dma-contiguous.c
@@ -46,7 +46,7 @@ struct cma *dma_contiguous_default_area;
  * Users, who want to set the size of global CMA area for their system
  * should use cma= kernel parameter.
  */
-static const phys_addr_t size_bytes = CMA_SIZE_MBYTES * SZ_1M;
+static const phys_addr_t size_bytes = (phys_addr_t)CMA_SIZE_MBYTES * SZ_1M;
 static phys_addr_t size_cmdline = -1;
 static phys_addr_t base_cmdline;
 static phys_addr_t limit_cmdline;
-- 
1.7.9.5
