From: jens.wiklander@linaro.org (Jens Wiklander)
Date: Thu, 3 Nov 2016 13:35:06 -0600
Subject: [PATCH v12 RESEND 0/4] generic TEE subsystem
In-Reply-To: <573b8fff-eeb7-3656-6f32-de69d906a966@ti.com>
References: <1477649984-16777-1-git-send-email-jens.wiklander@linaro.org>
 <1e532aeb-4944-62e4-c8c4-1e23438b92cd@ti.com>
 <20161029094641.GA23362@ermac>
 <573b8fff-eeb7-3656-6f32-de69d906a966@ti.com>
Message-ID: <20161103193505.GA5600@ermac>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 31, 2016 at 01:24:14PM -0500, Andrew F. Davis wrote:
> On 10/29/2016 04:46 AM, Jens Wiklander wrote:
> > On Fri, Oct 28, 2016 at 10:43:24AM -0500, Andrew F. Davis wrote:
> >> On 10/28/2016 05:19 AM, Jens Wiklander wrote:
> >>> Hi,
> >>>
> >>> This patch set introduces a generic TEE subsystem. The TEE subsystem will
> >>> contain drivers for various TEE implementations. A TEE (Trusted Execution
> >>> Environment) is a trusted OS running in some secure environment, for
> >>> example, TrustZone on ARM CPUs, or a separate secure co-processor etc.
> >>>
> >>> Regarding use cases, TrustZone has traditionally been used for
> >>> offloading secure tasks to the secure world. Examples include: 
> >>> - Secure key handling where the OS may or may not have direct access to key
> >>>   material.
> >>> - E-commerce and payment technologies. Credentials, credit card numbers etc
> >>>   could be stored in a more secure environment.
> >>> - Trusted User Interface (TUI) to ensure that no-one can snoop PIN-codes
> >>>   etc.
> >>> - Secure boot to ensure that loaded binaries haven?t been tampered with.
> >>>   It?s not strictly needed for secure boot, but you could enhance security
> >>>   by leveraging a TEE during boot.
> >>> - Digital Rights Management (DRM), the studios provides content with
> >>>   different resolution depending on the security of the device. Higher
> >>>   security means higher resolution.
> >>>
> >>> A TEE could also be used in existing and new technologies. For example IMA
> >>> (Integrity Measurement Architecture) which has been in the kernel for quite
> >>> a while. Today you can enhance security by using a TPM-chip to sign the IMA
> >>> measurement list. This is something that you also could do by leveraging a
> >>> TEE.
> >>>
> >>> Another example could be in 2-factor authentication which is becoming
> >>> increasingly more important. FIDO (https://fidoalliance.org) for example
> >>> are using public key cryptography in their 2-factor authentication standard
> >>> (U2F). With FIDO, a private and public key pair will be generated for every
> >>> site you visit and the private key should never leave the local device.
> >>> This is an example where you could use secure storage in a TEE for the
> >>> private key.
> >>>
> >>> Today you will find a quite a few different out of tree implementations of
> >>> TEE drivers which tends to fragment the TEE ecosystem and development. We
> >>> think it would be a good idea to have a generic TEE driver integrated in
> >>> the kernel which would serve as a base for several different TEE solutions,
> >>> no matter if they are on-chip like TrustZone or if they are on a separate
> >>> crypto co-processor.
> >>>
> >>> To develop this TEE subsystem we have been using the open source TEE called
> >>> OP-TEE (https://github.com/OP-TEE/optee_os) and therefore this would be the
> >>> first TEE solution supported by this new subsystem. OP-TEE is a
> >>> GlobalPlatform compliant TEE, however this TEE subsystem is not limited to
> >>> only GlobalPlatform TEEs, instead we have tried to design it so that it
> >>> should work with other TEE solutions also.
> >>>
> >>
> >> The above is my biggest concern with this whole subsystem, to me it
> >> still feels very OPTEE specific. As much as I would love to believe
> >> OPTEE will be the end-all TEE, I'm sure we soon will start to see wider
> >> use of vendor TEEs (like TI's own legacy Trustzone thing we are hoping
> >> to depreciate with OPTEE moving forward), possibly Google's Trusty TEE,
> >> and whatever Intel/AMD are cooking up for x86.
> > 
> > I'd rather say that it's slightly GlobalPlatform specific, but a bit
> > more flexible.
> > 
> >>
> >> As we all know when things are upstreamed we lose the ability to make
> >> radical changes easily, especially to full subsystems. What happens when
> >> this framework, built with only one existing TEE, built by the one
> >> existing TEE's devs, is not as flexible as we need when other TEEs start
> >> rolling out?
> > 
> > Initially the TEE subsystem was much more flexible and was criticized
> > for that.
> > 
> 
> That's rather strange, I haven't been following this from the start so I
> will just take your word that this is where the community wants this
> subsystem to go.
> 
> >>
> >> Do we see this as a chicken and egg situation, or is there any harm
> >> beyond the pains of supporting an out-of-tree driver for a while, to
> >> wait until we have at least one other TEE to add to this subsystem
> >> before merging?
> > 
> > This proposal is the bare minimum to have something useful. On top of
> > this there's more things we'd like to add, for example an in-kernel API
> > for accessing the TEE and secure buffer handling. The way we're dealing
> > with shared memory need to be improved to better support multiple guests
> > communicating with one TEE.
> > 
> > What we can do now with the subsystem now is somewhat limited by the
> > fact that we're trying to upstream it and want to do that it in
> > manageable increments.
> > 
> 
> Fair enough.
> 
> For now this series is being used in our production SDKs so it has at
> least some basic testing from us, so for the whole series:
> 
> Tested-by: Andrew F. Davis <afd@ti.com>

Thanks, Andrew. A summary of all tags so far:

When I sent out this patch set I missed including the previous
tested-bys:
Tested-by: Jerome Forissier <jerome.forissier@linaro.org> (HiKey)
Tested-by: Volodymyr Babchuk <vlad.babchuk@gmail.com>

Then there's also the acked-by from Andreas which should have been
included even if the mail now bounces:
Acked-by: Andreas Dannenberg <dannenberg@ti.com>

The DT patch has (since v8):
Acked-by: Rob Herring <robh@kernel.org>

Thanks,
Jens
