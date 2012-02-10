From: bill4carson@gmail.com (Bill Carson)
Date: Fri, 10 Feb 2012 17:27:52 +0800
Subject: [PATCH V1] hotplug: eliminate warning Unknown IPI message 0x1
Message-ID: <1328866073-14769-1-git-send-email-bill4carson@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi, All


Does the second parameter of gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
have special meaning? because most of the callers have 1 for this, while 0 for mach-highbank.
This hard code value also causes hotplug warnings:

/sys/devices/system/cpu # echo 0 > cpu3/online 
CPU3: shutdown
/sys/devices/system/cpu # echo 1 > cpu3/online 
CPU3: Booted secondary processor
Calibrating delay loop (skipped) already calibrated this CPU
CPU3: Unknown IPI message 0x1


IMHO, it's necessary to introduce a new ipi_msg_type to eliminate this warning.
And I did the testing on vexpress board, so far so good.

So any comments?






Bill Carson(1)
    hotplug: Introduce a new ipi_msg_type to eliminate phony warning
 

Signed-off-by: Bill Carson <bill4carson@gmail.com>
---
 arch/arm/include/asm/hardirq.h    |    2 +-
 arch/arm/kernel/smp.c             |    5 +++++
 arch/arm/plat-versatile/platsmp.c |    2 +-
 3 files changed, 7 insertions(+), 2 deletions(-)
