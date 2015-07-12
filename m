From: robh@kernel.org (Rob Herring)
Date: Sun, 12 Jul 2015 09:26:43 -0500
Subject: [PATCH v2 05/13] gpu/drm: kill off set_irq_flags usage
In-Reply-To: <1436711211-18223-1-git-send-email-robh@kernel.org>
References: <1436711211-18223-1-git-send-email-robh@kernel.org>
Message-ID: <1436711211-18223-6-git-send-email-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

set_irq_flags is ARM specific with custom flags which have genirq
equivalents. Convert drivers to use the genirq interfaces directly, so we
can kill off set_irq_flags. The translation of flags is as follows:

IRQF_VALID -> !IRQ_NOREQUEST
IRQF_PROBE -> !IRQ_NOPROBE
IRQF_NOAUTOEN -> IRQ_NOAUTOEN

For IRQs managed by an irqdomain, the irqdomain core code handles clearing
and setting IRQ_NOREQUEST already, so there is no need to do this in
.map() functions and we can simply remove the set_irq_flags calls. Some
users also set IRQ_NOPROBE and this has been maintained although it is not
clear that is really needed. There appears to be a great deal of blind
copy and paste of this code.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: David Airlie <airlied@linux.ie>
Cc: dri-devel at lists.freedesktop.org
---
 drivers/gpu/drm/msm/mdp/mdp5/mdp5_irq.c | 1 -
 drivers/gpu/ipu-v3/ipu-common.c         | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/mdp/mdp5/mdp5_irq.c b/drivers/gpu/drm/msm/mdp/mdp5/mdp5_irq.c
index 33bd4c6..9a6a747 100644
--- a/drivers/gpu/drm/msm/mdp/mdp5/mdp5_irq.c
+++ b/drivers/gpu/drm/msm/mdp/mdp5/mdp5_irq.c
@@ -165,7 +165,6 @@ static int mdp5_hw_irqdomain_map(struct irq_domain *d,
 
 	irq_set_chip_and_handler(irq, &mdp5_hw_irq_chip, handle_level_irq);
 	irq_set_chip_data(irq, mdp5_kms);
-	set_irq_flags(irq, IRQF_VALID);
 
 	return 0;
 }
diff --git a/drivers/gpu/ipu-v3/ipu-common.c b/drivers/gpu/ipu-v3/ipu-common.c
index 6d2f39d..cf0cf46 100644
--- a/drivers/gpu/ipu-v3/ipu-common.c
+++ b/drivers/gpu/ipu-v3/ipu-common.c
@@ -1099,8 +1099,7 @@ static int ipu_irq_init(struct ipu_soc *ipu)
 	}
 
 	ret = irq_alloc_domain_generic_chips(ipu->domain, 32, 1, "IPU",
-					     handle_level_irq, 0,
-					     IRQF_VALID, 0);
+					     handle_level_irq, 0, 0, 0);
 	if (ret < 0) {
 		dev_err(ipu->dev, "failed to alloc generic irq chips\n");
 		irq_domain_remove(ipu->domain);
-- 
2.1.0
