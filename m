From: jkrzyszt@tis.icnet.pl (Janusz Krzysztofik)
Date: Sun, 27 Nov 2011 04:32:31 +0100
Subject: [PATCH 5/5] ARM: OMAP1: recalibrate loops per jiffy after dpll1
 reprogram
In-Reply-To: <1322364751-29980-1-git-send-email-jkrzyszt@tis.icnet.pl>
References: <1322364751-29980-1-git-send-email-jkrzyszt@tis.icnet.pl>
Message-ID: <1322364751-29980-6-git-send-email-jkrzyszt@tis.icnet.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Otherwise timing is not accurate, resulting in devices which depend
on it, like omap-keypad, broken.

Created against linux-3.2-rc2.
Depends on patch "init: allow for recalibration of loops per jiffy".
Tested on top of linux-omap/fixes on Amstrad Delta.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Sameer Nanda <snanda@chromium.org>
---
 arch/arm/mach-omap1/clock_data.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap1/clock_data.c b/arch/arm/mach-omap1/clock_data.c
index 201b1f2..7fa6b8b 100644
--- a/arch/arm/mach-omap1/clock_data.c
+++ b/arch/arm/mach-omap1/clock_data.c
@@ -16,6 +16,7 @@
 
 #include <linux/kernel.h>
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/io.h>
 
 #include <asm/mach-types.h>  /* for machine_is_* */
@@ -942,4 +943,5 @@ void __init omap1_clk_late_init(void)
 	}
 	propagate_rate(&ck_dpll1);
 	omap1_show_rates();
+	recalibrate_delay();
 }
-- 
1.7.3.4
