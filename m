From: tony@atomide.com (Tony Lindgren)
Date: Wed, 26 Oct 2016 08:17:01 -0700
Subject: [PATCH 3/5] ARM: OMAP4+: Fix bad fallthrough for cpuidle
In-Reply-To: <20161026151703.24730-1-tony@atomide.com>
References: <20161026151703.24730-1-tony@atomide.com>
Message-ID: <20161026151703.24730-4-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We don't want to fall through to a bunch of errors for retention
if PM_OMAP4_CPU_OSWR_DISABLE is not configured for a SoC.

Fixes: 6099dd37c669 ("ARM: OMAP5 / DRA7: Enable CPU RET on suspend")
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap-mpuss-lowpower.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -244,10 +244,9 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
 		save_state = 1;
 		break;
 	case PWRDM_POWER_RET:
-		if (IS_PM44XX_ERRATUM(PM_OMAP4_CPU_OSWR_DISABLE)) {
+		if (IS_PM44XX_ERRATUM(PM_OMAP4_CPU_OSWR_DISABLE))
 			save_state = 0;
-			break;
-		}
+		break;
 	default:
 		/*
 		 * CPUx CSWR is invalid hardware state. Also CPUx OSWR
-- 
2.9.3
