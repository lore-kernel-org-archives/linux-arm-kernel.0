From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Wed, 11 Jun 2014 10:50:04 +0100
Subject: [RFC v2] ARM VM System Specification
In-Reply-To: <5397360B.80102@huawei.com>
References: <20140328184517.GA27219@cbox> <5397360B.80102@huawei.com>
Message-ID: <alpine.DEB.2.02.1406111035190.13771@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Although not in the ARM VM System Specification, Xen is certainly going
to support a fast boot path without UEFI firmware. I guess KVM will too.
You'll have to rely on hypervisor specific mechanisms to achieve it.

In fact I wouldn't worry about UEFI when you need ACPI, that is not in
this specification. Moreover the only hypervisor supporting virtio on
ARM is KVM as far as I know.

So it looks like you are already tying yourself to one hypervisor (KVM)
and an out-of-spec standard (ACPI). The ARM VM System Specification is
for people that intend to produce cross-hypervisor images.


On Tue, 10 Jun 2014, Claudio Fontana wrote:
> Hello all,
> 
> I just wanted to share with you guys how we are using virtualization on ARM64 over here for the OSv project.
> I don't know if that's something that could be useful for your specification effort.
> 
> In OSv, creating and starting a VM to some level means starting an application.
> That is, OSv should be a very thin bare bones guest server OS, which also acts as a kind of run-time library for an application to run.
> All the devices are assumed to be virtualized and heavily relying on virtio.
> 
> Therefore we see a higher need for quick VM launch than it might be for other use cases.
> 
> One aspect of this is that we currently start executing the image directly (no UEFI involved on the guest),
> and in some cases we might not need a full fledged file system at all,
> as the communication can happen via virtio channels.
> 
> We do have a need for ACPI for discovery of information like gic addresses, timers, interrupts... (no interest on device trees, really), and of PCI-E.
> 
> By skipping steps like UEFI, grub, firmware load, etc we strive to keep our application launch time low.
> Is this going to create problems for us in the future if you start requiring every VM to boot using those instead?
> 
> Thank you for your comments,
> 
> Claudio
> 
> 
> On 28.03.2014 19:45, Christoffer Dall wrote:
> > ARM VM System Specification
> > ===========================
> > 
> > Goal
> > ----
> > The goal of this spec is to allow suitably-built OS images to run on
> > all ARM virtualization solutions, such as KVM or Xen.
> > 
> > Recommendations in this spec are valid for aarch32 and aarch64 alike, and
> > they aim to be hypervisor agnostic.
> > 
> > Note that simply adhering to the SBSA [2] is not a valid approach, for
> > example because the SBSA mandates EL2, which will not be available for
> > VMs.  Further, this spec also covers the aarch32 execution mode, not
> > covered in the SBSA.
> > 
> > 
> > Image format
> > ------------
> > The image format, as presented to the VM, needs to be well-defined in
> > order for prepared disk images to be bootable across various
> > virtualization implementations.
> > 
> > The raw disk format as presented to the VM must be partitioned with a
> > GUID Partition Table (GPT).  The bootable software must be placed in the
> > EFI System Partition (ESP), using the UEFI removable media path, and
> > must be an EFI application complying to the UEFI Specification 2.4
> > Revision A [6].
> > 
> > The ESP partition's GPT entry's partition type GUID must be
> > C12A7328-F81F-11D2-BA4B-00A0C93EC93B and the file system must be
> > formatted as FAT32/vfat as per Section 12.3.1.1 in [6].
> > 
> > The removable media path is \EFI\BOOT\BOOTARM.EFI for the aarch32
> > execution state and is \EFI\BOOT\BOOTAA64.EFI for the aarch64 execution
> > state as specified in Section 3.3 (3.3 (Boot Option Variables Default Boot
> > Behavior) and 3.4.1.1 (Removable Media Boot Behavior) in [6].
> > 
> > This ensures that tools for both Xen and KVM can load a binary UEFI
> > firmware which can read and boot the EFI application in the disk image.
> > 
> > A typical scenario will be GRUB2 packaged as an EFI application, which
> > mounts the system boot partition and boots Linux.
> > 
> > 
> > Virtual Firmware
> > ----------------
> > The VM system must be UEFI compliant in order to be able to boot the EFI
> > application in the ESP.  It is recommended that this is achieved by
> > loading a UEFI binary as the first software executed by the VM, which
> > then executes the EFI application.  The UEFI implementation should be
> > compliant with UEFI Specification 2.4 Revision A [6] or later.
> > 
> > This document strongly recommends that the VM implementation supports
> > persistent environment storage for virtual firmware implementation in
> > order to ensure probable use cases such as adding additional disk images
> > to a VM or running installers to perform upgrades.
> > 
> > This document strongly recommends that VM implementations implement
> > persistent variable storage for their UEFI implementation.  Persistent
> > variable storage shall be a property of a VM instance, but shall not be
> > stored as part of a portable disk image.  Portable disk images shall
> > conform to the UEFI removable disk requirements from the UEFI spec and
> > cannot rely on on a pre-configured UEFI environment.
> > 
> > The binary UEFI firmware implementation should not be distributed as
> > part of the VM image, but is specific to the VM implementation.
> > 
> > 
> > Hardware Description
> > --------------------
> > The VM system must be UEFI compliant and therefore the UEFI system table
> > will provide a means to access hardware description data.
> > 
> > The VM implementation must provide through its UEFI implementation:
> > 
> >   a complete FDT which describes the entire VM system and will boot
> >   mainline kernels driven by device tree alone
> > 
> > For more information about the arm and arm64 boot conventions, see
> > Documentation/arm/Booting and Documentation/arm64/booting.txt in the
> > Linux kernel source tree.
> > 
> > For more information about UEFI booting, see [4] and [5].
> > 
> > 
> > VM Platform
> > -----------
> > The specification does not mandate any specific memory map.  The guest
> > OS must be able to enumerate all processing elements, devices, and
> > memory through HW description data (FDT) or a bus-specific
> > mechanism such as PCI.
> > 
> > If aarch64 physical CPUs implement support for the aarch32 execution
> > state in EL1 and EL0 execution, it is recommended that the VM
> > implementation supports booting the VM at EL1 in both aarch32 and
> > aarch64 execution states.
> > 
> > The virtual hardware platform must provide a number of mandatory
> > peripherals:
> > 
> >   Serial console:  The platform should provide a console,
> >   based on an emulated pl011, a virtio-console, or a Xen PV console.
> > 
> >   An ARM Generic Interrupt Controller v2 (GICv2) [3] or newer.  GICv2
> >   limits the the number of virtual CPUs to 8 cores, newer GIC versions
> >   removes this limitation.
> > 
> >   The ARM virtual timer and counter should be available to the VM as
> >   per the ARM Generic Timers specification in the ARM ARM [1].
> > 
> > It is strongly recommended that the VM implementation provides a
> > hotpluggable bus to support hotplug of at least block and network
> > devices.  Suitable buses include a virtual PCIe bus and the Xen PV bus.
> > 
> > For the VM image to be compliant with this spec, the following applies
> > for the guest OS in the VM image:
> > 
> >   The guest OS must include support for pl011 UART, virtio-console, and
> >   the Xen PV console.
> > 
> >   The guest OS must include support for GICv2 and any available newer
> >   version of the GIC architecture to maintain compatibility with older
> >   VM implementations.
> > 
> >   It is strongly recommended to include support for all available
> >   (block, network, console, balloon) virtio-pci, virtio-mmio, and Xen PV
> >   drivers in the guest OS kernel or initial ramdisk.
> > 
> > 
> > Other common peripherals for block devices, networking, and more can
> > (and typically will) be provided, but OS software written and compiled
> > to run on ARM VMs cannot make any assumptions about which variations
> > of these should exist or which implementation they use (e.g. VirtIO or
> > Xen PV).  See "Hardware Description" above.
> > 
> > 
> > Changes from previous versions of this RFC
> > ------------------------------------------
> > Changes v1-v2:
> >  - Clearly specify that the guest must support the pl011,
> >    virtio-console, and Xen PV console.  (Note that it was discussed to
> >    mandate a pl011 during Linaro Connect Asia 2014, but that was under the
> >    impression that the SBSA specification was an output-only no-irq
> >    serial port, which is not the case.  The only two benefits from
> >    mandating a specific serial type was to handle "console=ttyAMA0"
> >    kernel command line parameters and earlyprintk; Grant Likely has
> >    submitted patches to avoid the need for "console=" parameters, and
> >    Rob Herring has submitted patches for paravirtualized earlyprintk
> >    consoles.)
> >  - Reference EFI specification for bootable paths.
> >  - Remove discussion on ACPI boot methods and do not suggest ACPI
> >    support in VMs.
> >  - Add specification about UEFI persistent variable storage and
> >    portability.
> > 
> > 
> > References
> > ----------
> > [1]: The ARM Architecture Reference Manual, ARMv8, Issue A.b
> > http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0487a.b/index.html
> > 
> > [2]: ARM Server Base System Architecture
> > http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.den0029/index.html
> > 
> > [3]: The ARM Generic Interrupt Controller Architecture Specifications v2.0
> > http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0487a.b/index.html
> > 
> > [4]: http://www.secretlab.ca/archives/27
> > 
> > [5]: https://git.linaro.org/people/leif.lindholm/linux.git/blob/refs/heads/uefi-for-upstream:/Documentation/arm/uefi.txt
> > 
> > [6]: UEFI Specification 2.4 Revision A
> > http://www.uefi.org/sites/default/files/resources/2_4_Errata_A.pdf
> > _______________________________________________
> > kvmarm mailing list
> > kvmarm at lists.cs.columbia.edu
> > https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
> > 
> 
> 
> -- 
> Claudio Fontana
> Server Virtualization Architect
> Huawei Technologies Duesseldorf GmbH
> Riesstra?e 25 - 80992 M?nchen
> 
> office: +49 89 158834 4135
> mobile: +49 15253060158
> 
