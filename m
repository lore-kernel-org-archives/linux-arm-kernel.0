From: robherring2@gmail.com (Rob Herring)
Date: Tue, 20 Nov 2012 22:00:13 -0600
Subject: [PATCH v4] Introduce irqchip infrastructure
In-Reply-To: <20121121001239.3ca7a87d@skate>
References: <1353448867-15008-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <50AC065C.7000305@gmail.com> <20121121001239.3ca7a87d@skate>
Message-ID: <50AC51CD.5090800@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/20/2012 05:12 PM, Thomas Petazzoni wrote:
> Rob,
> 
> On Tue, 20 Nov 2012 16:38:20 -0600, Rob Herring wrote:
> 
>>> Remaining issues to solve:
>>>
>>>  * Russell would like arch/arm/include/asm/hardware/vic.h and
>>>    arch/arm/include/asm/hardware/gic.h to move elsewhere, since the
>>>    corresponding code is no longer in arch/arm/. I can move them in
>>>    <linux/irqchip>, but that will cause a fairly large change as there
>>>    are a big number of users of those headers in arch/arm.
>>
>> We need to do this. KVM will need the header as well, so we can't move
>> the register definitions out either.
> 
> Which register definitions are you talking about? The one from vic.h ?
> 
>>>  * The arch/arm/include/asm/hardware/vic.h has a few offset macros
>>>    that should move into the .c file of the irqchip driver, but some
>>>    of those offsets are bizarrely used in some other pieces of code in
>>>    arch/arm/.
>>
>> Not really a good solution that I can see there. We could punt on doing
>> the VIC for now.
> 
> Well, most of the VIC macro users are strange. Most of them probably
> need their own macro definition instead of shamelessly borrowing the
> VIC definitions.
> 
>>>  * How to get rid entirely of the headers in <linux/irqchip/>. The
>>>    remaining problematic functions are <foo>_handle_irq() and
>>>    <foo>_irq_init() that are used by non-DT platforms. And the special
>>>    case of gic_cascade_irq().
>>
>> I have patches for removing vic/gic_handle_irq. It is going to take a
>> while for the others, so I don't think we should wait for that. KVM
>> needs the GIC header anyway.
> 
> What is your approach to remove vic/gic_handle_irq? I'll see in your
> patches I guess.
> 
> That said, I think that having <linux/irqchip/gic.h> and
> <linux/irqchip/vic.h> for now is not a big problem. What we want to
> avoid is to have gazillions of headers here, but as new platforms are
> DT-capable, those platforms shouldn't need to add a header in
> <linux/irqchip/>, so I think we could live with
> <linux/irqchip/{gic,vic}.h> for a while, and progressively clean
> up/improve what needs to be done. Doing the perfect migration as an
> unique step is going to be difficult.
> 
>>>  * Move all the users of gic_of_init() to the irqchip mechanism
>>>    (Exynos, i.MX 6, MSM, OMAP, SH Mobile, socfpga, spear13xx, tegra,
>>>    ux500, vexpress) so that gic_of_init() no longer has to be
>>>    exported.
>>
>> I have a patch doing this. I will try to get this sent out today. I've
>> split this into clean-up and then the move, so the clean-up could go in
>> for 3.8. It is only dependent on patch 2.

I've pushed out patches that moves gic.h and converts all GIC DT
platforms over to irqchip_init:

git://sources.calxeda.com/kernel/linux.git gic-irqchip

I haven't gotten to rebasing the VIC ones yet.

One issue I found is it would be easier to move things if
IRQCHIP_DECLARE was accessible in arch/arm. Then I can convert all the
init over to irqchip_init first and then move gic.c and gic.h together
in one patch.

Rob
