From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 4 Oct 2016 14:15:16 +0200
Subject: [PATCH 03/14] ASoC: sun4i-i2s: Add apb reset
In-Reply-To: <2c5abe6578c8e4e841cb59357d88ce397551a593.1475571575.git.mylene.josserand@free-electrons.com>
References: <cover.1475569400.git.mylene.josserand@free-electrons.com>
 <2c5abe6578c8e4e841cb59357d88ce397551a593.1475571575.git.mylene.josserand@free-electrons.com>
Message-ID: <20161004141516.53c6fa8c@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue,  4 Oct 2016 11:46:16 +0200, Myl?ne Josserand wrote:

>  #include <sound/dmaengine_pcm.h>
>  #include <sound/pcm_params.h>
> @@ -589,6 +590,7 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
>  {
>  	struct sun4i_i2s *i2s;
>  	struct resource *res;
> +	struct reset_control *reset_apb;
>  	void __iomem *regs;
>  	int irq, ret;
>  
> @@ -626,7 +628,19 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
>  		dev_err(&pdev->dev, "Can't get our mod clock\n");
>  		return PTR_ERR(i2s->mod_clk);
>  	}
> -	
> +
> +	reset_apb = devm_reset_control_get(&pdev->dev, "apb_reset");

I believe this is a change in the Device Tree binding, since you're
adding support for a new resource. Perhaps the Device Tree binding
documentation should be updated accordingly?

> +	if (IS_ERR(reset_apb)) {
> +		dev_err(&pdev->dev, "Can't get apb reset\n");
> +		return PTR_ERR(i2s->mod_clk);

This should be:

		return PTR_ERR(reset_apb);

> +	}
> +
> +	ret = reset_control_deassert(reset_apb);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Can't deassert apb reset (%d)\n", ret);
> +		return ret;
> +	}

Do you need to re-assert the reset line in the ->remove() hook?

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
