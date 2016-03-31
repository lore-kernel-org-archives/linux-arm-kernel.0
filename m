From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Thu, 31 Mar 2016 10:00:17 +0200
Subject: [PATCH] drm/rockchip: Return -EBUSY if there's already a pending
 flip event
In-Reply-To: <56FC7C97.8000506@rock-chips.com>
References: <1459345705-4473-1-git-send-email-tomeu.vizoso@collabora.com>
 <56FC7C97.8000506@rock-chips.com>
Message-ID: <CAAObsKCD665onmzKtiiR2fE0jJtNLAZ2VUZyLbF7kPJKpqxXRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 March 2016 at 03:25, Mark yao <mark.yao@rock-chips.com> wrote:
> On 2016?03?30? 21:48, Tomeu Vizoso wrote:
>>
>> As per the docs, atomic_commit should return -EBUSY "if an asycnhronous
>> updated is requested and there is an earlier updated pending".
>>
>> Also wait for the pending event to complete when a sync update is
>> requested.
>>
>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>> ---
>>   drivers/gpu/drm/rockchip/rockchip_drm_drv.h |  1 +
>>   drivers/gpu/drm/rockchip/rockchip_drm_fb.c  | 14 +++++++++++++-
>>   drivers/gpu/drm/rockchip/rockchip_drm_vop.c |  6 ++++++
>>   3 files changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
>> b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
>> index 3529f692edb8..37952eefd33d 100644
>> --- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
>> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
>> @@ -69,6 +69,7 @@ int rockchip_register_crtc_funcs(struct drm_crtc *crtc,
>>   void rockchip_unregister_crtc_funcs(struct drm_crtc *crtc);
>>   int rockchip_drm_crtc_mode_config(struct drm_crtc *crtc, int
>> connector_type,
>>                                   int out_mode);
>> +bool rockchip_drm_crtc_has_pending_event(struct drm_crtc *crtc);
>>   int rockchip_drm_dma_attach_device(struct drm_device *drm_dev,
>>                                    struct device *dev);
>>   void rockchip_drm_dma_detach_device(struct drm_device *drm_dev,
>> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
>> b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
>> index 3b8f652698f8..028fd2f8f47b 100644
>> --- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
>> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
>> @@ -280,7 +280,19 @@ int rockchip_drm_atomic_commit(struct drm_device
>> *dev,
>>   {
>>         struct rockchip_drm_private *private = dev->dev_private;
>>         struct rockchip_atomic_commit *commit = &private->commit;
>> -       int ret;
>> +       struct drm_crtc_state *crtc_state;
>> +       struct drm_crtc *crtc;
>> +       int i, ret;
>> +
>> +       for_each_crtc_in_state(state, crtc, crtc_state, i) {
>> +               if (crtc->state->event ||
>> +                   rockchip_drm_crtc_has_pending_event(crtc)) {
>> +                       if (async)
>> +                               return -EBUSY;
>> +                       else
>> +                               rockchip_crtc_wait_for_update(crtc);
>
>
>> +               }
>> +       }
>>         ret = drm_atomic_helper_prepare_planes(dev, state);
>>         if (ret)
>> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
>> b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
>> index e2118e62345b..5240bc8fe088 100644
>> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
>> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
>> @@ -848,6 +848,12 @@ int rockchip_drm_crtc_mode_config(struct drm_crtc
>> *crtc,
>>   }
>>   EXPORT_SYMBOL_GPL(rockchip_drm_crtc_mode_config);
>>   +bool rockchip_drm_crtc_has_pending_event(struct drm_crtc *crtc)
>> +{
>> +       return to_vop(crtc)->event;
>> +}
>> +EXPORT_SYMBOL_GPL(rockchip_drm_crtc_has_pending_event);
>> +
>
>
> No need to do EXPORT_SYMBOL_GPL, rockchip_drm_vop.c and rockchip_drm_fb.c
> will build into same object.
>
>
>>   static int vop_crtc_enable_vblank(struct drm_crtc *crtc)
>>   {
>>         struct vop *vop = to_vop(crtc);
>
> Hi Tomeu
>
> Since rockchip atomic async use "serialize outstanding asynchronous
> commits", async commit will wait on "flush_work(&commit->work);" to ensure
> last pending event is done, so vop->event should be NULL after flush. if
> not, it should be a BUG.

I missed that, thanks.

> Anyway, serialize async commits is not a good way, but I don't think your
> patch is better way.

Per-CRTC workqueues should improve that, but I'm right now more
interested in correctness than performance.

> I think maybe we can check the "commit->work" status(finish or running) to
> judge return BUSY or not, instead of flush it.

That sounds better indeed.

Thanks,

Tomeu

> Thanks.
>
> --
> ?ark Yao
>
>
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
