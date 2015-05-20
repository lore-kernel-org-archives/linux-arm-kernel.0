From: jens.wiklander@linaro.org (Jens Wiklander)
Date: Wed, 20 May 2015 14:16:48 +0200
Subject: [PATCH V3 2/2] tee: add OP-TEE driver
In-Reply-To: <20150518131850.GA7064@leverpostej>
References: <1431671667-11219-1-git-send-email-jens.wiklander@linaro.org>
 <1431671667-11219-3-git-send-email-jens.wiklander@linaro.org>
 <20150518131850.GA7064@leverpostej>
Message-ID: <20150520121648.GA9819@ermac>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, May 18, 2015 at 02:18:50PM +0100, Mark Rutland wrote:
> Hi,
> 
> On Fri, May 15, 2015 at 07:34:27AM +0100, Jens Wiklander wrote:
> > Adds a OP-TEE driver which also can be compiled as a loadable module.
> >
> > * Targets ARM and ARM64
> > * Supports using reserved memory from OP-TEE as shared memory
> > * CMA as shared memory is optional and only tried if OP-TEE doesn't
> >   supply a reserved shared memory region
> 
> How does OP-TEE provide that reserved memory? How is that described in
> DT/UEFI to the OS (e.g. is there a memreserve, or is the memory not
> described at all)?
It's either memreserve or not described at all. This should only be
needed when secure world is limited in which memory it can use for
shared memory. Currently all OP-TEE ports uses reserved shared memory,
but we're moving away from it to avoid the problem with updating DT.

> 
> > * Probes OP-TEE version using SMCs
> > * Accepts requests on privileged and unprivileged device
> > * Uses OPTEE message protocol version 2
> >
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/optee/optee.txt  |  17 +
> 
> I'm concerned that there's no documentation regarding the interface
> exposed to userspace, for neither rationale nor usage.
OK, I'll add something.

> 
> I'm also very concerned that the interface exposed to userspace is
> hideously low-level. Surely we'd expect kernel-side drivers to be doing
> the bulk of direct communication to the OP-TEE instance? In the lack of
> a provided rationale I don't see why the current messaging interface
> would make sense.
The kernel-side does all the direct communication since there's where
the SMC is done, but one level above most of the communication is
terminated in user space. Loading of Trusted Applications and other file
system access is done in by a helper process in user space,
tee-supplicant. A large part of the OP-TEE message protocol is
transparent to the kernel.

We're trying to not exclude any TEE implementation by having this low
level TEE_IOC_CMD instead of a high level interface. The problem with
the different TEEs is that they are designed differently and we haven't
been able to find a high level interface that suits all. Applications
aren't expected to use TEE_IOC_CMD directly, instead there's supposed to
be a client lib wich wraps the kernel interface and provides a higher
level interface, for instance a Global Platform Client API in the case
of a GP TEE.

For OP-TEE we're using the same protocol all the way down to user space,
the advantage is that it's only one protocol to keep track of and we
don't need to translate the entire message (we do need to copy it,
excluding the payload) each time the message is passed to the next
memory space. In the presence of a hypervisor we have
user space -> kernel -> hypervisor -> secure world
Unfortunately some fields has a different meaning in user space and
kernel space. I'll address this in the documentation.

The OP-TEE helper process, tee-supplicant, is specific to only OP-TEE.
Other TEEs uses helper processes too, but what they do depend on the
design of the TEE. As a consequence more or less all TEEs needs
something specific for that particular TEE in user space to be fully
functional.

To summarize, the current assumption is that all TEEs can't use the same
high level interface. Instead we need to provide a way for each TEE to
have their own low level interface which should be wrapped in a user
space library to provide a more reasonable interface to the client
application.

