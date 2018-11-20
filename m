From: minghuan.lian@nxp.com (M.h. Lian)
Date: Tue, 20 Nov 2018 11:26:55 +0000
Subject: [PATCHv2 19/25] PCI: mobiveil: disabled IB and OB windows set by
 bootloader
In-Reply-To: <20181120092615.11680-20-Zhiqiang.Hou@nxp.com>
References: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
 <20181120092615.11680-20-Zhiqiang.Hou@nxp.com>
Message-ID: <HE1PR0401MB223585063880133513F87A5BE8D90@HE1PR0401MB2235.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>

> -----Original Message-----
> From: Z.q. Hou
> Sent: Tuesday, November 20, 2018 5:28 PM
> To: linux-pci at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> devicetree at vger.kernel.org; linux-kernel at vger.kernel.org;
> bhelgaas at google.com; robh+dt at kernel.org; mark.rutland at arm.com;
> l.subrahmanya at mobiveil.co.in; shawnguo at kernel.org; Leo Li
> <leoyang.li@nxp.com>; lorenzo.pieralisi at arm.com;
> catalin.marinas at arm.com; will.deacon at arm.com
> Cc: Mingkai Hu <mingkai.hu@nxp.com>; M.h. Lian
> <minghuan.lian@nxp.com>; Xiaowei Bao <xiaowei.bao@nxp.com>; Z.q. Hou
> <zhiqiang.hou@nxp.com>
> Subject: [PATCHv2 19/25] PCI: mobiveil: disabled IB and OB windows set by
> bootloader
> 
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Disabled all inbound and outbound windows before set up the windows in
> kernel, in case transactions match the window set by bootloader.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V2:
>  - no change
> 
>  .../controller/mobiveil/pcie-mobiveil-host.c   |  7 +++++++
>  .../pci/controller/mobiveil/pcie-mobiveil.c    | 18 ++++++++++++++++++
>  .../pci/controller/mobiveil/pcie-mobiveil.h    |  2 ++
>  3 files changed, 27 insertions(+)
> 
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> index d1765d572f44..d028cdf31d0e 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> @@ -221,6 +221,13 @@ static int mobiveil_host_init(struct mobiveil_pcie
> *pcie)  {
>  	u32 value, pab_ctrl, type;
>  	struct resource_entry *win;
> +	int i;
> +
> +	/* Disable all inbound/outbound windows */
> +	for (i = 0; i < pcie->apio_wins; i++)
> +		mobiveil_pcie_disable_ob_win(pcie, i);
> +	for (i = 0; i < pcie->ppio_wins; i++)
> +		mobiveil_pcie_disable_ib_win(pcie, i);
> 
>  	/* setup bus numbers */
>  	value = csr_readl(pcie, PCI_PRIMARY_BUS); diff --git
> a/drivers/pci/controller/mobiveil/pcie-mobiveil.c
> b/drivers/pci/controller/mobiveil/pcie-mobiveil.c
> index 370658d6546d..49d471b75925 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil.c
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.c
> @@ -226,3 +226,21 @@ int mobiveil_bringup_link(struct mobiveil_pcie *pcie)
> 
>  	return -ETIMEDOUT;
>  }
> +
> +void mobiveil_pcie_disable_ib_win(struct mobiveil_pcie *pci, int
> +win_num) {
> +	u32 val;
> +
> +	val = csr_readl(pci, PAB_PEX_AMAP_CTRL(win_num));
> +	val &= ~(1 << AMAP_CTRL_EN_SHIFT);
> +	csr_writel(pci, val, PAB_PEX_AMAP_CTRL(win_num)); }
> +
> +void mobiveil_pcie_disable_ob_win(struct mobiveil_pcie *pci, int
> +win_num) {
> +	u32 val;
> +
> +	val = csr_readl(pci, PAB_AXI_AMAP_CTRL(win_num));
> +	val &= ~(1 << WIN_ENABLE_SHIFT);
> +	csr_writel(pci, val, PAB_AXI_AMAP_CTRL(win_num)); }
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> index eb4cb61291a8..81685840b378 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> @@ -171,6 +171,8 @@ void program_ob_windows(struct mobiveil_pcie
> *pcie, int win_num, u64 cpu_addr,
>  			u64 pci_addr, u32 type, u64 size);
>  void program_ib_windows(struct mobiveil_pcie *pcie, int win_num, u64
> cpu_addr,
>  			u64 pci_addr, u32 type, u64 size);
> +void mobiveil_pcie_disable_ob_win(struct mobiveil_pcie *pci, int
> +win_num); void mobiveil_pcie_disable_ib_win(struct mobiveil_pcie *pci,
> +int win_num);
>  u32 csr_read(struct mobiveil_pcie *pcie, u32 off, size_t size);  void
> csr_write(struct mobiveil_pcie *pcie, u32 val, u32 off, size_t size);
> 
> --
> 2.17.1
