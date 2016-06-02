From: mark.yao@rock-chips.com (Mark yao)
Date: Thu, 2 Jun 2016 14:25:37 +0800
Subject: [PATCH 1/2] drm/rockchip: vop: Do check if an update is pending
 during disable
In-Reply-To: <CAAObsKC=kSbWkBgTgcYnkiudSH=xez3N1+OipT33vZ0YkMSPQQ@mail.gmail.com>
References: <1459937686-9142-1-git-send-email-tomeu.vizoso@collabora.com>
 <5707043D.6060706@rock-chips.com>
 <CAAObsKAeAjUP1retiZqo5geOK2OkVjKvSB6g6nvGTh_rdNiFJQ@mail.gmail.com>
 <570AFAC2.8080907@rock-chips.com>
 <CAAObsKCmPZBaSudVJy8BPThhoZw8VVqxicqsmc8diApajD57nA@mail.gmail.com>
 <CAAObsKBXxb8ZS3CqLy4qsDRWLvT=w2ACANCcDLE5B47nRKtvBw@mail.gmail.com>
 <5742A41B.8030308@rock-chips.com>
 <CAAObsKAj9Ja56buTixvp0EVBk=xE4JCXPPwXdviweHkmUQb2xg@mail.gmail.com>
 <5744FA7C.3080802@rock-chips.com> <574500FE.4050708@rock-chips.com>
 <CAAObsKC=kSbWkBgTgcYnkiudSH=xez3N1+OipT33vZ0YkMSPQQ@mail.gmail.com>
Message-ID: <574FD161.4050503@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016?06?02? 13:57, Tomeu Vizoso wrote:
> On 25 May 2016 at 03:33, Mark yao <mark.yao@rock-chips.com> wrote:
>> On 2016?05?25? 09:06, Mark yao wrote:
>>
>> On 2016?05?24? 18:11, Tomeu Vizoso wrote:
>>
>> Hi Tomeu
>>> Sorry for reply late.
>>> I don't agree the changes:
>>>
>>> - if (!state->enable)
>>> - return VOP_WIN_GET(vop_win->vop, vop_win->data, enable) == 0;
>>> + if (!state->enable &&
>>> +    VOP_WIN_GET(vop_win->vop, vop_win->data, enable) == 0)
>>> + return true;
>>>
>>> This changes actually would lead a bug.
>>> when we disable a plane, the vop_win_pending_is_complete would always
>>> return
>>> true, That is not allowed, would cause fb free too early.
>> Ok, maybe I need to ask you first what the original block of code
>> intended to achieve. The TRM I have is very terse and I don't find any
>> explanation there. The battery of tests I have pass just fine without
>> it.
>>
>>> Does this patch is needed for "[PATCH 2/2] drm/rockchip: vop: Wait for
>>> pending events when disabling a CRTC"
>> Yes, this function is currently returning false when the pageflip has
>> been completed but the plan has been already disabled.
>>
>> If you have any different idea of how to fix this bug, please share.
>>
>> Thanks,
>>
>> Tomeu
>>
>>
>>
>> Hi Tomeu
>>
>> @@ -504,6 +506,9 @@ static void vop_crtc_disable(struct drm_crtc *crtc)
>>    if (!vop->is_enabled)
>>    return;
>>
>> + if (crtc->state->event || vop->event)
>> + vop_crtc_wait_for_update(crtc);
>> +
>>
>> I think above change has some problem,
>>
>> the function stack:
>> ->drm swap state
>> ->vop_crtc_disable
>> ->vop_atomic_begin
>> ->vop_atomic_flush
>>
>> on vop_crtc_disable, crtc->state is new state, the crtc->state->event not
>> yet update to vop, wait for  crtc->state->event here is wrong.
>>
>> So I think the patch should be:
>> + if (vop->event)
>> + vop_crtc_wait_for_update(crtc);
>> +
>>
>>
>> call vop_crtc_wait_for_update(crtc) here also is unsafe, it will reinit the
>> vop->wait_update_complete.
>>
>> I doubt that, since use the serialize outstanding nonblocking commits, only
>> one process can run into the update stack, old vop->event should be free on
>> last time, if we get vop->event here, that should be a bug.
>>
>>
>> Then the patch "drm/rockchip: vop: Do check if an update is pending during
>> disable" should be no needed.
> Hi Mark,
>
> with Daniel's series linked below this and the other issues I found in
> the Rockchip driver are fixed:
>
> http://thread.gmane.org/gmane.comp.freedesktop.xorg.drivers.intel/91023/focus=91053

Good news, I also see the Daniel's series patches, wonderful update.

You can add a Tested-by for Daniel's rockchip patches, and I add a 
Acked-by for those rockchip patches.

Thanks

> Thanks,
>
> Tomeu
>
>> Thanks.
>>
>> -- ?ark Yao
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel at lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>>
>>
>>
>> --
>> ?ark Yao
>>
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel at lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>>
>
>


-- 
?ark Yao
