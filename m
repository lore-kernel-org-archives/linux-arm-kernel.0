From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 22 May 2015 17:27:59 +0100
Subject: [PATCH V3 2/2] tee: add OP-TEE driver
In-Reply-To: <20150520121648.GA9819@ermac>
References: <1431671667-11219-1-git-send-email-jens.wiklander@linaro.org>
 <1431671667-11219-3-git-send-email-jens.wiklander@linaro.org>
 <20150518131850.GA7064@leverpostej> <20150520121648.GA9819@ermac>
Message-ID: <20150522162758.GC7481@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 20, 2015 at 01:16:48PM +0100, Jens Wiklander wrote:
> Hi,
> 
> On Mon, May 18, 2015 at 02:18:50PM +0100, Mark Rutland wrote:
> > Hi,
> >
> > On Fri, May 15, 2015 at 07:34:27AM +0100, Jens Wiklander wrote:
> > > Adds a OP-TEE driver which also can be compiled as a loadable module.
> > >
> > > * Targets ARM and ARM64
> > > * Supports using reserved memory from OP-TEE as shared memory
> > > * CMA as shared memory is optional and only tried if OP-TEE doesn't
> > >   supply a reserved shared memory region
> >
> > How does OP-TEE provide that reserved memory? How is that described in
> > DT/UEFI to the OS (e.g. is there a memreserve, or is the memory not
> > described at all)?
> It's either memreserve or not described at all. This should only be
> needed when secure world is limited in which memory it can use for
> shared memory. Currently all OP-TEE ports uses reserved shared memory,
> but we're moving away from it to avoid the problem with updating DT.

Ok. It's worth noting that memreserves allow the kernel to map the
memory with cacheable attributes, which can result in coherency problems
if it's expected to access any buffer with non-cacheable attributes.

> > > * Probes OP-TEE version using SMCs
> > > * Accepts requests on privileged and unprivileged device
> > > * Uses OPTEE message protocol version 2
> > >
> > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > ---
> > >  Documentation/devicetree/bindings/optee/optee.txt  |  17 +
> >
> > I'm concerned that there's no documentation regarding the interface
> > exposed to userspace, for neither rationale nor usage.
> OK, I'll add something.
> 
> >
> > I'm also very concerned that the interface exposed to userspace is
> > hideously low-level. Surely we'd expect kernel-side drivers to be doing
> > the bulk of direct communication to the OP-TEE instance? In the lack of
> > a provided rationale I don't see why the current messaging interface
> > would make sense.
> The kernel-side does all the direct communication since there's where
> the SMC is done, but one level above most of the communication is
> terminated in user space. Loading of Trusted Applications and other file
> system access is done in by a helper process in user space,
> tee-supplicant. A large part of the OP-TEE message protocol is
> transparent to the kernel.

So you expect userspace clients rather than kernel drivers plugging into
this framework?

> We're trying to not exclude any TEE implementation by having this low
> level TEE_IOC_CMD instead of a high level interface. The problem with
> the different TEEs is that they are designed differently and we haven't
> been able to find a high level interface that suits all. Applications
> aren't expected to use TEE_IOC_CMD directly, instead there's supposed to
> be a client lib wich wraps the kernel interface and provides a higher
> level interface, for instance a Global Platform Client API in the case
> of a GP TEE.
> 
> For OP-TEE we're using the same protocol all the way down to user space,
> the advantage is that it's only one protocol to keep track of and we
> don't need to translate the entire message (we do need to copy it,
> excluding the payload) each time the message is passed to the next
> memory space. In the presence of a hypervisor we have
> user space -> kernel -> hypervisor -> secure world
> Unfortunately some fields has a different meaning in user space and
> kernel space. I'll address this in the documentation.
> 
> The OP-TEE helper process, tee-supplicant, is specific to only OP-TEE.
> Other TEEs uses helper processes too, but what they do depend on the
> design of the TEE. As a consequence more or less all TEEs needs
> something specific for that particular TEE in user space to be fully
> functional.

I'm not sure that your proposed kernel/user split is ideal. How does
userspace determine the appropriate TEE client to use? What's required
in the way of arbitration between clients?

> To summarize, the current assumption is that all TEEs can't use the same
> high level interface. Instead we need to provide a way for each TEE to
> have their own low level interface which should be wrapped in a user
> space library to provide a more reasonable interface to the client
> application.

[...]

> > > +* OP-TEE based on ARM TrustZone required properties:
> > > +
> > > +- compatible="optee,optee-tz"
> > > +
> > > +Example:
> > > +       optee {
> > > +               compatible="optee,optee-tz";
> > > +       };
> >
> > What does the OP-TEE protocol give in the way of discoverability? Is it
> > expected that the specific implementation and/or features will be
> > detected dynamically?
> We have OPTEEM_FUNCID_GET_OS_UUID and OPTEEM_FUNCID_GET_OS_REVISION
> which the client can use to identify which particular OP-TEE it's
> talking to.

Ok.

> This is not so interesting for the driver, but the client may care
> when there's more than one TEE using the OP-TEE message protocol in a
> single system.

How does having more than one TEE work given there's a single conduit?

