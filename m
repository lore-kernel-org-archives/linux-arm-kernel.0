From: tfiga@chromium.org (Tomasz Figa)
Date: Fri, 3 Jul 2015 17:02:44 +0900
Subject: [PATCH v2 5/5] drm/rockchip: default enable win2/3 area0 bit
In-Reply-To: <1435313432-4923-1-git-send-email-mark.yao@rock-chips.com>
References: <1435313249-4549-1-git-send-email-mark.yao@rock-chips.com>
 <1435313432-4923-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <CAAFQd5D4W1+ShB4zpSJrBiFYWh21axJoGoQ77NwXzhSRapysgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Please see my comments inline.

On Fri, Jun 26, 2015 at 7:10 PM, Mark Yao <mark.yao@rock-chips.com> wrote:
> Win2/3 support 4 area display, but now havn't found a suitable
> way to use it, and it enable by win gate and area gate,
> so default enable area0 gate, so that its behaviour just like a
> win.

So I assume this means that currently, without those bits set, win2
and win3 do not work? This would make this patch a fix maybe even with
a potential backportability.

>
> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
> ---
> Changes in v2: None
>
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c |    6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> index 40107bb..e001d26 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> @@ -337,6 +337,12 @@ static const struct vop_reg_data vop_init_reg_table[] = {
>         {DSP_CTRL0, 0x00000000},
>         {WIN0_CTRL0, 0x00000080},
>         {WIN1_CTRL0, 0x00000080},
> +       /*
> +        * Todo: win2/3 support area func, but now havn't found a suitable
> +        * way to use it, so default enable area0 as a win display.

TODO: Win2/3 support multiple area function, but we haven't found
a suitable way to use it yet, so let's just use them as other windows
with only area 0 enabled.

> +        */
> +       {WIN2_CTRL0, 0x00000010},
> +       {WIN3_CTRL0, 0x00000010},

Anyway, is it enough to program those registers one time in
vop_initial()? Won't they get cleared when VOP is power cycled, e.g.
in case of DPMS off and on? Maybe instead this could be done in
vop_update_plane_event() for windows that need it?

Best regards,
Tomasz
