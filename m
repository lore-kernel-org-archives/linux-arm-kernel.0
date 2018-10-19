From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Fri, 19 Oct 2018 14:08:46 +0200
Subject: [PATCH 00/12] introduce support for early platform drivers
In-Reply-To: <20180511162028.20616-1-brgl@bgdev.pl>
References: <20180511162028.20616-1-brgl@bgdev.pl>
Message-ID: <CAMRc=MdShqv00spBgOu1=YfG9enZ6umPss7kfi=XRV=J6S3qGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pt., 11 maj 2018 o 18:21 Bartosz Golaszewski <brgl@bgdev.pl> napisa?(a):
>
> This series is a follow-up to the RFC[1] posted a couple days ago.
>
> NOTE: this series applies on top of my recent patches[2] that move the previous
> implementation of early platform devices to arch/sh.
>
> Problem:
>
> Certain class of devices, such as timers, certain clock drivers and irq chip
> drivers need to be probed early in the boot sequence. The currently preferred
> approach is using one of the OF_DECLARE() macros. This however does not create
> a platform device which has many drawbacks - such as not being able to use
> devres routines, dev_ log functions or no way of deferring the init OF function
> if some other resources are missing.
>
> For drivers that use both platform drivers and OF_DECLARE the situation is even
> more complicated as the code needs to take into account that there can possibly
> be no struct device present. For a specific use case that we're having problems
> with, please refer to the recent DaVinci common-clock conversion patches and
> the nasty workaround that this problem implies[3].
>
> We also used to have an early platform drivers implementation but they were not
> integrated with the linux device model at all - they merely used the same data
> structures. The users could not use devres, defer probe and the early devices
> never became actual platform devices later on.
>
> Proposed solution:
>
> This series aims at solving this problem by (re-)introducing the concept of
> early platform drivers and devices - this time however in a way that seamlessly
> integrates with the existing platform drivers and also offers device-tree
> support.
>
> The idea is to provide a way for users to probe devices early, while already
> being able to use devres, devices resources and properties and also deferred
> probing.
>
> New structures are introduced: the early platform driver contains the
> early_probe callback which has the same signature as regular platform_device
> probe. This callback is called early on. The user can have both the early and
> regular probe speficied or only one of them and they both receive the same
> platform device object as argument. Any device data allocated early will be
> carried over to the normal probe.
>
> The architecture code is responsible for calling early_platform_start() in
> which the early drivers will be registered and devices populated from DT.
>
> Once the device and kobject mechanisms are ready, all early drivers and devices
> will be converted into real platform drivers and devices. Also: if any of the
> early platform registration functions will be called once early initialization
> is done, these functions will work like regular platform_device/driver ones.
>
> Patches 1-9/12 introduce changes to existing code that are necessary before
> adding support for early drivers. Patch 10/12 contains the new framwork in an
> isolated file which can be compiled only if needed by the architecture.
>
> Patch 11/12 contains a dummy early platform driver that serves as a code
> example and can be used for simple testing.
>
> The last patch finally makes the of/platform code aware of early platform
> drivers.
>
> If accepted, this new mechanism could potentially lead to consolidation of the
> code currently used by users of OF_DECLARE, since they could be converted to
> actual platform drivers.
>
> [1] https://lkml.org/lkml/2018/4/26/657
> [2] https://lkml.org/lkml/2018/4/30/547
> [3] https://lkml.org/lkml/2018/4/26/1094
>
> Bartosz Golaszewski (12):
>   platform/early: add a new field to struct device
>   platform/early: don't WARN() on non-empty devres list for early
>     devices
>   platform/early: export platform_match() locally
>   platform: provide a separate function for initializing platform
>     devices
>   platform: export platform_device_release() locally
>   of: add a new flag for OF device nodes
>   of/platform: provide a separate routine for setting up device
>     resources
>   of/platform: provide a separate routine for device initialization
>   platform/early: add an init section for early driver data
>   platform/early: implement support for early platform drivers
>   misc: implement a dummy early platform driver
>   of/platform: make the OF code aware of early platform drivers
>
>  drivers/base/Kconfig              |   3 +
>  drivers/base/Makefile             |   1 +
>  drivers/base/base.h               |   4 +
>  drivers/base/dd.c                 |   2 +-
>  drivers/base/early.c              | 332 ++++++++++++++++++++++++++++++
>  drivers/base/platform.c           |  28 ++-
>  drivers/misc/Kconfig              |   8 +
>  drivers/misc/Makefile             |   2 +
>  drivers/misc/dummy-early.c        |  82 ++++++++
>  drivers/of/platform.c             |  85 +++++---
>  include/asm-generic/vmlinux.lds.h |  11 +
>  include/linux/device.h            |   1 +
>  include/linux/early_platform.h    |  75 +++++++
>  include/linux/of.h                |   1 +
>  include/linux/of_platform.h       |   2 +
>  include/linux/platform_device.h   |   2 +
>  16 files changed, 604 insertions(+), 35 deletions(-)
>  create mode 100644 drivers/base/early.c
>  create mode 100644 drivers/misc/dummy-early.c
>  create mode 100644 include/linux/early_platform.h
>
> --
> 2.17.0
>

Hi

For anyone interested: I'll be doing a BoF about early platform
drivers next week on Monday at 6:00pm during the ELCE 2018 in
Edinburgh. It would be great to discuss this topic personally.

Best regards and hope to see you there
Bartosz Golaszewski
