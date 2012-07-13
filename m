From: viresh.kumar@linaro.org (viresh kumar)
Date: Fri, 13 Jul 2012 11:30:01 +0100
Subject: [PATCH V2 6/7] ARM: SPEAr13xx: Add auxdata for Ethernet
 controller.
In-Reply-To: <214127499f10b0099e6f3542e1e879fdd8c1bdcf.1342171151.git.vipulkumar.samar@st.com>
References: <cover.1342171151.git.vipulkumar.samar@st.com>
 <214127499f10b0099e6f3542e1e879fdd8c1bdcf.1342171151.git.vipulkumar.samar@st.com>
Message-ID: <CAOh2x==ob+N26pJdc1DC8DfOomus1robkj=8DeyVE_ve_L-bAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 13, 2012 at 10:23 AM, Vipul Kumar Samar
<vipulkumar.samar@st.com> wrote:
> Use AUXDATA to pass platform data for Ethernet controller.

> diff --git a/arch/arm/mach-spear13xx/spear1340.c b/arch/arm/mach-spear13xx/spear1340.c

> +static struct plat_stmmacenet_data eth_data = {
> +       .bus_id = 0,
> +       .phy_addr = -1,
> +       .interface = PHY_INTERFACE_MODE_RGMII,
> +       .has_gmac = 1,
> +       .enh_desc = 1,
> +       .tx_coe = 1,
> +       .dma_cfg = &dma0_private_data,
> +       .rx_coe = STMMAC_RX_COE_TYPE2,
> +       .bugged_jumbo = 1,
> +       .pmt = 1,
> +       .mdio_bus_data = &mdio0_private_data,
> +       .init = spear13xx_eth_phy_clk_cfg,
> +       .clk_csr = STMMAC_CSR_150_250M,
> +};
> +
>  /* SATA device registration */
>  static int sata_miphy_init(struct device *dev, void __iomem *addr)
>  {
> @@ -166,6 +197,7 @@ static struct of_dev_auxdata spear1340_auxdata_lookup[] __initdata = {
>         OF_DEV_AUXDATA("snps,spear-ahci", SPEAR1340_SATA_BASE, NULL,
>                         &sata_pdata),
>         OF_DEV_AUXDATA("arm,pl011", SPEAR1340_UART1_BASE, NULL, &uart1_data),
> +       OF_DEV_AUXDATA("st,spear600-gmac", SPEAR13XX_GETH_BASE, NULL, &eth_data),
>         {}
>  };

Adding Stefan and Peppe.

I understand why you can't send all platform data from DT.
Let me elaborate the problem statement

stmmac is used by platforms with and without DT.
- Without DT will pass platform data directly, without any issues.
- With DT have to pass all data, some of that via DT and other without
DT, like routines
  (atleast for now)

For now what I suggest is, update DT support for whatever we can..
i.e. support Maximum
properties there. As finally we will support everything via DT, no
platform data.

Whatever is left, that can't be passed via DT, like routine, pass it
from platform data
and merge both these versions of platform data in driver, keeping DT
ones in priority.

i.e. Whatever is defined in DT properties must come from there and
left outs from
platform data.

--
viresh
