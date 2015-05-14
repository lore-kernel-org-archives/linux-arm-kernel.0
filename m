From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Thu, 14 May 2015 19:10:38 +0200
Subject: [PATCH] iio: adc: xilinx-xadc: Convert to raw spinlock
In-Reply-To: <1431013090-18996-1-git-send-email-xander.huff@ni.com>
References: <1431013090-18996-1-git-send-email-xander.huff@ni.com>
Message-ID: <20150514171038.GG13442@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Xander Huff | 2015-05-07 10:38:10 [-0500]:

>The driver currently registers a pair of irq handlers using
>request_threaded_irq(), however the synchronization mechanism
>between the hardirq and the threadedirq handler is a regular spinlock.
>
>Unfortunately, this breaks PREEMPT_RT builds, where a spinlock can
>sleep, and is thus not able to be acquired from a hardirq handler.
>Because the set of operations performed under the spinlock is already
>minimal and bounded, it is a suitable candidate for being a raw_spinlock.
>
>This patch should not impact behavior on !PREEMPT_RT builds.
>
>Signed-off-by: Xander Huff <xander.huff@ni.com>
>Reviewed-by: Joe Hershberger <joe.hershberger@ni.com>
>Reviewed-by: Ben Shelton <ben.shelton@ni.com>
>Reviewed-by: Josh Cartwright <joshc@ni.com>

Do you have any cyclictest numbers how much the latency increases on
heavy iio usage? Traditionally the primary handler should be very quick
/ short.

Sebastian
