From: jeffy.chen@rock-chips.com (jeffy)
Date: Mon, 09 Oct 2017 14:49:08 +0800
Subject: [PATCH] drm/rockchip: Fix memory leak in rockchip_drm_sys_resume()
In-Reply-To: <59CC6996.2000402@rock-chips.com>
References: <20170927122642.18628-1-jeffy.chen@rock-chips.com>
 <20170927202709.ugbjyi3ktfjssiyp@art_vandelay>
 <59CC6996.2000402@rock-chips.com>
Message-ID: <59DB1BE4.9080907@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sean,

On 09/28/2017 11:16 AM, jeffy wrote:
> Hi Sean,
>
> On 09/28/2017 04:27 AM, Sean Paul wrote:
>>> >@@ -299,6 +300,7 @@ static int rockchip_drm_sys_resume(struct device
>>> *dev)
>>> >
>>> >      priv = drm->dev_private;
>>> >      drm_atomic_helper_resume(drm, priv->state);
>>> >+    drm_atomic_state_put(priv->state);
>> Won't this be freed for you eventually in commit_tail()?
>>
> i think the drm_atomic_state_put in commit_tail is paired to the
> drm_atomic_state_get in drm_atomic_helper_commit.
>
> and the kmemleak shows(after a few suspend/resume):
>
>      unreferenced object 0xffffffc0ce0fa400 (size 256):
>      ...
>        backtrace:
>          [<ffffffc00034a9a8>] __save_stack_trace+0x48/0x6c
>          [<ffffffc00034b088>] create_object+0x138/0x254
>          [<ffffffc0009d5504>] kmemleak_alloc+0x58/0x8c
>          [<ffffffc000345f78>] __kmalloc+0x1d4/0x2a0
>          [<ffffffc0006765bc>] usb_alloc_urb+0x30/0x60
>          [<ffffffbffc128598>] alloc_ctrl_urb+0x38/0x120 [btusb]
>          [<ffffffbffc129e7c>] btusb_send_frame+0x64/0xf8 [btusb]

oops, the log is wrong...

it should be:
unreferenced object 0xffffffc0c75fe600 (size 256):
   comm "bash", pid 168, jiffies 4294748032 (age 557.932s)
   hex dump (first 32 bytes):
     e0 4a 02 ce c0 ff ff ff 00 98 f2 c8 c0 ff ff ff  .J..............
     00 98 f2 c8 c0 ff ff ff 00 45 9f cb c0 ff ff ff  .........E......
   backtrace:
     [<ffffff9008c76ba0>] kmemleak_alloc+0x58/0x8c
     [<ffffff900828fe70>] __kmalloc+0x1dc/0x2d4
     [<ffffff9008647698>] drm_atomic_state_init+0xb8/0x114
     [<ffffff9008649ed8>] drm_atomic_state_alloc+0x70/0xa4
     [<ffffff90086209f8>] drm_atomic_helper_duplicate_state+0x94/0x210
     [<ffffff9008621184>] drm_atomic_helper_suspend+0xb4/0x160
     [<ffffff9008666f18>] rockchip_drm_sys_suspend+0x5c/0xa0
     [<ffffff9008697f18>] platform_pm_suspend+0x58/0x74
     [<ffffff90086a7f98>] dpm_run_callback+0x13c/0x2f0
     [<ffffff90086a9064>] __device_suspend+0x28c/0x3fc
     [<ffffff90086ab9ec>] dpm_suspend+0x1cc/0x50c
     [<ffffff90086ac5a4>] dpm_suspend_start+0x8c/0xa4
     [<ffffff90081226a0>] suspend_devices_and_enter+0x12c/0xd84
     [<ffffff9008123d30>] pm_suspend+0xa38/0xb98
     [<ffffff9008120f94>] state_store+0xe0/0x108
     [<ffffff9008c63e7c>] kobj_attr_store+0x48/0x58


since it's allocated in the drm_atomic_helper_suspend(), maybe it would 
make more sense to unref it in drm_atomic_helper_resume(), i'll send a 
v2 patch for it :)

>
>
>
>
> checking the current code, i saw only i915/intel_display.c has this
> drm_atomic_state_put for the state allocated by
> drm_atomic_helper_suspend(), there're many drivers missing that(or maybe
> they free it in some other way?)
>
>> Sean
>>
>
