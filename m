From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 18 May 2015 14:18:50 +0100
Subject: [PATCH V3 2/2] tee: add OP-TEE driver
In-Reply-To: <1431671667-11219-3-git-send-email-jens.wiklander@linaro.org>
References: <1431671667-11219-1-git-send-email-jens.wiklander@linaro.org>
 <1431671667-11219-3-git-send-email-jens.wiklander@linaro.org>
Message-ID: <20150518131850.GA7064@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, May 15, 2015 at 07:34:27AM +0100, Jens Wiklander wrote:
> Adds a OP-TEE driver which also can be compiled as a loadable module.
>
> * Targets ARM and ARM64
> * Supports using reserved memory from OP-TEE as shared memory
> * CMA as shared memory is optional and only tried if OP-TEE doesn't
>   supply a reserved shared memory region

How does OP-TEE provide that reserved memory? How is that described in
DT/UEFI to the OS (e.g. is there a memreserve, or is the memory not
described at all)?

> * Probes OP-TEE version using SMCs
> * Accepts requests on privileged and unprivileged device
> * Uses OPTEE message protocol version 2
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  Documentation/devicetree/bindings/optee/optee.txt  |  17 +

I'm concerned that there's no documentation regarding the interface
exposed to userspace, for neither rationale nor usage.

I'm also very concerned that the interface exposed to userspace is
hideously low-level. Surely we'd expect kernel-side drivers to be doing
the bulk of direct communication to the OP-TEE instance? In the lack of
a provided rationale I don't see why the current messaging interface
would make sense.

>  .../devicetree/bindings/vendor-prefixes.txt        |   1 +
>  MAINTAINERS                                        |   6 +
>  drivers/tee/Kconfig                                |  10 +
>  drivers/tee/Makefile                               |   1 +
>  drivers/tee/optee/Kconfig                          |  19 +
>  drivers/tee/optee/Makefile                         |  13 +
>  drivers/tee/optee/call.c                           | 294 ++++++++++++
>  drivers/tee/optee/core.c                           | 509 ++++++++++++++++++++
>  drivers/tee/optee/optee_private.h                  | 138 ++++++
>  drivers/tee/optee/optee_smc.h                      | 510 +++++++++++++++++++++
>  drivers/tee/optee/rpc.c                            | 282 ++++++++++++
>  drivers/tee/optee/smc_a32.S                        |  30 ++
>  drivers/tee/optee/smc_a64.S                        |  37 ++
>  drivers/tee/optee/supp.c                           | 327 +++++++++++++
>  include/uapi/linux/optee_msg.h                     | 368 +++++++++++++++
>  16 files changed, 2562 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/optee/optee.txt
>  create mode 100644 drivers/tee/optee/Kconfig
>  create mode 100644 drivers/tee/optee/Makefile
>  create mode 100644 drivers/tee/optee/call.c
>  create mode 100644 drivers/tee/optee/core.c
>  create mode 100644 drivers/tee/optee/optee_private.h
>  create mode 100644 drivers/tee/optee/optee_smc.h
>  create mode 100644 drivers/tee/optee/rpc.c
>  create mode 100644 drivers/tee/optee/smc_a32.S
>  create mode 100644 drivers/tee/optee/smc_a64.S
>  create mode 100644 drivers/tee/optee/supp.c
>  create mode 100644 include/uapi/linux/optee_msg.h
>
> diff --git a/Documentation/devicetree/bindings/optee/optee.txt b/Documentation/devicetree/bindings/optee/optee.txt
> new file mode 100644
> index 0000000..8cea829
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/optee/optee.txt
> @@ -0,0 +1,17 @@
> +OP-TEE Device Tree Bindings
> +
> +OP-TEE is a piece of software using hardware features to provide a Trusted
> +Execution Environment. The security can be provided with ARM TrustZone, but
> +also by virtualization or a separate chip. As there's no single OP-TEE
> +vendor we're using "optee" as the first part of compatible propterty,

s/propterty/property/

> +indicating the OP-TEE protocol is used when communicating with the secure
> +world.
> +
> +* OP-TEE based on ARM TrustZone required properties:
> +
> +- compatible="optee,optee-tz"
> +
> +Example:
> +       optee {
> +               compatible="optee,optee-tz";
> +       };

What does the OP-TEE protocol give in the way of discoverability? Is it
expected that the specific implementation and/or features will be
detected dynamically?

Where can I find documentation on the protocol?

> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 8033919..17c2a7e 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -141,6 +141,7 @@ nvidia      NVIDIA
>  nxp    NXP Semiconductors
>  onnn   ON Semiconductor Corp.
>  opencores      OpenCores.org
> +optee  OP-TEE, Open Portable Trusted Execution Environment
>  ortustech      Ortus Technology Co., Ltd.
>  ovti   OmniVision Technologies
>  panasonic      Panasonic Corporation
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dfcc9cc..1234695 100644

Please split the DT binding parts into a separate patch, at the start of
the series.

> diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
> new file mode 100644
> index 0000000..096651d
> --- /dev/null
> +++ b/drivers/tee/optee/Makefile
> @@ -0,0 +1,13 @@
> +obj-$(CONFIG_OPTEE) += optee.o
> +optee-objs += core.o
> +optee-objs += call.o
> +ifdef CONFIG_ARM
> +plus_sec := $(call as-instr,.arch_extension sec,+sec)
> +AFLAGS_smc_a32.o := -Wa,-march=armv7-a$(plus_sec)
> +optee-objs += smc_a32.o
> +endif
> +ifdef CONFIG_ARM64
> +optee-objs += smc_a64.o
> +endif

The assembly objects should probably live under the relevant arch/
folders, and can probably be shared with clients for other services
compliant with the SMC Calling Conventions.

> +static void optee_call_lock(struct optee_call_sync *callsync)
> +{
> +       mutex_lock(&callsync->mutex);
> +}
> +
> +static void optee_call_lock_wait_completion(struct optee_call_sync *callsync)
> +{
> +       /*
> +        * Release the lock until "something happens" and then reacquire it
> +        * again.

When you say you're waiting until "something happens", you really are
waiting until something happens. The quotes aren't helpful, please drop
them.

> +        *
> +        * This is needed when TEE returns "busy" and we need to try again
> +        * later.
> +        */
> +       callsync->c_waiters++;
> +       mutex_unlock(&callsync->mutex);
> +       /*
> +        * Wait at most one second. Secure world is normally never busy
> +        * more than that so we should normally never timeout.
> +        */
> +       wait_for_completion_timeout(&callsync->c, HZ);
> +       mutex_lock(&callsync->mutex);
> +       callsync->c_waiters--;
> +}
> +
> +static void optee_call_unlock(struct optee_call_sync *callsync)
> +{
> +       /*
> +        * If at least one thread is waiting for "something to happen" let
> +        * one thread know that "something has happened".
> +        */
> +       if (callsync->c_waiters)
> +               complete(&callsync->c);
> +       mutex_unlock(&callsync->mutex);
> +}
> +

You can get rid of the c_waiters variable entirely, as complete() is
safe to call when the completion has an empty waiters list (and the
manipulation of c_waiters is racy anyway...).

Also, I think you need complete_all(&callsync->c) if more than two
concurrent calls are possible. Otherwise one call might block another
indefinitely.

