From: tfiga@chromium.org (Tomasz Figa)
Date: Fri, 25 May 2018 11:57:37 +0900
Subject: [PATCH] drm/rockchip: vop: fix irq disabled after vop driver
 probed
In-Reply-To: <25470133.K8n9sLBzRS@diego>
References: <b8eb41e576c4007d40223699eb951db32916b86a.camel@collabora.com>
 <25470133.K8n9sLBzRS@diego>
Message-ID: <CAAFQd5DwFiKJ-JyFkFqC-XzTyBeanbQWazw8OqT4XQRmwrNJrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko, Sandy,

On Fri, May 25, 2018 at 7:07 AM Heiko St?bner <heiko@sntech.de> wrote:

> From: Sandy Huang <hjc@rock-chips.com>

> The vop irq is shared between vop and iommu and irq probing in the
> iommu driver moved to the probe function recently. This can in some
> cases lead to a stall if the irq is triggered while the vop driver
> still has it disabled.

> But there is no real need to disable the irq, as the vop can simply
> also track its enabled state and ignore irqs in that case.

> So remove the enable/disable handling and add appropriate condition
> to the irq handler.

> Signed-off-by: Sandy Huang <hjc@rock-chips.com>
> [added an actual commit message]
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
> Hi Ezequiel,

> this patch came from a discussion I had with Rockchip people over the
> iommu changes and resulting issues back in april, but somehow was
> forgotten and not posted to the lists. Correcting that now.

> So removing the enable/disable voodoo on the shared interrupt is
> the preferred way.

>   drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 13 ++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)

> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> index 510cdf0..61493d4 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> @@ -549,8 +549,6 @@ static int vop_enable(struct drm_crtc *crtc)

>          spin_unlock(&vop->reg_lock);

> -       enable_irq(vop->irq);
> -

While this one should be okay (+/- my comment for vop_isr()), because the
hardware is already powered on and clocked at this point...

>          drm_crtc_vblank_on(crtc);

>          return 0;
> @@ -596,8 +594,6 @@ static void vop_crtc_atomic_disable(struct drm_crtc
*crtc,

>          vop_dsp_hold_valid_irq_disable(vop);

> -       disable_irq(vop->irq);
> -
>          vop->is_enabled = false;

...this one is more tricky. There might be an interrupt handler still
running at this point. disable_irq() waits for any running handler to
complete before disabling, so we might want to call synchronize_irq() after
setting is_enabled to false.


>          /*
> @@ -1168,6 +1164,13 @@ static irqreturn_t vop_isr(int irq, void *data)
>          int ret = IRQ_NONE;

>          /*
> +        * since the irq is shared with iommu, iommu irq is enabled
before vop
> +        * enable, so before vop enable we do nothing.
> +        */
> +       if (!vop->is_enabled)
> +               return IRQ_NONE;

This doesn't seem to be properly synchronized. We don't even call it under
a spinlock, so no barriers are issued. Perhaps we should make this atomic_t?

Best regards,
Tomasz
