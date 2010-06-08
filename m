From: eric@eukrea.com (=?utf-8?q?Eric=20B=C3=A9nard?=)
Date: Tue,  8 Jun 2010 11:02:57 +0200
Subject: [PATCH 3/8] i.MX25: fix get_rate_otg to return the correct value
In-Reply-To: <1275987782-16094-2-git-send-email-eric@eukrea.com>
References: <1275987782-16094-1-git-send-email-eric@eukrea.com>
	<1275987782-16094-2-git-send-email-eric@eukrea.com>
Message-ID: <1275987782-16094-3-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

usb drivers need to get the right value for otg clock so
calculate and return it

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 arch/arm/mach-mx25/clock.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx25/clock.c b/arch/arm/mach-mx25/clock.c
index 1550149..d2835ff 100644
--- a/arch/arm/mach-mx25/clock.c
+++ b/arch/arm/mach-mx25/clock.c
@@ -131,7 +131,10 @@ static unsigned long get_rate_lcdc(struct clk *clk)
 
 static unsigned long get_rate_otg(struct clk *clk)
 {
-	return 48000000; /* FIXME */
+	unsigned long cctl = readl(CRM_BASE + CCM_CCTL);
+	unsigned long rate = get_rate_upll();
+
+	return (cctl & (1 << 23)) ? 0 : rate / ((0x3F & (cctl >> 16)) + 1);
 }
 
 static int clk_cgcr_enable(struct clk *clk)
-- 
1.6.3.3
