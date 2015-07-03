From: mark.yao@rock-chips.com (Mark yao)
Date: Fri, 03 Jul 2015 18:08:31 +0800
Subject: [PATCH v2 5/5] drm/rockchip: default enable win2/3 area0 bit
In-Reply-To: <CAAFQd5BCT_j1ZxMaaA-qaFct6+-VTJs4mEsZzGuFc=nL9jGNDA@mail.gmail.com>
References: <1435313249-4549-1-git-send-email-mark.yao@rock-chips.com>
 <1435313432-4923-1-git-send-email-mark.yao@rock-chips.com>
 <CAAFQd5D4W1+ShB4zpSJrBiFYWh21axJoGoQ77NwXzhSRapysgA@mail.gmail.com>
 <5596457F.5090601@rock-chips.com>
 <CAAFQd5BCT_j1ZxMaaA-qaFct6+-VTJs4mEsZzGuFc=nL9jGNDA@mail.gmail.com>
Message-ID: <55965F1F.9090301@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?07?03? 17:24, Tomasz Figa wrote:
> On Fri, Jul 3, 2015 at 5:19 PM, Mark yao <mark.yao@rock-chips.com> wrote:
>> On 2015?07?03? 16:02, Tomasz Figa wrote:
>>> Hi Mark,
>>>
>>> Please see my comments inline.
>>>
>>> On Fri, Jun 26, 2015 at 7:10 PM, Mark Yao <mark.yao@rock-chips.com> wrote:
>>>> Win2/3 support 4 area display, but now havn't found a suitable
>>>> way to use it, and it enable by win gate and area gate,
>>>> so default enable area0 gate, so that its behaviour just like a
>>>> win.
>>> So I assume this means that currently, without those bits set, win2
>>> and win3 do not work? This would make this patch a fix maybe even with
>>> a potential backportability.
>>
>> Yes, without this patch, all win2/3 area gate default disabled.
>> vop_update_plane_event call win enable only enable the win gate.
>>
>>
>>>> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
>>>> ---
>>>> Changes in v2: None
>>>>
>>>>    drivers/gpu/drm/rockchip/rockchip_drm_vop.c |    6 ++++++
>>>>    1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
>>>> b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
>>>> index 40107bb..e001d26 100644
>>>> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
>>>> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
>>>> @@ -337,6 +337,12 @@ static const struct vop_reg_data
>>>> vop_init_reg_table[] = {
>>>>           {DSP_CTRL0, 0x00000000},
>>>>           {WIN0_CTRL0, 0x00000080},
>>>>           {WIN1_CTRL0, 0x00000080},
>>>> +       /*
>>>> +        * Todo: win2/3 support area func, but now havn't found a
>>>> suitable
>>>> +        * way to use it, so default enable area0 as a win display.
>>> TODO: Win2/3 support multiple area function, but we haven't found
>>> a suitable way to use it yet, so let's just use them as other windows
>>> with only area 0 enabled.
>>>
>>>> +        */
>>>> +       {WIN2_CTRL0, 0x00000010},
>>>> +       {WIN3_CTRL0, 0x00000010},
>>> Anyway, is it enough to program those registers one time in
>>> vop_initial()? Won't they get cleared when VOP is power cycled, e.g.
>>> in case of DPMS off and on? Maybe instead this could be done in
>>> vop_update_plane_event() for windows that need it?
>> There are two gate for Win2/3,
>> at VOP_WIN3_CTRL0:
>>          bit[0], "win3_en"
>>              this gating all the area.
>>
>>          bit[4], win3_mst0_en
>>          bit[5], win3_mst1_en
>>          bit[6], win3_mst2_en
>>          bit[7], win3_mst3_en
>>              those gate each area.
>>
>> This patch default enable win3_mst0_en, so control bit[0]"win3_en" that cat
>> power on/off this window.
>>
>> vop_update_plane_event()/ vop_disable_plane() only can control
>> bit[0]"win3_en".
>>
>>
>> So this patch is enough to enable window2/3 area 0.
> That's right. However, the vop_init_reg_table[] is only used at probe
> time by vop_initial() and register settings listed there are not
> applied any time later. If we call DPMS off, which will turn the VOP
> off and in turn also the whole power domain off, won't the registers
> be reset to default values (e.g. zeroed)?
Right, the vop registers would be reset to default values when power 
domain off.

But the cursor can works after resume. because the initial value save to 
the regbak cache,
and cursor area gate, win gate are at the same regs, so it can be 
restore when do cursor enable.

But if we add other regs, this may cause bug, maybe no one restore them.
So I think we need do like under to force restore all the regs when resume:
     memcpy(vop->regs, vop->regsbak, vop->len);

> Best regards,
> Tomasz
>
>
>


-- 
?ark