> +static int optee_arg_from_user(struct opteem_arg *arg, size_t size,
> +                       struct tee_shm **put_shm)
> +{
> +       struct opteem_param *param;
> +       size_t n;
> +
> +       if (!arg->num_params || !put_shm)
> +               return -EINVAL;
> +
> +       param = OPTEEM_GET_PARAMS(arg);

OPTEEM is a little opaque. OPTEE_MSG would be easier to grasp.

[...]

> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> new file mode 100644
> index 0000000..b3f8b92d
> --- /dev/null
> +++ b/drivers/tee/optee/core.c
> @@ -0,0 +1,509 @@
> +/*
> + * Copyright (c) 2015, Linaro Limited
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +#include <linux/types.h>
> +#include <linux/string.h>
> +#include <linux/errno.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/uaccess.h>
> +#include <linux/dma-contiguous.h>
> +#ifdef CONFIG_OPTEE_USE_CMA
> +#include <linux/cma.h>
> +#endif

Surely this ifdeffery isn't necessary?

[...]

> +static struct tee_shm_pool *optee_config_shm_ioremap(struct device *dev,
> +                       void __iomem **ioremaped_shm)
> +{
> +       struct optee_smc_param param = { .a0 = OPTEE_SMC_GET_SHM_CONFIG };
> +       struct tee_shm_pool *pool;
> +       u_long vaddr;

Why not plain unsigned long?

[...]

> +/*
> + * This file is exported by OP-TEE and is in kept in sync between secure
> + * world and normal world kernel driver. We're following ARM SMC Calling
> + * Convention as specified in
> + * http://infocenter.arm.com/help/topic/com.arm.doc.den0028a/index.html

The values defined in the SMC Calling Conventions (which have nothing to
do with OP-TEE as such), we should probably prefix with SMCCC_, and have
in a shared file.

> + *
> + * This file depends on optee_msg.h being included to expand the SMC id
> + * macros below.
> + */
> +
> +#define OPTEE_SMC_32                   0
> +#define OPTEE_SMC_64                   0x40000000
> +#define OPTEE_SMC_FAST_CALL            0x80000000
> +#define OPTEE_SMC_STD_CALL             0

The zero cases look a bit odd here. They might be better-documented if
you defined them with shifts, e.g.

#define SMCCC_SMC_32                    (0 << 30)
#define SMCCC_SMC_64                    (1 << 30)
#define SMCCC_FAST_CALL                 (1 << 31)
#define SMCCC_STD_CALL                  (0 << 31)

[...]

> +/*
> + * Cache settings for shared memory
> + */
> +#define OPTEE_SMC_SHM_NONCACHED                0ULL
> +#define OPTEE_SMC_SHM_CACHED           1ULL

What precise set of memory attributes do these imply?

[...]

> +/*
> + * Same values as TEE_PARAM_* from TEE Internal API
> + */
> +#define OPTEEM_ATTR_TYPE_NONE          0
> +#define OPTEEM_ATTR_TYPE_VALUE_INPUT   1
> +#define OPTEEM_ATTR_TYPE_VALUE_OUTPUT  2
> +#define OPTEEM_ATTR_TYPE_VALUE_INOUT   3
> +#define OPTEEM_ATTR_TYPE_MEMREF_INPUT  5
> +#define OPTEEM_ATTR_TYPE_MEMREF_OUTPUT 6
> +#define OPTEEM_ATTR_TYPE_MEMREF_INOUT  7

Are these well-defined ABI values?

As mentioned previously, OPTEEM_* is opaque, and OPTEE_MSG_* would be
far clearer.

> +/**
> + * struct opteem_param_memref - memory reference
> + * @buf_ptr:   Address of the buffer
> + * @size:      Size of the buffer
> + * @shm_ref:   Shared memory reference only used by normal world
> + *
> + * Secure and normal world communicates pointers as physical address
> + * instead of the virtual address. This is because secure and normal world
> + * have completely independent memory mapping. Normal world can even have a
> + * hypervisor which need to translate the guest physical address (AKA IPA
> + * in ARM documentation) to a real physical address before passing the
> + * structure to secure world.
> + */
> +struct opteem_param_memref {
> +       __u64 buf_ptr;
> +       __u64 size;
> +       __u64 shm_ref;
> +};

Why does this mention physical addresses at all? What does that have to
do with userspace?

What is the shm_ref, and who allocates it?

There should really be some documentation for this.

> +/**
> + * struct opteem_param_value - values
> + * @a: first value
> + * @b: second value
> + * @c: third value
> + */
> +struct opteem_param_value {
> +       __u64 a;
> +       __u64 b;
> +       __u64 c;
> +};

Are OP-TEE messages defined to only ever take three parameters?

[...]

> +/**
> + * struct optee_cmd_prefix - initial header for all user space buffers
> + * @func_id:   Function Id OPTEEM_FUNCID_* below
> + * @pad:       padding to make the struct size a multiple of 8 bytes
> + *
> + * This struct is 8 byte aligned since it's always followed by a struct
> + * opteem_arg which requires 8 byte alignment.
> + */
> +struct opteem_cmd_prefix {
> +       __u32 func_id;
> +       __u32 pad __aligned(8);
> +};

Shouldn't the alignment be applied to the struct as a whole rather than
the final field?

> +/*
> + * Sleep mutex, helper for secure world to implement a sleeping mutex.
> + * struct opteem_arg::func     one of OPTEEM_RPC_SLEEP_MUTEX_* below
> + *
> + * OPTEEM_RPC_SLEEP_MUTEX_WAIT
> + * [in] param[0].value .a sleep mutex key
> + *                     .b wait tick
> + * [not used] param[1]
> + *
> + * OPTEEM_RPC_SLEEP_MUTEX_WAKEUP
> + * [in] param[0].value .a sleep mutex key
> + *                     .b wait after
> + * [not used] param[1]
> + *
> + * OPTEEM_RPC_SLEEP_MUTEX_DELETE
> + * [in] param[0].value .a sleep mutex key
> + * [not used] param[1]
> + */
> +#define OPTEEM_RPC_SLEEP_MUTEX_WAIT    0
> +#define OPTEEM_RPC_SLEEP_MUTEX_WAKEUP  1
> +#define OPTEEM_RPC_SLEEP_MUTEX_DELETE  2
> +#define OPTEEM_RPC_CMD_SLEEP_MUTEX     4

I'm lost. Why are mutexes exposed to userspace or the secure world in
such a manner?

Thanks,
Mark.
