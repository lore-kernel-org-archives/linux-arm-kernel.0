From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 20 Apr 2015 12:20:52 -0600
Subject: [tpmdd-devel] [RFC PATCH 1/2] tee: generic TEE subsystem
In-Reply-To: <20150420062044.GA7767@ermac>
References: <1429257057-7935-1-git-send-email-jens.wiklander@linaro.org>
 <1429257057-7935-2-git-send-email-jens.wiklander@linaro.org>
 <2102140.2VHBUJBHNB@wuerfel> <20150420062044.GA7767@ermac>
Message-ID: <20150420182052.GA32299@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 20, 2015 at 08:20:44AM +0200, Jens Wiklander wrote:

> I'm not sure I understand what you mean. This function is a building
> block for the TEE driver to supply whatever interface is needed for user
> space. For a Global Platform like TEE it will typically have support for
> TEEC_OpenSession(), TEEC_InvokeCommand(), TEEC_RequestCancellation() and
> TEEC_CloseSession(). But how that's done is depending on how the
> interface towards the TEE (in secure world) looks like. From what I've
> heard so far those interfaces diverges a lot so we've compromised with
> this function.

The goal of the mid layer is to bring all these differences into a
common abstraction, not punt on them to higher layers.

The goal if the driver is to translate and transport the common
abstraction to the hardware.

It is an absolute failure if each TEE driver implements a different
TEEC_OpenSession() ioctl. They must be the same, the common code
must de-marshal the request from user space and then call
ops->open_session()

Driver specific ioctls are a terrible way to start a new mid layer.

> > What is the typical and maximum allocation size here?
> It depends on the design of the Trusted Application in secure world and
> the client in user space.  A few KiB could be the typical allocation
> size, with a maximum at perhaps 512 KiB (for instance when loading a
> very large Trusted Application).

So this TEE stuff also encompasses a 'firmware' loader (to the secure
world, presumably)?

That is probably your base level of 'ops' functionality, plus the
shared memroy stuff.

How does this work if two userspace things run concurrently with
different firmwares? Is there some locking or something? What is the
lifetime of this firmware tied to?

> I agree that we can drop least one of the _version fields probably both,
> but something is needed for user space to be able to know which TEE (in
> secure world) it's communicating with. The uuid will let the client know
> how how to format the commands passed to TEE_IOC_CMD below.

So you load the firmare, learn what command set it supports then use
TEE_IOC_CMD to shuttle firmware-specific data to and from?

> I've touched on this above, this function the essential when
> communicating with the driver and secure world. Different TEEs (running
> in some secure environment) provides different interfaces. By providing
> an opaque channel we don't have to force something on the TEE.  The
> problem is moved to the user space library which is used when talking to
> the TEE. The assumption here is that the interface provided the TEE is
> stable or something that the specific TEE driver can handle with a glue
> layer.

I would use read/write for this, not ioctl. read/write can work with
select/poll so you can send your command then go into a polling loop
waiting for the reply from the firmware.

Jason
