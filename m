From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sat, 29 Oct 2016 21:36:54 +0200
Subject: [PATCH 00/15] use permission-specific DEVICE_ATTR variants
Message-ID: <1477769829-22230-1-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Use DEVICE_ATTR_RO etc. for read only attributes etc.  This simplifies the
source code, improves readbility, and reduces the chance of
inconsistencies.

The complete semantic patch is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@ro@
declarer name DEVICE_ATTR;
identifier x,x_show;
@@

DEVICE_ATTR(x, \(0444\|S_IRUGO\), x_show, NULL);

@wo@
declarer name DEVICE_ATTR;
identifier x,x_store;
@@

DEVICE_ATTR(x, \(0200\|S_IWUSR\), NULL, x_store);

@rw@
declarer name DEVICE_ATTR;
identifier x,x_show,x_store;
@@

DEVICE_ATTR(x, \(0644\|S_IRUGO|S_IWUSR\), x_show, x_store);

@script:ocaml@
x << ro.x;
x_show << ro.x_show;
@@

if not (x^"_show" = x_show) then Coccilib.include_match false

@script:ocaml@
x << wo.x;
x_store << wo.x_store;
@@

if not (x^"_store" = x_store) then Coccilib.include_match false

@script:ocaml@
x << rw.x;
x_show << rw.x_show;
x_store << rw.x_store;
@@

if not (x^"_show" = x_show && x^"_store" = x_store)
then Coccilib.include_match false

@@
declarer name DEVICE_ATTR_RO;
identifier ro.x,ro.x_show;
@@

- DEVICE_ATTR(x, \(0444\|S_IRUGO\), x_show, NULL);
+ DEVICE_ATTR_RO(x);

@@
declarer name DEVICE_ATTR_WO;
identifier wo.x,wo.x_store;
@@

- DEVICE_ATTR(x, \(0200\|S_IWUSR\), NULL, x_store);
+ DEVICE_ATTR_WO(x);

@@
declarer name DEVICE_ATTR_RW;
identifier rw.x,rw.x_show,rw.x_store;
@@

- DEVICE_ATTR(x, \(0644\|S_IRUGO|S_IWUSR\), x_show, x_store);
+ DEVICE_ATTR_RW(x);
// </smpl>

---

 arch/mips/txx9/generic/7segled.c                  |    4 ++--
 arch/powerpc/kernel/iommu.c                       |    3 +--
 arch/tile/kernel/sysfs.c                          |   14 +++++++-------
 drivers/atm/solos-pci.c                           |    2 +-
 drivers/pci/pcie/aspm.c                           |    4 ++--
 drivers/power/supply/wm8350_power.c               |    2 +-
 drivers/ptp/ptp_sysfs.c                           |    2 +-
 drivers/thermal/int340x_thermal/int3400_thermal.c |    2 +-
 drivers/thermal/thermal_hwmon.c                   |    2 +-
 drivers/tty/nozomi.c                              |    4 ++--
 drivers/usb/wusbcore/dev-sysfs.c                  |    6 +++---
 drivers/usb/wusbcore/wusbhc.c                     |   13 +++++--------
 drivers/video/fbdev/wm8505fb.c                    |    2 +-
 sound/soc/omap/mcbsp.c                            |    4 ++--
 sound/soc/soc-dapm.c                              |    2 +-
 15 files changed, 31 insertions(+), 35 deletions(-)
