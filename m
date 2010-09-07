From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 07 Sep 2010 16:18:52 -0400
Subject: [PATCH 1/2] ARM: link board specific files after core files
In-Reply-To: <1283890733-6548-1-git-send-email-nico@fluxnic.net>
References: <1283890733-6548-1-git-send-email-nico@fluxnic.net>
Message-ID: <1283890733-6548-2-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Pitre <nicolas.pitre@linaro.org>

This allows for board specific issues to override decisions made in generic
code that might not be suitable due to some errata or the like, by making
the initcall hooks from those board specific files run after the core ones,
therefore avoiding ugly #ifdef's in core code.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
Tested-by: Dave Martin <dave.martin@linaro.org>
Tested-by: Jason Hui <jason.hui@linaro.org>
---
 arch/arm/Makefile |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 64ba313..1373bfe 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -236,13 +236,14 @@ ifeq ($(FASTFPE),$(wildcard $(FASTFPE)))
 FASTFPE_OBJ	:=$(FASTFPE)/
 endif
 
-# If we have a machine-specific directory, then include it in the build.
-core-y				+= arch/arm/kernel/ arch/arm/mm/ arch/arm/common/
-core-y				+= $(machdirs) $(platdirs)
 core-$(CONFIG_FPE_NWFPE)	+= arch/arm/nwfpe/
 core-$(CONFIG_FPE_FASTFPE)	+= $(FASTFPE_OBJ)
 core-$(CONFIG_VFP)		+= arch/arm/vfp/
 
+# If we have a machine-specific directory, then include it in the build.
+core-y				+= arch/arm/kernel/ arch/arm/mm/ arch/arm/common/
+core-y				+= $(machdirs) $(platdirs)
+
 drivers-$(CONFIG_OPROFILE)      += arch/arm/oprofile/
 
 libs-y				:= arch/arm/lib/ $(libs-y)
-- 
1.7.2.2.440.g49ea7
