From: jens.wiklander@linaro.org (Jens Wiklander)
Date: Mon, 25 May 2015 13:53:31 +0200
Subject: [PATCH V3 2/2] tee: add OP-TEE driver
In-Reply-To: <20150522162758.GC7481@leverpostej>
References: <1431671667-11219-1-git-send-email-jens.wiklander@linaro.org>
 <1431671667-11219-3-git-send-email-jens.wiklander@linaro.org>
 <20150518131850.GA7064@leverpostej> <20150520121648.GA9819@ermac>
 <20150522162758.GC7481@leverpostej>
Message-ID: <20150525115331.GA9297@ermac>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 22, 2015 at 05:27:59PM +0100, Mark Rutland wrote:
> On Wed, May 20, 2015 at 01:16:48PM +0100, Jens Wiklander wrote:
> > Hi,
> > 
> > On Mon, May 18, 2015 at 02:18:50PM +0100, Mark Rutland wrote:
> > > Hi,
> > >
> > > On Fri, May 15, 2015 at 07:34:27AM +0100, Jens Wiklander wrote:
> > > > Adds a OP-TEE driver which also can be compiled as a loadable module.
> > > >
> > > > * Targets ARM and ARM64
> > > > * Supports using reserved memory from OP-TEE as shared memory
> > > > * CMA as shared memory is optional and only tried if OP-TEE doesn't
> > > >   supply a reserved shared memory region
> > >
> > > How does OP-TEE provide that reserved memory? How is that described in
> > > DT/UEFI to the OS (e.g. is there a memreserve, or is the memory not
> > > described at all)?
> > It's either memreserve or not described at all. This should only be
> > needed when secure world is limited in which memory it can use for
> > shared memory. Currently all OP-TEE ports uses reserved shared memory,
> > but we're moving away from it to avoid the problem with updating DT.
> 
> Ok. It's worth noting that memreserves allow the kernel to map the
> memory with cacheable attributes, which can result in coherency problems
> if it's expected to access any buffer with non-cacheable attributes.

Thanks, that rules out memreserve for this.

> > > > * Probes OP-TEE version using SMCs
> > > > * Accepts requests on privileged and unprivileged device
> > > > * Uses OPTEE message protocol version 2
> > > >
> > > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > ---
> > > >  Documentation/devicetree/bindings/optee/optee.txt  |  17 +
> > >
> > > I'm concerned that there's no documentation regarding the interface
> > > exposed to userspace, for neither rationale nor usage.
> > OK, I'll add something.
> > 
> > >
> > > I'm also very concerned that the interface exposed to userspace is
> > > hideously low-level. Surely we'd expect kernel-side drivers to be doing
> > > the bulk of direct communication to the OP-TEE instance? In the lack of
> > > a provided rationale I don't see why the current messaging interface
> > > would make sense.
> > The kernel-side does all the direct communication since there's where
> > the SMC is done, but one level above most of the communication is
> > terminated in user space. Loading of Trusted Applications and other file
> > system access is done in by a helper process in user space,
> > tee-supplicant. A large part of the OP-TEE message protocol is
> > transparent to the kernel.
> 
> So you expect userspace clients rather than kernel drivers plugging into
> this framework?

The OP-TEE message protocol is primarily for the OP-TEE driver. Other
TEE drivers plugging into this framwork may use this protocol too, but I
guess that most will use their own message protocol.

Provided that each TEE driver rolls their own protocol I'm expecting one
counter part in user space for each TEE driver. The user space client
will know which kind of TEE it's talking to through TEE_IOC_VERSION.

