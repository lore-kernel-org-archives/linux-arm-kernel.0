From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed,  4 Dec 2013 00:41:31 +0800
Subject: [RFC part3 PATCH 2/2] ARM64 / clocksource: Use arch_timer_acpi_init()
In-Reply-To: <1386088891-2917-1-git-send-email-hanjun.guo@linaro.org>
References: <1386088891-2917-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1386088891-2917-3-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use arch_timer_acpi_init() on ARM64 to initialise arch timer
in ACPI way when DT is not available.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/arm64/kernel/time.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/kernel/time.c b/arch/arm64/kernel/time.c
index 29c39d5..fb009da 100644
--- a/arch/arm64/kernel/time.c
+++ b/arch/arm64/kernel/time.c
@@ -67,6 +67,10 @@ void __init time_init(void)
 
 	clocksource_of_init();
 
+	/* if can't be initialised from DT, try ACPI way */
+	if (!arch_timer_get_rate())
+		arch_timer_acpi_init();
+
 	arch_timer_rate = arch_timer_get_rate();
 	if (!arch_timer_rate)
 		panic("Unable to initialise architected timer.\n");
-- 
1.7.9.5
