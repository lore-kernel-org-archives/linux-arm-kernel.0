From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 27 Apr 2018 10:43:56 +0200
Subject: LS1043A : "synchronous abort" at boot due to PCI config read
In-Reply-To: <5AD0E995.3090802@kontron.com>
References: <5AD0E995.3090802@kontron.com>
Message-ID: <CAKv+Gu_v4V8DUa6f4WxvjZHoJbbqT0mKpOwYVmaLaE20CB3U_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(add Bjorn and linux-pci)

On 13 April 2018 at 19:32, Gilles Buloz <Gilles.Buloz@kontron.com> wrote:
> Dear developers,
>
> I currently have two functional workarounds for this issue but would like to know which one you would recommend, if any :-)
> I'm using a LS1043A CPU (NXP QorIQ Layerscape) and get a "synchronous external abort" when booting because of a PCI config read
> during PCI scan.
>
> I'm using a custom hardware (based on LS1043ARDB) having a PEX8112 PCIe-to-PCI bridge connected to the LS1043A to have a PCI slot
> for legacy devices. This bridge only supports PCI-Compatible config accesses (offset 0x00-0xFF).
> On this PCI slot I connect a PCI module made of a PCI-to-PCIe bridge plus PCIe devices behind.
> The problem occurs when the kernel probes the PCIe devices : as they are PCIe devices, the kernel does a PCI config read access at
> offset 0x100 to check if "PCIe extended capability registers" are accessible (see drivers/pci/probe.c, function
> pci_cfg_space_size_ext()). Unfortunately the PEX8112 PCIe-to-PCI bridge that is in the path reports an error to the CPU for this
> access, and it seems there's no way to disable that on this bridge.
>
> The first workaround I found was to patch drivers/pci/host/pci-layerscape.c to have PCIE_ABSERR_SETTING set to 0x9400 instead of
> 0x9401 (for PCIE_ABSERR register) to disable error reporting. This only impacts an NXP part of the Linux kernel code, but I'm not
> sure this is a good idea (however it seems to be like that on Intel platforms where even MEM accesses to a no-device address return
> FF without any error).
>
> I've also tried another workaround that works : patch drivers/pci/probe.c to use bus_flags to remember if a bus is behind a bridge
> without extended address capability, to avoid PCi config read accesses at offset 0x100 in
> pci_cfg_space_size() / pci_cfg_space_size_ext(). But this patch impacts the generic PCI probe method of Linux.
>
> Any Idea to properly handle that issue ?
>

This seems like a rather unusual configuration, but I guess that if
the first bridge/switch advertises its inability to support extended
config space accesses, we should not be performing them on any of its
subordinate buses. How does the PEX8112 advertise this limitation?

That said, I wonder if it is reasonable in the first place to expect
that a PCIe device works as expected passing through a legacy PCI
layer like that.
