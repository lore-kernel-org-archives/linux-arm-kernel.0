From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 28 Jun 2016 18:50:18 +0100
Subject: [PATCH 2/2] arm-cci: ensure perf synchronisation
In-Reply-To: <1467136218-15789-1-git-send-email-mark.rutland@arm.com>
References: <1467136218-15789-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1467136218-15789-3-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the IRQ core is permitted to make the CCI PMU IRQ handler
threaded, and will allow userspace to change the CPU affinity of the
interrupt behind our back. Both of these could violate our
synchronisation requirements with the core perf code, which relies upon
strict CPU affinity and disabling of interrupts to guarantee mutual
exclusion in some cases.

As with the CPU PMU drivers, we should request the interrupt with
IRQF_NOBALANCING and IRQF_NO_THREAD, to avoid these issues.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Punit Agrawal <punit.agrawal@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Olof Johansson <olof@lixom.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: <arm@kernel.org>
---
 drivers/bus/arm-cci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index a49b283..6a8825a 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -881,7 +881,8 @@ static int pmu_request_irq(struct cci_pmu *cci_pmu, irq_handler_t handler)
 	 * This should allow handling of non-unique interrupt for the counters.
 	 */
 	for (i = 0; i < cci_pmu->nr_irqs; i++) {
-		int err = request_irq(cci_pmu->irqs[i], handler, IRQF_SHARED,
+		int err = request_irq(cci_pmu->irqs[i], handler,
+				IRQF_SHARED | IRQF_NOBALANCING | IRQF_NO_THREAD,
 				"arm-cci-pmu", cci_pmu);
 		if (err) {
 			dev_err(&pmu_device->dev, "unable to request IRQ%d for ARM CCI PMU counters\n",
-- 
1.9.1
