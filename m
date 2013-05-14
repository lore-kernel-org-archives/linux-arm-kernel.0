From: jonathan.austin@arm.com (Jonathan Austin)
Date: Tue, 14 May 2013 13:26:56 +0100
Subject: [PATCH 1/3] ARM: select CPU_CPU15_MMU/MPU appropriately
In-Reply-To: <1368534418-11287-1-git-send-email-jonathan.austin@arm.com>
References: <1368534418-11287-1-git-send-email-jonathan.austin@arm.com>
Message-ID: <1368534418-11287-2-git-send-email-jonathan.austin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently CPU_V7 selects CPU_CP15_MMU, however in the case of a V7 CPU
implementing the PMSA, such as the Cortex-R7, the CP15_MMU operations are
not available. Selecting CPU_CP15_MPU is appropriate in this case.

This patch makes CPU_CP15_MMU dependent on the use of the MMU, selecting
CPU_CP15_MPU for v7 processors when !MMU is chosen.

Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
---
 arch/arm/mm/Kconfig |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 35955b5..ca5c585 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -392,7 +392,8 @@ config CPU_V7
 	select CPU_CACHE_V7
 	select CPU_CACHE_VIPT
 	select CPU_COPY_V6 if MMU
-	select CPU_CP15_MMU
+	select CPU_CP15_MMU if MMU
+	select CPU_CP15_MPU if !MMU
 	select CPU_HAS_ASID if MMU
 	select CPU_PABRT_V7
 	select CPU_TLB_V7 if MMU
-- 
1.7.9.5
