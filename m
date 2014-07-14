From: Mohit.KUMAR@st.com (Mohit KUMAR DCG)
Date: Mon, 14 Jul 2014 13:22:21 +0800
Subject: [PATCH V9 2/7] phy: Add drivers for PCIe and SATA phy on SPEAr13xx
In-Reply-To: <53BFA120.2070005@ti.com>
References: <cover.1404976058.git.viresh.kumar@linaro.org>
 <d1ef8db8704d09ba4f276c954dc22b555998f957.1404976058.git.viresh.kumar@linaro.org>
 <53BE926A.2070005@ti.com>
 <CAKohpokNijH37NAmuh5cYEZxYFJE-COKwVNP3RNHSEoS03YYAA@mail.gmail.com>
 <53BFA120.2070005@ti.com>
Message-ID: <2CC2A0A4A178534D93D5159BF3BCB661A47A2A7BF3@EAPEX1MAIL1.st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Kishon/Viresh,

> -----Original Message-----
> From: Kishon Vijay Abraham I [mailto:kishon at ti.com]
> Sent: Friday, July 11, 2014 2:03 PM
> To: Viresh Kumar
> Cc: Arnd Bergmann; olof at lixom.net; linux-arm-kernel at lists.infradead.org;
> spear-devel; Bartlomiej Zolnierkiewicz; Bjorn Helgaas; Mark Nicholson; linux-
> pci at vger.kernel.org; Pratyush ANAND
> Subject: Re: [PATCH V9 2/7] phy: Add drivers for PCIe and SATA phy on
> SPEAr13xx
> 
> 
> 
> On Thursday 10 July 2014 07:00 PM, Viresh Kumar wrote:
> > On 10 July 2014 18:47, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> >> On Thursday 10 July 2014 12:56 PM, Viresh Kumar wrote:
> >>> From: Pratyush Anand <pratyush.anand@st.com>
> >>>


[...]

> >>> +
> >>> +static int spear1340_miphy_sata_init(struct spear1340_miphy_priv
> >>> +*priv) {
> >>> +     regmap_update_bits(priv->misc, SPEAR1340_PCIE_SATA_CFG,
> >>> +                        SPEAR1340_PCIE_SATA_CFG_MASK,
> >>> +                        SPEAR1340_SATA_CFG_VAL);
> >>> +     regmap_update_bits(priv->misc, SPEAR1340_PCIE_MIPHY_CFG,
> >>> +                        SPEAR1340_PCIE_MIPHY_CFG_MASK,
> >>> +
> SPEAR1340_PCIE_SATA_MIPHY_CFG_SATA_25M_CRYSTAL_CLK);
> >>> +     /* Switch on sata power domain */
> >>> +     regmap_update_bits(priv->misc, SPEAR1340_PCM_CFG,
> >>> +                        SPEAR1340_PCM_CFG_SATA_POWER_EN,
> >>> +                        SPEAR1340_PCM_CFG_SATA_POWER_EN);
> >>> +     msleep(20);
> >>> +     /* Disable PCIE SATA Controller reset */
> >>> +     regmap_update_bits(priv->misc, SPEAR1340_PERIP1_SW_RST,
> >>> +                        SPEAR1340_PERIP1_SW_RSATA, 0);
> >>> +     msleep(20);
> >>
> >> Please add a comment for all delays added.
> >
> > @Pratyush/Mohit: please let me know what to add here.
> >

- I think we should read regmap_*() and msleep() in continuation and so the comment above it
is valid for both the operations.

Otherwise we can add comment line for msleep() like:
/* Wait for SATA power domain on */
/* Wait for SATA reset de-assert completion */

Similarily in *_exit routine:
/* Wait for SATA power domain off */
/* Wait for SATA reset assert completion */

Thanks
Mohit
