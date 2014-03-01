From: grant.likely@linaro.org (Grant Likely)
Date: Sat, 01 Mar 2014 15:41:08 +0000
Subject: [RFC] ARM VM System Sepcification
In-Reply-To: <530F39C3.5060808@codeaurora.org>
References: <20140226183454.GA14639@cbox> <530E402C.9040502@codeaurora.org>
 <20140226195111.GB16149@cbox> <530F39C3.5060808@codeaurora.org>
Message-ID: <20140301154108.ECF54C40567@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 27 Feb 2014 08:12:35 -0500, Christopher Covington <cov@codeaurora.org> wrote:
> Hi Christoffer,
> 
> On 02/26/2014 02:51 PM, Christoffer Dall wrote:
> > On Wed, Feb 26, 2014 at 02:27:40PM -0500, Christopher Covington wrote:
> 
> >>> Image format
> >>> ------------
> >>> The image format, as presented to the VM, needs to be well-defined in
> >>> order for prepared disk images to be bootable across various
> >>> virtualization implementations.
> >>>
> >>> The raw disk format as presented to the VM must be partitioned with a
> >>> GUID Partition Table (GPT).  The bootable software must be placed in the
> >>> EFI System Partition (ESP), using the UEFI removable media path, and
> >>> must be an EFI application complying to the UEFI Specification 2.4
> >>> Revision A [6].
> >>>
> >>> The ESP partition's GPT entry's partition type GUID must be
> >>> C12A7328-F81F-11D2-BA4B-00A0C93EC93B and the file system must be
> >>> formatted as FAT32/vfat as per Section 12.3.1.1 in [6].
> >>>
> >>> The removable media path is \EFI\BOOT\BOOTARM.EFI for the aarch32
> >>> execution state and is \EFI\BOOT\BOOTAA64.EFI for the aarch64 execution
> >>> state.
> >>>
> >>> This ensures that tools for both Xen and KVM can load a binary UEFI
> >>> firmware which can read and boot the EFI application in the disk image.
> >>>
> >>> A typical scenario will be GRUB2 packaged as an EFI application, which
> >>> mounts the system boot partition and boots Linux.
> >>>
> >>>
> >>> Virtual Firmware
> >>> ----------------
> >>> The VM system must be able to boot the EFI application in the ESP.  It
> >>> is recommended that this is achieved by loading a UEFI binary as the
> >>> first software executed by the VM, which then executes the EFI
> >>> application.  The UEFI implementation should be compliant with UEFI
> >>> Specification 2.4 Revision A [6] or later.
> >>>
> >>> This document strongly recommends that the VM implementation supports
> >>> persistent environment storage for virtual firmware implementation in
> >>> order to ensure probable use cases such as adding additional disk images
> >>> to a VM or running installers to perform upgrades.
> >>>
> >>> The binary UEFI firmware implementation should not be distributed as
> >>> part of the VM image, but is specific to the VM implementation.
> >>
> >> Can you elaborate on the motivation for requiring that the kernel be stuffed
> >> into a disk image and for requiring such a heavyweight bootloader/firmware? By
> >> doing so you would seem to exclude those requiring an optimized boot process.

This spec doesn't exclude or prevent VMs from doing that if the user
wants to. It is about specifying the base requirements for a disk image
to be portable. Any disk image conforming to this spec should boot on
any VM conforming to the spec.

> > What's the alternative?  Shipping kernels externally and loading them
> > externally?  Sure you can do that, but then distros can't upgrade the
> > kernel themselves, and you have to come up with a convention for how to
> > ship kernels, initrd's etc.
> 
> The self-hosted upgrades use case makes sense. I can imagine using a
> pass-through or network filesystem to do it in the case of external loading,
> something like the following.

Network booting is actually something else that is already supported and
doesn't use the filesystem protocol at all. DHCP+TFTP to obtain the 2nd
stage loader (which can do whatever it wants) is the preferred way to do
things. The problem with trying to provide a network filesystem

Section 3.4.2 (Boot via LOAD_FILE_PROTOCOL) and 3.4.2.1 (Network
Booting) covers that scenario. Network boot uses most of the Preboot
eXecution Environment (PXE) spec except it retrieves an EFI executable
instead of a PXE executable. It is expected that PXE server will then
supply all the boot configuration to the client. The exact same thing
can be done with VMs... all of which is out of scope for this section
because it is talking about disk images!  :-)

g.