> 
> >  .../devicetree/bindings/vendor-prefixes.txt        |   1 +
> >  MAINTAINERS                                        |   6 +
> >  drivers/tee/Kconfig                                |  10 +
> >  drivers/tee/Makefile                               |   1 +
> >  drivers/tee/optee/Kconfig                          |  19 +
> >  drivers/tee/optee/Makefile                         |  13 +
> >  drivers/tee/optee/call.c                           | 294 ++++++++++++
> >  drivers/tee/optee/core.c                           | 509 ++++++++++++++++++++
> >  drivers/tee/optee/optee_private.h                  | 138 ++++++
> >  drivers/tee/optee/optee_smc.h                      | 510 +++++++++++++++++++++
> >  drivers/tee/optee/rpc.c                            | 282 ++++++++++++
> >  drivers/tee/optee/smc_a32.S                        |  30 ++
> >  drivers/tee/optee/smc_a64.S                        |  37 ++
> >  drivers/tee/optee/supp.c                           | 327 +++++++++++++
> >  include/uapi/linux/optee_msg.h                     | 368 +++++++++++++++
> >  16 files changed, 2562 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/optee/optee.txt
> >  create mode 100644 drivers/tee/optee/Kconfig
> >  create mode 100644 drivers/tee/optee/Makefile
> >  create mode 100644 drivers/tee/optee/call.c
> >  create mode 100644 drivers/tee/optee/core.c
> >  create mode 100644 drivers/tee/optee/optee_private.h
> >  create mode 100644 drivers/tee/optee/optee_smc.h
> >  create mode 100644 drivers/tee/optee/rpc.c
> >  create mode 100644 drivers/tee/optee/smc_a32.S
> >  create mode 100644 drivers/tee/optee/smc_a64.S
> >  create mode 100644 drivers/tee/optee/supp.c
> >  create mode 100644 include/uapi/linux/optee_msg.h
> >
> > diff --git a/Documentation/devicetree/bindings/optee/optee.txt b/Documentation/devicetree/bindings/optee/optee.txt
> > new file mode 100644
> > index 0000000..8cea829
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/optee/optee.txt
> > @@ -0,0 +1,17 @@
> > +OP-TEE Device Tree Bindings
> > +
> > +OP-TEE is a piece of software using hardware features to provide a Trusted
> > +Execution Environment. The security can be provided with ARM TrustZone, but
> > +also by virtualization or a separate chip. As there's no single OP-TEE
> > +vendor we're using "optee" as the first part of compatible propterty,
> 
> s/propterty/property/
> 
> > +indicating the OP-TEE protocol is used when communicating with the secure
> > +world.
> > +
> > +* OP-TEE based on ARM TrustZone required properties:
> > +
> > +- compatible="optee,optee-tz"
> > +
> > +Example:
> > +       optee {
> > +               compatible="optee,optee-tz";
> > +       };
> 
> What does the OP-TEE protocol give in the way of discoverability? Is it
> expected that the specific implementation and/or features will be
> detected dynamically?
We have OPTEEM_FUNCID_GET_OS_UUID and OPTEEM_FUNCID_GET_OS_REVISION
which the client can use to identify which particular OP-TEE it's
talking to. This is not so interesting for the driver, but the client
may care when there's more than one TEE using the OP-TEE message
protocol in a single system.

There's also OPTEEM_FUNCID_CALLS_UID and OPTEEM_FUNCID_CALLS_REVISION
(required by SMC Calling Convention), but those are expected to return
static values except OPTEEM_REVISION_MINOR which would be increased if
some new message type is added in the future.

To summarize, OPTEEM_FUNCID_CALLS_* identifies the OP-TEE message
protocol and OPTEEM_FUNCID_GET_OS_* identifies the OP-TEE OS
implementation.

> 
> Where can I find documentation on the protocol?
The documentation is currently include/uapi/linux/optee_msg.h and
drivers/tee/optee/optee_smc.h. I'll add something under Documentation.

There's more details at http://shorl.com/lubopribokygy , but that's not
entirely updated with this driver.

