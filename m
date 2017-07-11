From: al.cooper@broadcom.com (Al Cooper)
Date: Tue, 11 Jul 2017 18:12:14 -0400
Subject: [PATCH v3 3/4] phy: usb: phy-brcm-usb: Add Broadcom STB USB phy
 driver
In-Reply-To: <2cdd9fa8-163b-260d-f8e5-193d56d7d0a8@ti.com>
References: <1498575553-19311-1-git-send-email-alcooperx@gmail.com>
 <1498575553-19311-4-git-send-email-alcooperx@gmail.com>
 <2cdd9fa8-163b-260d-f8e5-193d56d7d0a8@ti.com>
Message-ID: <CAGh=XACnRDLpz1Ab-2dpMW9tiEPECVojxpxjF131m+b3pBvi=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 11, 2017 at 5:41 AM, 'Kishon Vijay Abraham I' via
BCM-KERNEL-FEEDBACK-LIST,PDL
<bcm-kernel-feedback-list.pdl@broadcom.com> wrote:
>
> Hi,
>
> > diff --git a/drivers/phy/broadcom/phy-brcm-usb-init.h b/drivers/phy/broadcom/phy-brcm-usb-init.h
> > new file mode 100644
> > index 0000000..2c5f10a
> > --- /dev/null
> > +++ b/drivers/phy/broadcom/phy-brcm-usb-init.h
> > @@ -0,0 +1,95 @@
> > +/*
> > + * Copyright (C) 2014-2017 Broadcom
> > + *
> > + * This software is licensed under the terms of the GNU General Public
> > + * License version 2, as published by the Free Software Foundation, and
> > + * may be copied, distributed, and modified under those terms.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + */
> > +
> > +#ifndef _USB_BRCM_COMMON_INIT_H
> > +#define _USB_BRCM_COMMON_INIT_H
> > +
> > +#define USB_CTLR_MODE_HOST 0
> > +#define USB_CTLR_MODE_DEVICE 1
> > +#define USB_CTLR_MODE_DRD 2
> > +#define USB_CTLR_MODE_TYPEC_PD 3
> > +
> > +struct  brcm_usb_init_params;
> > +
> > +struct brcm_usb_init_ops {
> > +     void (*init_ipp)(struct brcm_usb_init_params *params);
> > +     void (*init_common)(struct brcm_usb_init_params *params);
> > +     void (*init_eohci)(struct brcm_usb_init_params *params);
> > +     void (*init_xhci)(struct brcm_usb_init_params *params);
> > +     void (*uninit_common)(struct brcm_usb_init_params *params);
> > +     void (*uninit_eohci)(struct brcm_usb_init_params *params);
> > +     void (*uninit_xhci)(struct brcm_usb_init_params *params);
> > +};
> > +
> > +struct  brcm_usb_init_params {
> > +     void __iomem *ctrl_regs;
> > +     void __iomem *xhci_ec_regs;
> > +     int ioc;
> > +     int ipp;
> > +     int mode;
> > +     u32 family_id;
> > +     u32 product_id;
> > +     int selected_family;
> > +     const char *family_name;
> > +     const u32 *usb_reg_bits_map;
> > +     const struct brcm_usb_init_ops *ops;
> > +};
> > +
> > +void brcm_usb_set_family_map(struct brcm_usb_init_params *params);
> > +int brcm_usb_init_get_dual_select(struct brcm_usb_init_params *params);
> > +void brcm_usb_init_set_dual_select(struct brcm_usb_init_params *params,
> > +                             int mode);
> > +
> > +static inline void brcm_usb_init_ipp(struct brcm_usb_init_params *ini)
> > +{
> > +     if (ini->ops->init_ipp)
> > +             ini->ops->init_ipp(ini);
> > +}
> > +
> > +static inline void brcm_usb_init_common(struct brcm_usb_init_params *ini)
> > +{
> > +     if (ini->ops->init_common)
> > +             ini->ops->init_common(ini);
> > +}
> > +
> > +static inline void brcm_usb_init_eohci(struct brcm_usb_init_params *ini)
> > +{
> > +     if (ini->ops->init_eohci)
> > +             ini->ops->init_eohci(ini);
> > +}
> > +
> > +static inline void brcm_usb_init_xhci(struct brcm_usb_init_params *ini)
> > +{
> > +     if (ini->ops->init_xhci)
> > +             ini->ops->init_xhci(ini);
> > +}
> > +
> > +static inline void brcm_usb_uninit_common(struct brcm_usb_init_params *ini)
> > +{
> > +     if (ini->ops->uninit_common)
> > +             ini->ops->uninit_common(ini);
> > +}
> > +
> > +static inline void brcm_usb_uninit_eohci(struct brcm_usb_init_params *ini)
> > +{
> > +     if (ini->ops->uninit_eohci)
> > +             ini->ops->uninit_eohci(ini);
> > +}
> > +
> > +static inline void brcm_usb_uninit_xhci(struct brcm_usb_init_params *ini)
> > +{
> > +     if (ini->ops->uninit_xhci)
> > +             ini->ops->uninit_xhci(ini);
> > +}
>
> I'm not sure if we need all this callback ops since arm and mips really doesn't
> have a different set of ops. mips only have few ops missing. That can be
> managed with a flag IMO.

