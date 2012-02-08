From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Thu, 09 Feb 2012 08:33:54 +1100
Subject: [PATCH RFC 0/4] Scheduler idle notifiers and users
In-Reply-To: <20120208202314.GA28290@redhat.com>
References: <20120208013959.GA24535@panacea>
 <1328670355.2482.68.camel@laptop> <20120208202314.GA28290@redhat.com>
Message-ID: <1328736834.2903.33.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-02-08 at 15:23 -0500, Dave Jones wrote:
> I think the biggest mistake we ever made with cpufreq was making it
> so configurable. If we redesign it, just say no to plugin governors,
> and
> yes to a lot fewer sysfs knobs.
> 
> So, provide mechanism to kill off all the governors, and there's a
> migration path from what we have now to something that just works
> in a lot more cases, while remaining configurable enough for the
> corner-cases.

On the other hand, the need for schedulable contxts may not necessarily
go away.

If you look beyond x86, there's several issues that get into the
picture. i2c clock chips & power control chips are slow (the i2c bus
itself is). You don't want to spin for hundreds of microsecs while you
do those transactions.

I have seen many cases where the clock control can be done quite
quickly, but on the other hand, the voltage control takes dozens of ms
to reach the target value & stabilize.

That could be done asynchronously .. as long as the scheduler doesn't
constantly hammer it with change requests.

Cheers,
Ben.
