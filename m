From: daniel@fooishbar.org (Daniel Stone)
Date: Tue, 24 May 2016 09:19:10 +0200
Subject: [PATCH] drm/rockchip: Return -EBUSY if there's already a pending
 flip event v3
In-Reply-To: <CAAObsKAyeg9JsPhCyWqLpg3n6V9Ab8OCJKXX41A86rQWWs+SdQ@mail.gmail.com>
References: <1459778134-30693-1-git-send-email-tomeu.vizoso@collabora.com>
 <CAPj87rPtP1ph-1FMxSKUANjeKwwjwgfMzbUGHvqudEx7nYCESQ@mail.gmail.com>
 <CAAObsKAyeg9JsPhCyWqLpg3n6V9Ab8OCJKXX41A86rQWWs+SdQ@mail.gmail.com>
Message-ID: <CAPj87rPgvjs5W68Cou6ODDqbqbPXQvFxLPtegBkdxdtPaRMX7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomeu,

On 5 April 2016 at 16:07, Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
> On 4 April 2016 at 17:44, Daniel Stone <daniel@fooishbar.org> wrote:
>> On 4 April 2016 at 14:55, Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
>>> +       if (async) {
>>> +               for_each_crtc_in_state(state, crtc, crtc_state, i) {
>>> +                       if (crtc->state->event ||
>>> +                           rockchip_drm_crtc_has_pending_event(crtc)) {
>>> +                               return -EBUSY;
>>> +                       }
>>> +               }
>>> +       }
>>
>> Hmmm ...
>>
>> Doesn't this trigger before the VOP atomic_begin() helper, meaning
>> that anything with an event set will trigger the check? Seems like it
>> should be && rather than ||.
>
> So, these are the two cases that this code aims to handle:
>
> 1. A previous request with an event set hasn't progressed to
> atomic_begin yet, so the event field in drm_crtc_state (at this point,
> the old state) is still populated but vop->event still isn't.

Ah right, this was what I was missing: the async (non-blocking)
implementation. Sounds good to me then.

Cheers,
Daniel
