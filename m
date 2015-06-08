From: Dave.Martin@arm.com (Dave P Martin)
Date: Mon, 8 Jun 2015 12:34:11 +0100
Subject: [PATCH] serial/amba-pl011: Disable interrupts around TX softirq
In-Reply-To: <55756FC5.5000801@arm.com>
References: <1433513267-24163-1-git-send-email-Dave.Martin@arm.com>
 <5571E47E.5020800@arm.com> <55756FC5.5000801@arm.com>
Message-ID: <20150608113406.GA3654@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 08, 2015 at 11:34:45AM +0100, Robin Murphy wrote:
> On 05/06/15 19:03, Robin Murphy wrote:
> > On 05/06/15 15:07, Dave P Martin wrote:
> >> pl011_tx_softirq() currently uses spin_{,un}lock(), which are not
> >> sufficient to inhibit pl011_int() from being triggered by a local
> >> IRQ and trying to re-take the same lock.  This can lead to
> >> deadlocks.
> >>
> >> This patch uses the _irq() locking variants instead to ensure that
> >> pl011_int() handling for a given port is deferred until any
> >> pl011_tx_softirq() work for that port is complete.
> >>
> >> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> >> ---
> >>
> >> Another candidate for v4.1 if possible (sorry!) -- I thought this change
> >> was already in, but it went astray when I was refactoring.
> >>
> >> This patch conflicts with tty-next like the previous patch, since it
> >> fixes code that is removed by tty-next.  The correct resolution for
> >> the resulting merge conflict is to keep the code from tty-next.
> >>
> >>
> >> I am not 100% certain yet whether some rare deadlocks that Robin is
> >> seeing are caused by this issue, or whether this patch fixes them --
> >> he's testing atm.
> >
> > FWIW, I've been running Juno in a startup/shutdown loop with a very
> > noisy systemd all afternoon and haven't hit a problem yet with this
> > patch applied. Testing without this patch yesterday I saw 3 or 4 lockdep
> > splats in about the same amount of time. I'll leave it going over the
> > weekend just to make sure, though.
> 
> Having still seen nothing over several hundred more reboot cycles, I'm 
> satisfied that the irq vs. softirq race explains the deadlock and that 
> this patch fixes it, so;
> 
> Tested-by: Robin Murphy <robin.murphy@arm.com>

Thanks for this

Cheers
---Dave
