From: tj@kernel.org (Tejun Heo)
Date: Fri, 27 Sep 2013 09:14:41 -0400
Subject: [v1] ahci: imx: setup power saving methods
In-Reply-To: <1380269265-10821-2-git-send-email-Hong-Xing.Zhu@freescale.com>
References: <1380269265-10821-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1380269265-10821-2-git-send-email-Hong-Xing.Zhu@freescale.com>
Message-ID: <20130927131441.GA3205@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, Sep 27, 2013 at 04:07:45PM +0800, Richard Zhu wrote:
> +config AHCI_IMX_PHY_POWER_DOWN_MODE
> +	bool "Power saving mode when there is no SATA DEV detected on the port"
> +	depends on AHCI_IMX
> +	help
> +	  This option enable the power down mode of the imx ahci when there is
> +	  no sata device detected on the port, the sata port wouldn't be
> +	  functional anymore except one system power down, and power up again.

The last part of the sentence is a bit difficult to understand.  Also,
I'm not sure whether making this a build option is a good idea.
Please read on.

> @@ -105,6 +110,36 @@ static int imx6q_sata_init(struct device *dev, void __iomem *mmio)
>  	reg_val = clk_get_rate(imxpriv->ahb_clk) / 1000;
>  	writel(reg_val, mmio + HOST_TIMER1MS);
>  
> +	if (IS_ENABLED(CONFIG_AHCI_IMX_PHY_POWER_DOWN_MODE)) {
> +		/*
> +		 * In order to save power consumption, enter PDDQ mode
> +		 * when there is no device detected on the port
> +		 */
> +		do {
> +			sstatus = readl(mmio + 0x100 + PORT_SCR_STAT);
> +			if ((sstatus & 0xF) == 0)
> +				usleep_range(1000, 2000);
> +			else
> +				break;
> +
> +			if (iterations == 0) {
> +				pr_info("No sata disk.\n");
> +				reg_val = readl(mmio + PORT_PHY_CTL);
> +				writel(reg_val | PORT_PHY_CTL_PDDQ_LOC,
> +						mmio + PORT_PHY_CTL);
> +				regmap_update_bits(imxpriv->gpr, IOMUXC_GPR13,
> +						IMX6Q_GPR13_SATA_MPLL_CLK_EN,
> +						!IMX6Q_GPR13_SATA_MPLL_CLK_EN);
> +				clk_disable_unprepare(imxpriv->sata_ref_clk);
> +				imxpriv->no_device = 1;
> +
> +				return 0;
> +			}
> +		} while (iterations-- > 0);
> +	} else {
> +		imxpriv->no_device = 0;
> +	}

This looks like it really should be part of lpm framework.  Allow the
ahci_platform driver to override set_lpm() and turning off PHY if
MIN_POWER && !dev should work, right?

Thanks.

-- 
tejun
