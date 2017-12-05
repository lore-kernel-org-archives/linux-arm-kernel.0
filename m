From: alexdeucher@gmail.com (Alex Deucher)
Date: Tue, 5 Dec 2017 12:53:20 -0500
Subject: [RFC PATCH 1/6] drm: Add Content Protection property
In-Reply-To: <20171205173408.GA18425@amd>
References: <20171130030907.26848-1-seanpaul@chromium.org>
 <20171130030907.26848-2-seanpaul@chromium.org>
 <20171205102840.GB12982@amd>
 <20171205104538.b4fxdjad3c46koas@phenom.ffwll.local>
 <20171205173408.GA18425@amd>
Message-ID: <CADnq5_PcbBeGL+3CxOpNgRiih4czU9SnmjNbRyyRHOn-OZvy5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 5, 2017 at 12:34 PM, Pavel Machek <pavel@ucw.cz> wrote:
> On Tue 2017-12-05 11:45:38, Daniel Vetter wrote:
>> On Tue, Dec 05, 2017 at 11:28:40AM +0100, Pavel Machek wrote:
>> > On Wed 2017-11-29 22:08:56, Sean Paul wrote:
>> > > This patch adds a new optional connector property to allow userspace to enable
>> > > protection over the content it is displaying. This will typically be implemented
>> > > by the driver using HDCP.
>> > >
>> > > The property is a tri-state with the following values:
>> > > - OFF: Self explanatory, no content protection
>> > > - DESIRED: Userspace requests that the driver enable protection
>> > > - ENABLED: Once the driver has authenticated the link, it sets this value
>> > >
>> > > The driver is responsible for downgrading ENABLED to DESIRED if the link becomes
>> > > unprotected. The driver should also maintain the desiredness of protection
>> > > across hotplug/dpms/suspend.
>> >
>> > Why would user of the machine want this to be something else than
>> > 'OFF'?
>> >
>> > If kernel implements this, will it mean hardware vendors will have to
>> > prevent user from updating kernel on machines they own?
>> >
>> > If this is merged, does it open kernel developers to DMCA threats if
>> > they try to change it?
>>
>> Because this just implements one part of the content protection scheme.
>> This only gives you an option to enable HDCP (aka encryption, it's really
>> nothing else) on the cable. Just because it has Content Protection in the
>> name does _not_ mean it is (stand-alone) an effective nor complete content
>> protection scheme. It's simply encrypting data, that's all.
>
> Yep. So my first question was: why would user of the machine ever want
> encryption "ENABLED" or "DESIRED"? Could you answer it?

How about for sensitive video streams in government offices where you
want to avoid a spy potentially tapping the cable to see the video
stream?

>
>> If you want to actually lock down a machine to implement content
>> protection, then you need secure boot without unlockable boot-loader and a
>> pile more bits in userspace.  If you do all that, only then do you have
>> full content protection. And yes, then you don't really own the machine
>> fully, and I think users who are concerned with being able to update
>> their
>
> Yes, so... This patch makes it more likely to see machines with locked
> down kernels, preventing developers from working with systems their
> own, running hardware. That is evil, and direct threat to Free
> software movement.
>
> Users compiling their own kernels get no benefit from it. Actually it
> looks like this only benefits Intel and Disney. We don't want that.

And just about every SoC manufacturer and google and amazon and a ton
of other companies and organizations.  Who gets to decide who's
benefit gets taken into account?

>
>> kernels and be able to exercise their software freedoms already know to
>> avoid such locked down systems.
>>
>> So yeah it would be better to call this the "HDMI/DP cable encryption
>> support", but well, it's not what it's called really.
>
> Well, it does not belong in kernel, no matter what is the name.

Should we remove support for encrypted file systems and encrypted
virtual machines?  Just like them the option is there is you want to
use it.  If you don't want to, you don't have to.


Alex
