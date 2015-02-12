From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 12 Feb 2015 20:42:41 +0100
Subject: [PATCH 09/11] ARM: rockchip: make rockchip_suspend_init conditional
In-Reply-To: <1423770163-583064-1-git-send-email-arnd@arndb.de>
References: <1423770163-583064-1-git-send-email-arnd@arndb.de>
Message-ID: <1423770163-583064-10-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If CONFIG_PM_SLEEP is disabled, we get a build error for rockchips:

arch/arm/mach-rockchip/built-in.o: In function `rockchip_dt_init':
:(.init.text+0x1c): undefined reference to `rockchip_suspend_init'

This adds an inline alternative for that case.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: linux-rockchip at lists.infradead.org
---
 arch/arm/mach-rockchip/pm.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-rockchip/pm.h b/arch/arm/mach-rockchip/pm.h
index 7d752ff39f91..7c889c04604b 100644
--- a/arch/arm/mach-rockchip/pm.h
+++ b/arch/arm/mach-rockchip/pm.h
@@ -24,7 +24,13 @@ extern unsigned long rkpm_bootdata_ddr_data;
 extern unsigned long rk3288_bootram_sz;
 
 void rockchip_slp_cpu_resume(void);
+#ifdef CONFIG_PM_SLEEP
 void __init rockchip_suspend_init(void);
+#else
+static inline void rockchip_suspend_init(void)
+{
+}
+#endif
 
 /****** following is rk3288 defined **********/
 #define RK3288_PMU_WAKEUP_CFG0		0x00
-- 
2.1.0.rc2
