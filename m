From: jonas.aberg@stericsson.com (Jonas Aaberg)
Date: Thu, 2 Sep 2010 09:30:33 +0200
Subject: [PATCH 3/3] mach-ux500: Added nomadik mtu timer suspend/resume hooks.
In-Reply-To: <1283412633-9883-2-git-send-email-jonas.aberg@stericsson.com>
References: <1283412633-9883-1-git-send-email-jonas.aberg@stericsson.com>
	<1283412633-9883-2-git-send-email-jonas.aberg@stericsson.com>
Message-ID: <1283412633-9883-3-git-send-email-jonas.aberg@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Acked-by: Alessandro Rubini <rubini@unipv.it>
Signed-off-by: Jonas Aaberg <jonas.aberg@stericsson.com>
---
 arch/arm/mach-ux500/cpu.c                |    6 +++++-
 arch/arm/mach-ux500/include/mach/setup.h |    2 ++
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
index e0fd747..86e95db 100644
--- a/arch/arm/mach-ux500/cpu.c
+++ b/arch/arm/mach-ux500/cpu.c
@@ -101,5 +101,9 @@ static void __init ux500_timer_init(void)
 }
 
 struct sys_timer ux500_timer = {
-	.init	= ux500_timer_init,
+	.init	 = ux500_timer_init,
+#ifdef CONFIG_PM
+	.suspend = nmdk_timer_suspend,
+	.resume  = nmdk_timer_resume,
+#endif
 };
diff --git a/arch/arm/mach-ux500/include/mach/setup.h b/arch/arm/mach-ux500/include/mach/setup.h
index 54bbe64..10e3511 100644
--- a/arch/arm/mach-ux500/include/mach/setup.h
+++ b/arch/arm/mach-ux500/include/mach/setup.h
@@ -25,6 +25,8 @@ extern void __init u8500_init_devices(void);
 extern void __init ux500_init_irq(void);
 /* We re-use nomadik_timer for this platform */
 extern void nmdk_timer_init(void);
+extern void nmdk_timer_suspend(void);
+extern void nmdk_timer_resume(void);
 
 extern void __init amba_add_devices(struct amba_device *devs[], int num);
 
-- 
1.6.3.3
