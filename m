From: tharvey@gateworks.com (Tim Harvey)
Date: Tue, 29 Mar 2016 09:40:06 -0700
Subject: [PATCH] i.MX6 PCIe: Fix imx6_pcie_deassert_core_reset() polarity
In-Reply-To: <56FAA9C1.5060107@tekno-soft.it>
References: <m3h9fuk7ik.fsf@t19.piap.pl> <23031613.R8qN30TbTq@wuerfel>
 <CAJ+vNU2BKLDREOWP8EWXZR43to10yw+qvKwv1MzS4a_L9n5ozg@mail.gmail.com>
 <5741237.2X2Q0sCFQj@wuerfel>
 <CAJ+vNU3kBk+J-hU1OWPOS6kbFq+J0zM9QpfVy4x1VXL3hgrMTg@mail.gmail.com>
 <56FAA9C1.5060107@tekno-soft.it>
Message-ID: <CAJ+vNU0bQVd0qyLg+09CUHx4WsrEqwZ4hLVuuvazR8DWpiHE_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 29, 2016 at 9:13 AM, Roberto Fichera <kernel@tekno-soft.it> wrote:
> On 03/29/2016 05:10 PM, Tim Harvey wrote:
>> Arnd,
>>
>> Right, on the IMX the MSI interrupt is GIC-120 which is also the
>> legacy INTD and I do see that if I happen to put a radio in a slot
>> where due to swizzling its pin1 becomes INTD (GIC-120) the interrupt
>> does fire and the device works. Any other slot using GIC-123 (INTA),
>> GIC-122 (INTB), or GIC-121 (INTC) never fires so its very possible
>> that something in the designware core is masking out the legacy irqs.
>> I would also think this was something IMX specific, but I really don't
>> see any codepaths in pci-imx6.c that would cause that: a driver
>> requesting a legacy PCI would get a GIC interrupt which is handled by
>> the IMX6 gpc interrupt controller.
>>
>> Any dra7xxx, exynos, spear13xx, keystone, layerscape, hisi, qcom SoC
>> users of designware PCIe core out there that can verify PCI MSI and
>> legacy are both working at the same time?
>>
>> Lucas is the expert here and I believe he has the documentation for
>> the designware core that Freescale doens't provide with the IMX6
>> documentation so hopefully he can provide some insight. He's the one
>> that has authored all the MSI support and has been using it.
>>
>> I typically advise our users to 'not' enable MSI because
>> architecturally you can spread 4 distinct legacy irq's across CPU's
>> better than a single shared irq.
>
> Don't know if I'm facing similar problem, however devices connected in miniPCI slot behind
> a PCIe-to-PCI bridge (MSI is disabled) using INTA all is working ok, including shared IRQ.
> In case of INTB will not work, and the GIC irq quite often get stuck.
>

Roberto,

What board/platform is this and what does /proc/interrupts look like?

This sounds like what would happen if the downstream interrupts on the
PCIe-to-PCI bridge are not mapped properly as was the case with a
board I support (in which case I had to work out a bootloader fixup
that placed a non-standard interrupt-map in the device-tree for the
bridge). What bridge are you using?

Tim
