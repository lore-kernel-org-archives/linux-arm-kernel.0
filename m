From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 13 Apr 2016 11:35:58 +0200
Subject: [PATCH v7 0/2] AMBA: add complete support for power domains
Message-ID: <1460540160-18762-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(Old thread name: Exynos4210: fix power domain for MDMA1 device)

This patchset solves the problem of registering AMBA device, which might
be a part of power domain. In some cases not all resources needed for
device registration might be available, because their provides are not
yet probed. The caller for amba_device_add() don't support -EPROBE_DEFER
return code, so in such case, success is returned and device is added to
special deferred list. Registration of devices from that list is
performed everytime when deferred probe action has been performed until
it finally succeeds.

This patchset originates from the patches for fixing mysterious boot
hang on Exynos 4210 SoCs when IOMMU was enabled. There is no direct
dependency between IOMMU devices and AMBA devices, however enabling
IOMMU changes the device probe order, what results in turning off some
power domains during boot. Then the registration of MDMA1 (PL330 AMBA)
device happens, what results in system hangs, because the common bus
code tries to read PID/CID registers from turned-off device.

Best regards
Marek Szyprowski
Samsung R&D Institute Poland

Changelog:

v7:
- replaced late_initcall approach with a notifier registered to device core

v6: https://lkml.org/lkml/2016/4/12/414
- got back to v1-style approach on Russell King request to avoid ABI break
- use list for storing deferred devices and retry their registration from
  late_initcall

v5: https://lkml.org/lkml/2016/2/10/179
- added 2 more patches to avoid regression with existing drivers (nvdimm and
  sa1111), for more information, see https://lkml.org/lkml/2015/12/17/390
- changed thread name to "AMBA: add complete support for power domains"

v4: https://lkml.org/lkml/2015/12/2/52
- fixed more issues pointed by Ulf Hansson and Russell King

v3: https://lkml.org/lkml/2015/12/1/334
- fixed issues pointed by Ulf Hansson
- dropped patch for exynos4210 dts, because it already got queued for merging

v2: https://lkml.org/lkml/2015/11/26/229
- added 2 patches from 'On-demand device probing' thread
  (https://lkml.org/lkml/2015/9/29/189), which move PID/CIR reading
  from amba_device_add() to amba_match()
- moved dev_pm_domain_attach() to amba_match(), which is allowed to
  return -EPROBE_DEFER

v1: http://www.spinics.net/lists/arm-kernel/msg463185.html
- initial version


Patch summary:

Marek Szyprowski (2):
  drivers: base: add support for registering notifier about deferred
    probe
  drivers: amba: properly handle devices with power domains

 drivers/amba/bus.c     | 106 ++++++++++++++++++++++++++++++++++++++++++++-----
 drivers/base/dd.c      |  31 +++++++++++++++
 include/linux/device.h |   3 ++
 3 files changed, 130 insertions(+), 10 deletions(-)

-- 
1.9.2
