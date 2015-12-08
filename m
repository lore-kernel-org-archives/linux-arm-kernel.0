From: stanimir.varbanov@linaro.org (Stanimir Varbanov)
Date: Tue, 8 Dec 2015 11:01:04 +0200
Subject: [PATCH v4 1/5] PCI: designware: add memory barrier after enabling
 region
In-Reply-To: <1449149725-27607-2-git-send-email-stanimir.varbanov@linaro.org>
References: <1449149725-27607-1-git-send-email-stanimir.varbanov@linaro.org>
 <1449149725-27607-2-git-send-email-stanimir.varbanov@linaro.org>
Message-ID: <56669C50.9060700@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/03/2015 03:35 PM, Stanimir Varbanov wrote:
> Add 'write memory' barrier after enable region in PCIE_ATU_CR2
> register. The barrier is needed to ensure that the region enable
> request has been reached it's destination at time when we
> read/write to PCI configuration space.
> 
> Without this barrier PCI device enumeration during kernel boot
> is not reliable, and reading configuration space for particular
> PCI device on the bus returns zero aka no device.

Anand, Jingoo, what is your opinion?

> 
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  drivers/pci/host/pcie-designware.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 02a7452bdf23..ed4dc2e2553b 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -164,6 +164,11 @@ static void dw_pcie_prog_outbound_atu(struct pcie_port *pp, int index,
>  	dw_pcie_writel_rc(pp, upper_32_bits(pci_addr), PCIE_ATU_UPPER_TARGET);
>  	dw_pcie_writel_rc(pp, type, PCIE_ATU_CR1);
>  	dw_pcie_writel_rc(pp, PCIE_ATU_ENABLE, PCIE_ATU_CR2);
> +	/*
> +	 * ensure that the ATU enable has been happaned before accessing
> +	 * pci configuration/io spaces through dw_pcie_cfg_[read|write].
> +	 */
> +	wmb();
>  }
>  
>  static struct irq_chip dw_msi_irq_chip = {
> 


-- 
regards,
Stan
