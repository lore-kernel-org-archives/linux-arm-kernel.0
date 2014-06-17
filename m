From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 17 Jun 2014 18:23:02 +0100
Subject: [PATCH 2/2] phy: add hix5hd2-sata-phy driver
In-Reply-To: <1402991881-27676-3-git-send-email-zhangfei.gao@linaro.org>
References: <1402991881-27676-1-git-send-email-zhangfei.gao@linaro.org>
 <1402991881-27676-3-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <20140617172302.GI8930@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 17, 2014 at 08:58:01AM +0100, Zhangfei Gao wrote:
> From: Jiancheng Xue <xuejiancheng@huawei.com>
> 
> Add hix5hd2-sata-phy driver on Hisilicon hix5hd2 soc.
> 
> Signed-off-by: Jiancheng Xue <xuejiancheng@huawei.com>
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> ---
>  drivers/phy/Kconfig            |    8 ++
>  drivers/phy/Makefile           |    1 +
>  drivers/phy/phy-hix5hd2-sata.c |  192 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 201 insertions(+)
>  create mode 100644 drivers/phy/phy-hix5hd2-sata.c
 
[...]

> +	paddr = of_get_property(phy->dev.of_node, "hisilicon,reg-init", &lenp);
> +	if (!paddr || lenp < 4 * sizeof(*paddr))
> +		return 0;
> +
> +	lenp /= sizeof(*paddr);
> +	for (i = 0; i < lenp - 3; i += 4) {
> +		offset = be32_to_cpup(paddr + i);
> +		shift = be32_to_cpup(paddr + i + 1);
> +		width = be32_to_cpup(paddr + i + 2);
> +		value = be32_to_cpup(paddr + i + 3);
> +		hix5hd2_sata_phy_write(priv->base + offset,
> +				       shift, width, value);
> +	}

There is absolutely no reason to use of_get_property and be32 values
here, we have of_property_count_u32_elems and
of_property_read_u32_index.

That said I would like to see a compelling reason for why we need to
have this at all; I'm not a fan of DT becoming a shoddy bytecode format.

Cheers,
Mark.