> There's also OPTEEM_FUNCID_CALLS_UID and OPTEEM_FUNCID_CALLS_REVISION
> (required by SMC Calling Convention), but those are expected to return
> static values except OPTEEM_REVISION_MINOR which would be increased if
> some new message type is added in the future.
> 
> To summarize, OPTEEM_FUNCID_CALLS_* identifies the OP-TEE message
> protocol and OPTEEM_FUNCID_GET_OS_* identifies the OP-TEE OS
> implementation.
> 
> >
> > Where can I find documentation on the protocol?
> The documentation is currently include/uapi/linux/optee_msg.h and
> drivers/tee/optee/optee_smc.h. I'll add something under Documentation.
> 
> There's more details at http://shorl.com/lubopribokygy , but that's not
> entirely updated with this driver.
> 
> >
> > > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> > > index 8033919..17c2a7e 100644
> > > --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> > > +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> > > @@ -141,6 +141,7 @@ nvidia      NVIDIA
> > >  nxp    NXP Semiconductors
> > >  onnn   ON Semiconductor Corp.
> > >  opencores      OpenCores.org
> > > +optee  OP-TEE, Open Portable Trusted Execution Environment
> > >  ortustech      Ortus Technology Co., Ltd.
> > >  ovti   OmniVision Technologies
> > >  panasonic      Panasonic Corporation
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index dfcc9cc..1234695 100644
> >
> > Please split the DT binding parts into a separate patch, at the start of
> > the series.
> OK
> 
> >
> > > diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
> > > new file mode 100644
> > > index 0000000..096651d
> > > --- /dev/null
> > > +++ b/drivers/tee/optee/Makefile
> > > @@ -0,0 +1,13 @@
> > > +obj-$(CONFIG_OPTEE) += optee.o
> > > +optee-objs += core.o
> > > +optee-objs += call.o
> > > +ifdef CONFIG_ARM
> > > +plus_sec := $(call as-instr,.arch_extension sec,+sec)
> > > +AFLAGS_smc_a32.o := -Wa,-march=armv7-a$(plus_sec)
> > > +optee-objs += smc_a32.o
> > > +endif
> > > +ifdef CONFIG_ARM64
> > > +optee-objs += smc_a64.o
> > > +endif
> >
> > The assembly objects should probably live under the relevant arch/
> > folders, and can probably be shared with clients for other services
> > compliant with the SMC Calling Conventions.
> OK, sounds good. Where should I put the smccc.h file to be able to share
> it between arch/arm and arch/arm64, under include/asm-generic?

I'd imagine the SMCCC stuff could live at include/linux/arm_smccc.h
(following the example of efi.h).

> > > +/*
> > > + * Cache settings for shared memory
> > > + */
> > > +#define OPTEE_SMC_SHM_NONCACHED                0ULL
> > > +#define OPTEE_SMC_SHM_CACHED           1ULL
> >
> > What precise set of memory attributes do these imply?
> OPTEE_SMC_SHM_NONCACHED is generally not used, but supposed to match how
> the kernel maps noncached memory. OP-TEE maps this as Device-nGnRE
> Outer sharable memory (MAIR ATTR = 0x04)
> 
> OPTEE_SMC_SHM_CACHED is cached memory with settings matching how the
> kernel maps cached memory. OP-TEE maps this as as Normal Memory,
> Outer Write-back non-transient Outer Read Allocate Outer Write Allocate
> Inner Write-back non-transient Inner Read Allocate Inner Write Allocate
> Inner sharable (MAIR ATTR = 0xff).
> 
> OP-TEE is more or less always compiled for a specific platform so if the
> kernel uses some other mapping for a particular platform we'll change the
> OP-TEE settings to be compatible with the kernel on that platform.

That assumes that the TEE has to know about any kernel that might run.
It also implies that a kernel needs to know what each TEE thinks the
kernel will be mapping memory as, so it can work around whatever
decision has been made by the TEE.

So as it stands I think that's a broken design. The attributes you need
should be strictly specified. It's perfectly valid for that strict
specification to be the same attributes the kernel uses now, but the
spec can't change later.

Otherwise mismatched attributes will get in the way on some platform,
and it's going to be close to impossible to fix things up.

> > > +/**
> > > + * struct opteem_param_memref - memory reference
> > > + * @buf_ptr:   Address of the buffer
> > > + * @size:      Size of the buffer
> > > + * @shm_ref:   Shared memory reference only used by normal world
> > > + *
> > > + * Secure and normal world communicates pointers as physical address
> > > + * instead of the virtual address. This is because secure and normal world
> > > + * have completely independent memory mapping. Normal world can even have a
> > > + * hypervisor which need to translate the guest physical address (AKA IPA
> > > + * in ARM documentation) to a real physical address before passing the
> > > + * structure to secure world.
> > > + */
> > > +struct opteem_param_memref {
> > > +       __u64 buf_ptr;
> > > +       __u64 size;
> > > +       __u64 shm_ref;
> > > +};
> >
> > Why does this mention physical addresses at all? What does that have to
> > do with userspace?
> >
> > What is the shm_ref, and who allocates it?
> >
> > There should really be some documentation for this.
> Agree.
> 
> buf_ptr is a physical address (IPA or PA depending on context) outside
> user space, in user space it's an offset into the shm_ref.
> 
> shm_ref is a pointer to struct tee_shm in the kernel, an opaque handle
> in secure world, and a file descriptor (connected to a struct tee_shm)
> in user space.

If this is the header for userspace, the comments should be useful to
userspace. Surely you can have a different structure kernel-side if you
need to encode different values?

Thanks,
Mark.
