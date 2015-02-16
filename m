From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 16 Feb 2015 18:28:05 +0100
Subject: Extending the Marvell MBus DT binding to create remappable windows
Message-ID: <20150216182805.529a0071@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Ezequiel,

Both of you were heavily involved in the definition of the MBus Device
Tree binding, and I'm now facing a new need, which maybe will require
extending this Device Tree binding.

Let me summarize a few things:

 - MBus windows are physical address windows that can be dynamically
   created. They associate a range of physical addresses with a
   certain device (a NOR flash, a PCIe memory or I/O area, etc.).

 - Some windows are statically described in the Device Tree: the ones
   for a NOR flash, for the BootROM, etc. For these, the Device Tree
   gives both the MBus target ID and attribute (which identify the
   target device) and the physical address and size at which the MBus
   window will be created. Such windows are created by the mvebu-mbus
   driver during its initialization.

 - Some windows however have to be dynamically created: the PCIe
   memory and I/O windows. For these, the Device Tree only specifies
   the MBus target ID and attribute for each PCIe interface, but the
   windows are created by the pci-mvebu driver at runtime, using an
   API provided by the mvebu-mbus driver.

Windows, in addition to having a (target ID, target attribute)
identifying the device plus a (physical address, size) describing
where the window is mapped in the CPU physical address, can describe a
"remap address". It's basically an additional register that exists for
each configurable MBus window, which allows to say at what address the
window is mapped "from the point of view of the device".

For now, such remappable windows were only used for PCI I/O windows:
even if an I/O window is visible at (say) 0xe8000000 in the CPU
physical address space, we still need to make the PCIe device believe
the PCIe I/O accesses are made from address (say) 0x10000. This is
what the remappable register that exists for each window allows to do.

For dynamically created windows, this works all fine: the mvebu-mbus
driver provides an API to create windows while specifying a remappable
address. So for the PCIe case, no problem.

Now, on the newly released Armada 39x SoC, the networking complex
requires some MBus windows, and one of them needs to be configured
with a certain "remap" value. Those windows are not dynamic like the
PCIe ones: they should be defined statically in the Device Tree, just
like the MBus window for a NOR flash.

Unfortunately, it seems we designed the Device Tree binding for MBus
without this use case in mind: there is no way in the MBus DT binding
to specify a "remap" address for a certain window.

Do you have an idea on how we could extend the MBus Device Tree
binding to encode this additional information?

If you want to learn more about this remappable attribute, look at the
public Armada XP datasheet
(http://www.marvell.com/embedded-processors/armada-xp/assets/ARMADA-XP-Functional-SpecDatasheet.pdf),
section 3.1.1 for example. This section is only about PCIe remapping,
but the same happens for other devices. Also look at the description
of register 0x20008 (table 182, page 631), it describes the remap
register for window 0.

Thanks for your input,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
