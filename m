From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 11 Jul 2018 12:24:24 +0100
Subject: [PATCH 3/3] clockevents: warn if cpu_all_mask is used for cpumask
 while registering new device
In-Reply-To: <1531308264-24220-1-git-send-email-sudeep.holla@arm.com>
References: <1531308264-24220-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1531308264-24220-3-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using cpu_all_mask in clockevents cpumask may result in issues while
comparing multiple clockevent devices to choose the preferred one.
On one of the platforms with 2 system(i.e. non per-CPU) timers with
different ratings, having cpu_all_mask for one of the device resulted
in boot hang with forever loop in clockevents_notify_released as both
were being selected as preferred.

In order to prevent such issues in future, let's warn if any clockevent
drivers sets cpu_all_mask as it's cpumask and just override it to use
cpu_possible_mask. All the existing occurrences of cpu_all_mask are
already replaced with cpu_possible_mask.

Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 kernel/time/clockevents.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index 16c027e9cc73..8c0e4092f661 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -463,6 +463,12 @@ void clockevents_register_device(struct clock_event_device *dev)
 		dev->cpumask = cpumask_of(smp_processor_id());
 	}

+	if (dev->cpumask == cpu_all_mask) {
+		WARN(1, "%s cpumask == cpu_all_mask, using cpu_possible_mask instead\n",
+		     dev->name);
+		dev->cpumask = cpu_possible_mask;
+	}
+
 	raw_spin_lock_irqsave(&clockevents_lock, flags);

 	list_add(&dev->list, &clockevent_devices);
--
2.7.4
