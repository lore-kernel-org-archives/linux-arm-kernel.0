From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue, 5 Apr 2016 16:07:36 +0200
Subject: [PATCH] drm/rockchip: Return -EBUSY if there's already a pending
 flip event v3
In-Reply-To: <CAPj87rPtP1ph-1FMxSKUANjeKwwjwgfMzbUGHvqudEx7nYCESQ@mail.gmail.com>
References: <1459778134-30693-1-git-send-email-tomeu.vizoso@collabora.com>
 <CAPj87rPtP1ph-1FMxSKUANjeKwwjwgfMzbUGHvqudEx7nYCESQ@mail.gmail.com>
Message-ID: <CAAObsKAyeg9JsPhCyWqLpg3n6V9Ab8OCJKXX41A86rQWWs+SdQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 April 2016 at 17:44, Daniel Stone <daniel@fooishbar.org> wrote:
> Hi Tomeu,
>
> On 4 April 2016 at 14:55, Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
>> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
>> index 3b8f652698f8..8305bbd2a4d7 100644
>> --- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
>> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
>> @@ -280,7 +280,18 @@ int rockchip_drm_atomic_commit(struct drm_device *dev,
>>  {
>>         struct rockchip_drm_private *private = dev->dev_private;
>>         struct rockchip_atomic_commit *commit = &private->commit;
>> -       int ret;
>> +       struct drm_crtc_state *crtc_state;
>> +       struct drm_crtc *crtc;
>> +       int i, ret;
>> +
>> +       if (async) {
>> +               for_each_crtc_in_state(state, crtc, crtc_state, i) {
>> +                       if (crtc->state->event ||
>> +                           rockchip_drm_crtc_has_pending_event(crtc)) {
>> +                               return -EBUSY;
>> +                       }
>> +               }
>> +       }
>
> Hmmm ...
>
> Doesn't this trigger before the VOP atomic_begin() helper, meaning
> that anything with an event set will trigger the check? Seems like it
> should be && rather than ||.

So, these are the two cases that this code aims to handle:

1. A previous request with an event set hasn't progressed to
atomic_begin yet, so the event field in drm_crtc_state (at this point,
the old state) is still populated but vop->event still isn't.

2. A previous request has already progressed to atomic_begin but we
haven't gotten yet the interrupt that signals its completion, so
vop->event is populated but crtc->state->event isn't anymore.

My understanding is that in both cases there's a pending flip event
and we have to return -EBUSY if it's as async request.

> Also, I know rockchip_drm_vop.c isn't holding dev->event_lock when it
> checks vop->event, but it really should be ... and so should this
> check. Otherwise you can race with the IRQ handler, which isn't
> required to hold the CRTC lock.

Cool, thanks.

Tomeu

> Cheers,
> Daniel
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
