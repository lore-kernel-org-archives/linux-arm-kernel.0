From: gilles.chanteperdrix@xenomai.org (Gilles Chanteperdrix)
Date: Tue, 21 Feb 2012 23:19:15 +0100
Subject: [PATCH] arm/spear600: fix one-shot timer
Message-ID: <1329862755-7439-1-git-send-email-gilles.chanteperdrix@xenomai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the "clockevent_next_event" function only works correctly
if the timer is not running when this function is called, which is
not always the case when running with CONFIG_HIGH_RES_TIMERS.

Fix this by stopping the timer at the beginning of this function.

Signed-off-by: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
---
 arch/arm/plat-spear/time.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-spear/time.c b/arch/arm/plat-spear/time.c
index 0c77e42..ac15ff3 100644
--- a/arch/arm/plat-spear/time.c
+++ b/arch/arm/plat-spear/time.c
@@ -147,9 +147,12 @@ static int clockevent_next_event(unsigned long cycles,
 {
 	u16 val;
 
+	val = readw(gpt_base + CR(CLKEVT));
+	if ((val & CTRL_ENABLE))
+		writew(val & ~CTRL_ENABLE, gpt_base + CR(CLKEVT));
+
 	writew(cycles, gpt_base + LOAD(CLKEVT));
 
-	val = readw(gpt_base + CR(CLKEVT));
 	val |= CTRL_ENABLE | CTRL_INT_ENABLE;
 	writew(val, gpt_base + CR(CLKEVT));
 
-- 
1.7.2.5
