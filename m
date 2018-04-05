From: thomas.petazzoni@bootlin.com (Thomas Petazzoni)
Date: Thu, 5 Apr 2018 11:51:13 +0200
Subject: Extending the Marvell ICU support
In-Reply-To: <c80537ac-e483-be9a-2dee-a222f429a3f0@arm.com>
References: <20180404160425.49fc620d@windsurf>
 <93739952-190c-0cdd-042e-95125f2d644d@arm.com>
 <20180405110421.662269ab@windsurf>
 <c80537ac-e483-be9a-2dee-a222f429a3f0@arm.com>
Message-ID: <20180405115113.4dac15df@windsurf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, 5 Apr 2018 10:27:24 +0100, Marc Zyngier wrote:

> > So you're suggesting that the ICU driver registers multiple irq
> > domains, one for NSR, one for SEI, each having its own MSI parent,
> > correct ?  
> 
> Yes, that's the idea. The alternative would have been to have a single
> GICP domain and to route everything there, but the fact that SEIs are
> multiplexed entirely kills that prospect. Blame the HW folks.

A quick question: the ICU in total can handle N wired interrupts, and
it has N registers to configure how those interrupts are routed to the
AP. Therefore, we have a global set of N wired interrupts, each can be
either a NSR, a SEI, a REI, etc.

Currently, the ICU driver registers a single irq domain of
ICU_MAX_IRQS. If we move to your solution with sub-nodes, we will have
to register several irq domains. Is it OK if each of them exposes
ICU_MAX_IRQS, even if in practice you won't be able to use both the
interrupt icu_nsr[2] and the interrupt icu_sei[2] ?

So we will expose 2 * ICU_MAX_IRQS, but in practice only a total of
ICU_MAX_IRQS can be used. We would probably use a bitmap or something
like that in the driver to know which ICU is already used, and which is
still available. Indeed, a configuration such as:

	dev1 {
		interrupt-extended = <&icu_nsr 2 IRQ_TYPE_LEVEL_HIGH>;
	}

	dev2 {
		interrupt-extended = <&icu_sei 2 IRQ_TYPE_LEVEL_HIGH>;
	}

is not valid, because the ICU n?2 can only be either a NSR *or* a SEI.

Does that make sense ?

> > I don't think "a new DT on an older kernel" has ever been a
> > requirement, has it? The whole idea of DT ABI compatibility is that an
> > old DT shipped on a board continues to work with newer kernel versions.  
> 
> In that case, you can probably achieve "old DT with new kernel" at the
> cost of checking the size of the interrupt specifier in your translate
> method.

Yep, I think backward compatibility can be achieved. It's going to
clutter the ICU driver implementation with dead code that is never
tested, but that's the whole point of DT backward compatibility.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
