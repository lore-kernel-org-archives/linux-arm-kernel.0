From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 30 Jun 2015 19:19:00 +0200
Subject: [PATCH v2 4/4] ARM: mvebu: Warn about the wake-up sources not taken
 into account in suspend
In-Reply-To: <1435684740-24912-1-git-send-email-gregory.clement@free-electrons.com>
References: <1435684740-24912-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1435684740-24912-5-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the Armada 370/XP/38x/39x SoCs when the suspend to ram feature is
supported, the SoC is shutdown and will be waken up by an external
micro-controller, so there is no possibility to setup wake-up source
from Linux. However, in standby mode, the SoCs stay powered and it is
possible to wake-up from any interrupt sources. As, when user decide to
setup a wake-up source, there is no way to know if they will be
wake-up source from suspend or from standby, then we chose allowing to
setup all the interrupt as wake-up sources.

The purpose of this patch is to inform the user that in suspend to ram
mode, the wake-up sources won't be taken into consideration.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/pm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-mvebu/pm.c b/arch/arm/mach-mvebu/pm.c
index 264073a777d8..4402dcfa7c56 100644
--- a/arch/arm/mach-mvebu/pm.c
+++ b/arch/arm/mach-mvebu/pm.c
@@ -235,6 +235,7 @@ static int mvebu_pm_enter(suspend_state_t state)
 		cpu_do_idle();
 		break;
 	case PM_SUSPEND_MEM:
+		pr_warn("None of the wakeup sources will be taken into account in suspend to ram\n");
 		return mvebu_enter_suspend();
 	default:
 		return -EINVAL;
-- 
2.1.0
