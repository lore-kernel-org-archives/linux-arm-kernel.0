From: jens.wiklander@linaro.org (Jens Wiklander)
Date: Tue, 21 Apr 2015 12:45:07 +0200
Subject: [tpmdd-devel] [RFC PATCH 1/2] tee: generic TEE subsystem
In-Reply-To: <20150420182052.GA32299@obsidianresearch.com>
References: <1429257057-7935-1-git-send-email-jens.wiklander@linaro.org>
 <1429257057-7935-2-git-send-email-jens.wiklander@linaro.org>
 <2102140.2VHBUJBHNB@wuerfel> <20150420062044.GA7767@ermac>
 <20150420182052.GA32299@obsidianresearch.com>
Message-ID: <20150421104507.GB7760@ermac>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 20, 2015 at 12:20:52PM -0600, Jason Gunthorpe wrote:
> On Mon, Apr 20, 2015 at 08:20:44AM +0200, Jens Wiklander wrote:
> 
> > I'm not sure I understand what you mean. This function is a building
> > block for the TEE driver to supply whatever interface is needed for user
> > space. For a Global Platform like TEE it will typically have support for
> > TEEC_OpenSession(), TEEC_InvokeCommand(), TEEC_RequestCancellation() and
> > TEEC_CloseSession(). But how that's done is depending on how the
> > interface towards the TEE (in secure world) looks like. From what I've
> > heard so far those interfaces diverges a lot so we've compromised with
> > this function.
> 
> The goal of the mid layer is to bring all these differences into a
> common abstraction, not punt on them to higher layers.
> 
> The goal if the driver is to translate and transport the common
> abstraction to the hardware.
> 
> It is an absolute failure if each TEE driver implements a different
> TEEC_OpenSession() ioctl. They must be the same, the common code
> must de-marshal the request from user space and then call
> ops->open_session()
> 
> Driver specific ioctls are a terrible way to start a new mid layer.
The example I gave above concerns Global Platform like TEEs, we're
trying to cover TEEs that doesn't follow Global Platform also here. Most
(or at least a significant part) deployed TEEs, in terms of volume,
today are not Global Platform compliant.

I'd like to view TEE_IOC_CMD as communication channel directly into the
TEE. What goes inside the channel is not something that this subsystem
cares about. The kernel driver will likely need to translate memory
references from user space inside this channel to something usable by
secure world (and vice versa), but apart from that it does as little as
possible except delivering messages.

There's no single definition of what interfaces a TEE has to normal
world. As soon as we try to define a common interface we're bound to
either miss a function completely or just define something that can't be
used by some TEE.

Global Platform has "TEE Client specification" and "TEE Internal Core
API Specification", but neither says anything about what happens between
the lower layers in user space and the TEE.

> 
> > > What is the typical and maximum allocation size here?
> > It depends on the design of the Trusted Application in secure world and
> > the client in user space.  A few KiB could be the typical allocation
> > size, with a maximum at perhaps 512 KiB (for instance when loading a
> > very large Trusted Application).
> 
> So this TEE stuff also encompasses a 'firmware' loader (to the secure
> world, presumably)?
Yes, but that's driver specific. Some TEEs don't have this and the rest
does it in their own way. Global Platform doesn't say anything at all
about this.

> 
> That is probably your base level of 'ops' functionality, plus the
> shared memroy stuff.
> 
> How does this work if two userspace things run concurrently with
> different firmwares? Is there some locking or something? What is the
> lifetime of this firmware tied to?
In secure world there's a trusted OS (the TEE) with possibly embedded
Trusted Applications (TAs). The TEE may support loading TAs dynamically.

In the OP-TEE case when running on ARM with TrustZone it works like this:
1. The TEE is already loaded when kernel boots.
2. A tee_context is created when user space opens /dev/teeX, this
   context holds the sessions.
3. TAs are loaded when needed when a session to the TA is opened.
4. When the context is closed all sessions that are still open are
   closed.
5. What happens with the TAs when sessions are closed is internal to the
   TEE. The TAs are stored in protected memory which the kernel can't
   access any way.

OP-TEE is currently single threaded in the sense that only one thread
can be active in secure world at a time. We have some synchronization
around the SMC that enters secure world, but that's implementation
specific and only there to avoid unnecessary ping pong or spinlock in
secure world.

> 
> > I agree that we can drop least one of the _version fields probably both,
> > but something is needed for user space to be able to know which TEE (in
> > secure world) it's communicating with. The uuid will let the client know
> > how how to format the commands passed to TEE_IOC_CMD below.
> 
> So you load the firmare, learn what command set it supports then use
> TEE_IOC_CMD to shuttle firmware-specific data to and from?
Correct, except that the firmware (the TEE) is in most cases already
loaded at this stage.

> 
> > I've touched on this above, this function the essential when
> > communicating with the driver and secure world. Different TEEs (running
> > in some secure environment) provides different interfaces. By providing
> > an opaque channel we don't have to force something on the TEE.  The
> > problem is moved to the user space library which is used when talking to
> > the TEE. The assumption here is that the interface provided the TEE is
> > stable or something that the specific TEE driver can handle with a glue
> > layer.
> 
> I would use read/write for this, not ioctl. read/write can work with
> select/poll so you can send your command then go into a polling loop
> waiting for the reply from the firmware.

There's two reasons I'm using ioctl instead.
On ARM with TrustZone (common case right now) the TEE is executing on
the same CPUs as the kernel (but with the ns-bit cleared instead of
set). Delivering a message/request is done with an SMC, you can compare
it with a syscall in user space. OP-TEE doesn't have a scheduler instead
we run on the time of the user space process doing the request. If we
where doing read/write/poll in which of the syscalls would we do the
SMC?

We have to be able to run several commands in parallel. How do we
connect the different reads and writes? A separate file descriptor would
do it, but we would need more than one for each session.

Regards,
Jens
