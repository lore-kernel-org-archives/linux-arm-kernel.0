From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 29 Mar 2016 18:56:41 +0100
Subject: [PATCH] i.MX6 PCIe: Fix imx6_pcie_deassert_core_reset() polarity
In-Reply-To: <3827347.i8fIQs6jUv@wuerfel>
References: <m3h9fuk7ik.fsf@t19.piap.pl> <5741237.2X2Q0sCFQj@wuerfel>
 <CAJ+vNU3kBk+J-hU1OWPOS6kbFq+J0zM9QpfVy4x1VXL3hgrMTg@mail.gmail.com>
 <3827347.i8fIQs6jUv@wuerfel>
Message-ID: <56FAC1D9.40404@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/03/16 16:24, Arnd Bergmann wrote:
> On Tuesday 29 March 2016 08:10:08 Tim Harvey wrote:
>> Arnd,
>>
>> Right, on the IMX the MSI interrupt is GIC-120 which is also the
>> legacy INTD and I do see that if I happen to put a radio in a slot
>> where due to swizzling its pin1 becomes INTD (GIC-120) the interrupt
>> does fire and the device works. Any other slot using GIC-123 (INTA),
>> GIC-122 (INTB), or GIC-121 (INTC) never fires so its very possible
>> that something in the designware core is masking out the legacy irqs.
> 
> Interesting. I was actually expecting the opposite here, having the
> IRQs only work if they are not IntD. 
> 
> 
>> I typically advise our users to 'not' enable MSI because
>> architecturally you can spread 4 distinct legacy irq's across CPU's
>> better than a single shared irq.
> 
> That is a very good point, I never understood why we want to enable
> MSI support on any PCI host bridge that just forwards all MSIs
> to a single IRQ line. Originally MSI was meant as a performance
> feature, but there is nothing in this setup that makes things go
> faster, and several things that make it go slower.

Feature-ticking exercise.

"We support MSI", never mind if that negating the benefits of the
mechanism and ending up with disastrous impacts on interrupt affinity,
and a set of open questions regarding the effect of the MSI as a DMA fence.

/me stops ranting for the day...

	M.
-- 
Jazz is not dead. It just smells funny...