> 
> > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> > index 8033919..17c2a7e 100644
> > --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> > +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> > @@ -141,6 +141,7 @@ nvidia      NVIDIA
> >  nxp    NXP Semiconductors
> >  onnn   ON Semiconductor Corp.
> >  opencores      OpenCores.org
> > +optee  OP-TEE, Open Portable Trusted Execution Environment
> >  ortustech      Ortus Technology Co., Ltd.
> >  ovti   OmniVision Technologies
> >  panasonic      Panasonic Corporation
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index dfcc9cc..1234695 100644
> 
> Please split the DT binding parts into a separate patch, at the start of
> the series.
OK

> 
> > diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
> > new file mode 100644
> > index 0000000..096651d
> > --- /dev/null
> > +++ b/drivers/tee/optee/Makefile
> > @@ -0,0 +1,13 @@
> > +obj-$(CONFIG_OPTEE) += optee.o
> > +optee-objs += core.o
> > +optee-objs += call.o
> > +ifdef CONFIG_ARM
> > +plus_sec := $(call as-instr,.arch_extension sec,+sec)
> > +AFLAGS_smc_a32.o := -Wa,-march=armv7-a$(plus_sec)
> > +optee-objs += smc_a32.o
> > +endif
> > +ifdef CONFIG_ARM64
> > +optee-objs += smc_a64.o
> > +endif
> 
> The assembly objects should probably live under the relevant arch/
> folders, and can probably be shared with clients for other services
> compliant with the SMC Calling Conventions.
OK, sounds good. Where should I put the smccc.h file to be able to share
it between arch/arm and arch/arm64, under include/asm-generic?

> 
> > +static void optee_call_lock(struct optee_call_sync *callsync)
> > +{
> > +       mutex_lock(&callsync->mutex);
> > +}
> > +
> > +static void optee_call_lock_wait_completion(struct optee_call_sync *callsync)
> > +{
> > +       /*
> > +        * Release the lock until "something happens" and then reacquire it
> > +        * again.
> 
> When you say you're waiting until "something happens", you really are
> waiting until something happens. The quotes aren't helpful, please drop
> them.
OK

> 
> > +        *
> > +        * This is needed when TEE returns "busy" and we need to try again
> > +        * later.
> > +        */
> > +       callsync->c_waiters++;
> > +       mutex_unlock(&callsync->mutex);
> > +       /*
> > +        * Wait at most one second. Secure world is normally never busy
> > +        * more than that so we should normally never timeout.
> > +        */
> > +       wait_for_completion_timeout(&callsync->c, HZ);
> > +       mutex_lock(&callsync->mutex);
> > +       callsync->c_waiters--;
> > +}
> > +
> > +static void optee_call_unlock(struct optee_call_sync *callsync)
> > +{
> > +       /*
> > +        * If at least one thread is waiting for "something to happen" let
> > +        * one thread know that "something has happened".
> > +        */
> > +       if (callsync->c_waiters)
> > +               complete(&callsync->c);
> > +       mutex_unlock(&callsync->mutex);
> > +}
> > +
> 
> You can get rid of the c_waiters variable entirely, as complete() is
> safe to call when the completion has an empty waiters list (and the
> manipulation of c_waiters is racy anyway...).
OK

> 
> Also, I think you need complete_all(&callsync->c) if more than two
> concurrent calls are possible. Otherwise one call might block another
> indefinitely.
Thanks, I'll do that.

