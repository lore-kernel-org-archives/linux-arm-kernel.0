From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 29 Nov 2016 10:05:33 +0100
Subject: [RFC PATCH 1/3] drm: Add support for Amlogic Meson Graphic
 Controller
In-Reply-To: <20161129085024.tqf5takulvv7f34x@phenom.ffwll.local>
References: <1480089791-12517-1-git-send-email-narmstrong@baylibre.com>
 <1480089791-12517-2-git-send-email-narmstrong@baylibre.com>
 <20161128081601.wapare3pyzmzghvp@phenom.ffwll.local>
 <99e71b1b-b0cc-ec54-6ca9-417d20195aca@baylibre.com>
 <20161129085024.tqf5takulvv7f34x@phenom.ffwll.local>
Message-ID: <be1e6df5-6c00-c10f-e686-c10251325912@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,
On 11/29/2016 09:50 AM, Daniel Vetter wrote:
> Hi Neil,
> 
> On Mon, Nov 28, 2016 at 10:34:58AM +0100, Neil Armstrong wrote:
>> On 11/28/2016 09:16 AM, Daniel Vetter wrote:
>>> On Fri, Nov 25, 2016 at 05:03:09PM +0100, Neil Armstrong wrote:
>>>> +static void meson_cvbs_encoder_disable(struct drm_encoder *encoder)
>>>> +{
>>>> +	struct meson_cvbs *meson_cvbs = encoder_to_meson_cvbs(encoder);
>>>> +
>>>> +	meson_venci_cvbs_disable(meson_cvbs->priv);
>>>> +}
>>>> +
>>>> +static void meson_cvbs_encoder_enable(struct drm_encoder *encoder)
>>>> +{
>>>> +	struct meson_cvbs *meson_cvbs = encoder_to_meson_cvbs(encoder);
>>>> +
>>>> +	meson_venci_cvbs_enable(meson_cvbs->priv);
>>>> +}
>>>
>>> Personally I'd remove the indirection above, more direct code is easier to
>>> read.
>>
>> I understand, I'll maybe change the meson_venci_cvbs_XXable to be
>> directly added to the ops.
>>
>> I want to keep the registers setup in separate files and keep a clean
>> DRM/HW separation.
> 
> I figured this is worth clarifying, and I'm somewhat guessing at your
> motivation here for a clean drm/hw split. There's of course various levels
> of how much you can split the drm side from your hw backend, but in
> general that design approach is really unpopular with upstream. It goes by
> the name of "midlayer", and the trouble with it is that it makes
> subsystem refactoring more complicated.

I totally understand, and I personally would prefer to have an unified drm source,
but the state of the hardware architecture makes it very hard to map cleanly over DRM.
I moved all the CRTC and Plane code into the corresponding file ans only kept
the init and common functions in the backend files.

> 
> For the driver itself it's nice, because it isolates you a bit from drm
> core. But that exact isolation is the problem when someone wants (or more
> often, needs to) refactor something across the entire subsystem. Then all
> these driver-private little (or sometimes much bigger) abstractions get in
> the way. That's way I suggested to remove it (both here and in the plane
> code), because for upstream the overall subsystem matters more than each
> individual driver. GPUs change fast, we need to be able to adapt fast,
> too.

It totally makes sense and I'm totally ready to refactor when necessary and match
the DRM/KMS architecture.

> 
> Anyway you're driver's pretty small, so personally I don't mind much. I'd
> still think removing the indirection would be better though.
> 
> Thanks, Daniel
> 

Thanks,
Neil
