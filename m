From: sandy.huang@rock-chips.com (Sandy Huang)
Date: Thu, 3 Aug 2017 21:06:27 +0800
Subject: [PATCH 2/6] drm/rockchip: vop: fix iommu page fault when resume
In-Reply-To: <1501494582-6934-1-git-send-email-mark.yao@rock-chips.com>
References: <1501494569-6825-1-git-send-email-mark.yao@rock-chips.com>
 <1501494582-6934-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <5c613e33-f5f2-6b5f-69a6-cc3a7aa93a71@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi mark,

? 2017/7/31 17:49, Mark Yao ??:
> Iommu would get page fault with following path:
>     vop_disable:
>        1, disable all windows and set vop config done
>        2, vop enter to standy, all windows not works, but their registers
>           are not clean, when you read window's enable bit, may found the
>           window is enable.
> 
>     vop_enable:
>        1, memcpy(vop->regsbak, vop->regs, len)
>           save current vop registers to vop->regsbak, then you can found
>           window is enable on regsbak.
>        2, VOP_WIN_SET(vop, win, gate, 1);
>           force enable window gate, but gate and enable are on same
>           hardware register, then window enable bit rewrite to vop hardware.
>        3, vop power on, and vop might try to scan destroyed buffer,
>           then iommu get page fault.
> 
> Move windows disable after vop regsbak restore, then vop regsbak mechanism
> would keep tracing the modify, everything would be safe.
> 
> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
> ---
>   drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 33 +++++++++++++----------------
>   1 file changed, 15 insertions(+), 18 deletions(-)
> 

Reviewed-by: Sandy huang <sandy.huang@rock-chips.com>
