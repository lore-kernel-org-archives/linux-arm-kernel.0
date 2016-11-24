From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 24 Nov 2016 14:40:50 +0000
Subject: TDA998x crash on HDLCD probe failure
In-Reply-To: <459978b7-39d8-feae-257a-40b047f8d379@arm.com>
References: <8281efe7-bac7-8e35-5784-e05cf0dc7eab@arm.com>
 <20161124132905.GG14217@n2100.armlinux.org.uk>
 <459978b7-39d8-feae-257a-40b047f8d379@arm.com>
Message-ID: <f951de07-b4c9-f10e-bd1c-0ded455ca18f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/11/16 13:49, Robin Murphy wrote:
> On 24/11/16 13:29, Russell King - ARM Linux wrote:
>> On Thu, Nov 24, 2016 at 01:18:39PM +0000, Robin Murphy wrote:
>>> Hi Liviu, Russell,
>>>
>>> I'd been meaning to try digging into this if it hadn't gone away since I
>>> first noticed it, but I don't really have the time and it still happens
>>> with 4.9-rc and today's -next. Representative splat below, but in
>>> summary what happens is that if the HDLCD fails to probe, the TDA998x
>>> connector seems to get cleaned up twice, resulting in a NULL dereference
>>> the second time. I got as far as sketching out the following flow from a
>>> debug session (on the same 4.8-rc2 kernel), but I don't know nearly
>>> enough to tell which driver is at fault:
>>>
>>> hdlcd_drm_bind
>>> -> drm_fbdev_cma_init (fails)
>>> ...
>>> -> drm_mode_config_cleanup
>>>    ...
>>>    -> drm_connector_cleanup
>>> -> component_unbind_all
>>>    ...
>>>    -> tda998x_unbind
>>>       -> drm_connector_cleanup (NULL connector)
>>>
>>> It's easily reproduced on Juno by booting arm64 defconfig with
>>> CONFIG_CMA_SIZE_MBYTES=1 and a sufficiently large monitor connected to
>>> warrant a >1MB framebuffer.
>>
>> It looks to me like a hdlcd bug.
>>
>> The probe path operates in this order:
>>
>> - allocates hdlcd - 1
>> - allocates drm device - 2
>> - drm_mode_config_init - 3
>> - hdlcd_load - 4
>> - binds all components - 5
>> - enables runtime PM - 6
>> - drm_vblank_init - 7
>> - drm_mode_config_reset - 8
>> - drm_kms_helper_poll_init - 9
>> - drm_fbdev_cma_init - 10
>> - drm_dev_register - 11
>>
>> However, the cleanup operates in this order:
>> - drm_fbdev_cma_fini - undoes 10
>> - drm_kms_helper_poll_fini - undoes 9
>> - drm_mode_config_cleanup - undoes 3
>> - drm_vblank_cleanup - undoes 7
>> - pm_runtime_disable - undoes 6
>> - component_unbind_all - undoes 5
>> - drm_irq_uninstall - undoes 4
>> - of_reserved_mem_device_release - undoes other half of 4
>> - drm_dev_unref - undoes 2
>>
>> Spot the step which is out of the correct order - drm_mode_config_cleanup()
>> is misplaced - it's reversing the actions of drm_mode_config_init(), not
>> drm_mode_config_reset().
> 
> Thanks for the explanation - that saves at least a day's worth of me
> trying to understand DRM code :)
> 
>> So, drm_mode_config_cleanup() should be much later, after step 4 has
>> been undone, otherwise there are paths that leave various DRM objects
>> (created by drm_mode_create_standard_properties()) referenced, and
>> will cause problems exactly like you're seeing here.
> 
> Liviu, can I leave this with you then?

That said, I just tried the quick and obvious thing over lunch and it
does *seem* to be OK:

----->8-----
From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH] drm: hdlcd: Fix cleanup order

If hdlcd_drm_bind() fails at drm_fbdev_cma_init(), its cleanup will call
drm_mode_config_cleanup() as if to balance drm_mode_config_reset(). The
net result is that drm_connector_cleanup() will clean up the active
connectors long before component_unbind_all() gets called, so when the
connector later tries to clean up itself after being unbound, Bad Things
can happen:

