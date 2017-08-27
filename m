From: jonnyc@amazon.com (Chocron, Jonathan)
Date: Sun, 27 Aug 2017 13:47:19 +0000
Subject: [PATCH net-next 4/8] net: ethernet: add the Alpine Ethernet driver
In-Reply-To: <20170203205823.GA22572@lunn.ch>
References: <20170203181216.30214-1-antoine.tenart@free-electrons.com>
 <20170203181216.30214-5-antoine.tenart@free-electrons.com>,
 <20170203205823.GA22572@lunn.ch>
Message-ID: <1503841641816.62526@amazon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a fixed version of my previous response (using proper indentation and leaving only the specific questions responded to).

> > +/* MDIO */
> > +#define AL_ETH_MDIO_C45_DEV_MASK     0x1f0000
> > +#define AL_ETH_MDIO_C45_DEV_SHIFT    16
> > +#define AL_ETH_MDIO_C45_REG_MASK     0xffff
> > +
> > +static int al_mdio_read(struct mii_bus *bp, int mii_id, int reg)
> > +{
> > +     struct al_eth_adapter *adapter = bp->priv;
> > +     u16 value = 0;
> > +     int rc;
> > +     int timeout = MDIO_TIMEOUT_MSEC;
> > +
> > +     while (timeout > 0) {
> > +             if (reg & MII_ADDR_C45) {
> > +                     netdev_dbg(adapter->netdev, "[c45]: dev %x reg %x val %x\n",
> > +                                ((reg & AL_ETH_MDIO_C45_DEV_MASK) >> AL_ETH_MDIO_C45_DEV_SHIFT),
> > +                                (reg & AL_ETH_MDIO_C45_REG_MASK), value);
> > +                     rc = al_eth_mdio_read(&adapter->hw_adapter, adapter->phy_addr,
> > +                             ((reg & AL_ETH_MDIO_C45_DEV_MASK) >> AL_ETH_MDIO_C45_DEV_SHIFT),
> > +                             (reg & AL_ETH_MDIO_C45_REG_MASK), &value);
> > +             } else {
> > +                     rc = al_eth_mdio_read(&adapter->hw_adapter, adapter->phy_addr,
> > +                                           MDIO_DEVAD_NONE, reg, &value);
> > +             }
> > +
> > +             if (rc == 0)
> > +                     return value;
> > +
> > +             netdev_dbg(adapter->netdev,
> > +                        "mdio read failed. try again in 10 msec\n");
> > +
> > +             timeout -= 10;
> > +             msleep(10);
> > +     }
> 
> This is rather unusual, retrying MDIO operations. Are you working
> around a hardware bug? I suspect this also opens up race conditions,
> in particular with PHY interrupts, which can be clear on read.

The MDIO bus is shared between the ethernet units. There is a HW lock used to arbitrate between different interfaces trying to access the bus, 
therefore there is a retry loop. The reg isn't accessed before obtaining the lock, so there shouldn't be any clear on read issues.

> > +/* al_eth_mdiobus_setup - initialize mdiobus and register to kernel */
> > +static int al_eth_mdiobus_setup(struct al_eth_adapter *adapter)
> > +{
> > +     struct phy_device *phydev;
> > +     int i;
> > +     int ret = 0;
> > +
> > +     adapter->mdio_bus = mdiobus_alloc();
> > +     if (!adapter->mdio_bus)
> > +             return -ENOMEM;
> > +
> > +     adapter->mdio_bus->name     = "al mdio bus";
> > +     snprintf(adapter->mdio_bus->id, MII_BUS_ID_SIZE, "%x",
> > +              (adapter->pdev->bus->number << 8) | adapter->pdev->devfn);
> > +     adapter->mdio_bus->priv     = adapter;
> > +     adapter->mdio_bus->parent   = &adapter->pdev->dev;
> > +     adapter->mdio_bus->read     = &al_mdio_read;
> > +     adapter->mdio_bus->write    = &al_mdio_write;
> > +     adapter->mdio_bus->phy_mask = ~BIT(adapter->phy_addr);
>
> Why do this?

Since the MDIO bus is shared, we want each interface to probe only for the PHY associated with it.

> > + * acquire mdio interface ownership
> > + * when mdio interface shared between multiple eth controllers, this function waits until the ownership granted for this controller.
> > + * this function does nothing when the mdio interface is used only by this controller.
> > + *
> > + * @param adapter
> > + * @return 0 on success, -ETIMEDOUT  on timeout.
> > + */
> > +static int al_eth_mdio_lock(struct al_hw_eth_adapter *adapter)
> > +{
> > +     int count = 0;
> > +     u32 mdio_ctrl_1;
> > +
> > +     if (!adapter->shared_mdio_if)
> > +             return 0; /* nothing to do when interface is not shared */
> > +
> > +     do {
> > +             mdio_ctrl_1 = readl(&adapter->mac_regs_base->gen.mdio_ctrl_1);
> > +             if (mdio_ctrl_1 & BIT(0)) {
> > +                     if (count > 0)
> > +                             netdev_dbg(adapter->netdev,
> > +                                        "eth %s mdio interface still busy!\n",
> > +                                        adapter->name);
> > +             } else {
> > +                     return 0;
> > +             }
> > +             udelay(AL_ETH_MDIO_DELAY_PERIOD);
> > +     } while (count++ < (AL_ETH_MDIO_DELAY_COUNT * 4));
>
> This needs explaining. How can a read alone perform a lock? How is
> this race free?

This is how this HW lock works: when the bit is 0 this means the lock is free. When a read transaction arrives
to the lock, it changes its value to 1 but sends 0 as the response, basically taking ownership.
When the owner is done, it writes  a 0 which essentially "frees" the lock.

> > +             if (adapter->mdio_type == AL_ETH_MDIO_TYPE_CLAUSE_22)
> > +                     rc = al_eth_mdio_10g_mac_type22(adapter, 1, phy_addr,
> > +                                                     reg, val);
> > +             else
> > +                     rc = al_eth_mdio_10g_mac_type45(adapter, 1, phy_addr,
> > +                                                     device, reg, val);
> 
> This seems odd. My understanding is that the device on the MDIO bus,
> the PHY, is either c22 or c45. The PHY driver will tell you this, not
> the adaptor.
 
The current implementation sets mdio_type according to information which is originally deduced from the
DeviceTree (the bootloader parses the ethernet node of the DeviceTree and saves this data to HW registers, which are then read by this driver).
How can this information be obtained by the PHY driver?

>    Andrew

Jonathan