> 
> > +static int optee_arg_from_user(struct opteem_arg *arg, size_t size,
> > +                       struct tee_shm **put_shm)
> > +{
> > +       struct opteem_param *param;
> > +       size_t n;
> > +
> > +       if (!arg->num_params || !put_shm)
> > +               return -EINVAL;
> > +
> > +       param = OPTEEM_GET_PARAMS(arg);
> 
> OPTEEM is a little opaque. OPTEE_MSG would be easier to grasp.
OK

> 
> [...]
> 
> > diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> > new file mode 100644
> > index 0000000..b3f8b92d
> > --- /dev/null
> > +++ b/drivers/tee/optee/core.c
> > @@ -0,0 +1,509 @@
> > +/*
> > + * Copyright (c) 2015, Linaro Limited
> > + *
> > + * This software is licensed under the terms of the GNU General Public
> > + * License version 2, as published by the Free Software Foundation, and
> > + * may be copied, distributed, and modified under those terms.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + */
> > +#include <linux/types.h>
> > +#include <linux/string.h>
> > +#include <linux/errno.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/slab.h>
> > +#include <linux/uaccess.h>
> > +#include <linux/dma-contiguous.h>
> > +#ifdef CONFIG_OPTEE_USE_CMA
> > +#include <linux/cma.h>
> > +#endif
> 
> Surely this ifdeffery isn't necessary?
> 
> [...]
> 
> > +static struct tee_shm_pool *optee_config_shm_ioremap(struct device *dev,
> > +                       void __iomem **ioremaped_shm)
> > +{
> > +       struct optee_smc_param param = { .a0 = OPTEE_SMC_GET_SHM_CONFIG };
> > +       struct tee_shm_pool *pool;
> > +       u_long vaddr;
> 
> Why not plain unsigned long?
OK, I'll change.

> 
> [...]
> 
> > +/*
> > + * This file is exported by OP-TEE and is in kept in sync between secure
> > + * world and normal world kernel driver. We're following ARM SMC Calling
> > + * Convention as specified in
> > + * http://infocenter.arm.com/help/topic/com.arm.doc.den0028a/index.html
> 
> The values defined in the SMC Calling Conventions (which have nothing to
> do with OP-TEE as such), we should probably prefix with SMCCC_, and have
> in a shared file.
> 
> > + *
> > + * This file depends on optee_msg.h being included to expand the SMC id
> > + * macros below.
> > + */
> > +
> > +#define OPTEE_SMC_32                   0
> > +#define OPTEE_SMC_64                   0x40000000
> > +#define OPTEE_SMC_FAST_CALL            0x80000000
> > +#define OPTEE_SMC_STD_CALL             0
> 
> The zero cases look a bit odd here. They might be better-documented if
> you defined them with shifts, e.g.
> 
> #define SMCCC_SMC_32                    (0 << 30)
> #define SMCCC_SMC_64                    (1 << 30)
> #define SMCCC_FAST_CALL                 (1 << 31)
> #define SMCCC_STD_CALL                  (0 << 31)
OK

> 
> [...]
> 
> > +/*
> > + * Cache settings for shared memory
> > + */
> > +#define OPTEE_SMC_SHM_NONCACHED                0ULL
> > +#define OPTEE_SMC_SHM_CACHED           1ULL
> 
> What precise set of memory attributes do these imply?
OPTEE_SMC_SHM_NONCACHED is generally not used, but supposed to match how
the kernel maps noncached memory. OP-TEE maps this as Device-nGnRE
Outer sharable memory (MAIR ATTR = 0x04)

OPTEE_SMC_SHM_CACHED is cached memory with settings matching how the
kernel maps cached memory. OP-TEE maps this as as Normal Memory,
Outer Write-back non-transient Outer Read Allocate Outer Write Allocate
Inner Write-back non-transient Inner Read Allocate Inner Write Allocate
Inner sharable (MAIR ATTR = 0xff).

OP-TEE is more or less always compiled for a specific platform so if the
kernel uses some other mapping for a particular platform we'll change the
OP-TEE settings to be compatible with the kernel on that platform.

> 
> [...]
> 
> > +/*
> > + * Same values as TEE_PARAM_* from TEE Internal API
> > + */
> > +#define OPTEEM_ATTR_TYPE_NONE          0
> > +#define OPTEEM_ATTR_TYPE_VALUE_INPUT   1
> > +#define OPTEEM_ATTR_TYPE_VALUE_OUTPUT  2
> > +#define OPTEEM_ATTR_TYPE_VALUE_INOUT   3
> > +#define OPTEEM_ATTR_TYPE_MEMREF_INPUT  5
> > +#define OPTEEM_ATTR_TYPE_MEMREF_OUTPUT 6
> > +#define OPTEEM_ATTR_TYPE_MEMREF_INOUT  7
> 
> Are these well-defined ABI values?
Yes.

> 
> As mentioned previously, OPTEEM_* is opaque, and OPTEE_MSG_* would be
> far clearer.
> 
> > +/**
> > + * struct opteem_param_memref - memory reference
> > + * @buf_ptr:   Address of the buffer
> > + * @size:      Size of the buffer
> > + * @shm_ref:   Shared memory reference only used by normal world
> > + *
> > + * Secure and normal world communicates pointers as physical address
> > + * instead of the virtual address. This is because secure and normal world
> > + * have completely independent memory mapping. Normal world can even have a
> > + * hypervisor which need to translate the guest physical address (AKA IPA
> > + * in ARM documentation) to a real physical address before passing the
> > + * structure to secure world.
> > + */
> > +struct opteem_param_memref {
> > +       __u64 buf_ptr;
> > +       __u64 size;
> > +       __u64 shm_ref;
> > +};
> 
> Why does this mention physical addresses at all? What does that have to
> do with userspace?
> 
> What is the shm_ref, and who allocates it?
> 
> There should really be some documentation for this.
Agree.

buf_ptr is a physical address (IPA or PA depending on context) outside
user space, in user space it's an offset into the shm_ref.

shm_ref is a pointer to struct tee_shm in the kernel, an opaque handle
in secure world, and a file descriptor (connected to a struct tee_shm)
in user space.

> 
> > +/**
> > + * struct opteem_param_value - values
> > + * @a: first value
> > + * @b: second value
> > + * @c: third value
> > + */
> > +struct opteem_param_value {
> > +       __u64 a;
> > +       __u64 b;
> > +       __u64 c;
> > +};
> 
> Are OP-TEE messages defined to only ever take three parameters?
No, this is a value parameter, each value parameter can carry three
value. An OP-TEE message carry the number of parameters specified with
num_params in struct opteem_arg.

> 
> [...]
> 
> > +/**
> > + * struct optee_cmd_prefix - initial header for all user space buffers
> > + * @func_id:   Function Id OPTEEM_FUNCID_* below
> > + * @pad:       padding to make the struct size a multiple of 8 bytes
> > + *
> > + * This struct is 8 byte aligned since it's always followed by a struct
> > + * opteem_arg which requires 8 byte alignment.
> > + */
> > +struct opteem_cmd_prefix {
> > +       __u32 func_id;
> > +       __u32 pad __aligned(8);
> > +};
> 
> Shouldn't the alignment be applied to the struct as a whole rather than
> the final field?
OK, I didn't know which was the preferred location to apply the aligned
attribute.

> 
> > +/*
> > + * Sleep mutex, helper for secure world to implement a sleeping mutex.
> > + * struct opteem_arg::func     one of OPTEEM_RPC_SLEEP_MUTEX_* below
> > + *
> > + * OPTEEM_RPC_SLEEP_MUTEX_WAIT
> > + * [in] param[0].value .a sleep mutex key
> > + *                     .b wait tick
> > + * [not used] param[1]
> > + *
> > + * OPTEEM_RPC_SLEEP_MUTEX_WAKEUP
> > + * [in] param[0].value .a sleep mutex key
> > + *                     .b wait after
> > + * [not used] param[1]
> > + *
> > + * OPTEEM_RPC_SLEEP_MUTEX_DELETE
> > + * [in] param[0].value .a sleep mutex key
> > + * [not used] param[1]
> > + */
> > +#define OPTEEM_RPC_SLEEP_MUTEX_WAIT    0
> > +#define OPTEEM_RPC_SLEEP_MUTEX_WAKEUP  1
> > +#define OPTEEM_RPC_SLEEP_MUTEX_DELETE  2
> > +#define OPTEEM_RPC_CMD_SLEEP_MUTEX     4
> 
> I'm lost. Why are mutexes exposed to userspace or the secure world in
> such a manner?
You're right it should go into another file not exposed to user space.


Thanks for taking the time to review this.

Regards,
Jens
