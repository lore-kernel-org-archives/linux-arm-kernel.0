From: daniel@ffwll.ch (Daniel Vetter)
Date: Mon, 31 Jul 2017 14:28:16 +0200
Subject: [PATCH 6/6] drm/rockchip: fix race with kms hotplug and fbdev
In-Reply-To: <CACvgo511Cb0_vT1vR+q-3d3zU2PmHmi-r-aH8uZHQXDj8V4byg@mail.gmail.com>
References: <1501494569-6825-1-git-send-email-mark.yao@rock-chips.com>
 <1501494601-7140-1-git-send-email-mark.yao@rock-chips.com>
 <CACvgo511Cb0_vT1vR+q-3d3zU2PmHmi-r-aH8uZHQXDj8V4byg@mail.gmail.com>
Message-ID: <CAKMK7uFXGPRQOxAXi+0_TO4HUN8p1RweGOGGsvnQrAcHbtuXWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 31, 2017 at 1:57 PM, Emil Velikov <emil.l.velikov@gmail.com> wrote:
> On 31 July 2017 at 10:50, Mark Yao <mark.yao@rock-chips.com> wrote:
>> Since fb_helper is not a pointer on rockchip_drm_private, it's no
>> need to check pointer.
>>
>> Kms hotplug event may race into fbdev helper initial, and fb_helper->dev
>> may be NULL pointer, that would cause the bug:
>>
>> [    0.735411] [00000200] *pgd=00000000f6ffe003, *pud=00000000f6ffe003, *pmd=0000000000000000
>> [    0.736156] Internal error: Oops: 96000005 [#1] PREEMPT SMP
>> [    0.736648] Modules linked in:
>> [    0.736930] CPU: 2 PID: 20 Comm: kworker/2:0 Not tainted 4.4.41 #20
>> [    0.737480] Hardware name: Rockchip RK3399 Board rev2 (BOX) (DT)
>> [    0.738020] Workqueue: events cdn_dp_pd_event_work
>> [    0.738447] task: ffffffc0f21f3100 ti: ffffffc0f2218000 task.ti: ffffffc0f2218000
>> [    0.739109] PC is at mutex_lock+0x14/0x44
>> [    0.739469] LR is at drm_fb_helper_hotplug_event+0x30/0x114
>> [    0.756253] [<ffffff8008a344f4>] mutex_lock+0x14/0x44
>> [    0.756260] [<ffffff8008445708>] drm_fb_helper_hotplug_event+0x30/0x114
>> [    0.756271] [<ffffff8008473c84>] rockchip_drm_output_poll_changed+0x18/0x20
>> [    0.756280] [<ffffff8008439fcc>] drm_kms_helper_hotplug_event+0x28/0x34
>> [    0.756286] [<ffffff800846c444>] cdn_dp_pd_event_work+0x394/0x3c4
>> [    0.756295] [<ffffff80080b2b38>] process_one_work+0x218/0x3e0
>> [    0.756302] [<ffffff80080b3538>] worker_thread+0x2e8/0x404
>> [    0.756308] [<ffffff80080b7e70>] kthread+0xe8/0xf0
>> [    0.756316] [<ffffff8008082690>] ret_from_fork+0x10/0x40
>>
>> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
>> ---
>>  drivers/gpu/drm/rockchip/rockchip_drm_fb.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
>> index 81f9548..e6bd0f4 100644
>> --- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
>> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
>> @@ -170,7 +170,7 @@ static void rockchip_drm_output_poll_changed(struct drm_device *dev)
>>         struct rockchip_drm_private *private = dev->dev_private;
>>         struct drm_fb_helper *fb_helper = &private->fbdev_helper;
>>
>> -       if (fb_helper)
>> +       if (fb_helper->dev)
>>                 drm_fb_helper_hotplug_event(fb_helper);
> Food for thought:
>
> Quick grep shows that no other drivers have such a ->dev check. Does
> this mean that either the issue is rockchip specific?
> If not, one could look into resolving the problem directly in drm core.
>
> Or at least update the other users, so they don't stumble upon the problem?

The fbdev helpers support already handling hotplug events before you
have finalized the fbdev setup. Please read the kerneldoc for the
various fbdev functions, they explain what you should be doing. This
hack here should indeed not be needed.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
