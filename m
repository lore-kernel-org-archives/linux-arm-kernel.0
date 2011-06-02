From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 2 Jun 2011 12:29:05 +0200 (CEST)
Subject: [PATCH 3/3] mach-u300: cleanup clockevent code
In-Reply-To: <alpine.LFD.2.02.1106021134190.3078@ionos>
References: <1306876145-6778-1-git-send-email-linus.walleij@stericsson.com>
	<alpine.LFD.2.02.1105312319530.3078@ionos>
	<BANLkTi=UyypKZUQOCCL-KWyAbMQBKY4ccg@mail.gmail.com>
	<alpine.LFD.2.02.1106011027360.3078@ionos>
	<20110601092229.GE3660@n2100.arm.linux.org.uk>
	<alpine.LFD.2.02.1106011201530.3078@ionos>
	<4DE6ECAF.9080409@codeaurora.org>
	<alpine.LFD.2.02.1106021134190.3078@ionos>
Message-ID: <alpine.LFD.2.02.1106021225290.3078@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2 Jun 2011, Thomas Gleixner wrote:
> On Wed, 1 Jun 2011, Stephen Boyd wrote:
> 
> Need to check that.
> 
> > runtime?

It's pretty simple and thanks for pointing it out!

diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index c027d4f..e4c699d 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -182,7 +182,10 @@ void clockevents_register_device(struct clock_event_device *dev)
 	unsigned long flags;
 
 	BUG_ON(dev->mode != CLOCK_EVT_MODE_UNUSED);
-	BUG_ON(!dev->cpumask);
+	if (!dev->cpumask) {
+		WARN_ON(num_possible_cpus() > 1);
+		dev->cpumask = cpumask_of(smp_processor_id());
+	}
 
 	raw_spin_lock_irqsave(&clockevents_lock, flags);
 
