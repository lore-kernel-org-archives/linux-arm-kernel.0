From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 18 Mar 2017 16:52:18 +0300
Subject: [PATCH v2 1/3] ata: add Palmchip BK3710 PATA controller driver
In-Reply-To: <1489509414-11491-2-git-send-email-b.zolnierkie@samsung.com>
References: <1489509414-11491-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20170314163742epcas5p32a49df6b4ae6c21ee159c79320df5781@epcas5p3.samsung.com>
 <1489509414-11491-2-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <bc9a2d9b-1f16-4b59-0033-235686c76dcb@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

On 3/14/2017 7:36 PM, Bartlomiej Zolnierkiewicz wrote:

> Add Palmchip BK3710 PATA controller driver.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
[...]
> diff --git a/drivers/ata/pata_bk3710.c b/drivers/ata/pata_bk3710.c
> new file mode 100644
> index 0000000..6d77217
> --- /dev/null
> +++ b/drivers/ata/pata_bk3710.c
> @@ -0,0 +1,386 @@
[...]
> +static void pata_bk3710_chipinit(void __iomem *base)
> +{
[...]
> +	/*
> +	 * IORDYTMP IORDY Timer for Primary Register
> +	 * (ATA_IORDYTMP_IORDYTMP     , 0xffff  )
> +	 */
> +	iowrite32(0xFFFF, base + BK3710_IORDYTMP);

    As I've already said, this is useless as we don't handle the IORDY timeout 
interrupt anyway; writing 0 would be fine.

> +
> +	/*
> +	 * Configure BMISP Register
> +	 * (ATA_BMISP_DMAEN1	, DISABLE )	|
> +	 * (ATA_BMISP_DMAEN0	, DISABLE )	|
> +	 * (ATA_BMISP_IORDYINT	, CLEAR)	|
> +	 * (ATA_BMISP_INTRSTAT	, CLEAR)	|
> +	 * (ATA_BMISP_DMAERROR	, CLEAR)
> +	 */
> +	iowrite16(0, base + BK3710_BMISP);

    Bits 0-3 cane only be cleared by writing 1, so this write can't clear 
them, contrary to what the comment says. Might be a material for a follow-up 
patch tho...

[...]
> +static int __init pata_bk3710_probe(struct platform_device *pdev)
> +{
> +	struct clk *clk;
> +	struct resource *mem;
> +	struct ata_host *host;
> +	struct ata_port *ap;
> +	void __iomem *base;
> +	unsigned long rate;
> +	int irq;
> +
> +	clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(clk))
> +		return -ENODEV;
> +
> +	clk_enable(clk);
> +	rate = clk_get_rate(clk);
> +	if (!rate)
> +		return -EINVAL;
> +
> +	/* NOTE:  round *down* to meet minimum timings; we count in clocks */
> +	ideclk_period = 1000000000UL / rate;
> +
> +	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (mem == NULL) {
> +		pr_err(DRV_NAME ": failed to get memory region resource\n");
> +		return -ENODEV;
> +	}

    NULL check not needed here, devm_ioremap_resource() checks this anyway.

> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		pr_err(DRV_NAME ": failed to get IRQ resource\n");
> +		return irq;
> +	}
> +
> +	base = devm_ioremap_resource(&pdev->dev, mem);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
[...]
> +/* work with hotplug and coldplug */
> +MODULE_ALIAS("platform:palm_bk3710");
> +
> +static struct platform_driver pata_bk3710_driver = {
> +	.driver = {
> +		.name = "palm_bk3710",

    Not DRV_NAME?

[...]

MBR, Sergei