Now that I look at how little there is in common between our ARM and
MIPS, I'm going to remove the MIPS support and add a separate, much
smaller, MIPS driver later.

> > +
> > +     priv->ini.family_id = brcmstb_get_family_id();
> > +     priv->ini.product_id = brcmstb_get_product_id();
>
> These APIs can be invoked only if CONFIG_SOC_BRCMSTB is set right?
> Can't we get these ids directly from device tree?

These routines get the family and product id out of device tree. These
are common to all brcmstb SOCs. We have various drivers that need to
do this so it seems better to have this functionality in a single
separate function than have each driver with the same code.
I'll have the Kconfig selection for this phy set CONFIG_SOC_BRCMSTB

> > +
> > +     if (of_property_read_bool(dn, "has_xhci_only")) {
> > +             priv->has_xhci = true;
> > +     } else {
> > +             priv->has_eohci = true;
> > +             if (of_property_read_bool(dn, "has_xhci"))
> > +                     priv->has_xhci = true;
> > +     }
> the dt binding documentation has mentioned brcm,has-xhci-only, brcm,has-xhci. I
> think instead of having has_xhci_only property, there can be a sub-node for
> each phy. So if there is only xhci, there can be a single sub-node and if there
> are more, there can be multiple sub-nodes.

The register block for phy control is a randomly ordered mix of XHCI,
E/OHCI, registers common to both and even some registers that mix
these in different fields. I need a single top level driver so that it
can enable the common portion if either XHCI or E/OHCI is being used
and can disable the common portion when neither is being used. If the
order is not done correctly we get bus errors accessing some of these
registers. What if I simplify the properties a little by using
"has_xhci" and "has_eohci"?

>
> > +     if (priv->has_eohci) {
> > +             gphy = devm_phy_create(dev, NULL, &brcm_usb_phy_ops);
> > +             if (IS_ERR(gphy)) {
> > +                     dev_err(dev, "failed to create EHCI/OHCI PHY\n");
> > +                     return PTR_ERR(gphy);
> > +             }
> > +             priv->phys[BRCM_USB_PHY_2_0].phy = gphy;
> > +             priv->phys[BRCM_USB_PHY_2_0].id = BRCM_USB_PHY_2_0;
> > +             phy_set_drvdata(gphy, &priv->phys[BRCM_USB_PHY_2_0]);
> > +     }
> > +     if (priv->has_xhci) {
> > +             gphy = devm_phy_create(dev, NULL, &brcm_usb_phy_ops);
> > +             if (IS_ERR(gphy)) {
> > +                     dev_err(dev, "failed to create XHCI PHY\n");
> > +                     return PTR_ERR(gphy);
> > +             }
> > +             priv->phys[BRCM_USB_PHY_3_0].phy = gphy;
> > +             priv->phys[BRCM_USB_PHY_3_0].id = BRCM_USB_PHY_3_0;
> > +             phy_set_drvdata(gphy, &priv->phys[BRCM_USB_PHY_3_0]);
> > +     }
> > +     mutex_init(&priv->mutex);
> > +     priv->usb_20_clk = of_clk_get_by_name(dn, "sw_usb");
> > +     if (IS_ERR(priv->usb_20_clk)) {
> > +             dev_info(&pdev->dev, "Clock not found in Device Tree\n");
> > +             priv->usb_20_clk = NULL;
> > +     }
> > +     err = clk_prepare_enable(priv->usb_20_clk);
> > +     if (err)
> > +             return err;
> > +
> > +     /* Get the USB3.0 clocks if we have XHCI */
> > +     if (priv->has_xhci) {
> > +             priv->usb_30_clk = of_clk_get_by_name(dn, "sw_usb3");
> > +             if (IS_ERR(priv->usb_30_clk)) {
> > +                     dev_info(&pdev->dev,
> > +                             "USB3.0 clock not found in Device Tree\n");
> > +                     priv->usb_30_clk = NULL;
> > +             }
> > +             err = clk_prepare_enable(priv->usb_30_clk);
> > +             if (err)
> > +                     return err;
> > +     }
>
> Instead of having has_xhci checks all over probe, can't we have a single
> function that performs all the initialization.

I'll restructure this.


Thanks
Al
