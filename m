From: jens.wiklander@linaro.org (Jens Wiklander)
Date: Tue, 24 Jan 2017 13:53:31 +0100
Subject: [PATCH v14 3/5] tee: add OP-TEE driver
In-Reply-To: <5564439.UZohRc66aK@wuerfel>
References: <1484744296-30003-1-git-send-email-jens.wiklander@linaro.org>
 <8183743.bSJXZpMh95@wuerfel> <20170123090852.GB1910@jax>
 <5564439.UZohRc66aK@wuerfel>
Message-ID: <20170124125330.GA30998@jax>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 23, 2017 at 05:16:15PM +0100, Arnd Bergmann wrote:
> On Monday, January 23, 2017 10:08:53 AM CET Jens Wiklander wrote:
> > On Fri, Jan 20, 2017 at 05:57:51PM +0100, Arnd Bergmann wrote:
> > > On Thursday, January 19, 2017 3:56:23 PM CET Jens Wiklander wrote:
> > > > On Wed, Jan 18, 2017 at 05:28:17PM +0100, Arnd Bergmann wrote:
> 
> > > > Does the platform devices really need cleaning? I mean
> > > > of_platform_default_populate_init() creates a bunch of platform devices
> > > > which are just left there even if unused. Here we're doing the same
> > > > thing except that we're doing it for a specific node in the DT.
> > > 
> > > I think it will work if you don't clean them up, but it feels wrong
> > > to have a loadable module that creates devices when loaded but doesn't
> > > remove them when unloaded.
> > > 
> > > This could be done differently by having the device creation done in
> > > one driver and the the user of that device in another driver, but I
> > > think just killing off the device achieves the same in a simpler way.
> > 
> > I see your point. My final concern here is that with device we got
> > entries in sysfs and uevents that could be used to automatically start
> > the correct supplicant. Different drivers are likely to require
> > different supplicants. Starting the correct supplicant based on uevents
> > is a quite elegant solution which I'm not sure how to support when
> > skipping devices. Perhaps I could create an object below
> > <sysfs>/firmware/tee ?
> 
> Putting the objects somewhere other than /sys/devices sounds good, yes.
> This would also help with TEE implementations that might get probed
> differently.
> 
> I think the natural place would be /sys/class/tee/, as we normally
> require something in /sys/class anyway to support the character
> device.
> 
> /sys/firmware/tee/ sounds less fitting, as there other TEE implementations
> are not necessarily firmware based, as you point out. 
> /sys/firmware/op-tee certainly makes sense for anything that is specific
> to OP-TEE in particular, while /sys/class/tee would be for anything
> that uses the ioctl interface. This part is particularly important to
> get right from the start, just like the ioctls themselves we can't make
> incompatible changes here later once there are users relying on the
> upstream kernel interfaces.

/sys/class/tee/ sounds good, I'll use that. It's more or less what we
also have today.

Thanks for the help with this review.

Jens
