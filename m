From: helgaas@kernel.org (Bjorn Helgaas)
Date: Fri, 7 Apr 2017 12:06:54 -0500
Subject: [PATCH] acpi: pci: don't ignore function ID of bridge device in
 _PRT
In-Reply-To: <20170407132222.28300-1-ard.biesheuvel@linaro.org>
References: <20170407132222.28300-1-ard.biesheuvel@linaro.org>
Message-ID: <20170407170654.GA30103@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On Fri, Apr 07, 2017 at 02:22:22PM +0100, Ard Biesheuvel wrote:
> We currently derive legacy interrupt routing by matching _PRT
> entries on the PCI device only, presumably under the assumption
> that PRT entries always have a value of 0xffff in the function
> field, meaning 'match all functions'.

The spec (ACPI v6.0, sec 6.2.13) contains a note that:

  The PCI function number in the Address field of the _PRT packages
  must be 0xFFFF, indicating "any" function number or "all functions".

If we need a patch like this, we need to somehow reconcile it with
that spec text to make sure firmware and OS folks have a common
understanding of how this is supposed to work.

> This no longer holds for modern PCIe topologies, where the
> legacy interrupts for different slots may be wired to different
> functions on the same bridge device. For instance, on AMD Seattle,
> we may have something like
> 
> -[0000:00]-+-00.0  Advanced Micro Devices, Inc. [AMD] Device 1a00
>            +-02.0  Advanced Micro Devices, Inc. [AMD] Device 1a01
>            +-02.2-[01]----00.0  Renesas uPD720202 USB 3.0 Host Controller
>            \-02.3-[02]----00.0  Realtek RTL8169 PCIe Gigabit Ethernet
> 
> where the _PRT describes the legacy interrupt routing as
> 
>     Name (_PRT, Package ()  // _PRT: PCI Routing Table
>     {
>         // slot 1: dev 2 fn 1
>         Package () { 0x20001, 0x0, 0x0, 0x140 },
>         Package () { 0x20001, 0x1, 0x0, 0x141 },
>         Package () { 0x20001, 0x2, 0x0, 0x142 },
>         Package () { 0x20001, 0x3, 0x0, 0x143 },
> 
>         // slot 1: dev 2 fn 2
>         Package () { 0x20002, 0x0, 0x0, 0x144 },
>         Package () { 0x20002, 0x1, 0x0, 0x145 },
>         Package () { 0x20002, 0x2, 0x0, 0x146 },
>         Package () { 0x20002, 0x3, 0x0, 0x147 },
> 
>         // slot 1: dev 2 fn 3
>         Package () { 0x20003, 0x0, 0x0, 0x148 },
>         Package () { 0x20003, 0x1, 0x0, 0x149 },
>         Package () { 0x20003, 0x2, 0x0, 0x14a },
>         Package () { 0x20003, 0x3, 0x0, 0x14b }
>     }) // _PRT

But I think this _PRT description is incorrect and we should change
the _PRT rather than the kernel.  My laptop has a basically identical
topology:

  -[0000:00]-+-00.0  Intel Corporation Sky Lake Host Bridge/DRAM Registers
             +-1c.0-[02]----00.0  Realtek Semiconductor Co., Ltd.  Device 525a
             +-1c.2-[04]----00.0  Intel Corporation Wireless 8260

and the ASL looks like this (paraphrased):

  Device (EXP1) {
    Name (_ADR, 0x001C0000)
    Name (_PRT) {
      Package () { 0xFFFF, 0x00, \_SB.LNKA, 0x00 },
      Package () { 0xFFFF, 0x01, \_SB.LNKB, 0x00 },
      ...
    }
  }
  Device (EXP3) {
    Name (_ADR, 0x001C0002)
    Name (_PRT) {
      Package () { 0xFFFF, 0x00, \_SB.LNKC, 0x00 },
      Package () { 0xFFFF, 0x01, \_SB.LNKD, 0x00 },
      ...
    }
  }

I assume the AMD Seattle device is on the motherboard, so I think this
topology could be described via two _PRTs, one for each root port.

> The current code always matches on the first entry when trying to
> derive the legacy interrupt routing for the USB and Ethernet controllers
> behind bridges 02.2 and 02.3, which results in the wrong entry to
> be selected.
> 
> So fix this by matching the function ID to the value in the _PRT entry
> if the _PRT entries are not using 0xffff in the lower word to match
> all functions.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  drivers/acpi/pci_irq.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
> index c576a6fe4ebb..caac4ac94418 100644
> --- a/drivers/acpi/pci_irq.c
> +++ b/drivers/acpi/pci_irq.c
> @@ -160,6 +160,8 @@ static int acpi_pci_irq_check_entry(acpi_handle handle, struct pci_dev *dev,
>  	struct acpi_prt_entry *entry;
>  
>  	if (((prt->address >> 16) & 0xffff) != device ||
> +	    ((prt->address & 0xffff) != 0xffff &&
> +	     (prt->address & 0xffff) != PCI_FUNC(dev->devfn)) ||
>  	    prt->pin + 1 != pin)
>  		return -ENODEV;
>  
> -- 
> 2.9.3
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
