From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 13 Oct 2011 13:26:14 -0600
Subject: [PATCH v4 7/8] ARM: pxa: add clk support in gpio driver
In-Reply-To: <1318478825-17187-8-git-send-email-haojian.zhuang@marvell.com>
References: <1318478825-17187-1-git-send-email-haojian.zhuang@marvell.com>
	<1318478825-17187-8-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <20111013192614.GY18574@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 13, 2011 at 12:07:04PM +0800, Haojian Zhuang wrote:
> Support clk in gpio driver. There's no gpio clock in PXA25x and PXA27x.
> So use dummy clk instead. And move the gpio edge initialization into
> gpio driver for arch-mmp.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> @@ -449,6 +461,10 @@ static int __devinit pxa_gpio_probe(struct platform_device *pdev)
>  		__raw_writel(0, c->regbase + GFER_OFFSET);
>  		__raw_writel(0, c->regbase + GRER_OFFSET);
>  		__raw_writel(~0,c->regbase + GEDR_OFFSET);
> +#ifdef CONFIG_ARCH_MMP
> +		/* unmask GPIO edge detect for AP side */
> +		__raw_writel(~0,c->regbase + ED_MASK_OFFSET);
> +#endif

What will happen on a PXA platform when both CONFIG_ARM_MMP and
CONFIG_ARM_PXA are enabled?

Otherwise the patch looks good.

g.


>  	}
>  
>  #ifdef CONFIG_ARCH_PXA
> diff --git a/include/linux/gpio-pxa.h b/include/linux/gpio-pxa.h
> index 6cebf6c..dd47850 100644
> --- a/include/linux/gpio-pxa.h
> +++ b/include/linux/gpio-pxa.h
> @@ -14,6 +14,7 @@ struct pxa_gpio_regs {
>  	u32	gfer;
>  	u32	gedr;
>  	u32	gafr;
> +	u32	ed_mask;
>  };
>  
>  /*
> -- 
> 1.7.2.5
> 