[    4.121888] Unable to handle kernel NULL pointer dereference at
virtual address 00000000
[    4.129951] pgd = ffffff80091e0000
[    4.133345] [00000000] *pgd=00000009ffffe003, *pud=00000009ffffe003,
*pmd=0000000000000000
[    4.141613] Internal error: Oops: 96000005 [#1] PREEMPT SMP
[    4.147144] Modules linked in:
[    4.150188] CPU: 0 PID: 122 Comm: kworker/u12:2 Not tainted
4.8.0-rc2+ #989
[    4.157097] Hardware name: ARM Juno development board (r1) (DT)
[    4.162981] Workqueue: deferwq deferred_probe_work_func
[    4.168173] task: ffffffc975d93200 task.stack: ffffffc975dac000
[    4.174055] PC is at drm_connector_cleanup+0x58/0x1c0
[    4.179074] LR is at tda998x_unbind+0x24/0x40
[    4.183401] pc : [<ffffff80084c46f0>] lr : [<ffffff800850414c>]
pstate: 00000045
[    4.190750] sp : ffffffc975dafa10
[    4.194041] x29: ffffffc975dafa10 x28: ffffffc9768152a8
[    4.199325] x27: ffffffc97ff46450 x26: ffffff8008d99000
[    4.204608] x25: dead000000000100 x24: dead000000000200
[    4.209891] x23: ffffffc976bf91e8 x22: 0000000000000000
[    4.215172] x21: ffffffc976bf9170 x20: ffffffc976bf9170
[    4.220454] x19: ffffffc976bf9018 x18: 0000000000000000
[    4.225737] x17: 0000000074ce71ee x16: 000000008ff5d35f
[    4.231019] x15: ffffffc97681e91c x14: ffffffffffffffff
[    4.236301] x13: ffffffc97681e185 x12: 0000000000000038
[    4.241583] x11: 0101010101010101 x10: 0000000000000000
[    4.246866] x9 : 0000000040000000 x8 : 0000000000210d00
[    4.252148] x7 : ffffffc97fea8c00 x6 : 000000000000001b
[    4.257430] x5 : ffffff80084b7b8c x4 : 0000000000000080
[    4.262712] x3 : ffffff8008504128 x2 : ffffffc975df3800
[    4.267993] x1 : 0000000000000000 x0 : 0000000000000000
...
[    4.750937] [<ffffff80084c46f0>] drm_connector_cleanup+0x58/0x1c0
[    4.756990] [<ffffff800850414c>] tda998x_unbind+0x24/0x40
[    4.762354] [<ffffff8008507918>] component_unbind.isra.4+0x28/0x50
[    4.768492] [<ffffff8008507a0c>] component_unbind_all+0xcc/0xd8
[    4.774373] [<ffffff80084d5adc>] hdlcd_drm_bind+0x234/0x418
[    4.779909] [<ffffff8008507b58>] try_to_bring_up_master+0x140/0x1a0
[    4.786133] [<ffffff8008507c50>] component_add+0x98/0x170
[    4.791496] [<ffffff8008504b90>] tda998x_probe+0x18/0x20
[    4.796774] [<ffffff80086bf914>] i2c_device_probe+0x164/0x258
[    4.802481] [<ffffff800850d094>] driver_probe_device+0x204/0x2b0
[    4.808447] [<ffffff800850d28c>] __device_attach_driver+0x9c/0xf8
[    4.814498] [<ffffff800850b108>] bus_for_each_drv+0x58/0x98
[    4.820033] [<ffffff800850cd64>] __device_attach+0xc4/0x138
[    4.825567] [<ffffff800850d338>] device_initial_probe+0x10/0x18
[    4.831446] [<ffffff800850c124>] bus_probe_device+0x94/0xa0
[    4.836981] [<ffffff800850c5b0>] deferred_probe_work_func+0x78/0xb0
[    4.843207] [<ffffff80080d2998>] process_one_work+0x118/0x378
[    4.848914] [<ffffff80080d2c40>] worker_thread+0x48/0x498
[    4.854276] [<ffffff80080d8918>] kthread+0xd0/0xe8
[    4.859036] [<ffffff8008082e90>] ret_from_fork+0x10/0x40
[    4.864314] Code: f2fbd5b9 f2fbd5b8 f8478ee0 eb17001f (f9400013)
[    4.870472] ---[ end trace a643cfe4ce1d838b ]---

Fix this by moving the drm_mode_config_cleanup() much later such that it
correctly balances drm_mode_config_init().

Suggested-by: Russell King <linux@armlinux.org.uk>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/gpu/drm/arm/hdlcd_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c
b/drivers/gpu/drm/arm/hdlcd_drv.c
index 59b76054edc9..1a4fff7c0a7c 100644
--- a/drivers/gpu/drm/arm/hdlcd_drv.c
+++ b/drivers/gpu/drm/arm/hdlcd_drv.c
@@ -420,7 +420,6 @@ static int hdlcd_drm_bind(struct device *dev)

 err_fbdev:
 	drm_kms_helper_poll_fini(drm);
-	drm_mode_config_cleanup(drm);
 	drm_vblank_cleanup(drm);
 err_vblank:
 	pm_runtime_disable(drm->dev);
@@ -432,6 +431,7 @@ static int hdlcd_drm_bind(struct device *dev)
 	drm_irq_uninstall(drm);
 	of_reserved_mem_device_release(drm->dev);
 err_free:
+	drm_mode_config_cleanup(drm);
 	dev_set_drvdata(dev, NULL);
 	drm_dev_unref(drm);

-- 
2.10.2.dirty
