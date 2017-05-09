From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 9 May 2017 21:05:10 +0200
Subject: [GIT PULL] TEE driver infrastructure and OP-TEE drivers
Message-ID: <CAK8P3a06+bG93H0XzAF1UUN_BbV-Cg3ERpVdR6qLuLpZUmp2Ug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 97da3854c526d3a6ee05c849c96e48d21527606c:

  Linux 4.11-rc3 (2017-03-19 19:09:39 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-tee

for you to fetch changes up to 414d06ace9cca3725b6c2072e1951e1e03807f63:

  Merge tag 'tee-drv-for-4.12' of
git://git.linaro.org:/people/jens.wiklander/linux-tee into next/tee
(2017-03-30 16:16:28 +0200)

----------------------------------------------------------------
TEE driver infrastructure and OP-TEE drivers

This branch introduces a generic TEE framework in the kernel, to handle
trusted environemtns (security coprocessor or software implementations
such as OP-TEE/TrustZone). I'm sending it separately from the other
arm-soc driver changes to give it a little more visibility, once
the subsystem is merged, we will likely keep this in the arm?soc
drivers branch or have the maintainers submit pull requests directly,
depending on the patch volume.

I have reviewed earlier versions in the past, and have reviewed
the latest version in person during Linaro Connect BUD17.

Here is my overall assessment of the subsystem:

* There is clearly demand for this, both for the generic
  infrastructure and the specific OP-TEE implementation.

* The code has gone through a large number of reviews,
  and the review comments have all been addressed, but
  the reviews were not coming up with serious issues any more
  and nobody volunteered to vouch for the quality.

* The user space ioctl interface is sufficient to work with the
  OP-TEE driver, and it should in principle work with other
  TEE implementations that follow the GlobalPlatform[1] standards,
  but it might need to be extended in minor ways depending on
  specific requirements of future TEE implementations

* The main downside of the API to me is how the user space
  is tied to the TEE implementation in hardware or firmware,
  but uses a generic way to communicate with it. This seems
  to be an inherent problem with what it is trying to do,
  and I could not come up with any better solution than what
  is implemented here.

For a detailed history of the patch series, see
https://lkml.org/lkml/2017/3/10/1277

Conflicts: needs a fixup after the drm tree was merged, see
https://patchwork.kernel.org/patch/9691679/

----------------------------------------------------------------
Arnd Bergmann (1):
      Merge tag 'tee-drv-for-4.12' of
git://git.linaro.org:/people/jens.wiklander/linux-tee into next/tee

Jens Wiklander (4):
      dt/bindings: add bindings for optee
      tee: generic TEE subsystem
      tee: add OP-TEE driver
      Documentation: tee subsystem and op-tee driver

Jerome Forissier (1):
      arm64: dt: hikey: Add optee node

 Documentation/00-INDEX                             |   2 +
 .../bindings/arm/firmware/linaro,optee-tz.txt      |  31 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 Documentation/ioctl/ioctl-number.txt               |   1 +
 Documentation/tee.txt                              | 118 +++
 MAINTAINERS                                        |  13 +
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts     |   7 +
 drivers/Kconfig                                    |   2 +
 drivers/Makefile                                   |   1 +
 drivers/tee/Kconfig                                |  18 +
 drivers/tee/Makefile                               |   5 +
 drivers/tee/optee/Kconfig                          |   7 +
 drivers/tee/optee/Makefile                         |   5 +
 drivers/tee/optee/call.c                           | 444 ++++++++++
 drivers/tee/optee/core.c                           | 622 ++++++++++++++
 drivers/tee/optee/optee_msg.h                      | 418 ++++++++++
 drivers/tee/optee/optee_private.h                  | 183 +++++
 drivers/tee/optee/optee_smc.h                      | 450 +++++++++++
 drivers/tee/optee/rpc.c                            | 396 +++++++++
 drivers/tee/optee/supp.c                           | 273 +++++++
 drivers/tee/tee_core.c                             | 893 +++++++++++++++++++++
 drivers/tee/tee_private.h                          | 129 +++
 drivers/tee/tee_shm.c                              | 358 +++++++++
 drivers/tee/tee_shm_pool.c                         | 156 ++++
 include/linux/tee_drv.h                            | 277 +++++++
 include/uapi/linux/tee.h                           | 346 ++++++++
 26 files changed, 5156 insertions(+)
 create mode 100644
Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.txt
 create mode 100644 Documentation/tee.txt
 create mode 100644 drivers/tee/Kconfig
 create mode 100644 drivers/tee/Makefile
 create mode 100644 drivers/tee/optee/Kconfig
 create mode 100644 drivers/tee/optee/Makefile
 create mode 100644 drivers/tee/optee/call.c
 create mode 100644 drivers/tee/optee/core.c
 create mode 100644 drivers/tee/optee/optee_msg.h
 create mode 100644 drivers/tee/optee/optee_private.h
 create mode 100644 drivers/tee/optee/optee_smc.h
 create mode 100644 drivers/tee/optee/rpc.c
 create mode 100644 drivers/tee/optee/supp.c
 create mode 100644 drivers/tee/tee_core.c
 create mode 100644 drivers/tee/tee_private.h
 create mode 100644 drivers/tee/tee_shm.c
 create mode 100644 drivers/tee/tee_shm_pool.c
 create mode 100644 include/linux/tee_drv.h
 create mode 100644 include/uapi/linux/tee.h
