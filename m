From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 29 May 2015 09:17:56 +0100
Subject: [PATCH] clocksource: make ARM_TIMER_SP804 depend on
 GENERIC_SCHED_CLOCK
In-Reply-To: <20150529110919.2276365a@canb.auug.org.au>
References: <20150529110919.2276365a@canb.auug.org.au>
Message-ID: <1432887476-19301-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 5261ef2ea836 ("ARM: 8366/1: move Dual-Timer SP804 driver to
drivers/clocksource") moved SP804 to drivers/clocksource resulting in
it being selectable on platforms/architectures without the config
GENERIC_SCHED_CLOCK enabled. Due to that, it results in the following
build failure(e.g. x86_64 allmodconfig)

drivers/built-in.o: In function `__sp804_clocksource_and_sched_clock_init':
(.init.text+0x1a0e7): undefined reference to `sched_clock_register'

This patch fixes the build by making ARM_TIMER_SP804 depend on
GENERIC_SCHED_CLOCK

Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/clocksource/Kconfig | 1 +
 1 file changed, 1 insertion(+)

Hi Russell,

If you are fine with this fix, I will put this into the patch tracker.

Regards,
Sudeep

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 0f1c0e7f86da..50534704486a 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -134,6 +134,7 @@ config ARM_GLOBAL_TIMER

 config ARM_TIMER_SP804
 	bool "Support for Dual Timer SP804 module"
+	depends on GENERIC_SCHED_CLOCK
 	select CLKSRC_MMIO
 	select CLKSRC_OF if OF

--
1.9.1
