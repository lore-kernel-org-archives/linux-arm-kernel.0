From: luis.henriques@canonical.com (Luis Henriques)
Date: Mon,  1 Apr 2013 16:04:35 +0100
Subject: [ 3.5.y.z extended stable ] Patch "clockevents: Don't allow dummy
 broadcast timers" has been added to staging queue
Message-ID: <1364828675-11216-1-git-send-email-luis.henriques@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a note to let you know that I have just added a patch titled

    clockevents: Don't allow dummy broadcast timers

to the linux-3.5.y-queue branch of the 3.5.y.z extended stable tree 
which can be found at:

 http://kernel.ubuntu.com/git?p=ubuntu/linux.git;a=shortlog;h=refs/heads/linux-3.5.y-queue

If you, or anyone else, feels it should not be added to this tree, please 
reply to this email.

For more information about the 3.5.y.z tree, see
https://wiki.ubuntu.com/Kernel/Dev/ExtendedStable

Thanks.
-Luis

------

>From 047c562aeae314a54669cc451e4763b0fc22f2b5 Mon Sep 17 00:00:00 2001
From: Mark Rutland <mark.rutland@arm.com>
Date: Thu, 7 Mar 2013 15:09:24 +0000
Subject: [PATCH] clockevents: Don't allow dummy broadcast timers

commit a7dc19b8652c862d5b7c4d2339bd3c428bd29c4a upstream.

Currently tick_check_broadcast_device doesn't reject clock_event_devices
with CLOCK_EVT_FEAT_DUMMY, and may select them in preference to real
hardware if they have a higher rating value. In this situation, the
dummy timer is responsible for broadcasting to itself, and the core
clockevents code may attempt to call non-existent callbacks for
programming the dummy, eventually leading to a panic.

This patch makes tick_check_broadcast_device always reject dummy timers,
preventing this problem.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: Jon Medhurst (Tixy) <tixy@linaro.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 kernel/time/tick-broadcast.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index f113755..a13987a 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -66,7 +66,8 @@ static void tick_broadcast_start_periodic(struct clock_event_device *bc)
  */
 int tick_check_broadcast_device(struct clock_event_device *dev)
 {
-	if ((tick_broadcast_device.evtdev &&
+	if ((dev->features & CLOCK_EVT_FEAT_DUMMY) ||
+	    (tick_broadcast_device.evtdev &&
 	     tick_broadcast_device.evtdev->rating >= dev->rating) ||
 	     (dev->features & CLOCK_EVT_FEAT_C3STOP))
 		return 0;
--
1.8.1.2
