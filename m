From: helgaas@kernel.org (Bjorn Helgaas)
Date: Wed, 16 Dec 2015 15:53:04 -0600
Subject: [PATCH v4 3/5] PCI: qcom: Add Qualcomm PCIe controller driver
In-Reply-To: <1449149725-27607-4-git-send-email-stanimir.varbanov@linaro.org>
References: <1449149725-27607-1-git-send-email-stanimir.varbanov@linaro.org>
 <1449149725-27607-4-git-send-email-stanimir.varbanov@linaro.org>
Message-ID: <20151216215304.GB27791@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 03, 2015 at 03:35:22PM +0200, Stanimir Varbanov wrote:
> From: Stanimir Varbanov <svarbanov@mm-sol.com>
> 
> The PCIe driver reuse the Designware common code for host
> and MSI initialization, and also program the Qualcomm
> application specific registers.
> 
> Signed-off-by: Stanimir Varbanov <svarbanov@mm-sol.com>
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  MAINTAINERS                  |    7 +
>  drivers/pci/host/Kconfig     |   10 +
>  drivers/pci/host/Makefile    |    1 +
>  drivers/pci/host/pcie-qcom.c |  624 ++++++++++++++++++++++++++++++++++++++++++

> +#define PCIE20_CAP				0x70
> +#define PCIE20_CAP_LINKCTRLSTATUS		(PCIE20_CAP + 0x10)
> +#define PCIE20_CAP_LINKCTRLSTATUS_LINK_UP	BIT(29)

This looks like it could be referring to a standard PCIe Capability;
could you use the existing PCI_EXP_LNKSTA and PCI_EXP_LNKSTA_DLLLA
symbols here?  And readw() instead of readl()?

> +static int qcom_pcie_enable_link_training(struct qcom_pcie *pcie)
> +{
> +	struct device *dev = pcie->dev;
> +	u32 val;
> +	int ret;
> +
> +	/* enable link training */
> +	val = readl(pcie->elbi + PCIE20_ELBI_SYS_CTRL);
> +	val |= PCIE20_ELBI_SYS_CTRL_LT_ENABLE;
> +	writel(val, pcie->elbi + PCIE20_ELBI_SYS_CTRL);
> +
> +	/* wait for up to 100ms for the link to come up */
> +	ret = readl_poll_timeout(pcie->elbi + PCIE20_ELBI_SYS_STTS, val,
> +				 val & XMLH_LINK_UP, LINKUP_DELAY_US,
> +				 LINKUP_TIMEOUT_US);
> +
> +	if (ret < 0 || !dw_pcie_link_up(&pcie->pp)) {
> +		dev_err(dev, "link initialization failed\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +}

This looks a lot like the *_establish_link() functions in other
DesignWare-based drivers.  Can you make it look even more similar,
e.g., by renaming it to qcom_pcie_establish_link() and maybe moving
some of the PHY functionality here?

readl_poll_timeout() is nice and avoids the hand-coded timeout loop
the other drivers use.  But is there benefit in checking for
XMLH_LINK_UP, or could you simply poll dw_pcie_link_up() like the
others do?  If it's sufficient, I'd prefer using dw_pcie_link_up()
by itself because it's a little more generic.

Bjorn
