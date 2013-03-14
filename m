From: agraf@suse.de (Alexander Graf)
Date: Thu, 14 Mar 2013 01:59:02 +0100
Subject: [PATCH 3/3] ARM: EXYNOS5250: Register architected timers
In-Reply-To: <1363222742-15220-1-git-send-email-agraf@suse.de>
References: <1363222742-15220-1-git-send-email-agraf@suse.de>
Message-ID: <1363222742-15220-4-git-send-email-agraf@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When running on an exynos 5250 SoC, we don't initialize the architected
timers. The chip however supports architected timers.

When we don't initialize them, KVM will try to access them and run into
NULL pointer dereferences attempting to do so.

This patch is really more of a hack than a real fix, but does get me
working with KVM on Arndale.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/arm/mach-exynos/mct.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-exynos/mct.c b/arch/arm/mach-exynos/mct.c
index c9d6650..eefb8af 100644
--- a/arch/arm/mach-exynos/mct.c
+++ b/arch/arm/mach-exynos/mct.c
@@ -482,4 +482,8 @@ void __init exynos4_timer_init(void)
 	exynos4_timer_resources();
 	exynos4_clocksource_init();
 	exynos4_clockevent_init();
+
+	if (soc_is_exynos5250()) {
+		arch_timer_of_register();
+	}
 }
-- 
1.7.10.4
