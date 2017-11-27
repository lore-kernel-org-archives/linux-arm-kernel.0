From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon, 27 Nov 2017 09:56:58 +0000
Subject: [PATCH] ARM: NOMMU: Allow userspace to access background MPU region
Message-ID: <1511776618-9018-1-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, with MPU enabled, we prohibit userspace access to anything
except RAM. Benjamin, reported that because of that his userspace
application cannot access framebuffer's memory he reserved in device
tree. It turns out we have no option other than to allow userspace
access memory covered by background region.

Reported-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Tested-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
KernelVersion: 4.15-rc1

 arch/arm/mm/pmsa-v7.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/pmsa-v7.c b/arch/arm/mm/pmsa-v7.c
index 976df60..6509989 100644
--- a/arch/arm/mm/pmsa-v7.c
+++ b/arch/arm/mm/pmsa-v7.c
@@ -433,7 +433,7 @@ void __init mpu_setup(void)
 
 	/* Background */
 	err |= mpu_setup_region(region++, 0, 32,
-				MPU_ACR_XN | MPU_RGN_STRONGLY_ORDERED | MPU_AP_PL1RW_PL0NA,
+				MPU_ACR_XN | MPU_RGN_STRONGLY_ORDERED | MPU_AP_PL1RW_PL0RW,
 				0, false);
 
 #ifdef CONFIG_XIP_KERNEL
-- 
1.9.1
