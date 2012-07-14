From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sat, 14 Jul 2012 13:41:55 +0200
Subject: [PATCH V2 6/7] ARM: SPEAr13xx: Add auxdata for Ethernet
 controller.
In-Reply-To: <214127499f10b0099e6f3542e1e879fdd8c1bdcf.1342171151.git.vipulkumar.samar@st.com>
References: <cover.1342171151.git.vipulkumar.samar@st.com>
 <214127499f10b0099e6f3542e1e879fdd8c1bdcf.1342171151.git.vipulkumar.samar@st.com>
Message-ID: <20120714114155.GE4450@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14:53 Fri 13 Jul     , Vipul Kumar Samar wrote:
> Use AUXDATA to pass platform data for Ethernet controller.
> 
> Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>
> ---
>  arch/arm/mach-spear13xx/include/mach/generic.h |    2 +
>  arch/arm/mach-spear13xx/include/mach/spear.h   |    1 +
>  arch/arm/mach-spear13xx/spear1340.c            |   32 +++++++
>  arch/arm/mach-spear13xx/spear13xx.c            |  104 ++++++++++++++++++++++++
>  4 files changed, 139 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-spear13xx/include/mach/generic.h b/arch/arm/mach-spear13xx/include/mach/generic.h
> index dac57fd..8c8fbaa 100644
> --- a/arch/arm/mach-spear13xx/include/mach/generic.h
> +++ b/arch/arm/mach-spear13xx/include/mach/generic.h
> @@ -15,6 +15,7 @@
>  #define __MACH_GENERIC_H
>  
>  #include <linux/dmaengine.h>
> +#include <linux/platform_device.h>
>  #include <asm/mach/time.h>
>  
>  /* Add spear13xx structure declarations here */
> @@ -31,6 +32,7 @@ void __init spear13xx_map_io(void);
>  void __init spear13xx_dt_init_irq(void);
>  void __init spear13xx_l2x0_init(void);
>  bool dw_dma_filter(struct dma_chan *chan, void *slave);
> +int spear13xx_eth_phy_clk_cfg(struct platform_device *pdev);
>  void spear_restart(char, const char *);
>  void spear13xx_secondary_startup(void);
>  
> diff --git a/arch/arm/mach-spear13xx/include/mach/spear.h b/arch/arm/mach-spear13xx/include/mach/spear.h
> index 65f27de..b0b6f91 100644
> --- a/arch/arm/mach-spear13xx/include/mach/spear.h
> +++ b/arch/arm/mach-spear13xx/include/mach/spear.h
> @@ -46,6 +46,7 @@
>  #define DMAC0_BASE				UL(0xEA800000)
>  #define DMAC1_BASE				UL(0xEB000000)
>  #define MCIF_CF_BASE				UL(0xB2800000)
> +#define SPEAR13XX_GETH_BASE			UL(0xE2000000)
>  
>  /* Devices present in SPEAr1310 */
>  #ifdef CONFIG_MACH_SPEAR1310
> diff --git a/arch/arm/mach-spear13xx/spear1340.c b/arch/arm/mach-spear13xx/spear1340.c
> index 81e4ed7..ab282ed 100644
> --- a/arch/arm/mach-spear13xx/spear1340.c
> +++ b/arch/arm/mach-spear13xx/spear1340.c
> @@ -18,6 +18,9 @@
>  #include <linux/delay.h>
>  #include <linux/dw_dmac.h>
>  #include <linux/of_platform.h>
> +#include <linux/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/stmmac.h>
>  #include <asm/hardware/gic.h>
>  #include <asm/mach/arch.h>
>  #include <mach/dma.h>
> @@ -100,6 +103,34 @@ static struct amba_pl011_data uart1_data = {
>  	.dma_rx_param = &uart1_dma_param[1],
>  };
>  
> +/* Ethernet platform data */
> +static struct stmmac_mdio_bus_data mdio0_private_data = {
> +	.bus_id = 0,
> +	.phy_mask = 0,
> +};
> +
> +static struct stmmac_dma_cfg dma0_private_data = {
> +	.pbl = 16,
> +	.fixed_burst = 1,
> +	.burst_len = DMA_AXI_BLEN_ALL,
> +};
> +
> +static struct plat_stmmacenet_data eth_data = {
> +	.bus_id = 0,
> +	.phy_addr = -1,
> +	.interface = PHY_INTERFACE_MODE_RGMII,
> +	.has_gmac = 1,
> +	.enh_desc = 1,
> +	.tx_coe = 1,
> +	.dma_cfg = &dma0_private_data,
> +	.rx_coe = STMMAC_RX_COE_TYPE2,
> +	.bugged_jumbo = 1,
> +	.pmt = 1,
> +	.mdio_bus_data = &mdio0_private_data,
> +	.init = spear13xx_eth_phy_clk_cfg,
> +	.clk_csr = STMMAC_CSR_150_250M,
> +};
sorry I see no reason to do not pass this via DT

I agreed that the pbl is quite sensitive but you do need to pass them via DT

Best Regards,
J.
