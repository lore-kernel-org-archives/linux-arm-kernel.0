From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat, 18 May 2013 20:20:00 +0200
Subject: [RFC 3/4] DRM: add OF support for Dove DRM driver
In-Reply-To: <20130518194502.102caa9e@armhf>
References: <20130516192510.GV18614@n2100.arm.linux.org.uk>
 <1368897139-25485-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1368897139-25485-4-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130518194502.102caa9e@armhf>
Message-ID: <5197C650.9020802@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/18/2013 07:45 PM, Jean-Francois Moine wrote:
> On Sat, 18 May 2013 19:12:18 +0200
> Sebastian Hesselbarth<sebastian.hesselbarth@gmail.com>  wrote:
>> This adds OF support for the Dove DRM driver recently posted as RFC by
>> Russell King.
>>
...

Jean-Francois,

one thing first: It is an RFC! It is to allow you to _test_ rmk's driver
on DT. Nothing more, nothing less.

I will comment on your questions but that all can change for a full
patch set of rmk, you, or me.

The "video-card" node combines all devices that will be available and
active on a specific Dove board. As you may have noticed about rmk's
driver, it is registering crtcs from IORESOURCE_MEM passed with the
platform_device.

To match with this approach we _have to_ recreate that platform_device
from what we see on DT. On DT each bus node gets registered as its own
platform_device. So in the video-card driver we look for node we know
of and put together a platform_device for rmk's driver. We cannot hook
DT upon either an lcd node nor dcon node as they might be disabled and
the driver will get called multiple times.

> It seems we are moving backwards:
> - what about the display controller?

That would be part of probing DT nodes above. I did not take care of
that because rmk doesn't support dcon for now.

> - how do you clone the lcd 0 output to the port B?

Pass properties on video-card node or even better let dcon driver
take care of it when it sees a video-card with more than one crtc.

> - what occurs when the si5351 and the tda998x are modules?

Touche, forgot that part. Feel free to add module support to the
RFC.

> My driver had the same layout as Russell's when I proposed it to you
> and when you insisted to handle the 2 LCDs and the 2 ports as one card.

I still insist to handle 2 LCDs and DCON.

> I spent 2 months to have a nice design and you put it to garbage!
> I am not happy...

I put nothing to garbage. _You_ also agreed to merge with rmk's driver!
We can now put in all features we implemented differently
_step-by-step_.

Merging the drivers starts with adding support for DT - that is what
I provided. You know the HW better than me, why don't you start picking
features from your driver and add them in rmk's driver?

Sebastian
