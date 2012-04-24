From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 24 Apr 2012 14:00:19 +0200
Subject: [PATCH V3 07/12] ata/sata_mv: Remove conditional compilation of
 clk code
In-Reply-To: <abbcf661dc58948794839eb0fba1d5a0950ec848.1335266056.git.viresh.kumar@st.com>
References: <cover.1335266056.git.viresh.kumar@st.com>
 <abbcf661dc58948794839eb0fba1d5a0950ec848.1335266056.git.viresh.kumar@st.com>
Message-ID: <20120424120019.GE24089@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -#if defined(CONFIG_HAVE_CLK)
>  	hpriv->clk = clk_get(&pdev->dev, NULL);
> -	if (IS_ERR(hpriv->clk))
> -		dev_notice(&pdev->dev, "cannot get clkdev\n");
> -	else
> -		clk_enable(hpriv->clk);
> -#endif
> +	if (IS_ERR(hpriv->clk)) {
> +		dev_err(&pdev->dev, "cannot get clkdev\n");
> +		return PTR_ERR(hpriv->clk);
> +	}
> +
> +	clk_enable(hpriv->clk);

Sorry, but still wrong.

The clock is optional. If we can find a clock, turn it on. If not,
keep going....

You patch causes the missing clock to become a fatal error.

This sata_mv exists in multiple forms. It can be part of a SoC. It can
also be on a PCI bus. In the PCI form, it is unlikely to have a clk
which can be controlled. When built into a SoC, namely one of the
Orion family, dove, orion5x, mv78xx0 do not have a clock which can be
controlled. However kirkwood does have a clock.

So, kirkwood will provide a clock and expects that sata_mv will turn
it on. All the other ways of using sata_mv will not provide a clock,
but still expect the driver to be happy.

    Andrew
