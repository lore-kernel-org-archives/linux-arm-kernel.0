From: Stefano.Stabellini@eu.citrix.com (Stefano Stabellini)
Date: Mon, 17 Sep 2012 18:37:08 +0100
Subject: [PATCH v5 00/17] Introduce Xen support on ARM (based on 3.6-rc5)
Message-ID: <alpine.DEB.2.02.1209171215490.29232@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,
this patch series implements Xen support for ARMv7 with virtualization
extensions.  It allows a Linux guest to boot as dom0 and
as domU on Xen on ARM. PV console, disk and network frontends and
backends are all working correctly.

It has been tested on a Versatile Express Cortex A15 emulator, using the
latest Xen ARM developement branch
(git://xenbits.xen.org/people/ianc/xen-unstable.git arm-for-4.3) plus
the "ARM hypercall ABI: 64 bit ready" patch series
(http://marc.info/?l=xen-devel&m=134426267205408), and a simple ad-hoc
tool to build guest domains (marc.info/?l=xen-devel&m=134089788016546).

The patch marked with [HACK] has been dropped from this series, however
you can find it here:
http://marc.info/?l=linux-kernel&m=134513277823527&w=2.

I am also attaching to this email the dts'es that I am currently using
for dom0 and domU: vexpress-v2p-ca15-tc1.dts (that includes
vexpress-v2m-rs1-rtsm.dtsi) is the dts used for dom0 and it is passed to
Linux by Xen, while vexpress-virt.dts is the dts used for other domUs
and it is appended in binary form to the guest kernel image. I am not
sure where they are supposed to live yet, so I am just attaching them
here so that people can actually try out this series if they want to.

Comments are very welcome!



The patch series has been rebased on Konrad's stable/for-linus-3.7
branch.

Arnd, Russell, what do you think about this series? If you are OK with
it, to whom should I submit it?



Changes in v5:
- rebase on Konrad's stable/for-linus-3.7;
- add a comment about the size of the grant table memory region in the
  device tree documentation;
- add a comment about the required presence of a GIC node in the device
  tree documentation;
- specify that the described properties are part of a top-level
  "hypervisor" node in the device tree documentation;
- specify #address-cells and #size-cells for the device tree example;
- make XEN_DOM0 depend on XEN;
- avoid "select XEN_DOM0" in XEN.


Changes in v4:
- rebase on 3.6-rc5;
- devicetree: "xen,xen" should be last as it is less specific;
- devicetree: use 2 address-cells and 2 size-cells in the reg property;
- do not xs_reset_watches on dom0;
- compile drivers/xen/pcpu.c only on x86;
- use "+=" instead of ":=" for dom0- targets;
- add a patch to update the MAINTAINERS file.


Changes in v3:
- move patches that have been picked up by Konrad at the end of the
  series;
- improve comments;
- add a doc to describe the Xen Device Tree format;
- do not use xen_ulong_t for multicalls and apic_physbase;
- add a patch at the end of the series to use the new __HVC macro;
- add missing pvclock-abi.h include to ia64 header files;
- do not use an anonymous union in struct xen_add_to_physmap.


Changes in v2:
- fix up many comments and commit messages;
- remove the early_printk patches: rely on the emulated serial for now;
- remove the xen_guest_init patch: without any PV early_printk, we don't
  need any early call to xen_guest_init, we can rely on core_initcall
  alone;
- define an HYPERCALL macro for 5 arguments hypercall wrappers, even if
  at the moment is unused;
- use ldm instead of pop in the hypercall wrappers;
- return -ENOSYS rather than -1 from the unimplemented grant_table
  functions;
- remove the pvclock ifdef in the Xen headers;
- remove include linux/types.h from xen/interface/xen.h;
- replace pr_info with pr_debug in xen_guest_init;
- add a new patch to introduce xen_ulong_t and use it top replace all
  the occurences of unsigned long in the public Xen interface;
- explicitely size all the pointers to 64 bit on ARM, so that the
  hypercall ABI is "64 bit ready";
- clean up xenbus_init;
- make pci.o depend on CONFIG_PCI and acpi.o depend on CONFIG_ACPI;
- mark Xen guest support on ARM as EXPERIMENTAL;
- introduce GRANT_TABLE_PHYSADDR;
- remove unneeded initialization of boot_max_nr_grant_frames;
- add a new patch to clear IRQ_NOAUTOEN and IRQ_NOREQUEST in events.c;
- return -EINVAL from xen_remap_domain_mfn_range if
  auto_translated_physmap;
- retain binary compatibility in xen_add_to_physmap: use a union to
  introduce foreign_domid.



Shortlog and diffstat:

Stefano Stabellini (17):
      arm: initial Xen support
      xen/arm: hypercalls
      xen/arm: page.h definitions
      xen/arm: sync_bitops
      xen/arm: empty implementation of grant_table arch specific functions
      docs: Xen ARM DT bindings
      xen/arm: Xen detection and shared_info page mapping
      xen/arm: Introduce xen_ulong_t for unsigned long
      xen: do not compile manage, balloon, pci, acpi, pcpu and cpu_hotplug on ARM
      xen/arm: introduce CONFIG_XEN on ARM
      xen/arm: get privilege status
      xen/arm: initialize grant_table on ARM
      xen/arm: receive Xen events on ARM
      xen/arm: implement alloc/free_xenballooned_pages with alloc_pages/kfree
      xen/arm: compile blkfront and blkback
      xen/arm: compile netback
      MAINTAINERS: add myself as Xen ARM maintainer

 Documentation/devicetree/bindings/arm/xen.txt |   25 ++++
 MAINTAINERS                                   |    7 +
 arch/arm/Kconfig                              |   10 ++
 arch/arm/Makefile                             |    1 +
 arch/arm/include/asm/hypervisor.h             |    6 +
 arch/arm/include/asm/sync_bitops.h            |   27 ++++
 arch/arm/include/asm/xen/events.h             |   18 +++
 arch/arm/include/asm/xen/hypercall.h          |   69 ++++++++++
 arch/arm/include/asm/xen/hypervisor.h         |   19 +++
 arch/arm/include/asm/xen/interface.h          |   73 +++++++++++
 arch/arm/include/asm/xen/page.h               |   82 ++++++++++++
 arch/arm/xen/Makefile                         |    1 +
 arch/arm/xen/enlighten.c                      |  168 +++++++++++++++++++++++++
 arch/arm/xen/grant-table.c                    |   53 ++++++++
 arch/arm/xen/hypercall.S                      |  106 ++++++++++++++++
 arch/ia64/include/asm/xen/interface.h         |    1 +
 arch/x86/include/asm/xen/interface.h          |    1 +
 arch/x86/xen/enlighten.c                      |    1 +
 arch/x86/xen/irq.c                            |    1 +
 arch/x86/xen/xen-ops.h                        |    1 -
 drivers/block/xen-blkback/blkback.c           |    1 +
 drivers/net/xen-netback/netback.c             |    1 +
 drivers/net/xen-netfront.c                    |    1 +
 drivers/xen/Makefile                          |   13 ++-
 drivers/xen/events.c                          |   17 ++-
 include/xen/events.h                          |    2 +
 include/xen/interface/features.h              |    3 +
 include/xen/interface/io/protocols.h          |    3 +
 include/xen/interface/memory.h                |   12 +-
 include/xen/interface/physdev.h               |    2 +-
 include/xen/interface/version.h               |    2 +-
 include/xen/xen.h                             |    2 +-
 32 files changed, 712 insertions(+), 17 deletions(-)


A branch based on 3.6-rc5 and Konrad's stable/for-linus-3.7 is available
here:

git://xenbits.xen.org/people/sstabellini/linux-pvhvm.git 3.6-rc5-arm-5


Cheers,

Stefano
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: vexpress-v2m-rs1.dtsi
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120917/627c2ce3/attachment.ksh>
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: vexpress-v2p-ca15-tc1.dts
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120917/627c2ce3/attachment-0001.ksh>
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: vexpress-virt.dts
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120917/627c2ce3/attachment-0002.ksh>
