From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 18 Apr 2014 14:19:49 +0200
Subject: [PATCH 3/7] irqchip: armada-370-xp: Fix releasing of MSIs
In-Reply-To: <1397823593-1932-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397823593-1932-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1397823593-1932-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Neil Greatorex <neil@fatboyfat.co.uk>

Store the value of d->hwirq in a local variable as the real value is wiped out
by calling irq_dispose_mapping. Without this patch, the armada_370_xp_free_msi
function would always free MSI#0, no matter what was passed to it.

Fixes: 31f614edb726fcc4d5aa0f2895fbdec9b04a3ca4 ('irqchip: armada-370-xp: implement MSI support')
Cc: <stable@vger.kernel.org> # v3.13+
Signed-off-by: Neil Greatorex <neil@fatboyfat.co.uk>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/irqchip/irq-armada-370-xp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index 78b0ac9..868d11b 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -158,8 +158,10 @@ static void armada_370_xp_teardown_msi_irq(struct msi_chip *chip,
 					   unsigned int irq)
 {
 	struct irq_data *d = irq_get_irq_data(irq);
+	unsigned long hwirq = d->hwirq;
+
 	irq_dispose_mapping(irq);
-	armada_370_xp_free_msi(d->hwirq);
+	armada_370_xp_free_msi(hwirq);
 }
 
 static int armada_370_xp_check_msi_device(struct msi_chip *chip, struct pci_dev *dev,
-- 
1.9.2
