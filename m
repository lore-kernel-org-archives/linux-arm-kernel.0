From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Mar 2016 17:24:31 +0200
Subject: [PATCH] i.MX6 PCIe: Fix imx6_pcie_deassert_core_reset() polarity
In-Reply-To: <CAJ+vNU3kBk+J-hU1OWPOS6kbFq+J0zM9QpfVy4x1VXL3hgrMTg@mail.gmail.com>
References: <m3h9fuk7ik.fsf@t19.piap.pl> <5741237.2X2Q0sCFQj@wuerfel>
 <CAJ+vNU3kBk+J-hU1OWPOS6kbFq+J0zM9QpfVy4x1VXL3hgrMTg@mail.gmail.com>
Message-ID: <3827347.i8fIQs6jUv@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 March 2016 08:10:08 Tim Harvey wrote:
> Arnd,
> 
> Right, on the IMX the MSI interrupt is GIC-120 which is also the
> legacy INTD and I do see that if I happen to put a radio in a slot
> where due to swizzling its pin1 becomes INTD (GIC-120) the interrupt
> does fire and the device works. Any other slot using GIC-123 (INTA),
> GIC-122 (INTB), or GIC-121 (INTC) never fires so its very possible
> that something in the designware core is masking out the legacy irqs.

Interesting. I was actually expecting the opposite here, having the
IRQs only work if they are not IntD. 


> I typically advise our users to 'not' enable MSI because
> architecturally you can spread 4 distinct legacy irq's across CPU's
> better than a single shared irq.

That is a very good point, I never understood why we want to enable
MSI support on any PCI host bridge that just forwards all MSIs
to a single IRQ line. Originally MSI was meant as a performance
feature, but there is nothing in this setup that makes things go
faster, and several things that make it go slower.

I would still hope that with disabling MSI support in just the i.MX
driver (as in the trivial patch I suggested trying, or by
reverting Lucas' d1dc9749a5b8 patch) will make things just work.
If not, we may need to change the pcie-designware driver as well,
so it doesn't try to enable MSI on its own.

	Arnd
