From: t-kristo@ti.com (Tero Kristo)
Date: Tue, 21 Feb 2012 16:04:58 +0200
Subject: [PATCHv5 14/14] arm: omap: pm: wait for domain wakeup if changing
 state of idle domain
In-Reply-To: <1329833098-19900-1-git-send-email-t-kristo@ti.com>
References: <1329833098-19900-1-git-send-email-t-kristo@ti.com>
Message-ID: <1329833098-19900-15-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we are switching the state of an idle powerdomain, we must wait for
the wakeup to complete before attempting to switch to the new state,
otherwise the powerdomain may not be ready for the switch and will fail.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/pm.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 2402e8e..7a669f3 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -126,6 +126,7 @@ int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
 		} else {
 			hwsup = clkdm_in_hwsup(pwrdm->pwrdm_clkdms[0]);
 			clkdm_wakeup(pwrdm->pwrdm_clkdms[0]);
+			pwrdm_wait_transition(pwrdm);
 			sleep_switch = FORCEWAKEUP_SWITCH;
 		}
 	}
-- 
1.7.4.1
