From: vkuzmichev@mvista.com (Vitaly Kuzmichev)
Date: Thu,  7 Jul 2011 16:23:13 +0400
Subject: [PATCH V3 1/4] ARM: smp_twd: Fix typo in 'twd_timer_rate' printing
In-Reply-To: <1310041339-2348-1-git-send-email-vkuzmichev@mvista.com>
References: <1310041339-2348-1-git-send-email-vkuzmichev@mvista.com>
Message-ID: <1310041396-2461-1-git-send-email-vkuzmichev@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To get hundredths of MHz the rate needs to be divided by 10'000.
Here is an example:
 twd_timer_rate = 123456789
 Before the patch:
    twd_timer_rate / 1000000 = 123
    (twd_timer_rate / 1000000) % 100 = 23
    Result: 123.23MHz.
 After being fixed:
    twd_timer_rate / 1000000 = 123
    (twd_timer_rate / 10000) % 100 = 45
    Result: 123.45MHz.

Signed-off-by: Vitaly Kuzmichev <vkuzmichev@mvista.com>
---
 arch/arm/kernel/smp_twd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 60636f4..2c277d4 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -115,7 +115,7 @@ static void __cpuinit twd_calibrate_rate(void)
 		twd_timer_rate = (0xFFFFFFFFU - count) * (HZ / 5);
 
 		printk("%lu.%02luMHz.\n", twd_timer_rate / 1000000,
-			(twd_timer_rate / 1000000) % 100);
+			(twd_timer_rate / 10000) % 100);
 	}
 }
 
-- 
1.7.3.4
