From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Apr 2013 18:18:01 +0100
Subject: [PATCH] ARM: smp: call platform's cpu_die in ipi_cpu_stop
In-Reply-To: <1365251824-4852-2-git-send-email-kevin@bracey.fi>
References: <1365251824-4852-1-git-send-email-kevin@bracey.fi>
 <1365251824-4852-2-git-send-email-kevin@bracey.fi>
Message-ID: <20130418171801.GC14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 06, 2013 at 03:37:04PM +0300, Kevin Bracey wrote:
> When hotplugging out, both cpu_kill and cpu_die have always been called.
> But when smp_send_stop was used in machine_shutdown or panic, only
> cpu_kill was called.
> 
> This causes problems for co-ordination between cpu_kill and cpu_die, as
> attempted by shmobile. So add cpu_die call to ipi_cpu_stop, to ensure
> that cpu_kill and cpu_die calls always occur together.

Actually, I'd prefer to pull more code out of the platforms.  Now
that we have flush_cache_louis(), we can flush the L1 cache for the
CPU going down in cpu_die() itself.  We just need to be careful
with that complete() call to ensure that becomes visible to other
cores before power is cut to the L1 cache.

That's fine though - because it must become visible for __cpu_die()
to continue (otherwise it will time out).

That should render shmobile's cpu_dead thing unnecessary, because the
platform independent code will do the required synchronisation.
