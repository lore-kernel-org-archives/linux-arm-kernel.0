From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Wed, 18 Sep 2013 11:48:37 -0700
Subject: [PATCH v2 3/4] tick: broadcast: Deny per-cpu clockevents from being
 broadcast sources
In-Reply-To: <1379530118-22813-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1379530118-22813-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1379530118-22813-4-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On most ARM systems the per-cpu clockevents are truly per-cpu in
the sense that they can't be controlled on any other CPU besides
the CPU that they interrupt. If one of these clockevents were to
become a broadcast source we will run into a lot of trouble
because the broadcast source is enabled on the first CPU to go
into deep idle (if that CPU suffers from FEAT_C3_STOP) and that
could be a different CPU than what the clockevent is interrupting
(or even worse the CPU that the clockevent interrupts could be
offline).

Theoretically it's possible to support per-cpu clockevents as the
broadcast source but so far we haven't needed this and supporting
it is rather complicated. Let's just deny the possibility for now
until this becomes a reality (let's hope it never does!).

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 kernel/time/tick-broadcast.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index 218bcb5..9532690 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -70,6 +70,7 @@ static bool tick_check_broadcast_device(struct clock_event_device *curdev,
 					struct clock_event_device *newdev)
 {
 	if ((newdev->features & CLOCK_EVT_FEAT_DUMMY) ||
+	    (newdev->features & CLOCK_EVT_FEAT_PERCPU) ||
 	    (newdev->features & CLOCK_EVT_FEAT_C3STOP))
 		return false;
 
-- 
1.8.4
