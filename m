From: gdavis@mvista.com (George G. Davis)
Date: Fri, 5 Feb 2010 00:38:01 -0500
Subject: [PATCH] ARM: Fix ARM11 MPCore OProfile breakage due to ARM patch 5901/2
Message-ID: <mailman.194.1265349378.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The recent "fe6c67f ARM: 5901/2: arm/oprofile: reserve the PMU when
starting" commit broke OProfile support on ARM11 MPCore targets by
adding a misplaced "} else {" clause in function em_start() which
results in a call to release_pmu() even though the PMU is in use
which in turn results in an oops while using OProfile.  Removing
the stray else clause fixes the problem.

Signed-off-by: George G. Davis <gdavis@mvista.com>
---
 arch/arm/oprofile/op_model_mpcore.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/oprofile/op_model_mpcore.c b/arch/arm/oprofile/op_model_mpcore.c
index f73ce87..0d4f099 100644
--- a/arch/arm/oprofile/op_model_mpcore.c
+++ b/arch/arm/oprofile/op_model_mpcore.c
@@ -246,7 +246,6 @@ static int em_start(void)
 		if (ret) {
 			arm11_release_interrupts(pmu_irqs->irqs,
 						 pmu_irqs->num_irqs);
-		} else {
 			release_pmu(pmu_irqs);
 			pmu_irqs = NULL;
 		}


--
Regards,
George
