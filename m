From: mark.yao@rock-chips.com (Mark yao)
Date: Fri, 01 Apr 2016 19:54:47 +0800
Subject: [PATCH] drm/rockchip: Return -EBUSY if there's already a pending
 flip event v2
In-Reply-To: <56FE5FD2.2050106@collabora.com>
References: <1459411680-6176-1-git-send-email-tomeu.vizoso@collabora.com>
 <56FE5AE9.40806@rock-chips.com> <56FE5FD2.2050106@collabora.com>
Message-ID: <56FE6187.1010004@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016?04?01? 19:47, Tomeu Vizoso wrote:
> On 04/01/2016 01:26 PM, Mark yao wrote:
>> On 2016?03?31? 16:08, Tomeu Vizoso wrote:
>>> As per the docs, atomic_commit should return -EBUSY "if an asycnhronous
>>> updated is requested and there is an earlier updated pending".
>>>
>>> v2: Use the status of the workqueue instead of vop->event, and don't add
>>> a superfluous wait on the workqueue.
>>>
>>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>>> ---
>>>   drivers/gpu/drm/rockchip/rockchip_drm_fb.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
>>> index 3b8f652698f8..285f8cd5afe1 100644
>>> --- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
>>> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
>>> @@ -282,6 +282,9 @@ int rockchip_drm_atomic_commit(struct drm_device *dev,
>>>   	struct rockchip_atomic_commit *commit = &private->commit;
>>>   	int ret;
>>>   
>>> +	if (async && work_busy(&commit->work))
>>> +		return -EBUSY;
>>> +
>> Sorry for reply late.
>>
>> There is a comment on work_busy function describe :
>>
>>      "the test result is  unreliable and only useful as advisory hints or
>> for debugging."
>>
>> I don't know if it's suitable to use it here, does some guys know it?
> I'm not sure, but if the reason is the caveat explained in
> find_worker_executing_work(), then it's probably safe (and would explain
> how the function is used in other parts in the kernel).
>
>> And then, the "flush_work(&commit->work);" is no needed if return -EBUSY
>> here.
>> you can remove it at this patch.
> We still need to wait if it's being called in sync mode.
>
> Regards,
>
> Tomeu
Hi Tomeu??

on sync mode, flush is no needed, because that:
1, there is mutex_lock/mutex_unlock on this context, So only single 
process run into commit work;

2, sync mode will block on:
rockchip_atomic_commit_complete-->rockchip_atomic_wait_for_complete,

Thanks.

>
>>>   	ret = drm_atomic_helper_prepare_planes(dev, state);
>>>   	if (ret)
>>>   		return ret;
>>
>>
>> -- 
>> ?ark Yao
>>
>
>
>


-- 
?ark Yao
