From: olof@lixom.net (Olof Johansson)
Date: Thu, 1 Jul 2010 19:10:47 -0500
Subject: [PATCH] ARM: Stop secondary cpus in machine_halt()
In-Reply-To: <20100701231128.GA19906@n2100.arm.linux.org.uk>
References: <20100701224706.GA26473@lixom.net>
	<20100701231128.GA19906@n2100.arm.linux.org.uk>
Message-ID: <20100702001047.GA26647@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 02, 2010 at 12:11:28AM +0100, Russell King - ARM Linux wrote:
> On Thu, Jul 01, 2010 at 05:47:06PM -0500, Olof Johansson wrote:
> > ARM doesn't spin down secondary cpus on halt, which results in interrupts
> > being delivered even after the "System halted" message, etc.
> > 
> > Change that to use smp_send_stop() to halt them. Also, change the
> > smp_send_stop() on ARM to not do a stack dump when stopping.
> 
> Actually, we want stack dumps - sometimes.  For instance, when we
> panic() or similar.

Do we really want the stack dumps of all cpus at panic time? They won't be
printed precisely since the IPI takes a while to make it over.

As the size of SMP systems grow, it'll also become too spammy.

Anyway, the patch only changes behaviour when the system_state is
SYSTEM_HALT, i.e. during shutdown so all other panics will still
dump stacks from all cpus.


-Olof
