From: andriy.shevchenko@intel.com (Shevchenko, Andriy)
Date: Fri, 12 Oct 2012 14:41:55 +0000
Subject: [PATCH 2/3] dmaengine: dw_dmac: Enhance device tree support
In-Reply-To: <CAKohpok=nv2XnFdPkD_yJgUsDqx2gEh=mG_Xhbe-BvT7swVsyg@mail.gmail.com>
References: <142ef9170a2c69657d8a05ac127a9970d7b04965.1350020375.git.viresh.kumar@linaro.org>
 <91e41b4cc972d298f714cbd6f400569a9710304c.1350020375.git.viresh.kumar@linaro.org>
 <1350048519.10584.158.camel@smile>
 <CAKohpok=nv2XnFdPkD_yJgUsDqx2gEh=mG_Xhbe-BvT7swVsyg@mail.gmail.com>
Message-ID: <1350052912.10584.167.camel@smile>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-10-12 at 19:36 +0530, Viresh Kumar wrote: 
> On 12 October 2012 18:58, Shevchenko, Andriy
> <andriy.shevchenko@intel.com> wrote:
> > On Fri, 2012-10-12 at 11:14 +0530, Viresh Kumar wrote:
> 
> >> +     if (!of_property_read_u32(np, "nr_masters", &val)) {
> >> +             if (val > 4)
> > I thought once that we might introduce constant like #define
> > DW_MAX_AHB_MASTERS 4. It seems a bit useless because hw is designed for
> > that number anyway, but maybe you have another opinion.
> 
> Not everyone have four masters in there SoC configurations. So its better
> to export correct values.
I meant is to use that constant instead of hard coding 4 everywhere.
It's a maximum value, not the SoC specific.

> >> +     if (!of_property_read_u32_array(np, "data_width", arr,
> >> +                             pdata->nr_masters))
> >> +             for (count = 0; count < pdata->nr_masters; count++)
> >> +                     pdata->data_width[count] = arr[count];
> > Ah, it would be nice to have of_property_read_u8_array and so on...
> 
> :)
> Maybe yes. I don't want to do it with this patchset, as that will take more
> time to go through maintainers.
Agreed, the comment just for future. I don't know if there any other
users of *_u8/u16_array().

> > it will probably require to split this part in a separate function and
> > calculate count of slave_info children before pdata memory allocation.
> 
> Liked the idea partially. Check my new implementation in fixup for all
> these comments:
Let me see.

> diff --git a/drivers/dma/dw_dmac.c b/drivers/dma/dw_dmac.c

> @@ -1516,7 +1516,7 @@ __devinit dw_dma_parse_dt(struct platform_device *pdev)
>  	struct device_node *sn, *cn, *np = pdev->dev.of_node;
>  	struct dw_dma_platform_data *pdata;
>  	struct dw_dma_slave *sd;
> -	u32 count, val, arr[4];
> +	u32 val, arr[4];
what about to use tmp name instead of val? It's really minor, but I
think val name is little bit unrelated to a loop counter.

> @@ -1533,63 +1533,57 @@ __devinit dw_dma_parse_dt(struct platform_device *pdev)

> -	count = 0;
> +	pdata->sd = sd;
> +	pdata->sd_count = val;
> +
>  	for_each_child_of_node(sn, cn) {
> -		of_property_read_string(cn, "bus_id", &sd[count].bus_id);
> -		of_property_read_u32(cn, "cfg_hi", &sd[count].cfg_hi);
> -		of_property_read_u32(cn, "cfg_lo", &sd[count].cfg_lo);
> +		sd->dma_dev = &pdev->dev;
> +		of_property_read_string(cn, "bus_id", &sd->bus_id);
> +		of_property_read_u32(cn, "cfg_hi", &sd->cfg_hi);
> +		of_property_read_u32(cn, "cfg_lo", &sd->cfg_lo);
>  		if (!of_property_read_u32(cn, "src_master", &val))
> -			sd[count].src_master = (u8)val;
> +			sd->src_master = val;
> 
>  		if (!of_property_read_u32(cn, "dst_master", &val))
> -			sd[count].dst_master = (u8)val;
> -
> -		sd[count].dma_dev = &pdev->dev;
> -		count++;
> +			sd->dst_master = val;
> +		sd++;
>  	}
This looks good.

-- 
Andy Shevchenko <andriy.shevchenko@intel.com>
Intel Finland Oy
---------------------------------------------------------------------
Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki 
Business Identity Code: 0357606 - 4 
Domiciled in Helsinki 

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
