From: jens.wiklander@linaro.org (Jens Wiklander)
Date: Wed,  8 Jul 2015 12:16:27 +0200
Subject: [PATCH v4 0/5] generic TEE subsystem
Message-ID: <1436350592-7732-1-git-send-email-jens.wiklander@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch set introduces a generic TEE subsystem. The TEE subsystem will be
able contain drivers for various TEE implementations. A TEE (Trusted
Execution Environment) is a trusted OS running in some secure environment,
for example, TrustZone on ARM cpus, or a separate secure co-processor etc.

Regarding use cases, TrustZone has traditionally been used for
offloading secure tasks to the secure world. Examples include banking
applications, Digital Rights Management (DRM), or specific secure
solutions.

This TEE subsystem can serve a TEE driver for a Global Platform compliant
TEE, but it's not limited to only Global Platform TEEs.  One reason why I'm
doing this to be able to get an OP-TEE (https://github.com/OP-TEE/optee_os)
driver upstream.

"tee: generic TEE subsystem" brings in the generic TEE subsystem which
helps when writing a driver for a specific TEE, for example, OP-TEE.

"tee: add OP-TEE driver" is an OP-TEE driver which uses the subsystem to do
its work.

This patch set has been prepared in cooperation with Javier Gonz?lez who
proposed "Generic TrustZone Driver in Linux Kernel" patches 28 Nov 2014,
https://lwn.net/Articles/623380/ . We've since then changed the scope to
TEE instead of TrustZone.

We have discussed the design on tee-dev at lists.linaro.org (archive at
https://lists.linaro.org/pipermail/tee-dev/) with people from other
companies, including Valentin Manea <valentin.manea@huawei.com>,
Emmanuel MICHEL <emmanuel.michel@st.com>,
Jean-michel DELORME <jean-michel.delorme@st.com>,
and Joakim Bech <joakim.bech@linaro.org>. Our main concern has been to
agree on something that is generic enough to support many different
TEEs while still keeping the interface together.

v4:
* Rebased on 4.1
* Redesigned the synchronization around entry exit of normal SMC
* Replaced rwsem on the driver instance with kref and completion since
  rwsem wasn't intended to be used in this way
* Expanded the TEE_IOCTL_PARAM_ATTR_TYPE_MASK to make room for
  future additional parameter types
* Documents TEE subsystem and OP-TEE driver
* Replaced TEE_IOC_CMD with TEE_IOC_OPEN_SESSION, TEE_IOC_INVOKE,
  TEE_IOC_CANCEL and TEE_IOC_CLOSE_SESSION
* DT bindings in a separate patch
* Assembly parts moved to arch/arm and arch/arm64 respectively, in a
  separate patch
* Redefined/clarified the meaning of OPTEE_SMC_SHM_CACHED
* Removed CMA usage to limit the scope of the patch set

v3:
* Rebased on 4.1-rc3 (dma_buf_export() API change)
* A couple of small sparse fixes
* Documents bindings for OP-TEE driver
* Updated MAINTAINERS

v2:
* Replaced the stubbed OP-TEE driver with a real OP-TEE driver
* Removed most APIs not needed by OP-TEE in current state
* Update Documentation/ioctl/ioctl-number.txt with correct path to tee.h
* Rename tee_shm_pool_alloc_cma() to tee_shm_pool_alloc()
* Moved tee.h into include/uapi/linux/
* Redefined tee.h IOCTL macros to be directly based on _IOR and friends
* Removed version info on the API to user space, a data blob which
  can contain an UUID is left for user space to be able to tell which
  protocol to use in TEE_IOC_CMD
* Changed user space exposed structures to only have types with __ prefix
* Dropped THIS_MODULE from tee_fops
* Reworked how the driver is registered and ref counted:
  - moved from using an embedded struct miscdevice to an embedded struct
    device.
  - uses an struct rw_semaphore as synchronization for driver detachment
  - uses alloc/register pattern from TPM

Thanks,
Jens

Jens Wiklander (5):
  arm/arm64: add smccc ARCH32
  dt/bindings: add bindings for optee
  tee: generic TEE subsystem
  tee: add OP-TEE driver
  Documentation: tee subsystem and op-tee driver

 Documentation/00-INDEX                             |   2 +
 Documentation/devicetree/bindings/optee/optee.txt  |  17 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 Documentation/ioctl/ioctl-number.txt               |   1 +
 Documentation/tee.txt                              | 117 +++
 MAINTAINERS                                        |  14 +
 arch/arm/Kconfig                                   |   4 +
 arch/arm/kernel/Makefile                           |   2 +
 arch/arm/kernel/smccc-call.S                       |  26 +
 arch/arm/kernel/smccc.c                            |  17 +
 arch/arm64/Kconfig                                 |   4 +
 arch/arm64/kernel/Makefile                         |   1 +
 arch/arm64/kernel/smccc-call.S                     |  34 +
 arch/arm64/kernel/smccc.c                          |  17 +
 drivers/Kconfig                                    |   2 +
 drivers/Makefile                                   |   1 +
 drivers/tee/Kconfig                                |  18 +
 drivers/tee/Makefile                               |   4 +
 drivers/tee/optee/Kconfig                          |   8 +
 drivers/tee/optee/Makefile                         |   5 +
 drivers/tee/optee/call.c                           | 390 ++++++++++
 drivers/tee/optee/core.c                           | 451 +++++++++++
 drivers/tee/optee/optee_msg.h                      | 334 ++++++++
 drivers/tee/optee/optee_private.h                  | 129 ++++
 drivers/tee/optee/optee_smc.h                      | 466 ++++++++++++
 drivers/tee/optee/rpc.c                            | 248 ++++++
 drivers/tee/optee/supp.c                           | 212 ++++++
 drivers/tee/tee.c                                  | 839 +++++++++++++++++++++
 drivers/tee/tee_private.h                          |  80 ++
 drivers/tee/tee_shm.c                              | 324 ++++++++
 drivers/tee/tee_shm_pool.c                         | 133 ++++
 include/linux/arm-smccc.h                          |  80 ++
 include/linux/tee_drv.h                            | 306 ++++++++
 include/uapi/linux/tee.h                           | 376 +++++++++
 34 files changed, 4663 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/optee/optee.txt
 create mode 100644 Documentation/tee.txt
 create mode 100644 arch/arm/kernel/smccc-call.S
 create mode 100644 arch/arm/kernel/smccc.c
 create mode 100644 arch/arm64/kernel/smccc-call.S
 create mode 100644 arch/arm64/kernel/smccc.c
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
 create mode 100644 drivers/tee/tee.c
 create mode 100644 drivers/tee/tee_private.h
 create mode 100644 drivers/tee/tee_shm.c
 create mode 100644 drivers/tee/tee_shm_pool.c
 create mode 100644 include/linux/arm-smccc.h
 create mode 100644 include/linux/tee_drv.h
 create mode 100644 include/uapi/linux/tee.h

-- 
1.9.1
