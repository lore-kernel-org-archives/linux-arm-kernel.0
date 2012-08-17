From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 17 Aug 2012 17:09:38 +0200
Subject: [PATCH 1/2] ARM: da850/omap-l138: Add SoC related definitions for
 VPIF
In-Reply-To: <502E5C40.803@ti.com>
References: <1343115786-15801-1-git-send-email-prabhakar.lad@ti.com>
 <1343115786-15801-2-git-send-email-prabhakar.lad@ti.com>
 <502A4464.3020706@ti.com> <502CC7CD.80906@ti.com> <502E5C40.803@ti.com>
Message-ID: <024a01cd7c8a$541efb20$fc5cf160$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Friday, August 17, 2012 4:59 PM Sekhar Nori wrote:

> On 8/16/2012 3:43 PM, Prabhakar Lad wrote:
> > On Tuesday 14 August 2012 05:58 PM, Sekhar Nori wrote:
> 
> [...]
> 
> >>> +int __init da850_register_vpif_display(struct vpif_display_config
> >>> +						*display_config)
> >>> +{
> >>> +	struct resource da850_vpif_display_resource[] = {
> >>> +		{
> >>> +			.start = IRQ_DA850_VPIFINT,
> >>> +			.end   = IRQ_DA850_VPIFINT,
> >>> +			.flags = IORESOURCE_IRQ,
> >>> +		},
> >>> +		{},
> >>> +	};
> >>> +	unsigned long phys_end_kernel;
> >>> +	int ret;
> >>> +
> >>> +	if (vpif_disp_cont_bufsize) {
> >>> +		phys_end_kernel = virt_to_phys((void *)PAGE_OFFSET) +
> >>> +					(num_physpages << PAGE_SHIFT);
> >>> +		phys_end_kernel += vpif_disp_cont_buf_offset;
> >>> +		da850_vpif_display_resource[1].start = phys_end_kernel;
> >>> +		da850_vpif_display_resource[1].end = phys_end_kernel +
> >>> +						vpif_disp_cont_bufsize - 1;
> >>> +		da850_vpif_display_resource[1].flags = IORESOURCE_MEM;
> >>> +
> >>> +		if (!request_mem_region(da850_vpif_display_resource[1].start,
> >>> +				resource_size(&da850_vpif_display_resource[1]),
> >>> +				da850_vpif_display_dev.name)) {
> >>> +			pr_err("region already claimed.\n");
> >>> +			return -EBUSY;
> >>> +		}
> >>> +		ret = dma_declare_coherent_memory(&da850_vpif_display_dev.dev,
> >>> +				phys_end_kernel, phys_end_kernel,
> >>> +				vpif_disp_cont_bufsize,
> >>> +				DMA_MEMORY_MAP | DMA_MEMORY_EXCLUSIVE);
> >>> +
> >>> +		if (!ret)
> >>> +			return -ENOMEM;
> >>> +	}
> >>> +	ret = platform_device_add_resources(&da850_vpif_display_dev,
> >>> +				da850_vpif_display_resource,
> >>> +				ARRAY_SIZE(da850_vpif_display_resource));
> >>
> >> You are taking memory at the end of RAM and passing it as a IO resource
> >> to the driver. This is not correct. For contiguous memory needs can you
> >> look at the recently merged CMA framework (include/linux/dma-contiguous.h)
> >>
> > Ok. But looks like CMA is enabled for CPU_V6/V6K/V7. If CMA is enabled
> > for ARM926 too than we can use the global CMA itself rather then doing
> > it for each device, then three will be no need to do the above and all
> > the kernel parameters can be removed too.
> 
> I hadn't followed the CMA development closely so I am not sure of the
> reasons behind restricting it to v6+. The patch that added this doesn't
> really talk about why it should be restricted to v6+. I am copying Marek
> here to see if he can quickly clarify, but may be you can even start a
> new thread asking about this.

Frankly, this is a leftover from some earlier suggestions that CMA should solve the
aliasing of coherent mappings, which might be a problem on v6+. If it works correctly
on pre-v6, then this dependency should be removed. Feel free to submit a patch and 
I will take it to my fixes branch.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
