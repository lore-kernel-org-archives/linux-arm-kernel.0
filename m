From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Sun, 26 Feb 2012 16:47:41 +0300
Subject: [PATCH 2/3] ARM: PXA27x: save/restore PWER on suspend/resume
In-Reply-To: <1330264062-5750-1-git-send-email-anarsoul@gmail.com>
References: <1330264062-5750-1-git-send-email-anarsoul@gmail.com>
Message-ID: <1330264062-5750-2-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bootloader can clobber PWER value, so save it state on suspend.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm/mach-pxa/pxa27x.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index acbaa2b..2951872 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -262,6 +262,7 @@ enum {
 	SLEEP_SAVE_PSTR,
 	SLEEP_SAVE_MDREFR,
 	SLEEP_SAVE_PCFR,
+	SLEEP_SAVE_PWER,
 	SLEEP_SAVE_COUNT
 };
 
@@ -269,7 +270,7 @@ void pxa27x_cpu_pm_save(unsigned long *sleep_save)
 {
 	sleep_save[SLEEP_SAVE_MDREFR] = __raw_readl(MDREFR);
 	SAVE(PCFR);
-
+	SAVE(PWER);
 	SAVE(PSTR);
 }
 
@@ -281,6 +282,7 @@ void pxa27x_cpu_pm_restore(unsigned long *sleep_save)
 	PSSR = PSSR_RDH | PSSR_PH;
 
 	RESTORE(PSTR);
+	RESTORE(PWER);
 }
 
 void pxa27x_cpu_pm_enter(suspend_state_t state)
-- 
1.7.9.2
