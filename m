From: peterz@infradead.org (Peter Zijlstra)
Date: Mon, 23 May 2016 14:44:02 +0200
Subject: [PATCH] arm: Enable interrupts before calling schedule()
In-Reply-To: <alpine.DEB.2.11.1605201740320.3639@nanos>
References: <alpine.DEB.2.11.1605201740320.3639@nanos>
Message-ID: <20160523124402.GJ15728@worktop.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 20, 2016 at 05:42:17PM +0200, Thomas Gleixner wrote:
> do_work_pending() calls schedule() with interrupts disabled, which is just
> wrong. Fix it.

Thomas; lockdep cannot currently catch this. It doesn't do IRQ state
validation other than ensuring the state matches with the hardware.

So things like:

	local_irq_disable();
	local_irq_disable();
	local_irq_save();
	local_irq_enable();

(and 'obviously' suspect sequence of IRQ events)

Are _fine_ by it. The only time it will yell is if flipping IRQ state
ends up marking an actual held lock with ENABLED_HARDIRQ while it
already had USED_IN_HARDIRQ.
