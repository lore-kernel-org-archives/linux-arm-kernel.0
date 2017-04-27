From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 27 Apr 2017 22:06:35 +0200
Subject: [RFC/RFT PATCH 00/18] PCI: ARM/ARM64: remove pci_fixup_irqs()
 usage
In-Reply-To: <20170426111809.19922-1-lorenzo.pieralisi@arm.com>
References: <20170426111809.19922-1-lorenzo.pieralisi@arm.com>
Message-ID: <20170427200635.GA6563@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 26, 2017 at 12:17:51PM +0100, Lorenzo Pieralisi wrote:
> Current pci_fixup_irqs() usage on ARM/ARM64 host controller drivers is
> flawed in that pci_fixup_irqs() allocates IRQs for all PCI devices present
> in a system; those PCI devices possibly belong to different PCI bus trees
> (and possibly rooted at different host bridges) and may well be enabled
> (ie probed and bound to a driver) by the time pci_fixup_irqs() is called
> when probing a given host bridge driver.
> 
> Furthermore, current kernel code relying on pci_fixup_irqs() to
> assign legacy PCI IRQs to devices does not work at all for
> hotplugged devices in that the code carrying out the IRQ fixup
> is called at host bridge driver probe time, which just cannot take
> into account devices hotplugged after system has booted.
> 
> By leveraging Matthew Minter's patch series (and its purpose):
> 
> http://lkml.kernel.org/r/1445576642-29624-2-git-send-email-matt at masarand.com
> 
> this series[1] adds IRQs mapping and swizzling primitives to
> the struct pci_host_bridge which allows IRQs to be allocated for
> for a device at probe time with host bridge specific functions,
> fixing the aforementioned limitations.
> 
> Current series remove pci_fixup_irqs() usage on ARM/ARM64; removal
> can be extended to other architectures provided the IRQs map/swizzle
> functions are set-up properly in the respective host bridges
> set-up/probe paths.
> 
> Tested on kvmtool with PCI host generic.

I've tested this on Jetson TX1 (though I need a small patch specific to
Tegra on top to fix a preexisting issue) and things seem to be working
normally.

The output of "lspci -v" is identical before and after applying the
series (on top of next-20170427):

-sh-4.4# lspci -v
00:01.0 PCI bridge: NVIDIA Corporation Device 0fae (rev a1) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0, IRQ 348
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00001000-00001fff [size=4K]
        Memory behind bridge: 13000000-130fffff [size=1M]
        Prefetchable memory behind bridge: 0000000020000000-00000000200fffff [size=1M]
        Capabilities: [40] Subsystem: NVIDIA Corporation Device 0000
        Capabilities: [48] Power Management version 3
        Capabilities: [50] MSI: Enable+ Count=1/2 Maskable- 64bit+
        Capabilities: [60] HyperTransport: MSI Mapping Enable- Fixed-
        Capabilities: [80] Express Root Port (Slot+), MSI 00
        Capabilities: [100] #00
        Capabilities: [140] L1 PM Substates
        Kernel driver in use: pcieport

01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 02)
        Subsystem: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller
        Flags: bus master, fast devsel, latency 0, IRQ 349
        I/O ports at 1000 [size=256]
        Memory at 13000000 (64-bit, non-prefetchable) [size=4K]
        Memory at 20000000 (64-bit, prefetchable) [size=64K]
        Capabilities: [40] Power Management version 3
        Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Capabilities: [70] Express Endpoint, MSI 01
        Capabilities: [b0] MSI-X: Enable- Count=2 Masked-
        Capabilities: [d0] Vital Product Data
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [140] Virtual Channel
        Capabilities: [160] Device Serial Number 8d-08-00-00-68-4c-e0-00
        Kernel driver in use: r8169

Note that the Realtek card is initialized by the r8169 driver and the
network card is used to boot over NFS.

My understanding is that this is what's expected, so:

Tested-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170427/a7d62976/attachment.sig>
