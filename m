From: mark.yao@rock-chips.com (Mark yao)
Date: Thu, 14 Jan 2016 16:46:37 +0800
Subject: [RFC/PATCH] drm/rockchip: don't wait for vblank if fb hasn't
 changed
In-Reply-To: <CAKMK7uGQ47eLS2HxUP2+tQcf5cZm+eoGryCRrBzA2b8=77ox-Q@mail.gmail.com>
References: <1452689614-6570-1-git-send-email-john@metanate.com>	<20160113142320.GQ19130@phenom.ffwll.local>	<20160113143425.363ce07a.john@metanate.com>	<20160113154005.GT19130@phenom.ffwll.local>	<20160113155529.6048b2c1.john@metanate.com>	<20160113162156.GA19130@phenom.ffwll.local>	<20160113164038.5fcf670f.john@metanate.com>	<20160113171917.GC19130@phenom.ffwll.local>	<20160113173954.52e688fc.john@metanate.com>	<5696F6F4.5060908@rock-chips.com>
 <CAKMK7uGQ47eLS2HxUP2+tQcf5cZm+eoGryCRrBzA2b8=77ox-Q@mail.gmail.com>
Message-ID: <5697606D.50603@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016?01?14? 16:32, Daniel Vetter wrote:
> On Thu, Jan 14, 2016 at 2:16 AM, Mark yao <mark.yao@rock-chips.com> wrote:
>> On 2016?01?14? 01:39, John Keeping wrote:
>>> On Wed, 13 Jan 2016 18:19:17 +0100, Daniel Vetter wrote:
>>>
>>>> On Wed, Jan 13, 2016 at 04:40:38PM +0000, John Keeping wrote:
>>>>> On Wed, 13 Jan 2016 17:21:56 +0100, Daniel Vetter wrote:
>>>>>
>>>>>> On Wed, Jan 13, 2016 at 03:55:29PM +0000, John Keeping wrote:
>>>>>>> On Wed, 13 Jan 2016 16:40:05 +0100, Daniel Vetter wrote:
>>>>>>>
>>>>>>>> On Wed, Jan 13, 2016 at 02:34:25PM +0000, John Keeping wrote:
>>>>>>>>> On Wed, 13 Jan 2016 15:23:20 +0100, Daniel Vetter wrote:
>>>>>>>>>
>>>>>>>>>> On Wed, Jan 13, 2016 at 12:53:34PM +0000, John Keeping wrote:
>>>>>>>>>>> As commented in drm_atomic_helper_wait_for_vblanks(), userspace
>>>>>>>>>>> relies on cursor ioctls being unsynced.  Converting the rockchip
>>>>>>>>>>> driver to atomic has significantly impacted cursor performance by
>>>>>>>>>>> making every cursor update wait for vblank.
>>>>>>>>>>>
>>>>>>>>>>> By skipping the vblank sync when the framebuffer has not changed
>>>>>>>>>>> (as is done in drm_atomic_helper_wait_for_vblanks()) we can avoid
>>>>>>>>>>> this for the common case of moving the cursor and only need to
>>>>>>>>>>> delay the cursor ioctl when the cursor icon changes.
>>>>>>>>>>>
>>>>>>>>>>> I originally inserted a check on legacy_cursor_update as well, but
>>>>>>>>>>> that caused a storm of iommu page faults.  I didn't investigate
>>>>>>>>>>> the
>>>>>>>>>>> cause of those since this change gives enough of a performance
>>>>>>>>>>> improvement for my use case.
>>>>>>>>>>>
>>>>>>>>>>> This is RFC because of that and because the framebuffer_changed()
>>>>>>>>>>> function is copied from drm_atomic_helper.c as a quick way to test
>>>>>>>>>>> the result.
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: John Keeping <john@metanate.com>
>>>>>>>>>>> ---
>>>>>>>>>>>    drivers/gpu/drm/rockchip/rockchip_drm_fb.c | 27
>>>>>>>>>>> +++++++++++++++++++++++++-- 1 file changed, 25 insertions(+), 2
>>>>>>>>>>> deletions(-)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
>>>>>>>>>>> b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c index
>>>>>>>>>>> f784488..8fd9821
>>>>>>>>>>> 100644 --- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
>>>>>>>>>>> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
>>>>>>>>>>> @@ -177,8 +177,28 @@ static void
>>>>>>>>>>> rockchip_crtc_wait_for_update(struct drm_crtc *crtc)
>>>>>>>>>>> crtc_funcs->wait_for_update(crtc); }
>>>>>>>>>>>    +static bool framebuffer_changed(struct drm_device *dev,
>>>>>>>>>>> +                               struct drm_atomic_state
>>>>>>>>>>> *old_state,
>>>>>>>>>>> +                               struct drm_crtc *crtc)
>>>>>>>>>>> +{
>>>>>>>>>>> +       struct drm_plane *plane;
>>>>>>>>>>> +       struct drm_plane_state *old_plane_state;
>>>>>>>>>>> +       int i;
>>>>>>>>>>> +
>>>>>>>>>>> +       for_each_plane_in_state(old_state, plane, old_plane_state,
>>>>>>>>>>> i) {
>>>>>>>>>>> +               if (plane->state->crtc != crtc &&
>>>>>>>>>>> +                   old_plane_state->crtc != crtc)
>>>>>>>>>>> +                       continue;
>>>>>>>>>>> +
>>>>>>>>>>> +               if (plane->state->fb != old_plane_state->fb)
>>>>>>>>>>> +                       return true;
>>>>>>>>>>> +       }
>>>>>>>>>>> +
>>>>>>>>>>> +       return false;
>>>>>>>>>>> +}
>>>>>>>>>> Please don't hand-roll logic that affects semantics like this.
>>>>>>>>>> Instead
>>>>>>>>>> please use drm_atomic_helper_wait_for_vblanks(), which should do
>>>>>>>>>> this
>>>>>>>>>> correctly for you.
>>>>>>>>>>
>>>>>>>>>> If that's not the case then we need to improve the generic helper,
>>>>>>>>>> or
>>>>>>>>>> figure out what's different with rockhip.
>>>>>>>>> According to commit 63ebb9f (drm/rockchip: Convert to support atomic
>>>>>>>>> API) it's because rockchip doesn't have a hardware vblank counter.
>>>>>>>>>
>>>>>>>>> I'm not entirely clear on why this prevents the use of
>>>>>>>>> drm_atomic_helper_wait_for_vblanks().
>>>>>>>> Hm, that commit isn't terribly helpful. If that's really needed then
>>>>>>>> imo I
>>>>>>>> think we should extract a
>>>>>>>> "drm_atomic_helper_plane_needs_vblank_wait()"
>>>>>>>> helper that's used by both. But since rockchip does vblank_get/put
>>>>>>>> calls
>>>>>>>> I'd hope vblanks actually work correctly. And then the helper should
>>>>>>>> work
>>>>>>>> too.
>>>>>>> I tried switching the call to rockchip_crtc_wait_for_update() to
>>>>>>> drm_atomic_helper_wait_for_vblanks() and it works fine until I switch
>>>>>>> the buffer associated with a cursor, at which point I get iommu page
>>>>>>> faults, presumably because the GEM buffer is unreferenced too early.
>>>>>>>
>>>>>>> AFAICT the buffer will be released via drm_atomic_state_free()
>>>>>>> unconditionally, but I suspect I'm missing something since that would
>>>>>>> mean every driver would hit a similar problem.
>>>>>> Yeah, with the helper we always skip, which means when the cursor bo
>>>>>> changes you indeed unmap too early. So can't even share the overall
>>>>>> condition, but we could definitely share the little framebuffer_changed
>>>>>> helper.
>>>>> That leaves me with the question: why do other atomic drivers work?
>>>>>
>>>>> If drm_atomic_helper_wait_for_vblanks() skipping vblanks results in the
>>>>> cursor bo being unmapped too early for rockchip, why is it not unmapped
>>>>> too early for all of the other drivers using that helper?
>>>> It's unmapped too early for everyone, it's just that normally that
>>>> doesn't
>>>> result in a fireworks show. What we maybe could/should do is do the
>>>> unmapping asynchronously, but that runs into the overall "current atomic
>>>> helpers don't do async yet" problem. Might be a good point to start
>>>> fixing
>>>> this up though.
>>> OK, thanks, I think I'm beginning to understand how this all fits
>>> together.
>>>
>>> It looks like there are two options for me to get reasonable cursor
>>> performance on rockchip in the short term:
>>>
>>> 1) Export the current framebuffer_changed() function as
>>>      drm_atomic_helper_framebuffer_changed() and use it in
>>>      rockchip_crtc_wait_for_update().
>>>
>>> 2) Add a mechanism to suppress the legacy_cursor_update check in
>>>      drm_atomic_helper_wait_for_vblanks() and switch the rockchip driver
>>>      over to it.
>>>
>>> In both of these cases we're only restoring the unsynced cursor ioctls
>>> behaviour when the cursor is moved but it will still be expensive when
>>> the cursor bo changes.  That gives sufficient performance in my testing.
>>>
>>>
>>>
>> Thanks for point that.
>>
>> because rockchip not support hardware vblank counter, use
>> drm_atomic_helper_wait_for_vblanks have under issues:
>>
>>                                               | <-- HW vsync irq and reg take
>> effect
>>              plane_commit  --->  |
>>       get_vblank and wait ->   |
>>                                               | <-- handle_vblank,
>> vblank->count + 1
>>                   cleanup_fb   ---> |
>>                iommu crash  --->  |
>>                                               | <-- HW vsync irq and reg take
>> effect
>> there is no hardware vblank counter on rockchip vop, we can't ensure the
>> consistency of reg take effect and vblank->count,
>> if plane commit hit into the period of  reg take effect and vblank->count,
>> cleanup_fb happen before old_fb swap out from vop,
>> then iommu crash.
>>
>> That is why I special the wait_for_vblanks, we need check the reg really
>> take effect before clean up old fb.
>> at vop_win_pending_is_complete function, check win enable and win address,
>> to ensure that.
>>
>> Not only rockchip drm do that thing:
>>
>> exynos also check address before cleanup fb
>>          if (start == start_s)
>>              exynos_drm_crtc_finish_update(ctx->crtc, plane);
>>
>> Thanks.
> Do you have a scanline counter or something similar at least? Any
> other indication about how far along the chip is with scanning out? We
> use that in i915 to avoid races with the interrupt handler and detect
> this w/a scenario.
>
> I think if you have a scanline counter then it should magically work,
> since the vblank code will realize that you're already past the last
> vblank interrupt and /should/ have incremented already. Or something
> like that.
>
> Otherwise if this is common we might want to figure out how to solve
> this in a generic way. It's one of these problems that will make
> generic async support almost impossible.
> -Daniel

No, both rk3288 or rk3036 not support hardware vblank counter and 
scanline counter.

At android side, we use same way, check address and enable bit to ensure 
register take effect.

On future chips,  scanline counter and hardware counter would be 
support, but not now.

-- 
?ark Yao
