From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 5 Apr 2018 10:27:24 +0100
Subject: Extending the Marvell ICU support
In-Reply-To: <20180405110421.662269ab@windsurf>
References: <20180404160425.49fc620d@windsurf>
 <93739952-190c-0cdd-042e-95125f2d644d@arm.com>
 <20180405110421.662269ab@windsurf>
Message-ID: <c80537ac-e483-be9a-2dee-a222f429a3f0@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/04/18 10:04, Thomas Petazzoni wrote:
> Hello Marc,
> 
> Thanks for your feedback!
> 
> On Thu, 5 Apr 2018 09:54:13 +0100, Marc Zyngier wrote:
> 
>>> However, as explained above, having multiple msi-parents is currently
>>> not supported. Should we add support for that ? Do you see a
>>> different/better way of supporting our use case ?
>>>
>>> It is worth mentioning that the ICU also support REIs, which work like
>>> the SEIs: there is a single GIC interrupt (n?33), one register to raise
>>> a REI (GICP_SET_REI) and two 32-bits registers (GICP_RECR0/GICP_RECR1)
>>> to find which REI was raised. So we might have to support this in the
>>> future as well. REI stands for RAM Error Interrupt.
>>>
>>> As usual, I'm available on IRC to discuss this live. I'm sure there are
>>> some bits of information that I forgot, and that will be needed to
>>> fully understand what our situation is.  
>>
>> To sum up the discussion we had yesterday on IRC:
>>
>> Multiple MSI parents, despite being easy to express in DT, are a real
>> pain in the kernel, because each device allocates its MSIs from a
>> single, implicit name-space (its directly attached msi_domain). Having
>> more than one means redesigning the whole generic MSI API to deal with
>> multiple domains. It then raises the question of how you access a
>> domain. How do you get a reference to it? Do we keep the additional
>> domains at the device level, or somewhere else? What's the notion of a
>> default MSI domain? This turns the whole logic upside down, and I'm not
>> even adding ACPI to the mix...
>>
>> I'm not saying this is impossible to achieve, but that's so disruptive
>> that this may not be easy to achieve within a reasonable time frame.
> 
> Yes, it is indeed a significant change.
> 
>> On the other hand, wired interrupts are just as easy to express in DT,
>> and because everything is explicit (domain, interrupt number,
>> configuration), you can actually implement something that works both in
>> DT and in the kernel.
>>
>> What I'm suggesting is the following:
>>
>> ap {
>> 	[...]
>> };
>>
>> cp {
>> 	interrupt-parent = <&icu>;
>>
>> 	icu: interrupt-controller at ... {
>> 		compatible = "marvell,cp110-icu";
>> 		reg = <...>;
>>
>> 		icu-nsr: icu-nsr {
>> 			#interrupt-cells = <2>;
>> 			interrupt-controller;
>> 			msi-parent = <&gicp>;
>> 		};
>>
>> 		icu-sei: icu-sei {
>> 			#interrupt-cells = <2>;
>> 			interrupt-controller;
>> 			msi-parent = <&gicp-sei>;
>> 		};
>> 	};
>>
>> 	/* This device uses a NSR */
>> 	rtc {
>> 		reg = <...>;
>> 		interrupts-extended = <&icu-nsr 77 IRQ_TYPE_LEVEL_HIGH>;
>> 	};
>>
>> 	some-other-device {
>> 		reg = <...>;
>> 		interrupts-extended = <&icu-sei 12 IRQ_TYPE_LEVEL_HIGH>;
>> 	};
>> };
>>
>> which should make things work in a pretty obvious way.
> 
> So you're suggesting that the ICU driver registers multiple irq
> domains, one for NSR, one for SEI, each having its own MSI parent,
> correct ?

Yes, that's the idea. The alternative would have been to have a single
GICP domain and to route everything there, but the fact that SEIs are
multiplexed entirely kills that prospect. Blame the HW folks.

> 
> I of course haven't tried it, but it feels like something that should
> work.
> 
>> Of course, the main issue is that it completely breaks DT compatibility.
>> You can probably make a new kernel work with an old DT, but a new DT on
>> an older kernel is just going to catch fire.
> 
> I don't think "a new DT on an older kernel" has ever been a
> requirement, has it? The whole idea of DT ABI compatibility is that an
> old DT shipped on a board continues to work with newer kernel versions.

In that case, you can probably achieve "old DT with new kernel" at the
cost of checking the size of the interrupt specifier in your translate
method.

>> I guess that's the price to pay for HW that wasn't completely described
>> on day-1.
> 
> Isn't "HW not completely described on day 1" the norm rather than the
> exception ? But oh well, I won't re-open this whole DT backward
> compatibility discussion.

It probably is. I'm not going to enter the debate on DT compatibility
either, because all the FW descriptions we have are absolutely pathetic
in that regard.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
