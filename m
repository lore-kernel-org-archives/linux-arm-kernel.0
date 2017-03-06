From: eric.auger@redhat.com (Eric Auger)
Date: Mon,  6 Mar 2017 12:34:15 +0100
Subject: [PATCH v3 00/19] vITS save/restore
Message-ID: <1488800074-21991-1-git-send-email-eric.auger@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series specifies and implements an API aimed at saving and restoring
the state of the in-kernel emulated ITS device.

The ITS is programmed through registers and tables. Those latter
are allocated by the guest. Their base address is programmed in
registers or table entries before the ITS is enabled.

The ITS is free to use some of them to flush its internal caches. This
is likely to be used when entering low power state.

Therefore, for save/restore use case, it looks natural to use this
guest RAM allocated space to save the table related data. However,
currently, The ITS in-kernel emulated device does not use all of those
tables and for those it uses, it does not always sync them with its
cached data. Additional sync must happen for:
- the collection table
- the device table
- the per-device translation tables
- the LPI pending tables.

The LPI configation table and the command queues do not need extra
syncs.

An alternative to flushing the tables into guest RAM could have been
to flush them into a separate user-space buffer. However the drawback
of this alternative is that the virtualizer would allocate dedicated
buffers to store the data that should normally be laid out in guest
RAM. It would also be obliged to re-compute their size from
register/table content.

So saving the tables in guest RAM better fit the ITS programming
model and optimizes the memory usage. The drawback of this solution
is it brings additional challenges at user-space level to make sure
the guest RAM is frozen after table sync.

Best Regards

Eric

Git: complete series available at
https://github.com/eauger/linux/tree/v4.11-rc1-its-mig-v3

* Testing:
- on Cavium ThunderX using a virtio-net-pci guest,
  virsh save/restore commands and virt-manager live migration.
  Tested with 1 and 2 stage device table.

History:

v2 -> v3:
- fix restore ITS ITT_addr bit masking

v1 -> v2:
- rebased on Vijaya's v11
- all entries now are 8 byte large
- devid/eventid indexing for device table and ITT
- support 2 stage device table
- common infra to read indexed tables
- add cpu <-> le64 conversions
- itte renamed into ite
- do not care anymore about pending table 1st KB
  (not needed at the moment for coarse mapping)

RFC v1
- creation


Eric Auger (19):
  KVM: arm/arm64: Add vITS save/restore API documentation
  KVM: arm/arm64: rename itte into ite
  arm/arm64: vgic: turn vgic_find_mmio_region into public
  KVM: arm64: ITS: KVM_DEV_ARM_VGIC_GRP_ITS_REGS group
  KVM: arm64: ITS: Implement vgic_its_has_attr_regs and attr_regs_access
  KVM: arm64: ITS: Implement vgic_mmio_uaccess_write_its_creadr
  KVM: arm64: ITS: Report the ITE size in GITS_TYPER
  KVM: arm64: ITS: Interpret MAPD Size field and check related errors
  KVM: arm64: ITS: Interpret MAPD ITT_addr field
  KVM: arm64: ITS: Check the device id matches TYPER DEVBITS range
  KVM: arm64: ITS: KVM_DEV_ARM_VGIC_GRP_ITS_TABLES group
  KVM: arm64: ITS: vgic_its_alloc_ite/device
  KVM: arm64: ITS: Sort the device and ITE lists
  KVM: arm64: ITS: Add infrastructure for table lookup
  KVM: arm64: ITS: Collection table save/restore
  KVM: arm64: ITS: vgic_its_check_id returns the entry's GPA
  KVM: arm64: ITS: ITT flush and restore
  KVM: arm64: ITS: Device table save/restore
  KVM: arm64: ITS: Pending table save/restore

 Documentation/virtual/kvm/devices/arm-vgic-its.txt |   78 ++
 arch/arm/include/uapi/asm/kvm.h                    |    2 +
 arch/arm64/include/uapi/asm/kvm.h                  |    2 +
 include/linux/irqchip/arm-gic-v3.h                 |    3 +
 virt/kvm/arm/vgic/vgic-its.c                       | 1031 ++++++++++++++++++--
 virt/kvm/arm/vgic/vgic-mmio.c                      |    3 +-
 virt/kvm/arm/vgic/vgic-mmio.h                      |   14 +-
 7 files changed, 1022 insertions(+), 111 deletions(-)

-- 
2.5.5
