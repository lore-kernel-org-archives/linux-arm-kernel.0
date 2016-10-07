From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 7 Oct 2016 19:28:10 +0300
Subject: [PATCH 3/3] mtd: s3c2410: parse the device configuration from OF
 node
In-Reply-To: <1475711217-974-4-git-send-email-sergio.prado@e-labworks.com>
References: <1475711217-974-1-git-send-email-sergio.prado@e-labworks.com>
 <1475711217-974-4-git-send-email-sergio.prado@e-labworks.com>
Message-ID: <20161007162810.GB4222@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 05, 2016 at 08:46:57PM -0300, Sergio Prado wrote:
> Allows configuring Samsung's s3c2410 memory controller using a
> devicetree.
> 
> Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>
> ---
>  drivers/mtd/nand/s3c2410.c                     | 171 ++++++++++++++++++++++---
>  include/linux/platform_data/mtd-nand-s3c2410.h |   1 +
>  2 files changed, 156 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/mtd/nand/s3c2410.c b/drivers/mtd/nand/s3c2410.c
> index 174ac9dc4265..352cf2656bc8 100644
> --- a/drivers/mtd/nand/s3c2410.c
> +++ b/drivers/mtd/nand/s3c2410.c
> @@ -39,6 +39,8 @@
>  #include <linux/slab.h>
>  #include <linux/clk.h>
>  #include <linux/cpufreq.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
>  
>  #include <linux/mtd/mtd.h>
>  #include <linux/mtd/nand.h>
> @@ -185,6 +187,26 @@ struct s3c2410_nand_info {
>  #endif
>  };
>  
> +struct s3c24XX_nand_devtype_data {
> +	enum s3c_cpu_type type;
> +};
> +
> +struct s3c24XX_nand_devtype_data s3c2410_nand_devtype_data = {
> +	.type = TYPE_S3C2410,
> +};
> +
> +struct s3c24XX_nand_devtype_data s3c2412_nand_devtype_data = {
> +	.type = TYPE_S3C2412,
> +};
> +
> +struct s3c24XX_nand_devtype_data s3c2440_nand_devtype_data = {
> +	.type = TYPE_S3C2440,
> +};
> +
> +struct s3c24XX_nand_devtype_data s3c6400_nand_devtype_data = {
> +	.type = TYPE_S3C2412,

All of these look like candidate for static const.

Additionally you are not actually differentiating between s3c2412 and
s3c64xx so I think there is not need of samsung,s3c6400-nand compatible.
Just use existing one.

Best regards,
Krzysztof
