From: daniel@ffwll.ch (Daniel Vetter)
Date: Wed, 15 Jun 2016 19:14:45 +0200
Subject: [PATCH v5 2/3] drm/arm: Add support for Mali Display Processors
In-Reply-To: <CAKMK7uENW3cU8LccHcqffX3cbzax2-5mzY0101yLfR7vtD4CoA@mail.gmail.com>
References: <1466002295-24813-1-git-send-email-Liviu.Dudau@arm.com>
 <1466002295-24813-3-git-send-email-Liviu.Dudau@arm.com>
 <20160615152309.GI1338@phenom.ffwll.local>
 <20160615161758.GF9711@e106497-lin.cambridge.arm.com>
 <CAKMK7uENW3cU8LccHcqffX3cbzax2-5mzY0101yLfR7vtD4CoA@mail.gmail.com>
Message-ID: <CAKMK7uGjfZAyzm6c6vsPZz79Tmx9mt4eewMyW6oCce9_-EezRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 15, 2016 at 7:13 PM, Daniel Vetter <daniel@ffwll.ch> wrote:
> On Wed, Jun 15, 2016 at 6:17 PM, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
>> On Wed, Jun 15, 2016 at 05:23:10PM +0200, Daniel Vetter wrote:
>>> On Wed, Jun 15, 2016 at 03:51:34PM +0100, Liviu Dudau wrote:
>>> > Add support for the new family of Display Processors from ARM Ltd.
>>> > This commit adds basic support for Mali DP500, DP550 and DP650
>>> > parts, with only the display engine being supported at the moment.
>>> >
>>> > Cc: David Brown <David.Brown@arm.com>
>>> > Cc: Brian Starkey <Brian.Starkey@arm.com>
>>> >
>>> > Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
>>>
>>> Small thing I noticed: drm_dev_register/connector_register_all should be
>>> the last step in your init code, and unregister the first. Atm it's
>>> somewhere in the middle. But perfectly fine to do that as a follow-up.
>>
>> I've tried that, but the connector and encoder that gets registered as part
>> of the component_bind_all() fails if there is no drm dev registered. You did
>> comment on the v4 version about that and I did test your idea, sorry for
>> forgeting to update you on that.
>
> Why does it fail? That shouldn't happen ... we need to be able to set
> up everything first, before we register.

To clarify: As soon as drm_dev_register completes userspace can access
the drm_device instance. If you add/init anything like crtc, planes or
encoders later on it can blow up, since drm doesn't support hot-adding
those at all. Therefore you _must_ delay the registering until all
components are set up.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
