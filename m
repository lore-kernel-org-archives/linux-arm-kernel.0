From: zhiqiang.hou@nxp.com (Z.q. Hou)
Date: Thu, 15 Nov 2018 02:59:48 +0000
Subject: [PATCH 10/23] PCI: mobiveil: fix the INTx process error
In-Reply-To: <20181106131807.29951-11-Zhiqiang.Hou@nxp.com>
References: <20181106131807.29951-1-Zhiqiang.Hou@nxp.com>
 <20181106131807.29951-11-Zhiqiang.Hou@nxp.com>
Message-ID: <AM6PR04MB5781A186E0F6D9C0E7BABAF384DC0@AM6PR04MB5781.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Subrahmanya,

As NXP does not integrate Mobiveil's INTx and MSI interrupt controller, I am unable to test this fix.
Can you help to test this fix?

Thanks,
Zhiqiang
> -----Original Message-----
> From: Z.q. Hou
> Sent: 2018?11?6? 21:20
> To: linux-pci at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> devicetree at vger.kernel.org; linux-kernel at vger.kernel.org;
> bhelgaas at google.com; robh+dt at kernel.org; mark.rutland at arm.com;
> l.subrahmanya at mobiveil.co.in; shawnguo at kernel.org; Leo Li
> <leoyang.li@nxp.com>; lorenzo.pieralisi at arm.com
> Cc: Mingkai Hu <mingkai.hu@nxp.com>; M.h. Lian
> <minghuan.lian@nxp.com>; Xiaowei Bao <xiaowei.bao@nxp.com>; Z.q. Hou
> <zhiqiang.hou@nxp.com>
> Subject: [PATCH 10/23] PCI: mobiveil: fix the INTx process error
> 
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> In the loop block, there is not code change the loop key, this patch updated
> the loop key by re-read the INTx status register.
> 
> This patch also change to clear the handled INTx status.
> 
> Note: Need MV to test this change.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
>  drivers/pci/controller/pcie-mobiveil.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mobiveil.c
> b/drivers/pci/controller/pcie-mobiveil.c
> index d03392940944..884c9f95374d 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -361,6 +361,7 @@ static void mobiveil_pcie_isr(struct irq_desc *desc)
>  	/* Handle INTx */
>  	if (intr_status & PAB_INTP_INTX_MASK) {
>  		shifted_status = csr_readl(pcie, PAB_INTP_AMBA_MISC_STAT);
> +		shifted_status &= PAB_INTP_INTX_MASK;
>  		shifted_status >>= PAB_INTX_START;
>  		do {
>  			for_each_set_bit(bit, &shifted_status, PCI_NUM_INTX) { @@
> -372,12 +373,16 @@ static void mobiveil_pcie_isr(struct irq_desc *desc)
>  					dev_err_ratelimited(dev, "unexpected IRQ,
> INT%d\n",
>  							    bit);
> 
> -				/* clear interrupt */
> -				csr_writel(pcie,
> -					   shifted_status << PAB_INTX_START,
> +				/* clear interrupt handled */
> +				csr_writel(pcie, 1 << (PAB_INTX_START + bit),
>  					   PAB_INTP_AMBA_MISC_STAT);
>  			}
> -		} while ((shifted_status >> PAB_INTX_START) != 0);
> +
> +			shifted_status = csr_readl(pcie,
> +						   PAB_INTP_AMBA_MISC_STAT);
> +			shifted_status &= PAB_INTP_INTX_MASK;
> +			shifted_status >>= PAB_INTX_START;
> +		} while (shifted_status != 0);
>  	}
> 
>  	/* read extra MSI status register */
> --
> 2.17.1
