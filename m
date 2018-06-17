From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Sun, 17 Jun 2018 11:12:59 +0200
Subject: [PATCH v2] drm/atmel-hlcdc: check stride values in the first plane
In-Reply-To: <20180617084826.31885-1-stefan@agner.ch>
References: <20180617084826.31885-1-stefan@agner.ch>
Message-ID: <20180617111259.556378e1@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 17 Jun 2018 10:48:22 +0200
Stefan Agner <stefan@agner.ch> wrote:

> The statement always evaluates to true since the struct fields
> are arrays. This has shown up as a warning when compiling with
> clang:
>   warning: address of array 'desc->layout.xstride' will always
>       evaluate to 'true' [-Wpointer-bool-conversion]
> 
> Check for values in the first plane instead.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

I'll add

Fixes: 1a396789f65a ("drm: add Atmel HLCDC Display Controller support")
Cc: stable at vger.kernel.org

when applying.

Thanks,

Boris

> ---
> Changes in v2:
> - Check for first value instead of dropping if statement
>   (subject was: drm/atmel-hlcdc: remove unnecessary if statement)
> 
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> index 73c875db45f4..47e0992f3908 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> @@ -839,7 +839,7 @@ static int atmel_hlcdc_plane_init_properties(struct atmel_hlcdc_plane *plane)
>  			return ret;
>  	}
>  
> -	if (desc->layout.xstride && desc->layout.pstride) {
> +	if (desc->layout.xstride[0] && desc->layout.pstride[0]) {
>  		int ret;
>  
>  		ret = drm_plane_create_rotation_property(&plane->base,
