From: mark.yao@rock-chips.com (Mark yao)
Date: Mon, 14 Mar 2016 10:40:06 +0800
Subject: [PATCH] drm/rockchip: cancel pending vblanks on close
In-Reply-To: <1457716877-427-1-git-send-email-john@metanate.com>
References: <1457716877-427-1-git-send-email-john@metanate.com>
Message-ID: <56E62486.7050700@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016?03?12? 01:21, John Keeping wrote:
> When closing the DRM device while a vblank is pending, we access
> file_priv after it has been free'd, which gives:
>
>    Unable to handle kernel NULL pointer dereference at virtual address 00000000
>    ...
>    PC is at __list_add+0x5c/0xe8
>    LR is at send_vblank_event+0x54/0x1f0
>    ...
>    [<c02952e8>] (__list_add) from [<c031a7b4>] (send_vblank_event+0x54/0x1f0)
>    [<c031a760>] (send_vblank_event) from [<c031a9c0>] (drm_send_vblank_event+0x70/0x78)
>    [<c031a950>] (drm_send_vblank_event) from [<c031a9f8>] (drm_crtc_send_vblank_event+0x30/0x34)
>    [<c031a9c8>] (drm_crtc_send_vblank_event) from [<c0339ad8>] (vop_isr+0x224/0x28c)
>    [<c03398b4>] (vop_isr) from [<c0081780>] (handle_irq_event_percpu+0x12c/0x3e4)
>
> This can be triggered somewhat reliably with:
>
> 	modetest -M rockchip -v -s ...
>
> Add a preclose hook to the driver so that we can discard any pending
> vblank events when the device is closed.
>
> Signed-off-by: John Keeping <john@metanate.com>

Looks good for me, applied into my drm-fixes.

Thanks for the fix.

-- 
?ark Yao
