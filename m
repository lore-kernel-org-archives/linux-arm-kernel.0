From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 19 Jan 2011 11:57:37 +0000
Subject: [PATCH] RFC: ux500: add PMU resources
In-Reply-To: <000001cbb7cd$7cb9c840$762d58c0$@deacon@arm.com>
References: <1295391579-9166-1-git-send-email-linus.walleij@stericsson.com>
	<000001cbb7cd$7cb9c840$762d58c0$@deacon@arm.com>
Message-ID: <20110119115737.GC31652@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 19, 2011 at 11:39:09AM -0000, Will Deacon wrote:
> 3.) Rework the GIC code so that an IRQ can target multiple CPUs and remove
>     the distributor-level masking. I think this was originally done so that
>     we can service different IRQs simultaneously, but with the deprecation
>     of IRQF_DISABLED I'm not sure if this is still an issue. If not, then
>     we can change to masking at the CPU interfaces which will make
>     supporting your combined IRQ much easier.

If an interrupt is routed to multiple cores simultaneously, then you end
up with a number of problems:

1. Each time an interrupt occurs, you wake up all CPUs.
2. One CPU wins the race and starts to handle the interrupt.  The others
   are left spinning on a lock waiting.  Eventually the lock is dropped
   and they too enter the handler.
3. Another race ensues on the drivers own spinlock.  The winning CPU
   possibly holds this lock for the duration of its handling.  Meanwhile
   the other CPUs are left spinning waiting for the lock to be dropped.
4. When the winning CPU drops the lock, it returns IRQ_HANDLED.  The other
   CPUs find that there is no IRQ pending from the device, and return
   IRQ_NONE.

(4) may result in the spurious/unhandled IRQ code eventually disabling
the interrupt.

TI also raised a point that knocking the losing CPUs out of low power
mode will waste power needlessly.

Not only that, but the losing CPUs waste time and power spinning.  So
this really isn't a good idea.
