From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 20 Mar 2014 17:14:22 +0100
Subject: [PATCH] ARM: at91: panic when the mck rate is zero
Message-ID: <1395332062-4967-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the mck rate is zero, we'll hit the following warning:

WARNING: CPU: 0 PID: 0 at arch/arm/mach-at91/at91sam926x_time.c:257 at91sam926x_pit_init+0x13c/0x260()

But the kernel will continue to try booting and face a lot of divisions by zero
when trying to handle the various clocks.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/at91sam926x_time.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-at91/at91sam926x_time.c b/arch/arm/mach-at91/at91sam926x_time.c
index 0f04ffe9c5a8..f060f6371392 100644
--- a/arch/arm/mach-at91/at91sam926x_time.c
+++ b/arch/arm/mach-at91/at91sam926x_time.c
@@ -250,6 +250,8 @@ void __init at91sam926x_pit_init(void)
 	if (IS_ERR(mck))
 		panic("AT91: PIT: Unable to get mck clk\n");
 	pit_rate = clk_get_rate(mck) / 16;
+	if (pit_rate == 0)
+		panic("AT91: PIT: can't continue, mck rate is zero\n");
 	pit_cycle = (pit_rate + HZ/2) / HZ;
 	WARN_ON(((pit_cycle - 1) & ~AT91_PIT_PIV) != 0);
 
-- 
1.8.3.2
