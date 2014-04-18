From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 18 Apr 2014 14:19:47 +0200
Subject: [PATCH 1/7] irqchip: armada-370-xp: fix invalid cast of signed value
 into unsigned variable
In-Reply-To: <1397823593-1932-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397823593-1932-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1397823593-1932-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The armada_370_xp_alloc_msi() function returns a signed int, which is
negative on error. However, we store the return value into an
irq_hw_number_t, which is unsigned. Therefore, we actually never test
if armada_370_xp_alloc_msi() returns an error or not, which may lead
us to use hwirq numbers of as 0xffffffe4 (when
armada_370_xp_alloc_msi() returns -ENOSPC).

This commit fixes that by storing the return value of
armada_370_xp_alloc_msi() in a signed variable.

Fixes: 31f614edb726fcc4d5aa0f2895fbdec9b04a3ca4 ('irqchip: armada-370-xp: implement MSI support')
Cc: <stable@vger.kernel.org> # v3.13+
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Tested-by: Neil Greatorex <neil@fatboyfat.co.uk>
---
 drivers/irqchip/irq-armada-370-xp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index 41be897..3c8d89b 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -132,8 +132,7 @@ static int armada_370_xp_setup_msi_irq(struct msi_chip *chip,
 				       struct msi_desc *desc)
 {
 	struct msi_msg msg;
-	irq_hw_number_t hwirq;
-	int virq;
+	int virq, hwirq;
 
 	hwirq = armada_370_xp_alloc_msi();
 	if (hwirq < 0)
-- 
1.9.2
