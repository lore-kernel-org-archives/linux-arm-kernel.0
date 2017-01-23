From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 23 Jan 2017 17:16:15 +0100
Subject: [PATCH v14 3/5] tee: add OP-TEE driver
In-Reply-To: <20170123090852.GB1910@jax>
References: <1484744296-30003-1-git-send-email-jens.wiklander@linaro.org>
 <8183743.bSJXZpMh95@wuerfel> <20170123090852.GB1910@jax>
Message-ID: <5564439.UZohRc66aK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, January 23, 2017 10:08:53 AM CET Jens Wiklander wrote:
> On Fri, Jan 20, 2017 at 05:57:51PM +0100, Arnd Bergmann wrote:
> > On Thursday, January 19, 2017 3:56:23 PM CET Jens Wiklander wrote:
> > > On Wed, Jan 18, 2017 at 05:28:17PM +0100, Arnd Bergmann wrote:

> > > Does the platform devices really need cleaning? I mean
> > > of_platform_default_populate_init() creates a bunch of platform devices
> > > which are just left there even if unused. Here we're doing the same
> > > thing except that we're doing it for a specific node in the DT.
> > 
> > I think it will work if you don't clean them up, but it feels wrong
> > to have a loadable module that creates devices when loaded but doesn't
> > remove them when unloaded.
> > 
> > This could be done differently by having the device creation done in
> > one driver and the the user of that device in another driver, but I
> > think just killing off the device achieves the same in a simpler way.
> 
> I see your point. My final concern here is that with device we got
> entries in sysfs and uevents that could be used to automatically start
> the correct supplicant. Different drivers are likely to require
> different supplicants. Starting the correct supplicant based on uevents
> is a quite elegant solution which I'm not sure how to support when
> skipping devices. Perhaps I could create an object below
> <sysfs>/firmware/tee ?

Putting the objects somewhere other than /sys/devices sounds good, yes.
This would also help with TEE implementations that might get probed
differently.

I think the natural place would be /sys/class/tee/, as we normally
require something in /sys/class anyway to support the character
device.

/sys/firmware/tee/ sounds less fitting, as there other TEE implementations
are not necessarily firmware based, as you point out. 
/sys/firmware/op-tee certainly makes sense for anything that is specific
to OP-TEE in particular, while /sys/class/tee would be for anything
that uses the ioctl interface. This part is particularly important to
get right from the start, just like the ioctls themselves we can't make
incompatible changes here later once there are users relying on the
upstream kernel interfaces.

> > > > > +/*
> > > > > + * Get revision of Trusted OS.
> > > > > + *
> > > > > + * Used by non-secure world to figure out which version of the Trusted OS
> > > > > + * is installed. Note that the returned revision is the revision of the
> > > > > + * Trusted OS, not of the API.
> > > > > + *
> > > > > + * Returns revision in 2 32-bit words in the same way as
> > > > > + * OPTEE_MSG_CALLS_REVISION described above.
> > > > > + */
> > > > > +#define OPTEE_MSG_OS_OPTEE_REVISION_MAJOR	1
> > > > > +#define OPTEE_MSG_OS_OPTEE_REVISION_MINOR	0
> > > > > +#define OPTEE_MSG_FUNCID_GET_OS_REVISION	0x0001
> > > > 
> > > > Just for my understanding, what is the significance of these numbers,
> > > > i.e. which code (user space, kernel driver, trusted OS) provides
> > > > the uuid and which one provides the version? The code comments almost
> > > > make sense to me, but I don't see why specific versions are listed
> > > > in this header.
> > > 
> > > You're right, OPTEE_MSG_OS_OPTEE_REVISION_* should be removed. The
> > > actual version the secure OS is of a mostly informational nature. The
> > > same goes the OS UUID, but I suppose the actual UUID used by the
> > > upstream version of OP-TEE OS could be interesting to know.
> > ...
> > > > What is the expected behavior when one side reports a version that
> > > > is unknown? Can one side claim to be backwards compatible with
> > > > a previous version, or does each new version need support on
> > > > all three sides?
> > > 
> > > The UUID and version of the message protocol are important to match
> > > correctly as otherwise it could mean that there's something unexpected
> > > in secure world that following the message protocol would be undefined
> > > behaviour. All changes to the message protocol should be backwards
> > > compatible in the sense that the driver and secure world need to
> > > negotiate eventual extensions while probing. That's what we're doing in
> > > optee_msg_exchange_capabilities().
> > 
> > Ok, then maybe the "compatible" identifier in DT should be sufficient
> > to ensure that the capability exchange works, and the rest be based
> > on that?
> > 
> > We tend to avoid version checks for APIs in the kernel because they
> > never work in practice, but the capability check should be fine.
> 
> UUID and version of the message protocol is required by ARM SMC Calling
> Convention. It will be there anyway so we could just as well check it in
> the probe function to catch eventual mismatches in configuration. Since
> we're using capabilities to manage extensions of the protocol I think
> the minor version could be ignored by probe.

Ok, makes sense.

	Arnd
