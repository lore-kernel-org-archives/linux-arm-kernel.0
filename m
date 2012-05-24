From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 24 May 2012 17:17:33 +0100
Subject: [PATCH] [ARM] Unconditional call to smp_cross_call on UP crashes
In-Reply-To: <1337889024-10416-1-git-send-email-panto@antoniou-consulting.com>
References: <1337889024-10416-1-git-send-email-panto@antoniou-consulting.com>
Message-ID: <20120524161733.GF6908@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 24, 2012 at 07:50:24PM +0000, Pantelis Antoniou wrote:
> omap2plus_defconfig builds with SMP & SMP_ON_UP set.
> On beagle (which is UP) is_smp() returns false and we don't call
> smp_init_cpus which in turn does not initialize smp_cross_call which
> remains NULL.
> 
> When issuing a reboot we OOPS with a NULL dereference on stop smp_call.

I've been wondering whether we should make smp_cross_call() a no-op instead
by default, rather than a NULL pointer.

Alternatively, if may be well worth changing this to do:

	if (!cpumask_empty(&mask))
		smp_cross_call(&mask, IPI_CPU_STOP);

instead, so we avoid calling smp_cross_call() when we're on a SMP system
with only one CPU online.  I like this approach better because it removes
a potential call into platform code which is inappropriate.
