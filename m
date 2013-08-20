From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 20 Aug 2013 22:14:42 +0100
Subject: [PATCH] irqchip: gic: Allow setting affinity to offline CPUs
In-Reply-To: <1377015070-26320-1-git-send-email-t.figa@samsung.com>
References: <1377015070-26320-1-git-send-email-t.figa@samsung.com>
Message-ID: <20130820211442.GF17845@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 20, 2013 at 06:11:10PM +0200, Tomasz Figa wrote:
> Sometimes it is necessary to fix interrupt affinity to an offline CPU,
> for example in initialization of local timers. This patch modifies
> .set_affinity() operation of irq-gic driver to fall back to any possible
> CPU if no online CPU can be found in requested CPU mask.

Err, this is a bad idea.  If a CPU is offline, then it must not respond
to interrupts.  If you bind an interrupt to an offline CPU, and that
device asserts its interrupt, what happens?  It doesn't get serviced
until that CPU comes back online, which may be a very long time.

If, for example, that is your network device, it would mean your
network stops operating.  Worse, the network layer will time out and
reset the ethernet device, trying to get things working (which it
won't.)

I think how I used to handle this case prior to genirq is that I fell
back to any online CPU if the interrupt ended up only routed to offline
CPUs, but when an offline CPU comes back, it could then be re-routed
back to that CPU.  In other words, the mask change was non-destructive.

I think with genirq, such mask changes are destructive.
