From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed,  6 Oct 2010 08:52:18 -0700
Subject: [PATCH] OMAP2: PM: check UART status before trying to idle
Message-ID: <1286380338-4072-1-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As is done on OMAP3, check omap_uart_can_sleep() as one of the
pre-conditions for entering the idle loop.  Without this check,
entering idle introduces large latencies on active UARTs, and is
especially noticable on serial console.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
Tony, this fixes the UART lag when using the serial console on n8x0.
With this, the UARTs will not idle until their sleep timeouts are
activated, and they're disabled by default.

There's an additional bug I'm still looking into as to why UART3
does not trigger wakeup from idle on 2420, but that is only triggered
after enabling UART timeouts.

 arch/arm/mach-omap2/pm24xx.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index c1bceec..a40457d 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -245,6 +245,8 @@ static int omap2_can_sleep(void)
 {
 	if (omap2_fclks_active())
 		return 0;
+	if (!omap_uart_can_sleep())
+		return 0;
 	if (osc_ck->usecount > 1)
 		return 0;
 	if (omap_dma_running())
-- 
1.7.2.1
