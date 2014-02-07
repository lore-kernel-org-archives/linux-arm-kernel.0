From: pratyush.anand@st.com (Pratyush Anand)
Date: Fri, 7 Feb 2014 09:24:30 +0530
Subject: [PATCH V4 6/8] phy: st-miphy-40lp: Add SPEAr1310 and SPEAr1340
 PCIe phy support
In-Reply-To: <201402061637.05414.arnd@arndb.de>
References: <cover.1391661589.git.pratyush.anand@st.com>
 <dca9c501de8386003142b463469c3d267a049eeb.1391661589.git.pratyush.anand@st.com>
 <201402061637.05414.arnd@arndb.de>
Message-ID: <20140207035429.GB2414@pratyush-vbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Thu, Feb 06, 2014 at 11:37:05PM +0800, Arnd Bergmann wrote:
> On Thursday 06 February 2014, Pratyush Anand wrote:
> > +static int spear1310_pcie_miphy_exit(struct st_miphy40lp_priv *phypriv)
> > +{
> > +       u32 mask;
> > +
> > +       switch (phypriv->id) {
> > +       case 0:
> > +               mask = SPEAR1310_PCIE_CFG_MASK(0);
> > +               break;
> > +       case 1:
> > +               mask = SPEAR1310_PCIE_CFG_MASK(1);
> > +               break;
> > +       case 2:
> > +               mask = SPEAR1310_PCIE_CFG_MASK(2);
> > +               break;
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +
> > +       regmap_update_bits(phypriv->misc, SPEAR1310_PCIE_SATA_CFG,
> > +                       SPEAR1310_PCIE_CFG_MASK(phypriv->id), 0);
> > +
> > +       regmap_update_bits(phypriv->misc, SPEAR1310_PCIE_MIPHY_CFG_1,
> > +                       SPEAR1310_PCIE_SATA_MIPHY_CFG_PCIE_MASK, 0);
> > +
> > +       return 0;
> > +}
> 
> hmm, you set the mask based on the id, but then use the macro below
> and ignore the mask?

Blunder, no need of switch case here :(
Will correct.

> 
> > +
> > +static int pcie_miphy_init(struct st_miphy40lp_priv *phypriv)
> > +{
> > +       if (of_device_is_compatible(phypriv->np, "st,spear1340-miphy"))
> > +               return spear1340_pcie_miphy_init(phypriv);
> > +       else if (of_device_is_compatible(phypriv->np, "st,spear1310-miphy"))
> > +               return spear1310_pcie_miphy_init(phypriv);
> > +       else
> > +               return -EINVAL;
> > +}
> > +
> > +static int pcie_miphy_exit(struct st_miphy40lp_priv *phypriv)
> > +{
> > +       if (of_device_is_compatible(phypriv->np, "st,spear1340-miphy"))
> > +               return spear1340_pcie_miphy_exit(phypriv);
> > +       else if (of_device_is_compatible(phypriv->np, "st,spear1310-miphy"))
> > +               return spear1310_pcie_miphy_exit(phypriv);
> > +       else
> > +               return -EINVAL;
> > +}
> 
> I think it's better to make this code table-driven. Rather than checking
> 'of_device_is_compatible()', it's much easier to add a .data field to
> the of_device_id array that describes the PHY. You can use .data to
> point to a structure containing per-device function pointers or
> (better) values and offsets to be used.

Sounds a better idea. will reduce code size a lot. Thanks.

Regards
Pratyush

> 
> 	Arnd
