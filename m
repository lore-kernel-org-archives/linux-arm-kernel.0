From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Tue, 22 Dec 2009 18:54:56 +0800
Subject: [PATCH 00/11] Device-tree support for ARM
Message-ID: <1261479296.245235.191110925832.0.gpush@pororo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

The following series of patches is an early prototype to add device tree
support to the ARM architecture.

If you're not familiar with device trees: a device tree is a data
structure describing the hardware that the kernel is booted on. On boot,
the bootloader can pass a 'device tree blob' to the kernel; the kernel
then parses the blob and extracts data used to initialise the machine.
Think ATAGS with a free-form structure and arbitrary property names and
values.

For cases where we don't want to rely on the bootloader's device tree
blob[1] (maybe we have an updated one with fixes), we can supply our own
device tree, attached to the kernel and passed through a boot wrapper.

Device trees are currently used in the boot process for the powerpc,
sparc and microblaze architectures.

This work is aimed at reducing the effort required to port to a new
board. Some hardware changes to may not require a new kernel at all;
these may be described by a corresponding change to the device
tree.

We'd also hope to see an overall decrease in code required as drivers
can be made generic enough to support a set of compatible devices, with
the differences being represented in the device tree.

At this stage, I've just added a mechanism to probe a platform
(Versatile PB) using a device tree; this is just a proof of concept for
machine probe, the interesting stuff happens when we can add DT support
to drivers that the DT-enabled platforms use. Also todo is the boot
wrapper to enable us to embed an updated DT in a bootable image.

These patches are based on Grant Likely's test-devicetree repo[2], which
is an effort to merge the common device tree code between the powerpc,
sparc and microblaze architectures. I have a git tree[3] of these
patches up too, based on his tree.

The approach I've chosen for a boot interface is to add an ATAG that
points to a device tree blob. If this ATAG is found, we use the
device-tree based discovery. There are a couple of other options, but I
think this is the least-intrusive method of passing the DT to the
kernel, and will continue to work with non-DT bootloaders.

If you'd like to try the code out, I have a page[4] up that has
details of the kernel, a link to DT-enabled qemu sources and a sample
device tree for the versatile machine.

This is only an initial prototype, but I'd appreciate any comments,
feedback or review.

Cheers,


Jeremy

1: http://lkml.org/lkml/2009/5/27/446
2: http://git.secretlab.ca/?p=linux-2.6.git;a=shortlog;h=refs/heads/test-devicetree
3: http://kernel.ubuntu.com/git?p=jk/dt/linux-2.6.git;a=summary
4: https://wiki.ubuntu.com/KernelTeam/ARMDeviceTrees

---
Jeremy Kerr (11):
      arm: change command_line to cmd_line, and export it
      arm: use generic infrastructure for early params
      arm: export arm_add_memory
      arm-dt: Add ATAG_DEVTREE tag
      arm-dt: Add CONFIG_ARM_DEVTREE
      arm-dt: postpone machine detection until setup_arch with CONFIG_ARM_DEVTREE
      arm-dt: parse devtree pointer on boot
      arm-dt: parse memory info from DT
      arm-dt: probe for device-tree enabled platforms
      arm-dt: parse initrd from device tree
      arm/versatile: probe via device tree
