From: robherring2@gmail.com (Rob Herring)
Date: Mon, 24 Aug 2015 09:48:27 -0500
Subject: [PATCH v3 06/14] Documentation: drm/bridge: add document for
 analogix_dp
In-Reply-To: <20150824125758.GA7557@n2100.arm.linux.org.uk>
References: <1439995728-18046-1-git-send-email-ykk@rock-chips.com>
 <1439995834-18363-1-git-send-email-ykk@rock-chips.com>
 <CAL_JsqLz+8RtBucctUj4euXZ3Ac0DvB52N9ONpAerh5T9BiTJg@mail.gmail.com>
 <20150824125758.GA7557@n2100.arm.linux.org.uk>
Message-ID: <CAL_JsqKZYMMzV9Sc2r3K_rnM0FNuyb1TyJEhjGq1Hf7dTiWFKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 24, 2015 at 7:57 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sun, Aug 23, 2015 at 06:23:14PM -0500, Rob Herring wrote:
>> On Wed, Aug 19, 2015 at 9:50 AM, Yakir Yang <ykk@rock-chips.com> wrote:
>> > +       -analogix,color-depth:
>> > +               number of bits per colour component.
>> > +                       COLOR_6 = 0, COLOR_8 = 1, COLOR_10 = 2, COLOR_12 = 3
>>
>> This seems pretty generic. Just use 6, 8, 10, or 12 for values. And
>> drop the vendor prefix.
>
> Please think about this some more.  What does "color-depth" mean?  Does it
> mean the number of bits per colour _component_, or does it mean the total
> number of bits to represent a particular colour.  It's confusing as it
> stands.

Then "component-color-bpp" perhaps?

>
>> > +Optional properties for dp-controller:
>> > +       -analogix,hpd-gpio:
>> > +               Hotplug detect GPIO.
>> > +                       Indicates which GPIO should be used for hotplug
>> > +                       detection
>>
>> We should align with "hpd-gpios" used by HDMI connector binding. Or do
>> we need a DP connector binding that this should be defined in?
>> Probably so.
>>
>> The DRM related bindings are such a cluster f*ck with everyone picking
>> their own way to do things. Just grep hpd in bindings for starters.
>> That is just the tip.
>
> I'm not surprised one iota that DRM bindings are a mess.  There's no one
> overlooking the adoption of DRM bindings, so surprise surprise, everyone
> does their own thing.  This is exactly what happens every time in that
> scenario.  It's not a new problem.

True.

> When we adopted the graph bindings for iMX DRM, I thought exactly at that
> time "it would be nice if this could become the standard for binding DRM
> components together" but I don't have the authority from either the DT
> perspective or the DRM perspective to mandate that.  Neither does anyone
> else.  That's the _real_ problem here.
>
> I've seen several DRM bindings go by which don't use the of-graph stuff,
> which means that they'll never be compatible with generic components
> which do use the of-graph stuff.

It goes beyond bindings IMO. The use of the component framework or not
has been at the whim of driver writers as well. It is either used or
private APIs are created. I'm using components and my need for it
boils down to passing the struct drm_device pointer to the encoder.
Other components like panels and bridges have different ways to attach
to the DRM driver.

> Like you say, it's a mess, but it's a mess of our own making, because no
> one has the authority to regulate this.

Certainly, and I will take some blame here. We deferred a lot of
binding review to subsystem maintainers with the directive to ask for
help when needed. The latter has not happened. We need to improve the
situation here before we end up with a bigger mess. The momentum to
use DRM on Android is growing, so the problem is only going to get
worse if we do nothing.

Rob
