From: jens.wiklander@linaro.org (Jens Wiklander)
Date: Mon, 23 Jan 2017 10:08:53 +0100
Subject: [PATCH v14 3/5] tee: add OP-TEE driver
In-Reply-To: <8183743.bSJXZpMh95@wuerfel>
References: <1484744296-30003-1-git-send-email-jens.wiklander@linaro.org>
 <12500736.cNG1jjvVpX@wuerfel> <20170119145621.GA4958@jax>
 <8183743.bSJXZpMh95@wuerfel>
Message-ID: <20170123090852.GB1910@jax>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2017 at 05:57:51PM +0100, Arnd Bergmann wrote:
> On Thursday, January 19, 2017 3:56:23 PM CET Jens Wiklander wrote:
> > On Wed, Jan 18, 2017 at 05:28:17PM +0100, Arnd Bergmann wrote:
> > > On Wednesday, January 18, 2017 1:58:14 PM CET Jens Wiklander wrote:
> 
> > > > +static int __init optee_driver_init(void)
> > > > +{
> > > > +	struct device_node *node;
> > > > +
> > > > +	/*
> > > > +	 * Preferred path is /firmware/optee, but it's the matching that
> > > > +	 * matters.
> > > > +	 */
> > > > +	for_each_matching_node(node, optee_match)
> > > > +		of_platform_device_create(node, NULL, NULL);
> > > > +
> > > > +	return platform_driver_register(&optee_driver);
> > > > +}
> > > > +module_init(optee_driver_init);
> > > > +
> > > > +static void __exit optee_driver_exit(void)
> > > > +{
> > > > +	platform_driver_unregister(&optee_driver);
> > > > +}
> > > > +module_exit(optee_driver_exit);
> > > 
> > > What is the platform driver good for if the same module has to create the
> > > platform devices itself?
> > 
> > The platform device(s) are created here because the optee node is below
> > "/firmware" instead of the root where it would have had the platform
> > device created automatically.
> > 
> > I think it's useful to be able to unload the module, the early reviews
> > of this patch set was much focused around that. Regardless I'll need
> > some device as parent for the devices created during optee_probe() and
> > using a platform device for that seems natural.
> > 
> > I'd rather keep the platform driver. Perhaps some variant of the pattern
> > in qcom_scm_init() (drivers/firmware/qcom_scm.c) is useful, except that
> > I need to find out what to do about the life cycle of the objects
> > created with of_platform_populate().
> 
> My point was that I don't think we need devices here at all. It's different
> when you talk to external hardware that has register resource etc that
> can be best abstracted as a real device, but for other firmware features
> we don't normally add one.
> 
> Module unloading can also be done without the device.
> 
> > > 
> > > I'd just skip it and do
> > > 
> > > 	for_each_matching_node(node, optee_match)
> > > 		optee_probe(node);
> > > 
> > > I also suspect that module unloading is broken here if you don't clean
> > > up the platform devices in the end, so you should already remove the
> > > exit function to prevent unloading.
> > 
> > Does the platform devices really need cleaning? I mean
> > of_platform_default_populate_init() creates a bunch of platform devices
> > which are just left there even if unused. Here we're doing the same
> > thing except that we're doing it for a specific node in the DT.
> 
> I think it will work if you don't clean them up, but it feels wrong
> to have a loadable module that creates devices when loaded but doesn't
> remove them when unloaded.
> 
> This could be done differently by having the device creation done in
> one driver and the the user of that device in another driver, but I
> think just killing off the device achieves the same in a simpler way.

I see your point. My final concern here is that with device we got
entries in sysfs and uevents that could be used to automatically start
the correct supplicant. Different drivers are likely to require
different supplicants. Starting the correct supplicant based on uevents
is a quite elegant solution which I'm not sure how to support when
skipping devices. Perhaps I could create an object below
<sysfs>/firmware/tee ?

> 
> > > > +/*
> > > > + * Get revision of Trusted OS.
> > > > + *
> > > > + * Used by non-secure world to figure out which version of the Trusted OS
> > > > + * is installed. Note that the returned revision is the revision of the
> > > > + * Trusted OS, not of the API.
> > > > + *
> > > > + * Returns revision in 2 32-bit words in the same way as
> > > > + * OPTEE_MSG_CALLS_REVISION described above.
> > > > + */
> > > > +#define OPTEE_MSG_OS_OPTEE_REVISION_MAJOR	1
> > > > +#define OPTEE_MSG_OS_OPTEE_REVISION_MINOR	0
> > > > +#define OPTEE_MSG_FUNCID_GET_OS_REVISION	0x0001
> > > 
> > > Just for my understanding, what is the significance of these numbers,
> > > i.e. which code (user space, kernel driver, trusted OS) provides
> > > the uuid and which one provides the version? The code comments almost
> > > make sense to me, but I don't see why specific versions are listed
> > > in this header.
> > 
> > You're right, OPTEE_MSG_OS_OPTEE_REVISION_* should be removed. The
> > actual version the secure OS is of a mostly informational nature. The
> > same goes the OS UUID, but I suppose the actual UUID used by the
> > upstream version of OP-TEE OS could be interesting to know.
> ...
> > > What is the expected behavior when one side reports a version that
> > > is unknown? Can one side claim to be backwards compatible with
> > > a previous version, or does each new version need support on
> > > all three sides?
> > 
> > The UUID and version of the message protocol are important to match
> > correctly as otherwise it could mean that there's something unexpected
> > in secure world that following the message protocol would be undefined
> > behaviour. All changes to the message protocol should be backwards
> > compatible in the sense that the driver and secure world need to
> > negotiate eventual extensions while probing. That's what we're doing in
> > optee_msg_exchange_capabilities().
> 
> Ok, then maybe the "compatible" identifier in DT should be sufficient
> to ensure that the capability exchange works, and the rest be based
> on that?
> 
> We tend to avoid version checks for APIs in the kernel because they
> never work in practice, but the capability check should be fine.

UUID and version of the message protocol is required by ARM SMC Calling
Convention. It will be there anyway so we could just as well check it in
the probe function to catch eventual mismatches in configuration. Since
we're using capabilities to manage extensions of the protocol I think
the minor version could be ignored by probe.

Thanks,
Jens
