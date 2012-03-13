From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 12 Mar 2012 21:52:46 -0600
Subject: [PATCH v4 2/2] ARM: Exynos: Add device tree support for interrupt
 combiner
In-Reply-To: <1329798806-32482-3-git-send-email-thomas.abraham@linaro.org>
References: <1329798806-32482-1-git-send-email-thomas.abraham@linaro.org>
 <1329798806-32482-3-git-send-email-thomas.abraham@linaro.org>
Message-ID: <20120313035246.6BC8A3E07E4@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 21 Feb 2012 10:03:26 +0530, Thomas Abraham <thomas.abraham@linaro.org> wrote:
> Add device tree based instantiation of the interrupt combiner controller.
> 
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
> @@ -406,13 +432,33 @@ void __init combiner_init(void __iomem *combiner_base, struct device_node *np)
>  
>  	for (i = 0; i < MAX_COMBINER_NR; i++) {
>  		combiner_init_one(i, combiner_base + (i >> 2) * 0x10);
> -		combiner_cascade_irq(i, IRQ_SPI(i));
> +#ifdef CONFIG_OF
> +		irq = np ? irq_of_parse_and_map(np, i) : IRQ_SPI(i);
> +#else
> +		irq = IRQ_SPI(i);
> +#endif

Hmmm, the #ifdef is rather ugly.  I'd rather have an empty
irq_of_parse_and_map() that always returns 0.

The patch series is fine, and you can add my acked-by, but please send
a follow-up patch to clean it up.

Acked-by: Grant Likely <grant.likely@secretlab.ca>
