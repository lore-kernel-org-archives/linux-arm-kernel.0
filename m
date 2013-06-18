From: ming.lei@canonical.com (Ming Lei)
Date: Tue, 18 Jun 2013 23:03:49 +0800
Subject: [RFC PATCH v1 3/6] USB: URB documentation: claim complete() may be
 run with IRQs enabled
In-Reply-To: <1371567833-9077-1-git-send-email-ming.lei@canonical.com>
References: <1371567833-9077-1-git-send-email-ming.lei@canonical.com>
Message-ID: <1371567833-9077-4-git-send-email-ming.lei@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no good reason to run complete() in hard interrupt
disabled context.

After running complete() in tasklet, we will enable local IRQs
when calling complete() since we can do it now.

Even though we still disable IRQs now when calling complete()
in tasklet, the URB documentation is updated to claim complete()
may be run in tasklet context and local IRQs may be enabled, so
that USB drivers can know the change and avoid one deadlock caused
by: assume IRQs disabled in complete() and call spin_lock() to
hold lock which might be acquired in interrupt context.

Current spin_lock() usages in drivers' complete() will be cleaned
up at the same time, and when the cleanup is finished, local IRQs
will be enabled when calling complete() in tasklet.

Also fix description about type of usb_complete_t.

Cc: Oliver Neukum <oliver@neukum.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 Documentation/usb/URB.txt |   30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/Documentation/usb/URB.txt b/Documentation/usb/URB.txt
index 00d2c64..454db87 100644
--- a/Documentation/usb/URB.txt
+++ b/Documentation/usb/URB.txt
@@ -195,13 +195,12 @@ by the completion handler.
 
 The handler is of the following type:
 
-	typedef void (*usb_complete_t)(struct urb *, struct pt_regs *)
+	typedef void (*usb_complete_t)(struct urb *)
 
-I.e., it gets the URB that caused the completion call, plus the
-register values at the time of the corresponding interrupt (if any).
-In the completion handler, you should have a look at urb->status to
-detect any USB errors. Since the context parameter is included in the URB,
-you can pass information to the completion handler. 
+I.e., it gets the URB that caused the completion call. In the completion
+handler, you should have a look at urb->status to detect any USB errors.
+Since the context parameter is included in the URB, you can pass
+information to the completion handler.
 
 Note that even when an error (or unlink) is reported, data may have been
 transferred.  That's because USB transfers are packetized; it might take
@@ -210,12 +209,19 @@ have transferred successfully before the completion was called.
 
 
 NOTE:  ***** WARNING *****
-NEVER SLEEP IN A COMPLETION HANDLER.  These are normally called
-during hardware interrupt processing.  If you can, defer substantial
-work to a tasklet (bottom half) to keep system latencies low.  You'll
-probably need to use spinlocks to protect data structures you manipulate
-in completion handlers.
-
+NEVER SLEEP IN A COMPLETION HANDLER.  These are called during hardware
+interrupt processing if HCD_BH isn't set in hcd->driver->flags, otherwise
+called in tasklet context. If you can, defer substantial work to a tasklet
+(bottom half) to keep system latencies low.  You'll probably need to use
+spinlocks to protect data structures you manipulate in completion handlers.
+
+Driver can't assume that local IRQs are disabled any more when running
+complete(), for example, if drivers want to hold a lock which might be
+acquired in hard interrupt handler, they have to use spin_lock_irqsave()
+instead of spin_lock() to hold the lock.
+
+In the future, all HCD might set HCD_BH to run complete() in tasklet so
+that system latencies can be kept low.
 
 1.8. How to do isochronous (ISO) transfers?
 
-- 
1.7.9.5
