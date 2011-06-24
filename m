From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 24 Jun 2011 15:10:55 +0100
Subject: [RFC PATCH 0/4] DT support for ARM GIC and TWD
Message-ID: <1308924659-31894-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series expands my previous SMP timer effort, and adds
device tree support to two very common elements: the GIC and the TWD
timer.

As this is my first trip into DT land, I'm pretty sure there's a lot
to say about the bindings, and I'm specially looking for comments
around the following topics:

- The device_type attribute: when is it valid to use it?

- I used the compatible attribute as a generic way to probe for a
  whole class of device, and I feel this is not the indended usage.

- The TWD binding describes its interrupts inside sub nodes, which
  means the platform device doesn't contain the IRQ resources, and the
  driver has to parse the tree itself. As I'm under the impression
  that a platform driver should only parse the tree to get platform
  data, I wonder if there is some DT magic to solve this particular
  problem in an elegant way?

- early platform devices and DT: I've taken the brute-force approach
  here, and would be very glad if someone could come up with a better
  alternative.

This patch series also depends on a few patches by Grant Likely:
 dt/platform: allow device name to be overridden
 drivers/amba: create devices from device tree
 dt: add of_platform_populate() for creating device from the device tree
 dt: Add default match table for bus ids
 irq: add irq_domain translation infrastructure

The whole branch including the PPI infrastructure, the SMP timer
rework, Grant's patches, this patch series and a few others are (or
will soon be) in the following repository:

git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git local_timer_devices-v3.0-rc4

Marc Zyngier (4):
  dt: early platform devices support
  ARM: dt: register local timers as early platform devices
  ARM: dt: add GIC bindings and driver support
  ARM: dt: Add TWD bindings and driver support

 Documentation/devicetree/bindings/arm/gic.txt |   92 ++++++++
 Documentation/devicetree/bindings/arm/twd.txt |   54 +++++
 arch/arm/common/gic.c                         |  312 ++++++++++++++++++++-----
 arch/arm/include/asm/hardware/gic.h           |    4 +
 arch/arm/kernel/time.c                        |    4 +
 drivers/clocksource/arm_smp_twd.c             |   92 +++++++-
 drivers/of/platform.c                         |   26 ++
 include/linux/of_platform.h                   |    1 +
 8 files changed, 517 insertions(+), 68 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/gic.txt
 create mode 100644 Documentation/devicetree/bindings/arm/twd.txt
