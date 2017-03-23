From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 23 Mar 2017 13:37:44 +0300
Subject: [PATCH v3 1/5] ata: add Palmchip BK3710 PATA controller driver
In-Reply-To: <1490206862-26065-2-git-send-email-b.zolnierkie@samsung.com>
References: <1490206862-26065-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20170322182131epcas1p26b2402ec94ca08d2a6a332579a65e269@epcas1p2.samsung.com>
 <1490206862-26065-2-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <103c435e-206c-aaaa-59ba-1eb2a4f77780@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

On 3/22/2017 9:20 PM, Bartlomiej Zolnierkiewicz wrote:

> Add Palmchip BK3710 PATA controller driver.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
[...]
> diff --git a/drivers/ata/pata_bk3710.c b/drivers/ata/pata_bk3710.c
> new file mode 100644
> index 0000000..1a1223f
> --- /dev/null
> +++ b/drivers/ata/pata_bk3710.c
> @@ -0,0 +1,382 @@
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

    I'd put this close to devm_iorempe_resource() and would probably even get 
rid of 'mem' altogether...

[...]

Acked-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

MBR, Sergei
