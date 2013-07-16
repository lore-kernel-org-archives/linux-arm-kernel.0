From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 16 Jul 2013 17:05:42 +0100
Subject: [RFC PATCH v5 0/1] drivers: mfd: Versatile Express SPC support
Message-ID: <1373990743-23106-1-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

version v5 of VExpress SPC driver, please read on the changelog for major
changes and explanations.

The probing scheme is unchanged, since after trying the early platform
devices approach it appeared that the end result was no better than the
current one. The only clean solution relies either on changing how
secondaries are brought up in the kernel (later than now) or enable
early platform device registration through DT. Please check this
thread for the related discussion:

https://lists.ozlabs.org/pipermail/devicetree-discuss/2013-June/036542.html

The interface was adapted to regmap and again reverted to old driver for
the following reasons:

- Power down registers locking is hairy and requires arch spinlocks in
  the MCPM back end to work properly, normal spinlocks cannot be used
- Regmap adds unnecessary code to manage SPC since it is just a bunch of
  registers used to control power management flags, the overhead is just
  not worth it (talking about power down registers, not the vexpress config
  interface)
- The locking scheme behind regmap requires all registers in the map
  to be protected with the same lock, which is not exactly what we want
  here
- Given the reasons above, adding a regmap interface buys us nothing from
  a driver readability and maintainability perspective (again just talking
  about the power interface, a few registers) because for the SPC it would
  simply not be used

/drivers/mfd is probably not the right place for this code as it stands (but
probably will be when the entire driver, with DVFS and config interface, is
complete).

Thank you for the review in advance,
Lorenzo

This patch is v5 of a previous posting:

http://lists.infradead.org/pipermail/linux-arm-kernel/2013-June/177150.html

v5 changes:

- Completely removed vexpress-config interface waiting for refactoring
  based on regmap
- Removed frequency scaling interface and operating points programming
  retrieval
- Trimmed the driver code and DT bindings

v4 changes:
- Applied review comments (trimmed function names, added comments, refactored
  some APIs)
- Added comments throughout the set
- Fixed irq handler bug in checking the transaction status
- Improved commit log to explain early init synchro scheme
- Created a single static structure for variables dynamically allocated to
  remove usage of static
- Improved Kconfig entry

v3 changes:

- added __refdata to spc_check_loaded pointer
- removed some exported symbols
- added node pointer check in vexpress_spc_init()

v2 changes:

- Dropped timeout interface patch
- Converted interfaces to non-timeout ones, integrated and retested
- Removed mutex used at init
- Refactored code to work around init sections warning
- Fixed two minor bugs

Lorenzo Pieralisi (1):
  drivers: mfd: vexpress: add Serial Power Controller (SPC) support

 Documentation/devicetree/bindings/mfd/vexpress-spc.txt |  36 ++
 drivers/mfd/Kconfig                                    |  10 +
 drivers/mfd/Makefile                                   |   1 +
 drivers/mfd/vexpress-spc.c                             | 253 ++++++++++
 include/linux/vexpress.h                               |  17 +
 5 files changed, 317 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/vexpress-spc.txt
 create mode 100644 drivers/mfd/vexpress-spc.c

-- 
1.8.2.2
