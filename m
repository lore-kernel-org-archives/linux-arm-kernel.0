From: daniel@ffwll.ch (Daniel Vetter)
Date: Tue, 5 Dec 2017 11:45:38 +0100
Subject: [RFC PATCH 1/6] drm: Add Content Protection property
In-Reply-To: <20171205102840.GB12982@amd>
References: <20171130030907.26848-1-seanpaul@chromium.org>
 <20171130030907.26848-2-seanpaul@chromium.org>
 <20171205102840.GB12982@amd>
Message-ID: <20171205104538.b4fxdjad3c46koas@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 05, 2017 at 11:28:40AM +0100, Pavel Machek wrote:
> On Wed 2017-11-29 22:08:56, Sean Paul wrote:
> > This patch adds a new optional connector property to allow userspace to enable
> > protection over the content it is displaying. This will typically be implemented
> > by the driver using HDCP.
> > 
> > The property is a tri-state with the following values:
> > - OFF: Self explanatory, no content protection
> > - DESIRED: Userspace requests that the driver enable protection
> > - ENABLED: Once the driver has authenticated the link, it sets this value
> > 
> > The driver is responsible for downgrading ENABLED to DESIRED if the link becomes
> > unprotected. The driver should also maintain the desiredness of protection
> > across hotplug/dpms/suspend.
> 
> Why would user of the machine want this to be something else than
> 'OFF'?
> 
> If kernel implements this, will it mean hardware vendors will have to
> prevent user from updating kernel on machines they own?
> 
> If this is merged, does it open kernel developers to DMCA threats if
> they try to change it?

Because this just implements one part of the content protection scheme.
This only gives you an option to enable HDCP (aka encryption, it's really
nothing else) on the cable. Just because it has Content Protection in the
name does _not_ mean it is (stand-alone) an effective nor complete content
protection scheme. It's simply encrypting data, that's all.

If you want to actually lock down a machine to implement content
protection, then you need secure boot without unlockable boot-loader and a
pile more bits in userspace.  If you do all that, only then do you have
full content protection. And yes, then you don't really own the machine
fully, and I think users who are concerned with being able to update their
kernels and be able to exercise their software freedoms already know to
avoid such locked down systems.

So yeah it would be better to call this the "HDMI/DP cable encryption
support", but well, it's not what it's called really.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
