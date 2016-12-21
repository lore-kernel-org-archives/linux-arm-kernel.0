From: alexander.stein@systec-electronic.com (Alexander Stein)
Date: Wed, 21 Dec 2016 16:03:38 +0100
Subject: [PATCH v2 0/2] mark driver as non-removable
Message-ID: <20161221150340.25657-1-alexander.stein@systec-electronic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes in v2;
* Instead of adding a remove function which is unused otherwise, mark the driver
  as non-remoable

Using DEBUG_TEST_DRIVER_REMOVE every driver gets probed, removed and probed
again. This breaks drivers without removal function, e.g. arm perf
resulting in the following dump:
------------[ cut here ]------------
WARNING: CPU: 1 PID: 1 at fs/sysfs/dir.c:31 sysfs_warn_dup+0x6c/0x7c
sysfs: cannot create duplicate filename '/devices/armv7_cortex_a7'
Modules linked in:
CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.9.0+ #212
Hardware name: Freescale LS1021A
Backtrace:
[<8020c044>] (dump_backtrace) from [<8020c2f0>] (show_stack+0x18/0x1c)
 r7:00000009 r6:60000013 r5:80c1776c r4:00000000
[<8020c2d8>] (show_stack) from [<8046ead8>] (dump_stack+0x94/0xa8)
[<8046ea44>] (dump_stack) from [<8021ecd0>] (__warn+0xec/0x104)
 r7:00000009 r6:8092efc8 r5:00000000 r4:bf04bd80
[<8021ebe4>] (__warn) from [<8021ed28>] (warn_slowpath_fmt+0x40/0x48)
 r9:80a32848 r8:00000000 r7:00000000 r6:bf0ab780 r5:8091d590 r4:bf0df000
[<8021ecec>] (warn_slowpath_fmt) from [<8036d53c>] (sysfs_warn_dup+0x6c/0x7c)
 r3:bf0df000 r2:8092ef94
[<8036d4d0>] (sysfs_warn_dup) from [<8036d628>] (sysfs_create_dir_ns+0x8c/0x9c)
 r6:bf0ab780 r5:bf20ee08 r4:ffffffef
[<8036d59c>] (sysfs_create_dir_ns) from [<80471860>] (kobject_add_internal+0xa8/0x34c)
 r6:bf0aa198 r5:00000000 r4:bf20ee08
[<804717b8>] (kobject_add_internal) from [<80471b54>] (kobject_add+0x50/0x94)
 r7:00000000 r6:00000000 r5:00000000 r4:bf20ee08
[<80471b08>] (kobject_add) from [<80524590>] (device_add+0xe4/0x590)
 r3:00000000 r2:00000000
 r6:bf20ee00 r5:00000000 r4:bf20ee08
[<805244ac>] (device_add) from [<802a38a8>] (pmu_dev_alloc+0x88/0xd8)
 r10:00000091 r9:80a32848 r8:00000000 r7:80a32840 r6:80c0ed3c r5:00000000
 r4:bf1fe800
[<802a3820>] (pmu_dev_alloc) from [<80a0cd20>] (perf_event_sysfs_init+0x5c/0xb4)
 r7:80a32840 r6:00000000 r5:bf1fe800 r4:80c0ede0
[<80a0ccc4>] (perf_event_sysfs_init) from [<80201778>] (do_one_initcall+0x48/0x178)
 r6:80c45000 r5:80a0ccc4 r4:00000006
[<80201730>] (do_one_initcall) from [<80a00ecc>] (kernel_init_freeable+0x168/0x20c)
 r8:80a00610 r7:80a32840 r6:80c45000 r5:80c45000 r4:00000006
[<80a00d64>] (kernel_init_freeable) from [<806febcc>] (kernel_init+0x10/0x11c)
 r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:806febbc
 r4:00000000
[<806febbc>] (kernel_init) from [<80208388>] (ret_from_fork+0x14/0x2c)
 r5:806febbc r4:00000000
---[ end trace 9d251d389382804f ]---

This patchset marks the driver as explicitly non-remoavle preventing this error.
This disables bin/unbind for this driver as well.

Alexander Stein (2):
  drivers/perf: arm_pmu: Use devm_ allocators
  arm: perf: Mark as non-removable

 arch/arm/kernel/perf_event_v7.c |  1 +
 drivers/perf/arm_pmu.c          | 14 ++++----------
 2 files changed, 5 insertions(+), 10 deletions(-)

-- 
2.10.2
