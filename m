From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 12 Mar 2012 20:04:32 +0530
Subject: [PATCH 1/2] ARM: OMAP: powerdomain: Wait for powerdomain transition
 in pwrdm_state_switch()
In-Reply-To: <1331562873-29535-1-git-send-email-santosh.shilimkar@ti.com>
References: <1331562873-29535-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1331562873-29535-2-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit b1cbdb00d{OMAP: clockdomain: Wait for powerdomain to be ON
when using clockdomain force wakeup} was assuming that pwrdm_state_switch()
does wait for the powerdomain transition which is not the case.

Fix this API by adding the pwrdm_wait_transition().

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
CC: Rajendra Nayak <rnayak@ti.com>
CC: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/powerdomain.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 8a18d1b..96ad3dbe 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -972,7 +972,13 @@ int pwrdm_wait_transition(struct powerdomain *pwrdm)
 
 int pwrdm_state_switch(struct powerdomain *pwrdm)
 {
-	return _pwrdm_state_switch(pwrdm, PWRDM_STATE_NOW);
+	int ret;
+
+	ret = pwrdm_wait_transition(pwrdm);
+	if (!ret)
+		ret = _pwrdm_state_switch(pwrdm, PWRDM_STATE_NOW);
+
+	return ret;
 }
 
 int pwrdm_clkdm_state_switch(struct clockdomain *clkdm)
-- 
1.7.4.1
