From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 5 Dec 2012 15:55:41 +0000
Subject: [PATCH v4 12/13] ARM: KVM: vgic: reduce the number of vcpu kick
In-Reply-To: <50BF4EC8.1050902@arm.com>
References: <20121110154358.3061.16338.stgit@chazy-air>
 <20121110154539.3061.82553.stgit@chazy-air>
 <20121205104358.GC22385@mudshark.cambridge.arm.com>
 <20121205105822.GL14363@n2100.arm.linux.org.uk> <50BF3B75.1060007@arm.com>
 <20121205122952.GO14363@n2100.arm.linux.org.uk> <50BF4EC8.1050902@arm.com>
Message-ID: <20121205155541.GP14363@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 05, 2012 at 01:40:24PM +0000, Marc Zyngier wrote:
> Admittedly, the whole sequence should be rewritten to be clearer. What
> it does is "If we're running a guest and there is no active interrupt,
> then kick the guest".

On the whole this entire thing should be written clearer; from the
explanations you've given it seems that the only reason this code works
is because you're relying on several behaviours all coming together to
achieve the right result - which makes for fragile code.

You're partly relying on atomic types to ensure that the increment and
decrement happen exclusively.  You're then relying on a combination of
IRQ protection and cmpxchg() to ensure that the non-atomic read of the
atomic type won't be a problem.

This doesn't inspire confidence, and I have big concerns over whether
this code will still be understandable in a number of years time.

And I still wonder how safe this is even with your explanations.  IRQ
disabling only works for the local CPU core so I still have questions
over this wrt a SMP host OS.
