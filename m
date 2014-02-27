From: cov@codeaurora.org (Christopher Covington)
Date: Thu, 27 Feb 2014 08:12:35 -0500
Subject: [RFC] ARM VM System Sepcification
In-Reply-To: <20140226195111.GB16149@cbox>
References: <20140226183454.GA14639@cbox> <530E402C.9040502@codeaurora.org>
 <20140226195111.GB16149@cbox>
Message-ID: <530F39C3.5060808@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,

On 02/26/2014 02:51 PM, Christoffer Dall wrote:
> On Wed, Feb 26, 2014 at 02:27:40PM -0500, Christopher Covington wrote:

>>> Image format
>>> ------------
>>> The image format, as presented to the VM, needs to be well-defined in
>>> order for prepared disk images to be bootable across various
>>> virtualization implementations.
>>>
>>> The raw disk format as presented to the VM must be partitioned with a
>>> GUID Partition Table (GPT).  The bootable software must be placed in the
>>> EFI System Partition (ESP), using the UEFI removable media path, and
>>> must be an EFI application complying to the UEFI Specification 2.4
>>> Revision A [6].
>>>
>>> The ESP partition's GPT entry's partition type GUID must be
>>> C12A7328-F81F-11D2-BA4B-00A0C93EC93B and the file system must be
>>> formatted as FAT32/vfat as per Section 12.3.1.1 in [6].
>>>
>>> The removable media path is \EFI\BOOT\BOOTARM.EFI for the aarch32
>>> execution state and is \EFI\BOOT\BOOTAA64.EFI for the aarch64 execution
>>> state.
>>>
>>> This ensures that tools for both Xen and KVM can load a binary UEFI
>>> firmware which can read and boot the EFI application in the disk image.
>>>
>>> A typical scenario will be GRUB2 packaged as an EFI application, which
>>> mounts the system boot partition and boots Linux.
>>>
>>>
>>> Virtual Firmware
>>> ----------------
>>> The VM system must be able to boot the EFI application in the ESP.  It
>>> is recommended that this is achieved by loading a UEFI binary as the
>>> first software executed by the VM, which then executes the EFI
>>> application.  The UEFI implementation should be compliant with UEFI
>>> Specification 2.4 Revision A [6] or later.
>>>
>>> This document strongly recommends that the VM implementation supports
>>> persistent environment storage for virtual firmware implementation in
>>> order to ensure probable use cases such as adding additional disk images
>>> to a VM or running installers to perform upgrades.
>>>
>>> The binary UEFI firmware implementation should not be distributed as
>>> part of the VM image, but is specific to the VM implementation.
>>
>> Can you elaborate on the motivation for requiring that the kernel be stuffed
>> into a disk image and for requiring such a heavyweight bootloader/firmware? By
>> doing so you would seem to exclude those requiring an optimized boot process.
>>
> 
> What's the alternative?  Shipping kernels externally and loading them
> externally?  Sure you can do that, but then distros can't upgrade the
> kernel themselves, and you have to come up with a convention for how to
> ship kernels, initrd's etc.

The self-hosted upgrades use case makes sense. I can imagine using a
pass-through or network filesystem to do it in the case of external loading,
something like the following. In the case of P9, the tag could be the same as
the GPT GUID. Everything could still be in the /EFI/BOOT directory. The kernel
Image could be at BOOT(ARM|AA64).IMG, the zImage at .ZMG, and the initramfs at
.RFS. It's more work for distros to support multiple upgrade methods, though,
so maybe those who want an optimized boot process should make an external
loader capable of carving the necessary components out of a VFAT filesystem
inside a GPT partitioned image instead.

>>> VM Platform
>>> -----------
>>> The specification does not mandate any specific memory map.  The guest
>>> OS must be able to enumerate all processing elements, devices, and
>>> memory through HW description data (FDT, ACPI) or a bus-specific
>>> mechanism such as PCI.
>>>
>>> The virtual platform must support at least one of the following ARM
>>> execution states:
>>>   (1) aarch32 virtual CPUs on aarch32 physical CPUs
>>>   (2) aarch32 virtual CPUs on aarch64 physical CPUs
>>>   (3) aarch64 virtual CPUs on aarch64 physical CPUs
>>>
>>> It is recommended to support both (2) and (3) on aarch64 capable
>>> physical systems.
>>>
>>> The virtual hardware platform must provide a number of mandatory
>>> peripherals:
>>>
>>>   Serial console:  The platform should provide a console,
>>>   based on an emulated pl011, a virtio-console, or a Xen PV console.
>>>
>>>   An ARM Generic Interrupt Controller v2 (GICv2) [3] or newer.  GICv2
>>>   limits the the number of virtual CPUs to 8 cores, newer GIC versions
>>>   removes this limitation.
>>>
>>>   The ARM virtual timer and counter should be available to the VM as
>>>   per the ARM Generic Timers specification in the ARM ARM [1].
>>>
>>>   A hotpluggable bus to support hotplug of at least block and network
>>>   devices.  Suitable buses include a virtual PCIe bus and the Xen PV
>>>   bus.
>>
>> Is VirtIO hotplug capable? Over PCI or MMIO transports or both?
> 
> VirtIO devices attached on a PCIe bus are hotpluggable, the emulated
> PCIe bus itself would not have anything to do with virtio, except that
> virtio devices can hang off of it.  AFAIU.

So network/block device only as memory mapped peripherals (like SMSC or PL
SD/MMC) or over VirtIO-MMIO won't meet the specification? Is PCI/VirtIO-PCI on
ARM production ready? What's the motivation for requiring hotplug?

Thanks,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
