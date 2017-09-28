From: jeffy.chen@rock-chips.com (jeffy)
Date: Thu, 28 Sep 2017 11:16:38 +0800
Subject: [PATCH] drm/rockchip: Fix memory leak in rockchip_drm_sys_resume()
In-Reply-To: <20170927202709.ugbjyi3ktfjssiyp@art_vandelay>
References: <20170927122642.18628-1-jeffy.chen@rock-chips.com>
 <20170927202709.ugbjyi3ktfjssiyp@art_vandelay>
Message-ID: <59CC6996.2000402@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sean,

On 09/28/2017 04:27 AM, Sean Paul wrote:
>> >@@ -299,6 +300,7 @@ static int rockchip_drm_sys_resume(struct device *dev)
>> >
>> >  	priv = drm->dev_private;
>> >  	drm_atomic_helper_resume(drm, priv->state);
>> >+	drm_atomic_state_put(priv->state);
> Won't this be freed for you eventually in commit_tail()?
>
i think the drm_atomic_state_put in commit_tail is paired to the 
drm_atomic_state_get in drm_atomic_helper_commit.

and the kmemleak shows(after a few suspend/resume):

     unreferenced object 0xffffffc0ce0fa400 (size 256):
     ...
       backtrace:
         [<ffffffc00034a9a8>] __save_stack_trace+0x48/0x6c
         [<ffffffc00034b088>] create_object+0x138/0x254
         [<ffffffc0009d5504>] kmemleak_alloc+0x58/0x8c
         [<ffffffc000345f78>] __kmalloc+0x1d4/0x2a0
         [<ffffffc0006765bc>] usb_alloc_urb+0x30/0x60
         [<ffffffbffc128598>] alloc_ctrl_urb+0x38/0x120 [btusb]
         [<ffffffbffc129e7c>] btusb_send_frame+0x64/0xf8 [btusb]




checking the current code, i saw only i915/intel_display.c has this 
drm_atomic_state_put for the state allocated by 
drm_atomic_helper_suspend(), there're many drivers missing that(or maybe 
they free it in some other way?)

> Sean
>
