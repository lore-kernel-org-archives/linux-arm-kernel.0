From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 26 Jan 2011 05:06:23 +0800
Subject: [PATCH] ARM: pxa: fix suspend on PXA3XX
In-Reply-To: <1295864750-1238-1-git-send-email-s.neumann@raumfeld.com>
References: <20110124101701.GE16202@n2100.arm.linux.org.uk>
	<1295864750-1238-1-git-send-email-s.neumann@raumfeld.com>
Message-ID: <AANLkTinrxiHx6jX9jFzVzjq5FH-W=MLoDThAtRq2a1zZ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

How about this instead?

diff --git a/arch/arm/mach-pxa/pm.c b/arch/arm/mach-pxa/pm.c
index 978e1b2..1807c9a 100644
--- a/arch/arm/mach-pxa/pm.c
+++ b/arch/arm/mach-pxa/pm.c
@@ -33,7 +33,7 @@ int pxa_pm_enter(suspend_state_t state)
 #endif

 	/* skip registers saving for standby */
-	if (state != PM_SUSPEND_STANDBY) {
+	if (state != PM_SUSPEND_STANDBY && pxa_cpu_pm_fns->save) {
 		pxa_cpu_pm_fns->save(sleep_save);
 		/* before sleeping, calculate and save a checksum */
 		for (i = 0; i < pxa_cpu_pm_fns->save_count - 1; i++)
@@ -44,7 +44,7 @@ int pxa_pm_enter(suspend_state_t state)
 	pxa_cpu_pm_fns->enter(state);
 	cpu_init();

-	if (state != PM_SUSPEND_STANDBY) {
+	if (state != PM_SUSPEND_STANDBY && pxa_cpu_pm_fns->restore) {
 		/* after sleeping, validate the checksum */
 		for (i = 0; i < pxa_cpu_pm_fns->save_count - 1; i++)
 			checksum += sleep_save[i];
