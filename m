From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 26 Jul 2018 21:16:37 +0200
Subject: [PATCH 6/7] net: phy: Add pm support to Broadcom iProc mdio mux
 driver
In-Reply-To: <1532630184-29450-7-git-send-email-arun.parameswaran@broadcom.com>
References: <1532630184-29450-1-git-send-email-arun.parameswaran@broadcom.com>
 <1532630184-29450-7-git-send-email-arun.parameswaran@broadcom.com>
Message-ID: <20180726191637.GI10686@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2018 at 11:36:23AM -0700, Arun Parameswaran wrote:
> Add support for suspend and resume to the Broadcom iProc mdio
> mux driver.

> +#ifdef CONFIG_PM_SLEEP
> +static int mdio_mux_iproc_suspend(struct device *dev)
> +{
> +	int i;
> +	struct iproc_mdiomux_desc *md = dev_get_drvdata(dev);
> +
> +	for (i = 0; i < MDIO_NUM_OF_REGS_TO_RESTORE; i++)
> +		md->restore_regs[i] = readl(md->base +
> +					    restore_reg_offsets[i]);
> +
> +	return 0;
> +}
> +
> +static int mdio_mux_iproc_resume(struct device *dev)
> +{
> +	int i;
> +	struct iproc_mdiomux_desc *md = dev_get_drvdata(dev);
> +
> +	for (i = 0; i < MDIO_NUM_OF_REGS_TO_RESTORE; i++)
> +		writel(md->restore_regs[i],
> +		       md->base + restore_reg_offsets[i]);
> +
> +	return 0;
> +}

Hi Arun

Would it not be simpler to just call mdio_mux_iproc_config_clk() on
resume?

	Andrew
