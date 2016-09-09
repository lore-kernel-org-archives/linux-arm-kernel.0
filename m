From: bparrot@ti.com (Benoit Parrot)
Date: Fri, 9 Sep 2016 11:03:55 -0500
Subject: [PATCH] [media] platform: constify vb2_ops structures
In-Reply-To: <1473379150-17315-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1473379150-17315-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <20160909160355.GC27225@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Thanks for the patch.

Julia Lawall <Julia.Lawall@lip6.fr> wrote on Fri [2016-Sep-09 01:59:10 +0200]:
> Check for vb2_ops structures that are only stored in the ops field of a
> vb2_queue structure.  That field is declared const, so vb2_ops structures
> that have this property can be declared as const also.
> 
> The semantic patch that makes this change is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @r disable optional_qualifier@
> identifier i;
> position p;
> @@
> static struct vb2_ops i at p = { ... };
> 
> @ok@
> identifier r.i;
> struct vb2_queue e;
> position p;
> @@
> e.ops = &i at p;
> 
> @bad@
> position p != {r.p,ok.p};
> identifier r.i;
> struct vb2_ops e;
> @@
> e at i@p
> 
> @depends on !bad disable optional_qualifier@
> identifier r.i;
> @@
> static
> +const
>  struct vb2_ops i = { ... };
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> ---
>  drivers/media/platform/exynos-gsc/gsc-m2m.c              |    2 +-
>  drivers/media/platform/exynos4-is/fimc-capture.c         |    2 +-
>  drivers/media/platform/exynos4-is/fimc-m2m.c             |    2 +-
>  drivers/media/platform/m2m-deinterlace.c                 |    2 +-
>  drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c       |    2 +-
>  drivers/media/platform/mx2_emmaprp.c                     |    2 +-
>  drivers/media/platform/rcar-vin/rcar-dma.c               |    2 +-
>  drivers/media/platform/rcar_jpu.c                        |    2 +-
>  drivers/media/platform/s5p-g2d/g2d.c                     |    2 +-
>  drivers/media/platform/s5p-jpeg/jpeg-core.c              |    2 +-
>  drivers/media/platform/sh_vou.c                          |    2 +-
>  drivers/media/platform/soc_camera/atmel-isi.c            |    2 +-
>  drivers/media/platform/soc_camera/rcar_vin.c             |    2 +-
>  drivers/media/platform/soc_camera/sh_mobile_ceu_camera.c |    2 +-
>  drivers/media/platform/sti/bdisp/bdisp-v4l2.c            |    2 +-

For the following 2 drivers,

>  drivers/media/platform/ti-vpe/cal.c                      |    2 +-
>  drivers/media/platform/ti-vpe/vpe.c                      |    2 +-

Reviewed-by: Benoit Parrot <bparrot@ti.com>

>  drivers/media/platform/vim2m.c                           |    2 +-
>  drivers/media/platform/xilinx/xilinx-dma.c               |    2 +-
>  19 files changed, 19 insertions(+), 19 deletions(-)

Regards,
Benoit Parrot
