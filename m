From: sean.wang@kernel.org (Sean Wang)
Date: Thu, 22 Nov 2018 23:04:09 -0800
Subject: [v5, PATCH 1/2] net:stmmac: dwmac-mediatek: add support for mt2712
In-Reply-To: <1542939448.24219.95.camel@mhfsdcap03>
References: <1542882521-18874-1-git-send-email-biao.huang@mediatek.com>
 <1542882521-18874-2-git-send-email-biao.huang@mediatek.com>
 <CAGp9LzoJTVm4OP+SRWCDk0TUmU5jNMFCsT_yyURXzXxjTF+-=g@mail.gmail.com>
 <1542939448.24219.95.camel@mhfsdcap03>
Message-ID: <CAGp9LzrdwXqQ+aHtCoKcxKx28xR21hKnpc+ruW4Gt7TyQLffsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

< ... >

> > > +       /* select phy interface in top control domain */
> > > +       switch (plat->phy_mode) {
> > > +       case PHY_INTERFACE_MODE_MII:
> > > +               intf_val |= PHY_INTF_MII_GMII;
> > > +               break;
> > > +       case PHY_INTERFACE_MODE_RMII:
> > > +               intf_val |= PHY_INTF_RMII;
> > > +               intf_val |= rmii_rxc;
> > how about putting into one line such as intf_val |= (PHY_INTF_RMII | rmii_rxc) ?
> >
> ok, will change in next version.
> > > +               break;
> > > +       case PHY_INTERFACE_MODE_RGMII:
> > > +       case PHY_INTERFACE_MODE_RGMII_TXID:
> > > +       case PHY_INTERFACE_MODE_RGMII_RXID:
> > > +       case PHY_INTERFACE_MODE_RGMII_ID:
> > > +               intf_val |= PHY_INTF_RGMII;
> > > +               break;
> > > +       default:
> > > +               dev_err(plat->dev, "phy interface not supported\n");
> > > +               return -EINVAL;
> > > +       }
> > > +
> > > +       regmap_write(plat->peri_regmap, PERI_ETH_PHY_INTF_SEL, intf_val);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int mt2712_set_delay(struct mediatek_dwmac_plat_data *plat)
> > > +{
> > > +       struct mac_delay_struct *mac_delay = &plat->mac_delay;
> > > +       u32 delay_val = 0;
> > > +       u32 fine_val = 0;
> > The same type declaration can be put into the one line
> >
> Got it.
> > > +
> > > +       switch (plat->phy_mode) {
> >
> > There exists some room for code optimization in the switch statement
> > such as PHY_INTERFACE_MODE_MII and PHY_INTERFACE_MODE_RGMII both are
> > almost the same and even the configuration for the other PHY modes can
> > reuse their partial setup. It appears to be better using a common way
> > to set up various PHY modes.
> >
> I'll try define a function to handle it.
> And how about like this:
>         static u32 delay_setting(u32 delay, bool inv, u32 en_bit, u32
> clk_shift, u32 clk_mask, u32 inv_bit) {
>                 u32 value = 0
>
>                 value |= delay ? en_bit : 0;
>                 value |= (delay << clk_shift) & clk_mask;
>                 value |= inv ? inv_bit : 0;
>         }
>
>         case PHY_INTERFACE_MODE_MII:
>                 delay_value |= delay_setting(mac_delay->tx_delay,
>                                              mac_delay->tx_inv,
>                                              PHY_DLY_TXC_ENABLE,
>                                              PHY_DLY_TXC_SHIFT,
>                                              PHY_DLY_TXC_STAGES,
>                                              PHY_DLY_TXC_INV);

We can reuse FIELD_PREP defined in include/linux/bitfield.h to make up
of the value instead of creating your own function delay_setting here,
 and also PHY_DLY_TXC_SHIFT macro can be trimmed while you're using
FIED_PREP

>                 delay_value |= delay_setting(mac_delay->rx_delay,
>                                              mac_delay->rx_inv,
>                                              PHY_DLY_RXC_ENABLE,
>                                              PHY_DLY_RXC_SHIFT,
>                                              PHY_DLY_RXC_STAGES,
>                                              PHY_DLY_RXC_INV);
>
>         case PHY_INTERFACE_MODE_RMII:
>                 if (plat->rmii_rxc) {
>                      delay_value |= delay_setting(mac_delay->rx_delay,
>                                                  mac_delay->rx_inv,
>                                                  PHY_DLY_RXC_ENABLE,
>                                                  PHY_DLY_RXC_SHIFT,
>                                                  PHY_DLY_RXC_STAGES,
>                                                  PHY_DLY_RXC_INV);
>                     fine_val |= mac_delay->tx_inv ?
>                                    ETH_RMII_DLY_TX_INV : 0;
>                 } else {
>                      delay_value |= delay_setting(mac_delay->rx_delay,
>                                                  mac_delay->rx_inv,

shoudn't the parametors be mac_delay->tx_delay and mac_delay->tx_inv?

>                                                  PHY_DLY_TXC_ENABLE,
>                                                  PHY_DLY_TXC_SHIFT,
>                                                  PHY_DLY_TXC_STAGES,
>                                                  PHY_DLY_TXC_INV);
>                     fine_val |= mac_delay->tx_inv ?
>                                    ETH_RMII_DLY_TX_INV : 0;

if (plat->tx_inv)
      fine_val = ETH_RMII_DLY_TX_INV;
the default fine_val is zero so zero assignement can be trimmed when
!plat-> tx_inv

>                 }
>         case PHY_INTERFACE_MODE_RGMII:
>               fine_val = plat->fine_tune ?
>                           (ETH_FINE_DLY_GTXC | ETH_FINE_DLY_RXC) : 0;

if (plat->fine_tune)
      fine_val = ETH_FINE_DLY_GTXC | ETH_FINE_DLY_RXC;
the default fine_val is zero so zero assignement can be trimmed when
!plat->fine_tune

>               delay_value |= delay_setting(mac_delay->tx_delay,
>                                            mac_delay->tx_inv,
>                                            PHY_DLY_GTXC_ENABLE,
>                                            PHY_DLY_GTXC_SHIFT,
>                                            PHY_DLY_GTXC_STAGES,
>                                            PHY_DLY_GTXC_INV);
>              delay_value |= delay_setting(mac_delay->rx_delay,
>                                            mac_delay->rx_inv,
>                                            PHY_DLY_RXC_ENABLE,
>                                            PHY_DLY_RXC_SHIFT,
>                                            PHY_DLY_RXC_STAGES,
>                                            PHY_DLY_RXC_INV);
>         case PHY_INTERFACE_MODE_RGMII_TXID:
>               fine_val = plat->fine_tune ? ETH_FINE_DLY_RXC : 0;
>               delay_value |= delay_setting(mac_delay->rx_delay,
>                                            mac_delay->rx_inv,
>                                            PHY_DLY_RXC_ENABLE,
>                                            PHY_DLY_RXC_SHIFT,
>                                            PHY_DLY_RXC_STAGES,
>                                            PHY_DLY_RXC_INV);
>         case PHY_INTERFACE_MODE_RGMII_RXID:
>               fine_val = plat->fine_tune ? ETH_FINE_DLY_GTXC : 0;
>               delay_value |= delay_setting(mac_delay->tx_delay,
>                                            mac_delay->tx_inv,
>                                            PHY_DLY_GTXC_ENABLE,
>                                            PHY_DLY_GTXC_SHIFT,
>                                            PHY_DLY_GTXC_STAGES,
>                                            PHY_DLY_GTXC_INV);
>

phy_mode is used to indicate what phy mode would be tweaked when mac
is connected to the phy so I thought mac delay can be independent from
phy internal delay  that means PHY_INTERFACE_MODE_RGMII_RXID and
PHY_INTERFACE_MODE_RGMII_TXID can apply the same setting as
PHY_INTERFACE_MODE_RGMII does.

> > > +       case PHY_INTERFACE_MODE_MII:
> > > +               delay_val |= mac_delay->tx_delay ? PHY_DLY_TXC_ENABLE : 0;
> > > +               delay_val |= (mac_delay->tx_delay << PHY_DLY_TXC_SHIFT) &
> > > +                            PHY_DLY_TXC_STAGES;
> > > +               delay_val |= mac_delay->tx_inv ? PHY_DLY_TXC_INV : 0;
> > > +               delay_val |= mac_delay->rx_delay ? PHY_DLY_RXC_ENABLE : 0;
> > > +               delay_val |= (mac_delay->rx_delay << PHY_DLY_RXC_SHIFT) &
> > > +                            PHY_DLY_RXC_STAGES;
> > > +               delay_val |= mac_delay->rx_inv ? PHY_DLY_RXC_INV : 0;
> > > +               break;
> > > +       case PHY_INTERFACE_MODE_RMII:
> > > +               if (plat->rmii_rxc) {
> > > +                       delay_val |= mac_delay->rx_delay ?
> > > +                                    PHY_DLY_RXC_ENABLE : 0;
> > > +                       delay_val |= (mac_delay->rx_delay <<
> > > +                                     PHY_DLY_RXC_SHIFT) & PHY_DLY_RXC_STAGES;
> > > +                       delay_val |= mac_delay->rx_inv ? PHY_DLY_RXC_INV : 0;
> > > +                       fine_val |= mac_delay->tx_inv ?
> > > +                                    ETH_RMII_DLY_TX_INV : 0;
> > why is fine_val got from tx_inv?
> >
> becase the tx inv will inverse the tx clock inside mac relative to
> reference clock from external phy, and this bit is located in the same
> register with fine-tune.
> maybe I should rename fine_val to avoid misunderstanding.

If you add more comments to say that, fine_val remains would be okay

> > > +               } else {
> > > +                       delay_val |= mac_delay->rx_delay ?
> > > +                                    PHY_DLY_TXC_ENABLE : 0;
> > > +                       delay_val |= (mac_delay->rx_delay <<
> > > +                                    PHY_DLY_TXC_SHIFT) & PHY_DLY_TXC_STAGES;
> > > +                       delay_val |= mac_delay->rx_inv ? PHY_DLY_TXC_INV : 0;
> > > +                       fine_val |= mac_delay->tx_inv ?
> > > +                                    ETH_RMII_DLY_TX_INV : 0;
> > ditto, why is fine_val got from tx_inv?
> >
> same as above. ETH_RMII_DLY_TX_INV is only for RMII, and located in the
> same register with fine-tune.

adding a fewer comments helps to avoid some confusion

> > > +               }
> > > +               break;
> > > +       case PHY_INTERFACE_MODE_RGMII:
> > > +               fine_val = plat->fine_tune ?
> > > +                           (ETH_FINE_DLY_GTXC | ETH_FINE_DLY_RXC) : 0;
> > > +               delay_val |= mac_delay->tx_delay ? PHY_DLY_GTXC_ENABLE : 0;
> > > +               delay_val |= mac_delay->tx_delay & PHY_DLY_GTXC_STAGES;
> > > +               delay_val |= mac_delay->tx_inv ? PHY_DLY_GTXC_INV : 0;
> > > +               delay_val |= mac_delay->rx_delay ? PHY_DLY_RXC_ENABLE : 0;
> > > +               delay_val |= (mac_delay->rx_delay << PHY_DLY_RXC_SHIFT) &
> > > +                            PHY_DLY_RXC_STAGES;
> > > +               delay_val |= mac_delay->rx_inv ? PHY_DLY_RXC_INV : 0;
> > > +               break;
> > > +       case PHY_INTERFACE_MODE_RGMII_TXID:
> > > +               fine_val = plat->fine_tune ? ETH_FINE_DLY_RXC : 0;
> > > +               delay_val |= mac_delay->rx_delay ? PHY_DLY_RXC_ENABLE : 0;
> > > +               delay_val |= (mac_delay->rx_delay << PHY_DLY_RXC_SHIFT) &
> > > +                            PHY_DLY_RXC_STAGES;
> > > +               delay_val |= mac_delay->rx_inv ? PHY_DLY_RXC_INV : 0;
> > why is PHY_INTERFACE_MODE_RGMII_TXID applied with *_RXC_* register
> > bits, not with *_TXC_* bits? I'm a little confused about what path the
> > register PHY_DLY_RXC_* cause the effects to? MAC to PHY or PHY to MAC?
> >
> The PHY_INTERFACE_MODE_RGMII_TXID is defined in
> Documentation/networking/phy.txt
> means phy will handle delay in tx path, so mac need handle delay in rx
> path here.

See the above explains: phy_mode is used to indicate what phy mode
would be tweaked when mac is connected to the phy so I thought mac
delay can be independent of phy internal delay that means
PHY_INTERFACE_MODE_RGMII_RXID and PHY_INTERFACE_MODE_RGMII_TXID can
apply the same setting as PHY_INTERFACE_MODE_RGMII does.

> > > +               break;
> > > +       case PHY_INTERFACE_MODE_RGMII_RXID:
> > > +               fine_val = plat->fine_tune ? ETH_FINE_DLY_GTXC : 0;
> > > +               delay_val |= mac_delay->tx_delay ? PHY_DLY_GTXC_ENABLE : 0;
> > > +               delay_val |= mac_delay->tx_delay & PHY_DLY_GTXC_STAGES;
> > > +               delay_val |= mac_delay->tx_inv ? PHY_DLY_GTXC_INV : 0;
> > ditto, as the above quetion
> >
> Similar answer as above.
> > > +               break;
> > > +       case PHY_INTERFACE_MODE_RGMII_ID:
> > > +               break;
> > > +       default:
> > > +               dev_err(plat->dev, "phy interface not supported\n");
> > > +               return -EINVAL;
> > > +       }
> > > +       regmap_write(plat->peri_regmap, PERI_ETH_PHY_DLY, delay_val);
> > > +       regmap_write(plat->peri_regmap, PERI_ETH_DLY_FINE, fine_val);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static const struct mediatek_dwmac_variant mt2712_gmac_variant = {
> > > +               .dwmac_set_phy_interface = mt2712_set_interface,
> > > +               .dwmac_set_delay = mt2712_set_delay,
> > > +               .clk_list = mt2712_dwmac_clk_l,
> > > +               .num_clks = ARRAY_SIZE(mt2712_dwmac_clk_l),
> > > +               .dma_bit_mask = 33,
> > > +               .rx_delay_max = 32,
> > > +               .tx_delay_max = 32,
> > > +};
> > > +
> > > +static int mediatek_dwmac_config_dt(struct mediatek_dwmac_plat_data *plat)
> > > +{
> > > +       u32 tx_delay, rx_delay;
> > > +
> > > +       plat->peri_regmap = syscon_regmap_lookup_by_phandle(plat->np, "mediatek,pericfg");

you're also missing the property definition in dt-binding.

> > > +       if (IS_ERR(plat->peri_regmap)) {
> > > +               dev_err(plat->dev, "Failed to get pericfg syscon\n");
> > > +               return PTR_ERR(plat->peri_regmap);
> > > +       }
> > > +
> > > +       plat->phy_mode = of_get_phy_mode(plat->np);
> > > +       if (plat->phy_mode < 0) {
> > > +               dev_err(plat->dev, "not find phy-mode\n");
> > > +               return -EINVAL;
> > > +       }
> > > +
> > > +       if (!of_property_read_u32(plat->np, "mediatek,tx-delay", &tx_delay)) {
> > > +               if (tx_delay < plat->variant->tx_delay_max) {
> > > +                       plat->mac_delay.tx_delay = tx_delay;
> > > +               } else {
> > > +                       dev_err(plat->dev, "Invalid TX clock delay: %d\n", tx_delay);
> > > +                       return -EINVAL;
> > > +               }
> > > +       }
> > > +
> > > +       if (!of_property_read_u32(plat->np, "mediatek,rx-delay", &rx_delay)) {
> > > +               if (rx_delay < plat->variant->rx_delay_max) {
> > > +                       plat->mac_delay.rx_delay = rx_delay;
> > > +               } else {
> > > +                       dev_err(plat->dev, "Invalid RX clock delay: %d\n", rx_delay);
> > > +                       return -EINVAL;
> > > +               }
> > > +       }
> > > +
> > > +       plat->mac_delay.tx_inv = of_property_read_bool(plat->np, "mediatek,txc-inverse");
> > > +       plat->mac_delay.rx_inv = of_property_read_bool(plat->np, "mediatek,rxc-inverse");
> > > +       plat->fine_tune = of_property_read_bool(plat->np, "mediatek,fine-tune");
> > > +       plat->rmii_rxc = of_property_read_bool(plat->np, "mediatek,rmii-rxc");
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int mediatek_dwmac_clk_init(struct mediatek_dwmac_plat_data *plat)
> > > +{
> > > +       const struct mediatek_dwmac_variant *variant = plat->variant;
> > > +       int num = variant->num_clks;
> > > +       int i;
> > put into the same line seems good
> >
> ok
> > > +
> > > +       plat->clks = devm_kcalloc(plat->dev, num, sizeof(*plat->clks), GFP_KERNEL);
> > > +       if (!plat->clks)
> > > +               return -ENOMEM;
> > > +
> > > +       for (i = 0; i < num; i++)
> > > +               plat->clks[i].id = variant->clk_list[i];
> > > +
> > > +       return devm_clk_bulk_get(plat->dev, num, plat->clks);
> > > +}
> > > +
> > > +static int mediatek_dwmac_init(struct platform_device *pdev, void *priv)
> > > +{
> > > +       struct mediatek_dwmac_plat_data *plat = priv;
> > > +       const struct mediatek_dwmac_variant *variant = plat->variant;
> > > +       int ret = 0;
> > zero initialized seems unnecessary
> >
> ok, will not initialized here
> > > +
> > > +       ret = dma_set_mask_and_coherent(plat->dev, DMA_BIT_MASK(variant->dma_bit_mask));
> > > +       if (ret) {
> > > +               dev_err(plat->dev, "No suitable DMA available, err = %d\n", ret);
> > > +               return ret;
> > > +       }
> > > +
> > > +       ret = variant->dwmac_set_phy_interface(plat);
> > > +       if (ret) {
> > > +               dev_err(plat->dev, "failed to set phy interface, err = %d\n", ret);
> > > +               return ret;
> > > +       }
> > > +
> > > +       ret = variant->dwmac_set_delay(plat);
> > > +       if (ret) {
> > > +               dev_err(plat->dev, "failed to set delay value, err = %d\n", ret);
> > > +               return ret;
> > > +       }
> > > +
> > > +       ret = clk_bulk_prepare_enable(variant->num_clks, plat->clks);
> > > +       if (ret) {
> > > +               dev_err(plat->dev, "failed to enable clks, err = %d\n", ret);
> > > +               return ret;
> > > +       }
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static void mediatek_dwmac_exit(struct platform_device *pdev, void *priv)
> > > +{
> > > +       struct mediatek_dwmac_plat_data *plat = priv;
> > > +       const struct mediatek_dwmac_variant *variant = plat->variant;
> > > +
> > > +       clk_bulk_disable_unprepare(variant->num_clks, plat->clks);
> > > +}
> > > +
> > > +static int mediatek_dwmac_probe(struct platform_device *pdev)
> > > +{
> > > +       struct mediatek_dwmac_plat_data *priv_plat;
> > > +       struct plat_stmmacenet_data *plat_dat;
> > > +       struct stmmac_resources stmmac_res;
> > > +       int ret = 0;
> > zero initialized seems unnecessary
> >
> ok, will not initialized here
> > > +
> > > +       priv_plat = devm_kzalloc(&pdev->dev, sizeof(*priv_plat), GFP_KERNEL);
> > > +       if (!priv_plat)
> > > +               return -ENOMEM;
> > > +
> > > +       priv_plat->variant = of_device_get_match_data(&pdev->dev);
> > > +       if (!priv_plat->variant) {
> > > +               dev_err(&pdev->dev, "Missing dwmac-mediatek variant\n");
> > > +               return -EINVAL;
> > > +       }
> > > +
> > > +       priv_plat->dev = &pdev->dev;
> > > +       priv_plat->np = pdev->dev.of_node;
> > > +
> > > +       ret = mediatek_dwmac_config_dt(priv_plat);
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       ret = mediatek_dwmac_clk_init(priv_plat);
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       ret = stmmac_get_platform_resources(pdev, &stmmac_res);
> > > +       if (ret)
> > > +               return ret;
> > > +

< ... >
