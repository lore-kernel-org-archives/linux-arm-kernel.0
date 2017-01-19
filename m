From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 19 Jan 2017 15:53:15 +0100
Subject: [PATCH net-next v3 06/10] net: dsa: Migrate to device_find_class()
In-Reply-To: <20170119142820.GA494@kroah.com>
References: <20170114214713.28109-1-f.fainelli@gmail.com>
 <20170114214713.28109-7-f.fainelli@gmail.com>
 <20170115110628.GF26374@kroah.com>
 <fc247aeb-a8d6-5ba9-c26d-cb057a5ac34d@gmail.com>
 <20170115173949.GA19268@kroah.com>
 <a9ea1f45-b9a5-d840-68e0-9bf9bc7a6598@gmail.com>
 <20170115191632.GD5643@lunn.ch>
 <912e6143-c67a-d909-2a6c-939de79efc5d@gmail.com>
 <20170119142820.GA494@kroah.com>
Message-ID: <20170119145315.GD21805@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > struct dsa_platform_data {
> > >         /*
> > >          * Reference to a Linux network interface that connects
> > >          * to the root switch chip of the tree.
> > >          */
> > >         struct device   *netdev;
> 
> This I think is the oddest thing, why do you need to have the "root
> switch" here?  You seem to have dropped the next value in this
> structure:
> 	struct net_device *of_netdev;

We are implementing platform_data for devices which don't support
device tree. When using OF, we don't have any of these issues. We can
go straight to the device.

It is a bit convoluted, but look at
arch/arm/mach-orion5x/rd88f5181l-ge-setup.c. It defines the start of
the dsa_platform_data in that file. It then gets passed through
common.c: orion5x_eth_switch_init() to 
arch/arm/plat-orion/common.c:orion_ge00_switch_init() :

void __init orion_ge00_switch_init(struct dsa_platform_data *d)
{
        int i;

        d->netdev = &orion_ge00.dev;
        for (i = 0; i < d->nr_chips; i++)
                d->chip[i].host_dev = &orion_ge_mvmdio.dev;

        platform_device_register_data(NULL, "dsa", 0, d, sizeof(d));
}

Where we have

static struct platform_device orion_ge00 = {
        .name           = MV643XX_ETH_NAME,
        .id             = 0,
        .num_resources  = 1,
        .resource       = orion_ge00_resources,
        .dev            = {
                .coherent_dma_mask      = DMA_BIT_MASK(32),
        },
};

So this is the platform device for the Ethernet device. We cannot go
to the net_device, because it does not exist until this Ethernet
platform device is instantiated.

> Shouldn't you have a bus for RGMII devices?  Is that the real problem
> here, you don't have a representation for your RGMII "bus" with a
> controller to bundle everything under (like a USB host controller, it
> bridges from one bus to another).

RGMII is not a bus. It is a point to point link. Normally, it is
between the Ethernet MAC and the Ethernet PHY. But you can also have
it between an Ethernet MAC and another Ethernet MAC. I'm not sure
describing this is a bus would be practical. It would mean every
ethernet driver also becomes a bus driver! Every Ethernet PHY would
become a bus device. That is a huge change, for a few legacy boards
which are not getting converted to device tree.

> If so, why is eth1 not below f1072004.mdio-mi in the heirachy already?

See the initial diagram above. The switch has two parents. It hangs of
an MDIO bus, and you would like to make RGMII also a bus. Can the
device model handle that? I thought it was a tree, not a graph?

       Andrew
