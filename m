From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 2 Jan 2018 11:44:24 +0000
Subject: [PATCH v2 01/21] nvmem: core: Allow specifying device name
 verbatim
In-Reply-To: <20180101232310.30420-2-andrew.smirnov@gmail.com>
References: <20180101232310.30420-1-andrew.smirnov@gmail.com>
 <20180101232310.30420-2-andrew.smirnov@gmail.com>
Message-ID: <ba0b8125-6094-d042-a391-edcc2f68a114@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for the Patch,

On 01/01/18 23:22, Andrey Smirnov wrote:
> Add code to allow avoid having nvmem core append a numeric suffix to
> the end of the name by passing config->id of -1.
> 
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Carlo Caione <carlo@caione.org>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: cphealy at gmail.com
> Cc: linux-kernel at vger.kernel.org
> Cc: linux-mediatek at lists.infradead.org
> Cc: linux-rockchip at lists.infradead.org
> Cc: linux-amlogic at lists.infradead.org
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>   drivers/nvmem/core.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
This looks fine for me, Can you also add a line in kernel doc about this 
behavior.

thanks,
srini
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 5a5cefd12153..57cbeacfbeb2 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -475,9 +475,14 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>   	nvmem->reg_write = config->reg_write;
>   	np = config->dev->of_node;
>   	nvmem->dev.of_node = np;
> -	dev_set_name(&nvmem->dev, "%s%d",
> -		     config->name ? : "nvmem",
> -		     config->name ? config->id : nvmem->id);
> +
> +	if (config->id == -1 && config->name) {
> +		dev_set_name(&nvmem->dev, "%s", config->name);
> +	} else {
> +		dev_set_name(&nvmem->dev, "%s%d",
> +			     config->name ? : "nvmem",
> +			     config->name ? config->id : nvmem->id);
> +	}
>   
>   	nvmem->read_only = of_property_read_bool(np, "read-only") |
>   			   config->read_only;
> 
