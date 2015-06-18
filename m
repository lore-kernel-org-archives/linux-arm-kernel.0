From: jens.wiklander@linaro.org (Jens Wiklander)
Date: Thu, 18 Jun 2015 15:34:11 +0200
Subject: [PATCH V3 2/2] tee: add OP-TEE driver
In-Reply-To: <20150605104814.GE599@leverpostej>
References: <1431671667-11219-1-git-send-email-jens.wiklander@linaro.org>
 <1431671667-11219-3-git-send-email-jens.wiklander@linaro.org>
 <20150518131850.GA7064@leverpostej> <20150520121648.GA9819@ermac>
 <20150522162758.GC7481@leverpostej> <20150525115331.GA9297@ermac>
 <20150605104814.GE599@leverpostej>
Message-ID: <20150618133410.GA11996@ermac>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 05, 2015 at 11:48:14AM +0100, Mark Rutland wrote:
[...]
> > The OP-TEE message protocol is primarily for the OP-TEE driver. Other
> > TEE drivers plugging into this framwork may use this protocol too, but I
> > guess that most will use their own message protocol.
> > 
> > Provided that each TEE driver rolls their own protocol I'm expecting one
> > counter part in user space for each TEE driver. The user space client
> > will know which kind of TEE it's talking to through TEE_IOC_VERSION.
> 
> Surely that means you need to have every possible user-space client
> present in a given filesystem, and you need to have all of them try to
> probe the FW to figure out whether appropriate FW is present? That
> sounds somewhat heavyweight.
> 
> To me it would seem a lot better to have the minimal drivers in the
> kernel that get probed based on information from the FW. The main TEE
> driver would query the generic APIs to discover which features are
> exposed, then instantiate the relevant set of TEE-specific drivers based
> on TEE_IOC_VERSION and friends. To handle a need for userspace
> components you could emit uevents as necessary, though I'm still unclear
> on what the userspace components would do.

I'm not 100% sure what you mean. Given this and other comments on
TEE_IOC_CMD, I give up on TEE_IOC_CMD. I'll replace it with several more
specific TEE_IOC_* that will give a less complex and unified interface
to user space.

[...]
> > > I'm not sure that your proposed kernel/user split is ideal. How does
> > > userspace determine the appropriate TEE client to use? What's required
> > > in the way of arbitration between clients?
> > 
> > Each client loops through /dev/tee[0-9]* until it finds a TEE it can
> > communicate with, or if the client is looking for a specific TEE until
> > it's found.
> > 
> > TEE_IOC_VERSION is used to tell which kind of TEE the client is talking
> > to. For a library that implements Global Platforms TEE Client API I
> > imagine that in TEEC_InitializeContext() the lib will detect which TEE
> > it's talking to and initialize the TEEC_Context appropriately.
> > 
> > For clients that doesn't care about Global Platform APIs I guess that
> > they will search for a specific TEE and give up if it's not found.
> 
> That covers detection, but what about arbitrartion?
> 
> What happens when I have multiple clients which want to communicate with
> the same TEE simultaneously?

Each client opens a the same /dev/teeX and communicates over their own file
descriptor.

> 
> > tee-supplicant is a special case since it's a helper process for the
> > TEE. The will likely be one tee-supplicant implementation
> > (tee-supplicant-optee, tee-supplicant-xyz, etc) for each TEE that user
> > space can support. tee-supplicant is looking for a TEE to connect to
> > through /dev/teepriv[0-9]*.
> >
> > The reason for having /dev/teeX for normal clients and /dev/teeprivX for
> > tee-supplicants we'd like to have any easy way to set different permission
> > on the devices.
> 
> What do TEE supplicants do?

For OP-TEE (and I guess most other TEEs) it handles file system access.
Having a separate user for tee-supplicant makes it easier to have strict
permissions for created files etc.

