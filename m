From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 8 Sep 2011 15:14:09 +0200 (CEST)
Subject: [PATCH v11 0/4] Consolidating GIC per-cpu interrupts
In-Reply-To: <20110815121312.GF26827@n2100.arm.linux.org.uk>
References: <1312883802-15022-1-git-send-email-marc.zyngier@arm.com>
	<20110815121312.GF26827@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1109081339120.2723@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

B1;2601;0cRussell,

On Mon, 15 Aug 2011, Russell King - ARM Linux wrote:

> Thomas,
> 
> Could you _please_ look Marcs patch series and give an opinion on it.
> I've also attached my patch to this reply too, which is an alternative
> approach to Marcs.

I don't have fundamental objections to Marcs or your approach. In fact
they are very similar.

The main difference is that Marc sets up regular interrupts with
handle_percpu_irq instead of going through a separate entry point. The
only downside is that it exposes the PPI interrupts to the generic irq
API, so nothing can prevent stupid drivers to call disable/enable_irq
& al. I'm not sure how much of an issue that is in reality. If it
matters we can add a flag to the core code which excludes such
interrupts from being accessed.

Another thing, which sticks out compared to other percpu interrupt
users in arch/* is that you provide the ability to assign different
handlers on different CPUs to a given PPI interrupt number. Most other
percpu implementations setup the interrupt with a unique percpu aware
handler and just enable/disable it per core in the low level
setup/shutdown code. Is running different handlers on different cores
a real requirement or just a nice feature with no usecase?

Thanks,

	tglx
