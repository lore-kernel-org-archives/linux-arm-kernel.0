From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 23 Nov 2016 17:55:43 +0530
Subject: [PATCH v3 1/3] bus: da8xx-mstpri: drop the call to
 of_flat_dt_get_machine_name()
In-Reply-To: <1479899187-10199-2-git-send-email-bgolaszewski@baylibre.com>
References: <1479899187-10199-1-git-send-email-bgolaszewski@baylibre.com>
 <1479899187-10199-2-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <34a4f4ed-37bb-e5d9-3d44-383f23d274bc@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bartosz,

On Wednesday 23 November 2016 04:36 PM, Bartosz Golaszewski wrote:
> In order to avoid a section mismatch use a locally implemented routine
> instead of of_flat_dt_get_machine_name() when printing the error
> message.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/bus/da8xx-mstpri.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bus/da8xx-mstpri.c b/drivers/bus/da8xx-mstpri.c
> index 85f0b53..064eeb9 100644
> --- a/drivers/bus/da8xx-mstpri.c
> +++ b/drivers/bus/da8xx-mstpri.c
> @@ -16,7 +16,6 @@
>  #include <linux/platform_device.h>
>  #include <linux/io.h>
>  #include <linux/regmap.h>
> -#include <linux/of_fdt.h>
>  
>  /*
>   * REVISIT: Linux doesn't have a good framework for the kind of performance
> @@ -190,6 +189,26 @@ static const struct da8xx_mstpri_board_priorities da8xx_mstpri_board_confs[] = {
>  	},
>  };
>  
> +/*
> + * FIXME Remove this function once of/base gets a general routine for getting
> + * the machine model/compatible string.
> + */
> +static const char *da8xx_mstpri_machine_get_compatible(void)
> +{
> +	struct device_node *root;
> +	const char *compatible;
> +	int ret = -1;
> +
> +	root = of_find_node_by_path("/");
> +	if (root) {
> +		ret = of_property_read_string_index(root, "compatible",
> +						    0, &compatible);
> +		of_node_put(root);
> +	}
> +
> +	return ret ? NULL : compatible;
> +}

As I just noted in the thread for v1 of this patch, calling
of_node_put(root) while keeping a reference to its compatible property
for later use sounds really broken.

I think it is safest to fix this by not including the compatible name in
error message at all. The error message will be little less descriptive,
but thats better than adding questionable code.

Thats what Frank suggested first up, but I did not realize at that time
that printing compatible name will be this much effort.

Can you please send a v4?

Thanks,
Sekhar
