From: jamie@jamieiles.com (Jamie Iles)
Date: Mon,  9 Jan 2012 18:14:32 +0000
Subject: [PATCH] ARM: picoxcell: fix sched_clock() cleanup fallout
Message-ID: <1326132872-6859-1-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 2f0778afa (ARM: 7205/2: sched_clock: allow sched_clock to be
selected at runtime) replaced the picoxcell specific sched_clock() with
a generic runtime selectable version but replaced "unsigned long long
notrace sched_clock(void)" with "unsigned u32 notrace
picoxcell_read_sched_clock(void)" fix this up to return a u32 as
expected.

Cc: Marc Zyngier <Marc.Zyngier@arm.com>
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/mach-picoxcell/time.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-picoxcell/time.c b/arch/arm/mach-picoxcell/time.c
index 6c89cf8..2ecba67 100644
--- a/arch/arm/mach-picoxcell/time.c
+++ b/arch/arm/mach-picoxcell/time.c
@@ -67,7 +67,7 @@ static void picoxcell_add_clocksource(struct device_node *source_timer)
 
 static void __iomem *sched_io_base;
 
-unsigned u32 notrace picoxcell_read_sched_clock(void)
+static u32 picoxcell_read_sched_clock(void)
 {
 	return __raw_readl(sched_io_base);
 }
-- 
1.7.5.4
