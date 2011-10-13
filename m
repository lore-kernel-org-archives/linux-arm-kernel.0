From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 13 Oct 2011 13:22:22 -0600
Subject: [PATCH v4 5/8] ARM: pxa: change gpio driver to platform driver
In-Reply-To: <1318478825-17187-6-git-send-email-haojian.zhuang@marvell.com>
References: <1318478825-17187-1-git-send-email-haojian.zhuang@marvell.com>
	<1318478825-17187-6-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <20111013192222.GW18574@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 13, 2011 at 12:07:02PM +0800, Haojian Zhuang wrote:
> Change gpio driver to platform driver and remove the potential
> conflicted name.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>


>  void __init mmp2_init_irq(void)
> @@ -226,3 +225,28 @@ MMP2_DEVICE(sdh1, "sdhci-pxav3", 1, MMC2, 0xd4280800, 0x120);
>  MMP2_DEVICE(sdh2, "sdhci-pxav3", 2, MMC3, 0xd4281000, 0x120);
>  MMP2_DEVICE(sdh3, "sdhci-pxav3", 3, MMC4, 0xd4281800, 0x120);
>  
> +struct resource mmp2_resources_gpio[] = {
> +	{
> +		.start  = 0xd4019000,
> +		.end    = 0xd4019fff,
> +		.name   = "gpio_phys_base",
> +		.flags  = IORESOURCE_MEM,
> +	}, {
> +		.start  = APB_VIRT_BASE + 0x19000,
> +		.end    = APB_VIRT_BASE + 0x19fff,
> +		.name   = "gpio_virtual_base",
> +		.flags  = IORESOURCE_MEM,

This shouldn't be needed.  The driver should ioremap its registers.
Only the physical address should be passed in via a IORESOURCE_MEM
resource.

g.