> 
> > We're trying to not exclude any TEE implementation by having this low
> > level TEE_IOC_CMD instead of a high level interface. The problem with
> > the different TEEs is that they are designed differently and we haven't
> > been able to find a high level interface that suits all. Applications
> > aren't expected to use TEE_IOC_CMD directly, instead there's supposed to
> > be a client lib wich wraps the kernel interface and provides a higher
> > level interface, for instance a Global Platform Client API in the case
> > of a GP TEE.
> > 
> > For OP-TEE we're using the same protocol all the way down to user space,
> > the advantage is that it's only one protocol to keep track of and we
> > don't need to translate the entire message (we do need to copy it,
> > excluding the payload) each time the message is passed to the next
> > memory space. In the presence of a hypervisor we have
> > user space -> kernel -> hypervisor -> secure world
> > Unfortunately some fields has a different meaning in user space and
> > kernel space. I'll address this in the documentation.
> > 
> > The OP-TEE helper process, tee-supplicant, is specific to only OP-TEE.
> > Other TEEs uses helper processes too, but what they do depend on the
> > design of the TEE. As a consequence more or less all TEEs needs
> > something specific for that particular TEE in user space to be fully
> > functional.
> 
> I'm not sure that your proposed kernel/user split is ideal. How does
> userspace determine the appropriate TEE client to use? What's required
> in the way of arbitration between clients?

Each client loops through /dev/tee[0-9]* until it finds a TEE it can
communicate with, or if the client is looking for a specific TEE until
it's found. 

TEE_IOC_VERSION is used to tell which kind of TEE the client is talking
to. For a library that implements Global Platforms TEE Client API I
imagine that in TEEC_InitializeContext() the lib will detect which TEE
it's talking to and initialize the TEEC_Context appropriately.

For clients that doesn't care about Global Platform APIs I guess that
they will search for a specific TEE and give up if it's not found.

tee-supplicant is a special case since it's a helper process for the
TEE. The will likely be one tee-supplicant implementation
(tee-supplicant-optee, tee-supplicant-xyz, etc) for each TEE that user
space can support. tee-supplicant is looking for a TEE to connect to
through /dev/teepriv[0-9]*. 

The reason for having /dev/teeX for normal clients and /dev/teeprivX for
tee-supplicants we'd like to have any easy way to set different permission
on the devices.


> > > > +* OP-TEE based on ARM TrustZone required properties:
> > > > +
> > > > +- compatible="optee,optee-tz"
> > > > +
> > > > +Example:
> > > > +       optee {
> > > > +               compatible="optee,optee-tz";
> > > > +       };
> > >
> > > What does the OP-TEE protocol give in the way of discoverability? Is it
> > > expected that the specific implementation and/or features will be
> > > detected dynamically?
> > We have OPTEEM_FUNCID_GET_OS_UUID and OPTEEM_FUNCID_GET_OS_REVISION
> > which the client can use to identify which particular OP-TEE it's
> > talking to.
> 
> Ok.
> 
> > This is not so interesting for the driver, but the client may care
> > when there's more than one TEE using the OP-TEE message protocol in a
> > single system.
> 
> How does having more than one TEE work given there's a single conduit?

Each TEE gets its own /dev/teeXX when the specific TEE driver registers
in the framework.

[...]
> > > > diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
> > > > new file mode 100644
> > > > index 0000000..096651d
> > > > --- /dev/null
> > > > +++ b/drivers/tee/optee/Makefile
> > > > @@ -0,0 +1,13 @@
> > > > +obj-$(CONFIG_OPTEE) += optee.o
> > > > +optee-objs += core.o
> > > > +optee-objs += call.o
> > > > +ifdef CONFIG_ARM
> > > > +plus_sec := $(call as-instr,.arch_extension sec,+sec)
> > > > +AFLAGS_smc_a32.o := -Wa,-march=armv7-a$(plus_sec)
> > > > +optee-objs += smc_a32.o
> > > > +endif
> > > > +ifdef CONFIG_ARM64
> > > > +optee-objs += smc_a64.o
> > > > +endif
> > >
> > > The assembly objects should probably live under the relevant arch/
> > > folders, and can probably be shared with clients for other services
> > > compliant with the SMC Calling Conventions.
> > OK, sounds good. Where should I put the smccc.h file to be able to share
> > it between arch/arm and arch/arm64, under include/asm-generic?
> 
> I'd imagine the SMCCC stuff could live at include/linux/arm_smccc.h
> (following the example of efi.h).

Thanks.

