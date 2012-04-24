From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 24 Apr 2012 09:04:26 +0200
Subject: [PATCH V2 4/9] ata/sata_mv: Remove conditional compilation of clk code
Message-ID: <20120424070426.GA24089@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Viresh

> With addition of dummy clk_*() calls for non CONFIG_HAVE_CLK cases in clk.h,
> there is no need to have clk code enclosed in #ifdef CONFIG_HAVE_CLK, #endif
> macros.
> 
> ...
> 
> -#if defined(CONFIG_HAVE_CLK)
>         hpriv->clk = clk_get(&pdev->dev, NULL);
>         if (IS_ERR(hpriv->clk))
>                 dev_notice(&pdev->dev, "cannot get clkdev\n");
>         else
>                 clk_enable(hpriv->clk);
> -#endif

I don't think this change is correct. With the old semantics, it was:

If we have CLK support, we expect there to be a clock for sata_mv, and
if there is no such clock, output a notice message, something is
probably wrong, i expected there to be a clock.

The new semantics are:

We expect there to be a clock for sata_mv, and if there is no such
clock, output a notice message, something is probably wrong, i
expected there to be a clock.

We are going to see this notice message much more, when it is not
expected.

	Andrew