[...]
> > > > > > +/*
> > > > > > + * Cache settings for shared memory
> > > > > > + */
> > > > > > +#define OPTEE_SMC_SHM_NONCACHED                0ULL
> > > > > > +#define OPTEE_SMC_SHM_CACHED           1ULL
> > > > >
> > > > > What precise set of memory attributes do these imply?
> > > > OPTEE_SMC_SHM_NONCACHED is generally not used, but supposed to match how
> > > > the kernel maps noncached memory. OP-TEE maps this as Device-nGnRE
> > > > Outer sharable memory (MAIR ATTR = 0x04)
> > > >
> > > > OPTEE_SMC_SHM_CACHED is cached memory with settings matching how the
> > > > kernel maps cached memory. OP-TEE maps this as as Normal Memory,
> > > > Outer Write-back non-transient Outer Read Allocate Outer Write Allocate
> > > > Inner Write-back non-transient Inner Read Allocate Inner Write Allocate
> > > > Inner sharable (MAIR ATTR = 0xff).
> > > >
> > > > OP-TEE is more or less always compiled for a specific platform so if the
> > > > kernel uses some other mapping for a particular platform we'll change the
> > > > OP-TEE settings to be compatible with the kernel on that platform.
> > >
> > > That assumes that the TEE has to know about any kernel that might run.
> > > It also implies that a kernel needs to know what each TEE thinks the
> > > kernel will be mapping memory as, so it can work around whatever
> > > decision has been made by the TEE.
> > >
> > > So as it stands I think that's a broken design. The attributes you need
> > > should be strictly specified. It's perfectly valid for that strict
> > > specification to be the same attributes the kernel uses now, but the
> > > spec can't change later.
> > >
> > > Otherwise mismatched attributes will get in the way on some platform,
> > > and it's going to be close to impossible to fix things up.
> > 
> > OK, I see the problem. Is it OK only specify the attributes that need to
> > be compatible like:
> > #define OPTEE_SMC_SHM_ICACHED           (1 << 0)
> > #define OPTEE_SMC_SHM_IWRITE_THROUGH    (1 << 1)
> > #define OPTEE_SMC_SHM_IWRITE_BACK       (1 << 2)
> > #define OPTEE_SMC_SHM_ISHARABLE         (1 << 3)
> > #define OPTEE_SMC_SHM_OCACHED           (1 << 4)
> > #define OPTEE_SMC_SHM_OWRITE_THROUGH    (1 << 5)
> > #define OPTEE_SMC_SHM_OWRITE_BACK       (1 << 6)
> > #define OPTEE_SMC_SHM_OSHARABLE         (1 << 7)
> > 
> > #define OPTEE_SMC_SHM_CACHED \
> >         (OPTEE_SMC_SHM_ICACHED | OPTEE_SMC_SHM_IWRITE_BACK | \
> >          OPTEE_SMC_SHM_ISHARABLE | OPTEE_SMC_SHM_OCACHED | \
> >          OPTEE_SMC_SHM_OWRITE_BACK)
> 
> I'm not sure I follow the question. Will these specific attributes be
> mandated by the OP-TEE spec? The set of attributes above are certainly
> better specified than simply "CACHED", though it would be nice to have
> an architectural definition rather than just a bag of bits.
> 
> The architecture maintainers will need to look at the memory attributes
> too. I don't think that current APIs offer fine-grained control over
> attributes and a UP kernel may not map memory as shareable, for example.

Defining all those bits for OPTEE_SMC_SHM_CACHED didn't help much. I
took the liberty to contact Catalin directly on this and my
interpretation of his advice is:

/*
 * Normal cached memory (write-back), shareable for SMP systems and not
 * shareable for UP systems.
 */
#define OPTEE_SMC_SHM_CACHED            1

This is closer to my original proposal, but with the crucial difference
that OP-TEE doesn't need to know how the kernel maps other memory.
OP-TEE requires the kernel to map memory shared with secure world with
the attributes specified in the comment.

--
Thanks,
Jens