> > > > +/*
> > > > + * Cache settings for shared memory
> > > > + */
> > > > +#define OPTEE_SMC_SHM_NONCACHED                0ULL
> > > > +#define OPTEE_SMC_SHM_CACHED           1ULL
> > >
> > > What precise set of memory attributes do these imply?
> > OPTEE_SMC_SHM_NONCACHED is generally not used, but supposed to match how
> > the kernel maps noncached memory. OP-TEE maps this as Device-nGnRE
> > Outer sharable memory (MAIR ATTR = 0x04)
> > 
> > OPTEE_SMC_SHM_CACHED is cached memory with settings matching how the
> > kernel maps cached memory. OP-TEE maps this as as Normal Memory,
> > Outer Write-back non-transient Outer Read Allocate Outer Write Allocate
> > Inner Write-back non-transient Inner Read Allocate Inner Write Allocate
> > Inner sharable (MAIR ATTR = 0xff).
> > 
> > OP-TEE is more or less always compiled for a specific platform so if the
> > kernel uses some other mapping for a particular platform we'll change the
> > OP-TEE settings to be compatible with the kernel on that platform.
> 
> That assumes that the TEE has to know about any kernel that might run.
> It also implies that a kernel needs to know what each TEE thinks the
> kernel will be mapping memory as, so it can work around whatever
> decision has been made by the TEE.
> 
> So as it stands I think that's a broken design. The attributes you need
> should be strictly specified. It's perfectly valid for that strict
> specification to be the same attributes the kernel uses now, but the
> spec can't change later.
> 
> Otherwise mismatched attributes will get in the way on some platform,
> and it's going to be close to impossible to fix things up.

OK, I see the problem. Is it OK only specify the attributes that need to
be compatible like:
#define OPTEE_SMC_SHM_ICACHED           (1 << 0)
#define OPTEE_SMC_SHM_IWRITE_THROUGH    (1 << 1)
#define OPTEE_SMC_SHM_IWRITE_BACK       (1 << 2)
#define OPTEE_SMC_SHM_ISHARABLE         (1 << 3)
#define OPTEE_SMC_SHM_OCACHED           (1 << 4)
#define OPTEE_SMC_SHM_OWRITE_THROUGH    (1 << 5)
#define OPTEE_SMC_SHM_OWRITE_BACK       (1 << 6)
#define OPTEE_SMC_SHM_OSHARABLE         (1 << 7)

#define OPTEE_SMC_SHM_CACHED \
        (OPTEE_SMC_SHM_ICACHED | OPTEE_SMC_SHM_IWRITE_BACK | \
         OPTEE_SMC_SHM_ISHARABLE | OPTEE_SMC_SHM_OCACHED | \
         OPTEE_SMC_SHM_OWRITE_BACK)

I'll drop the OPTEE_SMC_SHM_NONCACHED define as it's currently not used.

> > > > +/**
> > > > + * struct opteem_param_memref - memory reference
> > > > + * @buf_ptr:   Address of the buffer
> > > > + * @size:      Size of the buffer
> > > > + * @shm_ref:   Shared memory reference only used by normal world
> > > > + *
> > > > + * Secure and normal world communicates pointers as physical address
> > > > + * instead of the virtual address. This is because secure and normal world
> > > > + * have completely independent memory mapping. Normal world can even have a
> > > > + * hypervisor which need to translate the guest physical address (AKA IPA
> > > > + * in ARM documentation) to a real physical address before passing the
> > > > + * structure to secure world.
> > > > + */
> > > > +struct opteem_param_memref {
> > > > +       __u64 buf_ptr;
> > > > +       __u64 size;
> > > > +       __u64 shm_ref;
> > > > +};
> > >
> > > Why does this mention physical addresses at all? What does that have to
> > > do with userspace?
> > >
> > > What is the shm_ref, and who allocates it?
> > >
> > > There should really be some documentation for this.
> > Agree.
> > 
> > buf_ptr is a physical address (IPA or PA depending on context) outside
> > user space, in user space it's an offset into the shm_ref.
> > 
> > shm_ref is a pointer to struct tee_shm in the kernel, an opaque handle
> > in secure world, and a file descriptor (connected to a struct tee_shm)
> > in user space.
> 
> If this is the header for userspace, the comments should be useful to
> userspace. Surely you can have a different structure kernel-side if you
> need to encode different values?

OK, I'll make separate structures.

Thanks,
Jens
