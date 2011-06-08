From: mark.rutland@arm.com (Mark Rutland)
Date: Wed,  8 Jun 2011 16:28:31 +0100
Subject: [PATCH 2/2] ARM: pmu: reject duplicate PMU registrations
In-Reply-To: <1307546911-2714-1-git-send-email-mark.rutland@arm.com>
References: <1307546911-2714-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1307546911-2714-3-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the PMU reservation framework allows for multiple PMUs of
the same type to register themselves. This can lead to a bug with the
sequence:

register_pmu(pmu1);
reserve_pmu(pmu_type);
register_pmu(pmu2);
release_pmu(pmu1);

Here, pmu1 cannot be released, and pmu2 cannot be reserved.

This patch modifies register_pmu to reject registrations where a PMU is
already present, preventing this problem. PMUs which can have multiple
instances should not use the PMU reservation framework.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-By Will Deacon <will.deacon@arm.com>
Cc: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/kernel/pmu.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kernel/pmu.c b/arch/arm/kernel/pmu.c
index 87942b9..de6b1b0 100644
--- a/arch/arm/kernel/pmu.c
+++ b/arch/arm/kernel/pmu.c
@@ -34,13 +34,13 @@ static int __devinit pmu_register(struct platform_device *pdev,
 		return -EINVAL;
 	}
 
-	if (pmu_devices[type])
-		pr_warning("registering new PMU device type %d overwrites "
-				"previous registration!\n", type);
-	else
-		pr_info("registered new PMU device of type %d\n",
-				type);
+	if (pmu_devices[type]) {
+		pr_warning("rejecting duplicate registration of PMU device "
+			"type %d.", type);
+		return -ENOSPC;
+	}
 
+	pr_info("registered new PMU device of type %d\n", type);
 	pmu_devices[type] = pdev;
 	return 0;
 }
-- 
1.7.0.4
