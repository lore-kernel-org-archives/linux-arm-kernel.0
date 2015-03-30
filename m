From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 30 Mar 2015 16:04:38 +0200
Subject: [PATCH 5/5] ARM: mvebu: Warn about the wake-ups sources not taken
 into account in suspend
In-Reply-To: <1427724278-12379-1-git-send-email-gregory.clement@free-electrons.com>
References: <1427724278-12379-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1427724278-12379-6-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the Armada 370/XP/38x/39x SoCs when the suspend to ram feature is
supported, the SoC is shutdown and will be wake up by an external
micro-controller, so there is no possibility to setup wake-up source
from Linux. However, in standby mode, as the SoC stay powered and it is
possible to wake-up from any interrupt sources. As when user decide to
setup a wake-up source, there is no way to know if they are wake-up
source from suspend or from standby, then we chose allowing to setup
all the interrupt as wake-up source.

The purpose of this patch is to inform the user that in suspend to ram
mode, the wake source won't be taken into consideration.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/pm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-mvebu/pm.c b/arch/arm/mach-mvebu/pm.c
index 547310230edd..94966f1e4b14 100644
--- a/arch/arm/mach-mvebu/pm.c
+++ b/arch/arm/mach-mvebu/pm.c
@@ -176,6 +176,7 @@ static int mvebu_pm_enter(suspend_state_t state)
 		cpu_do_idle();
 		break;
 	case PM_SUSPEND_MEM:
+		pr_warn("None of the wakeup sources will be taken into account in suspend to ram\n");
 		mvebu_enter_suspend();
 	default:
 		return -EINVAL;
-- 
2.1.0
