From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 28 Jun 2016 18:50:17 +0100
Subject: [PATCH 1/2] arm-ccn: ensure perf synchronisation
In-Reply-To: <1467136218-15789-1-git-send-email-mark.rutland@arm.com>
References: <1467136218-15789-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1467136218-15789-2-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the IRQ core is permitted to make the CCN PMU IRQ handler
threaded, and will allow userspace to change the CPU affinity of the
interrupt behind our back. Both of these could violate our
synchronisation requirements with the core perf code, which relies upon
strict CPU affinity and disabling of interrupts to guarantee mutual
exclusion in some cases.

As with the CPU PMU drivers, we should request the interrupt with
IRQF_NOBALANCING and IRQF_NO_THREAD, to avoid these issues.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Olof Johansson <olof@lixom.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: <arm@kernel.org>
---
 drivers/bus/arm-ccn.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/arm-ccn.c b/drivers/bus/arm-ccn.c
index acc3eb5..2c99ab2 100644
--- a/drivers/bus/arm-ccn.c
+++ b/drivers/bus/arm-ccn.c
@@ -1479,8 +1479,9 @@ static int arm_ccn_probe(struct platform_device *pdev)
 		/* Can set 'disable' bits, so can acknowledge interrupts */
 		writel(CCN_MN_ERRINT_STATUS__PMU_EVENTS__ENABLE,
 				ccn->base + CCN_MN_ERRINT_STATUS);
-		err = devm_request_irq(ccn->dev, irq, arm_ccn_irq_handler, 0,
-				dev_name(ccn->dev), ccn);
+		err = devm_request_irq(ccn->dev, irq, arm_ccn_irq_handler,
+				       IRQF_NOBALANCING | IRQF_NO_THREAD,
+				       dev_name(ccn->dev), ccn);
 		if (err)
 			return err;
 
-- 
1.9.1
