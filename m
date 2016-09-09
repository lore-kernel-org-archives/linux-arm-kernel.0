From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 09 Sep 2016 11:42:19 +0300
Subject: [PATCH] [media] platform: constify vb2_ops structures
In-Reply-To: <1473379150-17315-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1473379150-17315-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1520635.43zSurJaks@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Julia,

Thank you for the patch.

On Friday 09 Sep 2016 01:59:10 Julia Lawall wrote:
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

For the drivers below,

>  drivers/media/platform/m2m-deinterlace.c                 |    2 +-
>  drivers/media/platform/rcar-vin/rcar-dma.c               |    2 +-
>  drivers/media/platform/rcar_jpu.c                        |    2 +-
>  drivers/media/platform/sh_vou.c                          |    2 +-
>  drivers/media/platform/soc_camera/atmel-isi.c            |    2 +-
>  drivers/media/platform/soc_camera/sh_mobile_ceu_camera.c |    2 +-
>  drivers/media/platform/vim2m.c                           |    2 +-
>  drivers/media/platform/xilinx/xilinx-dma.c               |    2 +-

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

For

>  drivers/media/platform/soc_camera/rcar_vin.c             |    2 +-

you can also add my

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

tag, but the driver will be scheduled for removal very soon.

-- 
Regards,

Laurent Pinchart
