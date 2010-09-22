From: shajuabraham@gmail.com (Shaju Abraham)
Date: Wed, 22 Sep 2010 16:30:21 +0530
Subject: Regarding hw irq to Linux irq mapping on ARM
In-Reply-To: <1285106546.30449.158.camel@pasglop>
References: <AANLkTi=6nCJnfLB1uc0uLGOvOm0CX_R=j-8GQWTzmmep@mail.gmail.com>
	<AANLkTimp7+BLNBwZyBiPS0JgB_mno+gp8+mK=VdOd3+_@mail.gmail.com>
	<1285106546.30449.158.camel@pasglop>
Message-ID: <AANLkTik6Nwt3O9hG971nzzEtiCLobSaWasZ4hjWCketh@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 22, 2010 at 3:32 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2010-09-21 at 16:57 -0300, Grant Likely wrote:
>> On Tue, Sep 21, 2010 at 7:25 AM, Shaju Abraham <shaju.abraham@linaro.org> wrote:
>> > Hi Grant
>> >
>> > Since there does not exist a mechanism to map the hw irq to linux irq
>> > on ARM (device tree), I would like to discuss ?with you the plans or
>> > ideas to implement the same.
>
> Note that the powerpc hw -> linux IRQ mapping (virtualized irq numbering
> scheme) is orthogonal to the device-tree. It can be used without the
> device-tree and the device-tree doesn't mandate such a scheme.
>
> However, when used together, it does provide some nice features such as
> making most cases of cascaded controllers totally trivial.
>
>> I don't have any immediate plans, but this topic has come up a lot in
>> the last two weeks, so I guess I need to focus on it. ?:-) ?[cc'ing
>> devicetree-discuss and linux-arm-kernel as well as Lorenzo and Eric
>> since this is a conversation that should be had publically]
>>
>> > Can you share with me your thoughts on it?
>> > I have browsed through the power pc code for the same. But not sure
>> > the same approach is usable on ARM as well.
>>
>> I haven't thought deeply about the powerpc implementation of virqs to
>> determine if it is suitable for other architectures or not, but the
>> concept behind it is sound. ?We need a method of mapping controller
>> specific IRQ (or hw irq) numbers into the global Linux irq space
>> (referred to a virqs from this point on). ?First it requires a
>> per-controller reference which can be a pointer to a per-controller
>> data structure, or any other unique identifier. ?It could even be the
>> interrupt controller device tree node pointer. ?Just so long as there
>> is a reliable method to derive the virq from the controller reference
>> + hw irq number.
>
> I like keeping it somewhat orthogonal. See how I do that on powerpc.
> That way, you can still exploit it, map interrupts etc... even if your
> device-tree happens to be deficient or missing.
>
> The main grief one could have with my scheme is the naming of irq_host
> which has confused people in the past. It should probably be irq_domain
> to make clear what it is. It generally have a 1:1 relationship to the
> irq_chip but there are cases where that isn't the case (essentially
> where you have multiple irq_chip per domain) for various reasons so it's
> better to keep those separate.
>

How do we handle multiplexed interrupts ? For example a single interrupt line
representing multple irq sources.
We have ARM systems with  single interrupt line on a VIC  muxed to
192 different GPIO sources (each capable of generating interrupts). For such a
system the virq to hw irq mapping can get complex.





> Ben.
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
