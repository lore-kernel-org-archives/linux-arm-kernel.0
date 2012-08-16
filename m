From: prabhakar.lad@ti.com (Prabhakar Lad)
Date: Thu, 16 Aug 2012 15:43:33 +0530
Subject: [PATCH 1/2] ARM: da850/omap-l138: Add SoC related definitions
 for VPIF
In-Reply-To: <502A4464.3020706@ti.com>
References: <1343115786-15801-1-git-send-email-prabhakar.lad@ti.com>
 <1343115786-15801-2-git-send-email-prabhakar.lad@ti.com>
 <502A4464.3020706@ti.com>
Message-ID: <502CC7CD.80906@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sekhar,

Thanks for the review. My comments are inlined.

On Tuesday 14 August 2012 05:58 PM, Sekhar Nori wrote:
> Hi Prabhakar,
> 
> On 7/24/2012 1:13 PM, Prabhakar Lad wrote:
>> From: Manjunath Hadli <manjunath.hadli@ti.com>
>>
>> Add clock, pin mux definitions and registration function for
>> VPIF capture and display driver on DA850/OMAP-L138 SoC.
>>
>> Signed-off-by: Manjunath Hadli <manjunath.hadli@ti.com>
>> Signed-off-by: Lad, Prabhakar <prabhakar.lad@ti.com>
>> Cc: Sekhar Nori <nsekhar@ti.com>
>> ---
>>  arch/arm/mach-davinci/da850.c              |  256 ++++++++++++++++++++++++++++
>>  arch/arm/mach-davinci/include/mach/da8xx.h |   11 ++
>>  arch/arm/mach-davinci/include/mach/mux.h   |   42 +++++
>>  arch/arm/mach-davinci/include/mach/psc.h   |    1 +
>>  4 files changed, 310 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
>> index b44dc84..c864431 100644
>> --- a/arch/arm/mach-davinci/da850.c
>> +++ b/arch/arm/mach-davinci/da850.c
>> @@ -347,6 +347,13 @@ static struct clk spi1_clk = {
>>  	.flags		= DA850_CLK_ASYNC3,
>>  };
>>  
>> +static struct clk vpif_clk = {
>> +	.name		= "vpif",
>> +	.parent		= &pll0_sysclk2,
>> +	.lpsc		= DA850_LPSC1_VPIF,
>> +	.gpsc		= 1,
>> +};
>> +
>>  static struct clk sata_clk = {
>>  	.name		= "sata",
>>  	.parent		= &pll0_sysclk2,
>> @@ -397,6 +404,7 @@ static struct clk_lookup da850_clks[] = {
>>  	CLK(NULL,		"usb20",	&usb20_clk),
>>  	CLK("spi_davinci.0",	NULL,		&spi0_clk),
>>  	CLK("spi_davinci.1",	NULL,		&spi1_clk),
>> +	CLK(NULL,		"vpif",		&vpif_clk),
> 
> You should dev_id for lookup instead of con_id. Looking at
> drivers/media/video/davinci/vpif.c, there is a single clock that VPIF
> needs, so con_id can actually be passed as NULL.
> 
  Ok I'll use dev_id.

>>  	CLK("ahci",		NULL,		&sata_clk),
>>  	CLK(NULL,		NULL,		NULL),
>>  };
>> @@ -573,6 +581,46 @@ static const struct mux_config da850_pins[] = {
>>  	MUX_CFG(DA850, GPIO6_10,	13,	20,	15,	8,	false)
>>  	MUX_CFG(DA850, GPIO6_13,	13,	8,	15,	8,	false)
>>  	MUX_CFG(DA850, RTC_ALARM,	0,	28,	15,	2,	false)
>> +	/* VPIF Capture */
>> +	MUX_CFG(DA850, VPIF_DIN0,	15,	4,	15,	1,	false)
>> +	MUX_CFG(DA850, VPIF_DIN1,	15,	0,	15,	1,	false)
>> +	MUX_CFG(DA850, VPIF_DIN2,	14,	28,	15,	1,	false)
>> +	MUX_CFG(DA850, VPIF_DIN3,	14,	24,	15,	1,	false)
>> +	MUX_CFG(DA850, VPIF_DIN4,	14,	20,	15,	1,	false)
>> +	MUX_CFG(DA850, VPIF_DIN5,	14,	16,	15,	1,	false)
>> +	MUX_CFG(DA850, VPIF_DIN6,	14,	12,	15,	1,	false)
>> +	MUX_CFG(DA850, VPIF_DIN7,	14,	8,	15,	1,	false)
>> +	MUX_CFG(DA850, VPIF_DIN8,	16,	4,	15,	1,	false)
>> +	MUX_CFG(DA850, VPIF_DIN9,	16,	0,	15,	1,	false)
>> +	MUX_CFG(DA850, VPIF_DIN10,	15,	28,	15,	1,	false)
>> +	MUX_CFG(DA850, VPIF_DIN11,	15,	24,	15,	1,	false)
>> +	MUX_CFG(DA850, VPIF_DIN12,	15,	20,	15,	1,	false)
>> +	MUX_CFG(DA850, VPIF_DIN13,	15,	16,	15,	1,	false)
>> +	MUX_CFG(DA850, VPIF_DIN14,	15,	12,	15,	1,	false)
>> +	MUX_CFG(DA850, VPIF_DIN15,	15,	8,	15,	1,	false)
>> +	MUX_CFG(DA850, VPIF_CLKIN0,	14,	0,	15,	1,	false)
>> +	MUX_CFG(DA850, VPIF_CLKIN1,	14,	4,	15,	1,	false)
>> +	MUX_CFG(DA850, VPIF_CLKIN2,	19,	8,	15,	1,	false)
>> +	MUX_CFG(DA850, VPIF_CLKIN3,	19,	16,	15,	1,	false)
>> +	/* VPIF Display */
>> +	MUX_CFG(DA850, VPIF_DOUT0,	17,	4,	15,	1,	false)
>> +	MUX_CFG(DA850, VPIF_DOUT1,	17,	0,	15,	1,	false)
>> +	MUX_CFG(DA850, VPIF_DOUT2,	16,	28,	15,	1,	false)
>> +	MUX_CFG(DA850, VPIF_DOUT3,	16,	24,	15,	1,	false)
>> +	MUX_CFG(DA850, VPIF_DOUT4,	16,	20,	15,	1,	false)
>> +	MUX_CFG(DA850, VPIF_DOUT5,	16,	16,	15,	1,	false)
>> +	MUX_CFG(DA850, VPIF_DOUT6,	16,	12,	15,	1,	false)
>> +	MUX_CFG(DA850, VPIF_DOUT7,	16,	8,	15,	1,	false)
>> +	MUX_CFG(DA850, VPIF_DOUT8,	18,	4,	15,	1,	false)
>> +	MUX_CFG(DA850, VPIF_DOUT9,	18,	0,	15,	1,	false)
>> +	MUX_CFG(DA850, VPIF_DOUT10,	17,	28,	15,	1,	false)
>> +	MUX_CFG(DA850, VPIF_DOUT11,	17,	24,	15,	1,	false)
>> +	MUX_CFG(DA850, VPIF_DOUT12,	17,	20,	15,	1,	false)
>> +	MUX_CFG(DA850, VPIF_DOUT13,	17,	16,	15,	1,	false)
>> +	MUX_CFG(DA850, VPIF_DOUT14,	17,	12,	15,	1,	false)
>> +	MUX_CFG(DA850, VPIF_DOUT15,	17,	8,	15,	1,	false)
>> +	MUX_CFG(DA850, VPIF_CLKO2,	19,	12,	15,	1,	false)
>> +	MUX_CFG(DA850, VPIF_CLKO3,	19,	20,	15,	1,	false)
>>  #endif
>>  };
>>  
>> @@ -595,6 +643,26 @@ const short da850_lcdcntl_pins[] __initdata = {
>>  	-1
>>  };
>>  
>> +const short da850_vpif_capture_pins[] __initdata = {
>> +	DA850_VPIF_DIN0, DA850_VPIF_DIN1, DA850_VPIF_DIN2, DA850_VPIF_DIN3,
>> +	DA850_VPIF_DIN4, DA850_VPIF_DIN5, DA850_VPIF_DIN6, DA850_VPIF_DIN7,
>> +	DA850_VPIF_DIN8, DA850_VPIF_DIN9, DA850_VPIF_DIN10, DA850_VPIF_DIN11,
>> +	DA850_VPIF_DIN12, DA850_VPIF_DIN13, DA850_VPIF_DIN14, DA850_VPIF_DIN15,
>> +	DA850_VPIF_CLKIN0, DA850_VPIF_CLKIN1, DA850_VPIF_CLKIN2,
>> +	DA850_VPIF_CLKIN3,
>> +	-1
>> +};
>> +
>> +const short da850_vpif_display_pins[] __initdata = {
>> +	DA850_VPIF_DOUT0, DA850_VPIF_DOUT1, DA850_VPIF_DOUT2, DA850_VPIF_DOUT3,
>> +	DA850_VPIF_DOUT4, DA850_VPIF_DOUT5, DA850_VPIF_DOUT6, DA850_VPIF_DOUT7,
>> +	DA850_VPIF_DOUT8, DA850_VPIF_DOUT9, DA850_VPIF_DOUT10,
>> +	DA850_VPIF_DOUT11, DA850_VPIF_DOUT12, DA850_VPIF_DOUT13,
>> +	DA850_VPIF_DOUT14, DA850_VPIF_DOUT15, DA850_VPIF_CLKO2,
>> +	DA850_VPIF_CLKO3,
>> +	-1
>> +};
>> +
>>  /* FIQ are pri 0-1; otherwise 2-7, with 7 lowest priority */
>>  static u8 da850_default_priorities[DA850_N_CP_INTC_IRQ] = {
>>  	[IRQ_DA8XX_COMMTX]		= 7,
>> @@ -1064,6 +1132,194 @@ no_ddrpll_mem:
>>  	return ret;
>>  }
>>  
>> +/* VPIF resource, platform data */
>> +static u64 da850_vpif_dma_mask = DMA_BIT_MASK(32);
>> +
>> +static struct resource da850_vpif_resource[] = {
>> +	{
>> +		.start	= DA8XX_VPIF_BASE,
>> +		.end	= DA8XX_VPIF_BASE + 0xfff,
>> +		.flags	= IORESOURCE_MEM,
>> +	}
>> +};
>> +
>> +static struct platform_device da850_vpif_dev = {
>> +	.name		= "vpif",
>> +	.id		= -1,
>> +	.dev		= {
>> +			.dma_mask		= &da850_vpif_dma_mask,
>> +			.coherent_dma_mask	= DMA_BIT_MASK(32),
>> +	},
>> +	.resource	= da850_vpif_resource,
>> +	.num_resources	= ARRAY_SIZE(da850_vpif_resource),
>> +};
>> +
>> +static unsigned long vpif_disp_cont_buf_offset;
>> +
>> +static int __init cfg_vpif_disp_cont_buf_offset(char *p)
>> +{
>> +	if (!p)
>> +		return 0;
>> +
>> +	return kstrtoul(p, 10, &vpif_disp_cont_buf_offset);
>> +}
>> +early_param("vpif_disp_cont_buf_offset", cfg_vpif_disp_cont_buf_offset);
>> +
>> +static unsigned long vpif_disp_cont_bufsize;
>> +
>> +static int __init cfg_vpif_disp_cont_bufsize(char *p)
>> +{
>> +	if (!p)
>> +		return 0;
>> +
>> +	return kstrtoul(p, 10, &vpif_disp_cont_bufsize);
>> +}
>> +early_param("vpif_disp_cont_bufsize", cfg_vpif_disp_cont_bufsize);
>> +
>> +static unsigned long vpif_cap_cont_buf_offset;
>> +
>> +static int __init cfg_vpif_cap_cont_buf_offset(char *p)
>> +{
>> +	if (!p)
>> +		return 0;
>> +
>> +	return kstrtoul(p, 10, &vpif_cap_cont_buf_offset);
>> +}
>> +early_param("vpif_cap_cont_buf_offset", cfg_vpif_cap_cont_buf_offset);
>> +
>> +static unsigned long vpif_cap_cont_bufsize;
>> +
>> +static int __init cfg_vpif_cap_cont_bufsize(char *p)
>> +{
>> +	if (!p)
>> +		return 0;
>> +
>> +	return kstrtoul(p, 10, &vpif_cap_cont_bufsize);
>> +}
>> +early_param("vpif_cap_cont_bufsize", cfg_vpif_cap_cont_bufsize);
> 
> 
> All these kernel parameters will need to be documented in
> Documentation/kernel-parameters.txt. I suspect they should rather be
> module parameters?
> 
This was added since dma_declare_coherent() should be done in the
machine file. This was discussed over this thread,
http://linux.omap.com/pipermail/davinci-linux-open-source/2012-May/024165.html.


>> +
>> +static struct platform_device da850_vpif_display_dev = {
>> +	.name		= "vpif_display",
>> +	.id		= -1,
>> +	.dev		= {
>> +		.dma_mask		= &da850_vpif_dma_mask,
>> +		.coherent_dma_mask	= DMA_BIT_MASK(32),
>> +	},
>> +};
>> +
>> +static struct platform_device da850_vpif_capture_dev = {
>> +	.name		= "vpif_capture",
>> +	.id		= -1,
>> +	.dev		= {
>> +		.dma_mask		= &da850_vpif_dma_mask,
>> +		.coherent_dma_mask	= DMA_BIT_MASK(32),
>> +	},
>> +};
>> +
>> +int __init da850_register_vpif(void)
>> +{
>> +	return platform_device_register(&da850_vpif_dev);
>> +}
>> +
>> +int __init da850_register_vpif_display(struct vpif_display_config
>> +						*display_config)
>> +{
>> +	struct resource da850_vpif_display_resource[] = {
>> +		{
>> +			.start = IRQ_DA850_VPIFINT,
>> +			.end   = IRQ_DA850_VPIFINT,
>> +			.flags = IORESOURCE_IRQ,
>> +		},
>> +		{},
>> +	};
>> +	unsigned long phys_end_kernel;
>> +	int ret;
>> +
>> +	if (vpif_disp_cont_bufsize) {
>> +		phys_end_kernel = virt_to_phys((void *)PAGE_OFFSET) +
>> +					(num_physpages << PAGE_SHIFT);
>> +		phys_end_kernel += vpif_disp_cont_buf_offset;
>> +		da850_vpif_display_resource[1].start = phys_end_kernel;
>> +		da850_vpif_display_resource[1].end = phys_end_kernel +
>> +						vpif_disp_cont_bufsize - 1;
>> +		da850_vpif_display_resource[1].flags = IORESOURCE_MEM;
>> +
>> +		if (!request_mem_region(da850_vpif_display_resource[1].start,
>> +				resource_size(&da850_vpif_display_resource[1]),
>> +				da850_vpif_display_dev.name)) {
>> +			pr_err("region already claimed.\n");
>> +			return -EBUSY;
>> +		}
>> +		ret = dma_declare_coherent_memory(&da850_vpif_display_dev.dev,
>> +				phys_end_kernel, phys_end_kernel,
>> +				vpif_disp_cont_bufsize,
>> +				DMA_MEMORY_MAP | DMA_MEMORY_EXCLUSIVE);
>> +
>> +		if (!ret)
>> +			return -ENOMEM;
>> +	}
>> +	ret = platform_device_add_resources(&da850_vpif_display_dev,
>> +				da850_vpif_display_resource,
>> +				ARRAY_SIZE(da850_vpif_display_resource));
> 
> You are taking memory at the end of RAM and passing it as a IO resource
> to the driver. This is not correct. For contiguous memory needs can you
> look at the recently merged CMA framework (include/linux/dma-contiguous.h)
> 
Ok. But looks like CMA is enabled for CPU_V6/V6K/V7. If CMA is enabled
for ARM926 too than we can use the global CMA itself rather then doing
it for each device, then three will be no need to do the above and all
the kernel parameters can be removed too.

>> +	if (ret)
>> +		return -EINVAL;
>> +
>> +	da850_vpif_display_dev.dev.platform_data = display_config;
>> +	return platform_device_register(&da850_vpif_display_dev);
>> +}
>> +
>> +int __init da850_register_vpif_capture(struct vpif_capture_config
>> +							*capture_config)
>> +{
>> +	static struct resource da850_vpif_capture_resource[] = {
>> +		{
>> +			.start = IRQ_DA850_VPIFINT,
>> +			.end   = IRQ_DA850_VPIFINT,
>> +			.flags = IORESOURCE_IRQ,
>> +		},
>> +		{
>> +			.start = IRQ_DA850_VPIFINT,
>> +			.end   = IRQ_DA850_VPIFINT,
>> +			.flags = IORESOURCE_IRQ,
>> +		},
>> +		{},
>> +	};
>> +	unsigned long phys_end_kernel;
>> +	int ret;
>> +
>> +	if (vpif_cap_cont_bufsize) {
>> +		phys_end_kernel = virt_to_phys((void *)PAGE_OFFSET) +
>> +					(num_physpages << PAGE_SHIFT);
>> +		phys_end_kernel += vpif_cap_cont_buf_offset;
>> +		da850_vpif_capture_resource[2].start = phys_end_kernel;
>> +		da850_vpif_capture_resource[2].end = phys_end_kernel +
>> +						vpif_cap_cont_bufsize - 1;
>> +		da850_vpif_capture_resource[2].flags = IORESOURCE_MEM;
>> +
>> +		if (!request_mem_region(da850_vpif_capture_resource[2].start,
>> +				resource_size(&da850_vpif_capture_resource[2]),
>> +				da850_vpif_capture_dev.name)) {
>> +			pr_err("region already claimed.\n");
>> +			return -EBUSY;
>> +		}
>> +		ret = dma_declare_coherent_memory(&da850_vpif_capture_dev.dev,
>> +				phys_end_kernel, phys_end_kernel,
>> +				vpif_cap_cont_bufsize, DMA_MEMORY_MAP |
>> +				DMA_MEMORY_EXCLUSIVE);
>> +
>> +		if (!ret)
>> +			return -ENOMEM;
>> +	}
>> +	ret = platform_device_add_resources(&da850_vpif_capture_dev,
>> +				da850_vpif_capture_resource,
>> +				ARRAY_SIZE(da850_vpif_capture_resource));
> 
> The capture has the same problems as the display part above.
> 
  ditto

>> +	if (ret)
>> +		return -EINVAL;
>> +
>> +	da850_vpif_capture_dev.dev.platform_data = capture_config;
>> +	return platform_device_register(&da850_vpif_capture_dev);
>> +}
>> +
>>  static struct davinci_soc_info davinci_soc_info_da850 = {
>>  	.io_desc		= da850_io_desc,
>>  	.io_desc_num		= ARRAY_SIZE(da850_io_desc),
>> diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
>> index a2f1f27..0028bd7 100644
>> --- a/arch/arm/mach-davinci/include/mach/da8xx.h
>> +++ b/arch/arm/mach-davinci/include/mach/da8xx.h
>> @@ -16,6 +16,7 @@
>>  #include <linux/platform_device.h>
>>  #include <linux/davinci_emac.h>
>>  #include <linux/spi/spi.h>
>> +#include <linux/videodev2.h>
>>  
>>  #include <mach/serial.h>
>>  #include <mach/edma.h>
>> @@ -26,6 +27,8 @@
>>  #include <mach/pm.h>
>>  #include <mach/spi.h>
>>  
>> +#include <media/davinci/vpif_types.h>
>> +
>>  extern void __iomem *da8xx_syscfg0_base;
>>  extern void __iomem *da8xx_syscfg1_base;
>>  
>> @@ -69,6 +72,7 @@ extern unsigned int da850_max_speed;
>>  #define DA8XX_AEMIF_CS3_BASE	0x62000000
>>  #define DA8XX_AEMIF_CTL_BASE	0x68000000
>>  #define DA8XX_ARM_RAM_BASE	0xffff0000
>> +#define DA8XX_VPIF_BASE		0x01e17000
> 
> These are sorted in increasing order of address. This helps avoid
> duplicates.
> 
 Ok I'll keep them sorted.

Thx,
--Prabhakar

> Thanks,
> Sekhar
> 
