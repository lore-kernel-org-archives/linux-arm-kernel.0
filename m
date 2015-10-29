From: jens.wiklander@linaro.org (Jens Wiklander)
Date: Thu, 29 Oct 2015 09:21:22 +0100
Subject: [PATCH v6 0/6] generic TEE subsystem
Message-ID: <1446106888-8983-1-git-send-email-jens.wiklander@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch set introduces a generic TEE subsystem. The TEE subsystem will
contain drivers for various TEE implementations. A TEE (Trusted Execution
Environment) is a trusted OS running in some secure environment, for
example, TrustZone on ARM CPUs, or a separate secure co-processor etc.

Regarding use cases, TrustZone has traditionally been used for
offloading secure tasks to the secure world. Examples include: 
- Secure key handling where the OS may or may not have direct access to key
  material.
- E-commerce and payment technologies. Credentials, credit card numbers etc
  could be stored in a more secure environment.
- Trusted User Interface (TUI) to ensure that no-one can snoop PIN-codes
  etc.
- Secure boot to ensure that loaded binaries haven?t been tampered with.
  It?s not strictly needed for secure boot, but you could enhance security
  by leveraging a TEE during boot.
- Digital Rights Management (DRM), the studios provides content with
  different resolution depending on the security of the device. Higher
  security means higher resolution.

A TEE could also be used in existing and new technologies. For example IMA
(Integrity Measurement Architecture) which has been in the kernel for quite
a while. Today you can enhance security by using a TPM-chip to sign the IMA
measurement list. This is something that you also could do by leveraging a
TEE.

Another example could be in 2-factor authentication which is becoming
increasingly more important. FIDO (https://fidoalliance.org) for example
are using public key cryptography in their 2-factor authentication standard
(U2F). With FIDO, a private and public key pair will be generated for every
site you visit and the private key should never leave the local device.
This is an example where you could use secure storage in a TEE for the
private key.

Today you will find a quite a few different out of tree implementations of
TEE drivers which tends to fragment the TEE ecosystem and development. We
think it would be a good idea to have a generic TEE driver integrated in
the kernel which would serve as a base for several different TEE solutions,
no matter if they are on-chip like TrustZone or if they are on a separate
crypto co-processor.

To develop this TEE subsystem we have been using the open source TEE called
OP-TEE (https://github.com/OP-TEE/optee_os) and therefore this would be the
first TEE solution supported by this new subsystem. OP-TEE is a
GlobalPlatform compliant TEE, however this TEE subsystem is not limited to
only GlobalPlatform TEEs, instead we have tried to design it so that it
should work with other TEE solutions also.

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

At last Linaro Connect, SFO15, I got some additional feedback on this patch
set:
* As each TEE driver has their own tee-supplicant (if any) we need an
  automated way of starting the correct tee-supplicant
  - Addressed with exposing implementation id of a TEE driver in sysfs
* Relying on using only contiguous physical memory when communicating with
  secure world is too constrained
  - Partially addressed with an updated OP-TEE message protocol in the
    OP-TEE driver
  - The main concerns are to avoid incompatible user space API changes and
    also avoid fundamental incompatible changes to the TEE subsystem or
    driver when adding support for physically fragmented memory later on.

v6:
* Rebased on v4.3-rc7
* Changed smccc interface to let the compiler marshal most of the
  parameters
* Added ARCH64 capability for smccc interface
* Changed the PSCI firmware calls (both arm and arm64) to use the new
  generic smccc interface instead instead of own assembly functions.
* Move optee DT bindings to below arm/firmware
* Defines method for OP-TEE driver to call secure world in DT, smc or hvc
* Exposes implementation id of a TEE driver in sysfs
  to easily spawn corresponding tee-supplicant when device is ready
* Update OP-TEE Message Protocol to better cope with fragmented physical
  memory
* Read time directly from OP-TEE driver instead of forwarding the RPC
  request to tee-supplicant

v5:
* Replaced kref reference counting for the device with a size_t instead as
  the counter is always protected by a mutex

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

Jens Wiklander (6):
  arm/arm64: add smccc
  drivers: psci: replace psci firmware calls
  dt/bindings: add bindings for optee
  tee: generic TEE subsystem
  tee: add OP-TEE driver
  Documentation: tee subsystem and op-tee driver

 Documentation/00-INDEX                             |   2 +
 .../bindings/arm/firmware/optee,optee-tz.txt       |  29 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 Documentation/ioctl/ioctl-number.txt               |   1 +
 Documentation/tee.txt                              | 117 +++
 MAINTAINERS                                        |  13 +
 arch/arm/Kconfig                                   |   4 +
 arch/arm/kernel/Makefile                           |   3 +-
 arch/arm/kernel/psci-call.S                        |  31 -
 arch/arm/kernel/smccc-call.S                       |  49 ++
 arch/arm/kernel/smccc.c                            |  18 +
 arch/arm64/Kconfig                                 |   4 +
 arch/arm64/kernel/Makefile                         |   3 +-
 arch/arm64/kernel/psci-call.S                      |  28 -
 arch/arm64/kernel/smccc-call.S                     |  43 +
 arch/arm64/kernel/smccc.c                          |  18 +
 drivers/Kconfig                                    |   2 +
 drivers/Makefile                                   |   1 +
 drivers/firmware/psci.c                            |  21 +-
 drivers/tee/Kconfig                                |  18 +
 drivers/tee/Makefile                               |   4 +
 drivers/tee/optee/Kconfig                          |   8 +
 drivers/tee/optee/Makefile                         |   5 +
 drivers/tee/optee/call.c                           | 400 ++++++++++
 drivers/tee/optee/core.c                           | 502 ++++++++++++
 drivers/tee/optee/optee_msg.h                      | 423 ++++++++++
 drivers/tee/optee/optee_private.h                  | 146 ++++
 drivers/tee/optee/optee_smc.h                      | 418 ++++++++++
 drivers/tee/optee/rpc.c                            | 322 ++++++++
 drivers/tee/optee/supp.c                           | 212 +++++
 drivers/tee/tee.c                                  | 873 +++++++++++++++++++++
 drivers/tee/tee_private.h                          |  80 ++
 drivers/tee/tee_shm.c                              | 324 ++++++++
 drivers/tee/tee_shm_pool.c                         | 133 ++++
 include/linux/arm-smccc.h                          |  98 +++
 include/linux/tee_drv.h                            | 300 +++++++
 include/uapi/linux/tee.h                           | 383 +++++++++
 37 files changed, 4974 insertions(+), 63 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/firmware/optee,optee-tz.txt
 create mode 100644 Documentation/tee.txt
 delete mode 100644 arch/arm/kernel/psci-call.S
 create mode 100644 arch/arm/kernel/smccc-call.S
 create mode 100644 arch/arm/kernel/smccc.c
 delete mode 100644 arch/arm64/kernel/psci-call.S
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
