From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 29 Sep 2017 11:31:49 +0100
Subject: [PATCH v1 00/14] tee: optee: add dynamic shared memory support
In-Reply-To: <1506621851-6929-1-git-send-email-volodymyr_babchuk@epam.com>
References: <1506621851-6929-1-git-send-email-volodymyr_babchuk@epam.com>
Message-ID: <20170929103149.GB5781@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Sep 28, 2017 at 09:03:57PM +0300, Volodymyr Babchuk wrote:
> From: Volodymyr Babchuk <vlad.babchuk@gmail.com>
> 
> This patch series enables dynamic shared memory support in the TEE
> subsystem as a whole and in OP-TEE in particular.
> 
> Global Platform TEE specification [1] allows client applications
> to register part of own memory as a shared buffer between
> application and TEE. This allows fast zero-copy communication between
> TEE and REE. But current implementation of TEE in Linux does not support
> this feature.
> 
> Also, current implementation of OP-TEE transport uses fixed size
> pre-shared buffer for all communications with OP-TEE OS. This is okay
> in the most use cases. But this prevents use of OP-TEE in virtualized
> environments, because:
>  a) We can't share the same buffer between different virtual machines
>  b) Physically contiguous memory as seen by VM can be non-contiguous
>     in reality (and as seen by OP-TEE OS) due to second stage of
>     MMU translation.
>  c) Size of this pre-shared buffer is limited.

I'm afraid that I don't follow the arguments for virtualized OP-TEE
usage.

In a virtualised environment, TEE access *must* be mediated via the
hypervisor, which can virtualise the interface, pin pages, etc.

Could you elaborate on how you expect TEE access to work in a
virtualised environment?

Thanks,
Mark.

> So, first part of this patch series adds generic register/unregister
> interface to tee subsystem. Next patches add necessary features
> into OP-TEE driver, so it can use not only static pre-shared buffer,
> but whole RAM to communicate with OP-TEE OS.
> 
> [1] https://www.globalplatform.org/specificationsdevice.asp
> 
> Jens Wiklander (2):
>   tee: flexible shared memory  pool creation
>   tee: add register user memory
> 
> Volodymyr Babchuk (12):
>   tee: shm: add accessors for buffer size and page offset
>   tee: shm: add page accessor functions
>   tee: optee: Update protocol definitions
>   tee: optee: add page list manipulation functions
>   tee: optee: add shared buffer registration functions
>   tee: optee: add registered shared parameters handling
>   tee: optee: add registered buffers handling into RPC calls
>   tee: optee: store OP-TEE capabilities in private data
>   tee: optee: add optee-specific shared pool implementation
>   tee: optee: enable dynamic SHM support
>   tee: use reference counting for tee_context
>   tee: shm: inline tee_shm getter functions
> 
>  drivers/tee/optee/Makefile        |   1 +
>  drivers/tee/optee/call.c          | 131 +++++++++++++++++++++-
>  drivers/tee/optee/core.c          | 160 +++++++++++++++++++++------
>  drivers/tee/optee/optee_msg.h     |  38 ++++++-
>  drivers/tee/optee/optee_private.h |  26 ++++-
>  drivers/tee/optee/optee_smc.h     |   7 ++
>  drivers/tee/optee/rpc.c           |  72 ++++++++++--
>  drivers/tee/optee/shm_pool.c      |  75 +++++++++++++
>  drivers/tee/optee/shm_pool.h      |  23 ++++
>  drivers/tee/tee_core.c            |  81 ++++++++++++--
>  drivers/tee/tee_private.h         |  60 +---------
>  drivers/tee/tee_shm.c             | 226 +++++++++++++++++++++++++++++++-------
>  drivers/tee/tee_shm_pool.c        | 165 +++++++++++++++++-----------
>  include/linux/tee_drv.h           | 184 ++++++++++++++++++++++++++++++-
>  include/uapi/linux/tee.h          |  30 +++++
>  15 files changed, 1058 insertions(+), 221 deletions(-)
>  create mode 100644 drivers/tee/optee/shm_pool.c
>  create mode 100644 drivers/tee/optee/shm_pool.h
> 
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
