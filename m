From: daniel@fooishbar.org (Daniel Stone)
Date: Wed, 2 Dec 2015 14:18:35 +0000
Subject: [RFC PATCH 3/9] drm/rockchip: Convert to support atomic API
In-Reply-To: <565D68F0.3010905@rock-chips.com>
References: <1448940391-23333-1-git-send-email-mark.yao@rock-chips.com>
 <1448940391-23333-4-git-send-email-mark.yao@rock-chips.com>
 <CAPj87rPtWgH2WE7_EEC-Q41c7Ew2z8CwPMMQD+cC08G7qNZTeg@mail.gmail.com>
 <565D68F0.3010905@rock-chips.com>
Message-ID: <CAPj87rO9_sXZHidTpNs_ubFaUX8ZtytK=bLpQSQwSy5G2-JGEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,
Thanks for getting back to this.

On 1 December 2015 at 09:31, Mark yao <mark.yao@rock-chips.com> wrote:
> On 2015?12?01? 16:18, Daniel Stone wrote:
>> On 1 December 2015 at 03:26, Mark Yao<mark.yao@rock-chips.com>  wrote:
>>> >+       for_each_crtc_in_state(state, crtc, crtc_state, i) {
>>> >+               if (!crtc->state->active)
>>> >+                       continue;
>>> >+
>>> >+               rockchip_crtc_wait_for_update(crtc);
>>> >+       }
>>
>> I'd be much more comfortable if this passed in an explicit pointer to
>> state, or an address to wait for, rather than have wait_for_complete
>> dig out state with no locking. The latter is potentially racy for
>> async operations.
>>
> Hi Daniel
>    "if this passed in an explicit pointer to state, or an address to wait
> for", I don't understand, can you point how it work?

Ah, OK. I mean that rockchip_crtc_wait_for_update takes a drm_crtc
pointer, and establishes the state from that (e.g.
crtc->primary->state). This can easily lead to confusion in async
contexts, as the states attached to a drm_crtc and a drm_plane can
change here while you wait for it.

It would be better if the call was:

for_each_plane_in_state(state, plane, plane_state, i) {
    if (plane->type == DRM_PLANE_TYPE_PRIMARY)
        rockchip_crtc_wait_for_update(plane_state->crtc, plane_state);
}

This way it is very clear, and there is no confusion as to which
request we are waiting to complete.

In general, using crtc->state or plane->state is a very bad idea,
_except_ in the atomic_check function where you are calculating
changes (e.g. if (plane_state->fb->pitches[0] !=
plane->state->fb->pitches[0]) rockchip_plane_state->pitch_changed =
true). After atomic_check, you should always pass around pointers to
the plane state explicitly, and avoid using the pointers from drm_crtc
and drm_plane.

Does that help?

>>>          if (is_yuv) {
>>>                  /*
>>>                   * Src.x1 can be odd when do clip, but yuv plane start
>>> point
>>>                   * need align with 2 pixel.
>>>                   */
>>> -               val = (src.x1 >> 16) % 2;
>>> -               src.x1 += val << 16;
>>> -               src.x2 += val << 16;
>>> +               uint32_t temp = (src->x1 >> 16) % 2;
>>> +
>>> +               src->x1 += temp << 16;
>>> +               src->x2 += temp << 16;
>>>          }
>>
>> I know this isn't new, but moving the plane around is bad. If the user
>> gives you a pixel boundary that you can't actually use, please reject
>> the configuration rather than silently trying to fix it up.
>
> the origin src.x1 would align with 2 pixel, but when we move the dest
> window, and do clip by output, the src.x1 may be clipped to odd.
> regect this configuration may let user confuse, sometimes good, sometimes
> bad.

For me, it is more confusing when the display shows something
different to what I have requested. In some media usecases, doing this
is a showstopper and will result in products failing acceptance
testing. Userspace can make a policy decision to try different
alignments to get _something_ to show (even if it's not what was
explicitly requested), but doing this in the kernel is inappropriate:
please just reject it, and have userspace fall back to another
composition method (e.g. GL) in these cases.

>>> -static void vop_plane_destroy(struct drm_plane *plane)
>>> +static void vop_atomic_plane_destroy_state(struct drm_plane *plane,
>>> +                                          struct drm_plane_state *state)
>>>   {
>>> -       vop_disable_plane(plane);
>>> -       drm_plane_cleanup(plane);
>>> +       struct vop_plane_state *vop_state = to_vop_plane_state(state);
>>> +
>>> +       if (state->fb)
>>> +               drm_framebuffer_unreference(state->fb);
>>> +
>>> +       kfree(vop_state);
>>>   }
>>
>> You can replace this hook with drm_atomic_helper_plane_destroy_state.
>
>
> Hmm, only can hook with __drm_atomic_helper_plane_destroy_state.

Ah yes, you're right. But still, using that would be better than duplicating it.

>     Can you share your Weston environment to me, I'm interesting to test drm
> rockchip on weston.

Of course. You can download Weston from http://wayland.freedesktop.org
- the most interesting dependencies are libevdev, libinput, and
wayland itself. If you are building newer Weston from git, you'll need
the wayland-protocols repository as well, from
anongit.freedesktop.org/git/wayland/wayland-protocols/. Please let me
know privately if you need some more help with building these, but
they should be quite straightforward.

Cheers,
Daniel
