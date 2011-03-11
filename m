From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Fri, 11 Mar 2011 11:20:50 +0200
Subject: [PATCH 4/4] ARM: PXA: PXAFB: don't disable controller on cpufreq
	transition if overlay is in use
In-Reply-To: <1299835250-11095-1-git-send-email-anarsoul@gmail.com>
References: <201103060030.59584.anarsoul@gmail.com>
	<1299835250-11095-1-git-send-email-anarsoul@gmail.com>
Message-ID: <1299835250-11095-4-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's not safe to disable controller if overlay(s) is enabled (results in
system hang). So we avoid to disable controller in this case. Userspace
should choose proper governor to avoid freq changing when overlay is in
use, otherwise LCD may blink.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/video/pxafb.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index a3bdcc1..a2e5b51 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -1648,7 +1648,8 @@ pxafb_freq_transition(struct notifier_block *nb, unsigned long val, void *data)
 
 	switch (val) {
 	case CPUFREQ_PRECHANGE:
-		set_ctrlr_state(fbi, C_DISABLE_CLKCHANGE);
+		if (!fbi->overlay[0].usage && !fbi->overlay[1].usage)
+			set_ctrlr_state(fbi, C_DISABLE_CLKCHANGE);
 		break;
 
 	case CPUFREQ_POSTCHANGE:
-- 
1.7.4.1
