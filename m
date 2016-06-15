From: daniel@ffwll.ch (Daniel Vetter)
Date: Wed, 15 Jun 2016 22:30:36 +0200
Subject: [PATCH v5 2/3] drm/arm: Add support for Mali Display Processors
In-Reply-To: <20160615200539.GH1041@n2100.armlinux.org.uk>
References: <1466002295-24813-1-git-send-email-Liviu.Dudau@arm.com>
 <1466002295-24813-3-git-send-email-Liviu.Dudau@arm.com>
 <20160615152309.GI1338@phenom.ffwll.local>
 <20160615161758.GF9711@e106497-lin.cambridge.arm.com>
 <CAKMK7uENW3cU8LccHcqffX3cbzax2-5mzY0101yLfR7vtD4CoA@mail.gmail.com>
 <20160615172104.GI9711@e106497-lin.cambridge.arm.com>
 <CAKMK7uGFTmQERWcDeQ=V-ntbgQv6K1avGx1LKCGLcAWacmHKnA@mail.gmail.com>
 <20160615200539.GH1041@n2100.armlinux.org.uk>
Message-ID: <CAKMK7uFwXzRmLp_werouyvFrb-qEZi+xg32bO48r51rHmvT3Vw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 15, 2016 at 10:05 PM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Wed, Jun 15, 2016 at 09:29:38PM +0200, Daniel Vetter wrote:
>> On Wed, Jun 15, 2016 at 7:21 PM, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
>> > Could be the tda998x_drv fault, but I'm getting this splat:
>>
>> Yeah, tda9998x needs to be fixed to _not_ register it's connector
>> before the overall (componentized) driver is ready. We need to make
>> sure first ofc that all users of that driver do register connectors,
>> but Chris' patch series will take care of that. But tda9998x needs to
>> be fixed either way.
>
> Componentised drivers only get one bind callback, they don't get a
> two-stage initialisation at bind time.

We don't need two-stage init in the component framework. There's
patches in-flight to simplify this a lot (and provide callbacks to
register additional connector interfaces like backlight). But in
general components should not call drm_connector_register, instead the
master should call drm_connector_register_all at the very end. Yes
this is a change from how all the original kms drivers have done it,
but that way was also racy (since it exposed interfaces to userspace
before they're fully set up). We're gradually switching each driver
over, but for shared bits like tda9998x it's a bit more complicated -
all the drivers using it need to switch at the same time.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
