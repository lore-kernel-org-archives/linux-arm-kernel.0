From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 17 May 2013 11:55:00 +0100
Subject: ARM Cortex-A7 support in Linux
In-Reply-To: <f6c9d2b0d52d63efa95f780b172690ef@localhost>
References: <A1A6EA40F8503D48BB002B42BD65974E295341@039-SN2MPN1-012.039d.mgd.msft.net>
 <f6c9d2b0d52d63efa95f780b172690ef@localhost>
Message-ID: <20130517105500.GE18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 17, 2013 at 12:47:45PM +0200, Marc Zyngier wrote:
> It depends which feature you're after. Linux supports the GIC
> virtualization extensions with KVM, for example. But we don't make any use
> of other things like priorities, split deactivation/priority drop...

Not that we could make use of priorities anymore as all interrupt handlers
are now run with IRQs disabled; an IRQ handler can't be interrupted by a
higher priority IRQ coming in.

Part of the solution to that is to go back to the original philosophy of
IRQ handling in Linux - do the least possible amount of work in the IRQ
and move the heavier stuff off into soft-IRQ context.  Unfortunately,
many drivers are no longer written like that, and just do a great amount
of time consuming work in their IRQ handler.
