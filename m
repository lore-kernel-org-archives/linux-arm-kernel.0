From: jens.wiklander@linaro.org (Jens Wiklander)
Date: Fri, 15 Dec 2017 14:21:26 +0100
Subject: [GIT PULL] tee dynamic shm for v4.16
Message-ID: <20171215132057.ang2xawtpzp5eb6o@jax>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello arm-soc maintainers,

Please pull these tee driver changes. This implements support for dynamic
shared memory support in OP-TEE. More specifically is enables mapping of
user space memory in secure world to be used as shared memory.

This has been reviewed and refined by the OP-TEE community at various
places on Github during the last year. An earlier version of this pull
request is used in the latest OP-TEE release (2.6.0). This has also been
reviewed recently at the kernel mailing lists, with all comments from
Mark Rutland <mark.rutland@arm.com> and Yury Norov
<ynorov@caviumnetworks.com> addressed as far as I can tell.

This isn't a bugfix so I'm aiming for the next merge window.

Thanks,
Jens


The following changes since commit 50c4c4e268a2d7a3e58ebb698ac74da0de40ae36:

  Linux 4.15-rc3 (2017-12-10 17:56:26 -0800)

are available in the git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/tee-drv-dynamic-shm-for-v4.16

for you to fetch changes up to ef8e08d24ca84846ce639b835ebd2f15a943f42b:

  tee: shm: inline tee_shm_get_id() (2017-12-15 13:36:21 +0100)

----------------------------------------------------------------
This pull request enables dynamic shared memory support in the TEE
subsystem as a whole and in OP-TEE in particular.

Global Platform TEE specification [1] allows client applications
to register part of own memory as a shared buffer between
application and TEE. This allows fast zero-copy communication between
TEE and REE. But current implementation of TEE in Linux does not support
this feature.

Also, current implementation of OP-TEE transport uses fixed size
pre-shared buffer for all communications with OP-TEE OS. This is okay
in the most use cases. But this prevents use of OP-TEE in virtualized
environments, because:
 a) We can't share the same buffer between different virtual machines
 b) Physically contiguous memory as seen by VM can be non-contiguous
    in reality (and as seen by OP-TEE OS) due to second stage of
    MMU translation.
 c) Size of this pre-shared buffer is limited.

So, first part of this pull request adds generic register/unregister
interface to tee subsystem. The second part adds necessary features into
OP-TEE driver, so it can use not only static pre-shared buffer, but
whole RAM to communicate with OP-TEE OS.

This change is backwards compatible allowing older secure world or
user space to work with newer kernels and vice versa.

[1] https://www.globalplatform.org/specificationsdevice.asp

----------------------------------------------------------------
Jens Wiklander (2):
      tee: flexible shared memory pool creation
      tee: add register user memory

Volodymyr Babchuk (12):
      tee: shm: add accessors for buffer size and page offset
      tee: shm: add page accessor functions
      tee: optee: Update protocol definitions
      tee: optee: add page list manipulation functions
      tee: optee: add shared buffer registration functions
      tee: optee: add registered shared parameters handling
      tee: optee: add registered buffers handling into RPC calls
      tee: optee: store OP-TEE capabilities in private data
      tee: optee: add optee-specific shared pool implementation
      tee: optee: enable dynamic SHM support
      tee: use reference counting for tee_context
      tee: shm: inline tee_shm_get_id()

 drivers/tee/optee/Makefile        |   1 +
 drivers/tee/optee/call.c          | 179 +++++++++++++++++++++++++++++-
 drivers/tee/optee/core.c          | 152 +++++++++++++++++++------
 drivers/tee/optee/optee_msg.h     |  38 ++++++-
 drivers/tee/optee/optee_private.h |  27 ++++-
 drivers/tee/optee/optee_smc.h     |   7 ++
 drivers/tee/optee/rpc.c           |  77 +++++++++++--
 drivers/tee/optee/shm_pool.c      |  75 +++++++++++++
 drivers/tee/optee/shm_pool.h      |  23 ++++
 drivers/tee/tee_core.c            |  81 ++++++++++++--
 drivers/tee/tee_private.h         |  60 +---------
 drivers/tee/tee_shm.c             | 228 +++++++++++++++++++++++++++++++-------
 drivers/tee/tee_shm_pool.c        | 165 ++++++++++++++++-----------
 include/linux/tee_drv.h           | 183 +++++++++++++++++++++++++++++-
 include/uapi/linux/tee.h          |  30 +++++
 15 files changed, 1105 insertions(+), 221 deletions(-)
 create mode 100644 drivers/tee/optee/shm_pool.c
 create mode 100644 drivers/tee/optee/shm_pool.h
