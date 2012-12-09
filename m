From: paul@pwsan.com (Paul Walmsley)
Date: Sat, 08 Dec 2012 18:23:37 -0700
Subject: [PATCH 02/10] ARM: OMAP2+: clockdomain: add pwrdm_state_switch()
 call to clkdm_sleep()
In-Reply-To: <20121209011755.19716.25244.stgit@dusk.lan>
References: <20121209011755.19716.25244.stgit@dusk.lan>
Message-ID: <20121209012337.19716.98362.stgit@dusk.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In clkdm_sleep(), the powerdomain should be eligible to switch power
states right after the call to the low-level clockdomain sleep
function.  We should have been tracking that with the
pwrdm_state_switch() code, but we weren't, for whatever reason.  Fix that.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clockdomain.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index 64e5046..18f65fd 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -763,6 +763,7 @@ int clkdm_sleep(struct clockdomain *clkdm)
 	spin_lock_irqsave(&clkdm->lock, flags);
 	clkdm->_flags &= ~_CLKDM_FLAG_HWSUP_ENABLED;
 	ret = arch_clkdm->clkdm_sleep(clkdm);
+	ret |= pwrdm_state_switch(clkdm->pwrdm.ptr);
 	spin_unlock_irqrestore(&clkdm->lock, flags);
 	return ret;
 }
