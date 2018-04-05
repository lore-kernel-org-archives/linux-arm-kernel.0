From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 5 Apr 2018 11:01:10 +0100
Subject: Extending the Marvell ICU support
In-Reply-To: <20180405115113.4dac15df@windsurf>
References: <20180404160425.49fc620d@windsurf>
 <93739952-190c-0cdd-042e-95125f2d644d@arm.com>
 <20180405110421.662269ab@windsurf>
 <c80537ac-e483-be9a-2dee-a222f429a3f0@arm.com>
 <20180405115113.4dac15df@windsurf>
Message-ID: <147ef036-1d64-1936-6443-b61c5412fa98@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/04/18 10:51, Thomas Petazzoni wrote:
> Hello,
> 
> On Thu, 5 Apr 2018 10:27:24 +0100, Marc Zyngier wrote:
> 
>>> So you're suggesting that the ICU driver registers multiple irq
>>> domains, one for NSR, one for SEI, each having its own MSI parent,
>>> correct ?  
>>
>> Yes, that's the idea. The alternative would have been to have a single
>> GICP domain and to route everything there, but the fact that SEIs are
>> multiplexed entirely kills that prospect. Blame the HW folks.
> 
> A quick question: the ICU in total can handle N wired interrupts, and
> it has N registers to configure how those interrupts are routed to the
> AP. Therefore, we have a global set of N wired interrupts, each can be
> either a NSR, a SEI, a REI, etc.
> 
> Currently, the ICU driver registers a single irq domain of
> ICU_MAX_IRQS. If we move to your solution with sub-nodes, we will have
> to register several irq domains. Is it OK if each of them exposes
> ICU_MAX_IRQS, even if in practice you won't be able to use both the
> interrupt icu_nsr[2] and the interrupt icu_sei[2] ?
> 
> So we will expose 2 * ICU_MAX_IRQS, but in practice only a total of
> ICU_MAX_IRQS can be used. We would probably use a bitmap or something
> like that in the driver to know which ICU is already used, and which is
> still available. Indeed, a configuration such as:
> 
> 	dev1 {
> 		interrupt-extended = <&icu_nsr 2 IRQ_TYPE_LEVEL_HIGH>;
> 	}
> 
> 	dev2 {
> 		interrupt-extended = <&icu_sei 2 IRQ_TYPE_LEVEL_HIGH>;
> 	}
> 
> is not valid, because the ICU n?2 can only be either a NSR *or* a SEI.
> 
> Does that make sense ?

It makes perfect sense, and I think that's fine. In order to avoid
always wasting ICU_MAX_IRQS entries, you could change the type of irq
domain you create from linear to tree. You pay a very small additional
hit on lookup, but that is probably immaterial.

You could benchmark it and decide for yourself.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
