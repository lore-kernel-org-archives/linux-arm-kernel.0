From: gilles.chanteperdrix@xenomai.org (Gilles Chanteperdrix)
Date: Wed, 22 Feb 2012 11:18:12 +0100
Subject: [PATCH v2] arm/spear600: fix one-shot timer
In-Reply-To: <4F446F4B.3030008@st.com>
References: <4F446F4B.3030008@st.com>
Message-ID: <1329905892-10085-1-git-send-email-gilles.chanteperdrix@xenomai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the "clockevent_next_event" function only works correctly
if the timer is not running when this function is called, which is
not always the case when running with CONFIG_HIGH_RES_TIMERS.

Fix this by stopping the timer at the beginning of this function.

Acked-by: Viresh Kumar <viresh.kumar@st.com>
Signed-off-by: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
---
 arch/arm/plat-spear/time.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-spear/time.c b/arch/arm/plat-spear/time.c
index 0c77e42..abb5bde 100644
--- a/arch/arm/plat-spear/time.c
+++ b/arch/arm/plat-spear/time.c
@@ -145,11 +145,13 @@ static void clockevent_set_mode(enum clock_event_mode mode,
 static int clockevent_next_event(unsigned long cycles,
 				 struct clock_event_device *clk_event_dev)
 {
-	u16 val;
+	u16 val = readw(gpt_base + CR(CLKEVT));
+
+	if (val & CTRL_ENABLE)
+		writew(val & ~CTRL_ENABLE, gpt_base + CR(CLKEVT));
 
 	writew(cycles, gpt_base + LOAD(CLKEVT));
 
-	val = readw(gpt_base + CR(CLKEVT));
 	val |= CTRL_ENABLE | CTRL_INT_ENABLE;
 	writew(val, gpt_base + CR(CLKEVT));
 
-- 
1.7.2.5
