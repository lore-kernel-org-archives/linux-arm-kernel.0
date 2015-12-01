From: mark.yao@rock-chips.com (Mark yao)
Date: Tue, 01 Dec 2015 17:31:28 +0800
Subject: [RFC PATCH 3/9] drm/rockchip: Convert to support atomic API
In-Reply-To: <CAPj87rPtWgH2WE7_EEC-Q41c7Ew2z8CwPMMQD+cC08G7qNZTeg@mail.gmail.com>
References: <1448940391-23333-1-git-send-email-mark.yao@rock-chips.com>	<1448940391-23333-4-git-send-email-mark.yao@rock-chips.com>
 <CAPj87rPtWgH2WE7_EEC-Q41c7Ew2z8CwPMMQD+cC08G7qNZTeg@mail.gmail.com>
Message-ID: <565D68F0.3010905@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?12?01? 16:18, Daniel Stone wrote:
> Hi Mark,
>
> On 1 December 2015 at 03:26, Mark Yao<mark.yao@rock-chips.com>  wrote:
>> >+static void rockchip_atomic_wait_for_complete(struct drm_atomic_state *state)
>> >+{
>> >+       struct drm_crtc_state *crtc_state;
>> >+       struct drm_crtc *crtc;
>> >+       int i;
>> >+
>> >+       for_each_crtc_in_state(state, crtc, crtc_state, i) {
>> >+               if (!crtc->state->active)
>> >+                       continue;
>> >+
>> >+               WARN_ON(drm_crtc_vblank_get(crtc));
>> >+       }
>> >+
>> >+       for_each_crtc_in_state(state, crtc, crtc_state, i) {
>> >+               if (!crtc->state->active)
>> >+                       continue;
>> >+
>> >+               rockchip_crtc_wait_for_update(crtc);
>> >+       }
> I'd be much more comfortable if this passed in an explicit pointer to
> state, or an address to wait for, rather than have wait_for_complete
> dig out state with no locking. The latter is potentially racy for
> async operations.
>
Hi Daniel
    "if this passed in an explicit pointer to state, or an address to 
wait for", I don't understand, can you point how it work?

-- 
?ark Yao
