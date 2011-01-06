From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 6 Jan 2011 12:14:59 +0800
Subject: [PATCH v3 05/10] net/fec: add dual fec support for mx28
In-Reply-To: <20110105163449.GU25121@pengutronix.de>
References: <1294236457-17476-1-git-send-email-shawn.guo@freescale.com>
	<1294236457-17476-6-git-send-email-shawn.guo@freescale.com>
	<20110105163449.GU25121@pengutronix.de>
Message-ID: <20110106041457.GC17891@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Wed, Jan 05, 2011 at 05:34:49PM +0100, Uwe Kleine-K?nig wrote:
> Hello,
> 
> On Wed, Jan 05, 2011 at 10:07:32PM +0800, Shawn Guo wrote:
> > This patch is to add mx28 dual fec support. Here are some key notes
> > for mx28 fec controller.
> >
> >  - The mx28 fec controller naming ENET-MAC is a different IP from FEC
> >    used on other i.mx variants.  But they are basically compatible
> >    on software interface, so it's possible to share the same driver.
> >  - ENET-MAC design made an improper assumption that it runs on a
> >    big-endian system. As the result, driver has to swap every frame
> >    going to and coming from the controller.
> >  - The external phys can only be configured by fec0, which means fec1
> >    can not work independently and both phys need to be configured by
> >    mii_bus attached on fec0.
> >  - ENET-MAC reset will get mac address registers reset too.
> >  - ENET-MAC MII/RMII mode and 10M/100M speed are configured
> >    differently FEC.
> >  - ETHER_EN bit must be set to get ENET-MAC interrupt work.
> >
> > Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> > ---
> > Changes for v3:
> >  - Move v2 changes into patch #3
> >  - Use device name to check if it's running on ENET-MAC
> >
> >  drivers/net/Kconfig |    7 ++-
> >  drivers/net/fec.c   |  140 +++++++++++++++++++++++++++++++++++++++++++++------
> >  drivers/net/fec.h   |    5 +-
> >  3 files changed, 131 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> > index 4f1755b..f34629b 100644
> > --- a/drivers/net/Kconfig
> > +++ b/drivers/net/Kconfig
> > @@ -1944,18 +1944,19 @@ config 68360_ENET
> >  config FEC
> >       bool "FEC ethernet controller (of ColdFire and some i.MX CPUs)"
> >       depends on M523x || M527x || M5272 || M528x || M520x || M532x || \
> > -             MACH_MX27 || ARCH_MX35 || ARCH_MX25 || ARCH_MX5
> > +             MACH_MX27 || ARCH_MX35 || ARCH_MX25 || ARCH_MX5 || SOC_IMX28
> >       select PHYLIB
> >       help
> >         Say Y here if you want to use the built-in 10/100 Fast ethernet
> >         controller on some Motorola ColdFire and Freescale i.MX processors.
> >
> >  config FEC2
> > -     bool "Second FEC ethernet controller (on some ColdFire CPUs)"
> > +     bool "Second FEC ethernet controller"
> >       depends on FEC
> >       help
> >         Say Y here if you want to use the second built-in 10/100 Fast
> > -       ethernet controller on some Motorola ColdFire processors.
> > +       ethernet controller on some Motorola ColdFire and Freescale
> > +       i.MX processors.
> >
> >  config FEC_MPC52xx
> >       tristate "MPC52xx FEC driver"
> > diff --git a/drivers/net/fec.c b/drivers/net/fec.c
> > index 8a1c51f..67ba263 100644
> > --- a/drivers/net/fec.c
> > +++ b/drivers/net/fec.c
> > @@ -17,6 +17,8 @@
> >   *
> >   * Bug fixes and cleanup by Philippe De Muyter (phdm at macqel.be)
> >   * Copyright (c) 2004-2006 Macq Electronique SA.
> > + *
> > + * Copyright (C) 2010 Freescale Semiconductor, Inc.
> >   */
> >
> >  #include <linux/module.h>
> > @@ -45,20 +47,33 @@
> >
> >  #include <asm/cacheflush.h>
> >
> > -#ifndef CONFIG_ARCH_MXC
> > +#if !defined(CONFIG_ARCH_MXC) && !defined(CONFIG_SOC_IMX28)
> maybe !defined(CONFIG_ARM)?
> 
Sounds good.

> >  #include <asm/coldfire.h>
> >  #include <asm/mcfsim.h>
> >  #endif
> >
> >  #include "fec.h"
> >
> > -#ifdef CONFIG_ARCH_MXC
> > -#include <mach/hardware.h>
> > +#if defined(CONFIG_ARCH_MXC) || defined(CONFIG_SOC_IMX28)
> >  #define FEC_ALIGNMENT        0xf
> >  #else
> >  #define FEC_ALIGNMENT        0x3
> >  #endif
> >
> > +#define DRIVER_NAME  "fec"
> > +#define ENET_MAC_NAME        "enet-mac"
> > +
> > +static struct platform_device_id fec_devtype[] = {
> > +     {
> > +             .name = DRIVER_NAME,
> > +     }, {
> > +             .name = ENET_MAC_NAME,
> > +     }
> I'd done it differently:
> 
>         {
>                 .name = "fec",
>                 .driver_data = 0,
>         }, {
>                 .name = "imx28-fec",
>                 .driver_data = HAS_ENET_MAC | ...,
>         }
> 
> and then test the bits in driver_data (which you get using
> platform_get_device_id() when you need to distinguish.
> Comparing names doesn't scale, assume there are three further features
> to distinguish, then you need to use strtok or index and get device
> names like enet-mac-with-feature1-but-without-feature2-and-feature3.
> 
Makes sense.  The frame endian issue will be fixed in future revision,
so I would define bit SWAP_FRAME for testing.

> > +};
> > +
> > +static unsigned fec_is_enetmac;
> > +static struct mii_bus *fec_mii_bus;
> In practice this might work, but actually these are per-device
> properties, not driver-global.  So it should go into the private data
> struct.
> 
Since it's just a tmp variable for holding fec0 mii_bus in function
fec_enet_mii_init, I would move it into the function as a static
variable.

> > +
> >  static unsigned char macaddr[ETH_ALEN];
> >  module_param_array(macaddr, byte, NULL, 0);
> >  MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address");
> > @@ -129,7 +144,8 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address");
> >   * account when setting it.
> >   */
> >  #if defined(CONFIG_M523x) || defined(CONFIG_M527x) || defined(CONFIG_M528x) || \
> > -    defined(CONFIG_M520x) || defined(CONFIG_M532x) || defined(CONFIG_ARCH_MXC)
> > +    defined(CONFIG_M520x) || defined(CONFIG_M532x) || \
> > +    defined(CONFIG_ARCH_MXC) || defined(CONFIG_SOC_IMX28)
> >  #define      OPT_FRAME_SIZE  (PKT_MAXBUF_SIZE << 16)
> >  #else
> >  #define      OPT_FRAME_SIZE  0
> > @@ -208,6 +224,17 @@ static void fec_stop(struct net_device *dev);
> >  /* Transmitter timeout */
> >  #define TX_TIMEOUT (2 * HZ)
> >
> > +static void *swap_buffer(void *bufaddr, int len)
> > +{
> > +     int i;
> > +     unsigned int *buf = bufaddr;
> > +
> > +     for (i = 0; i < (len + 3) / 4; i++, buf++)
> > +             *buf = __swab32(*buf);
> Would it better to use cpu_to_be32 here?  Then the compiler might
> be smart enough to optimize it away on BE.  (Currently the code
> generated for a BE build would be wrong with your patch, wouldn't it?)
Yes.

> > +
> > +     return bufaddr;
> > +}
> > +
> >  static netdev_tx_t
> >  fec_enet_start_xmit(struct sk_buff *skb, struct net_device *dev)
> >  {
> > @@ -256,6 +283,14 @@ fec_enet_start_xmit(struct sk_buff *skb, struct net_device *dev)
> >               bufaddr = fep->tx_bounce[index];
> >       }
> >
> > +     /*
> > +      * enet-mac design made an improper assumption that it's running
> > +      * on a big endian system. As the result, driver has to swap
> if he was really aware that he limits the performant use of the fec to
> big endian systems, can you please make him stop designing hardware!?
> 
You over looked my power :)  BTW, he had left Freescale.

> > +      * every frame going to and coming from the controller.
> > +      */
> > +     if (fec_is_enetmac)
> > +             swap_buffer(bufaddr, skb->len);
> > +
> >       /* Save skb pointer */
> >       fep->tx_skbuff[fep->skb_cur] = skb;
> >
> > @@ -487,6 +522,9 @@ fec_enet_rx(struct net_device *dev)
> >               dma_unmap_single(NULL, bdp->cbd_bufaddr, bdp->cbd_datlen,
> >                               DMA_FROM_DEVICE);
> >
> > +             if (fec_is_enetmac)
> > +                     swap_buffer(data, pkt_len);
> > +
> >               /* This does 16 byte alignment, exactly what we need.
> >                * The packet length includes FCS, but we don't want to
> >                * include that when passing upstream as it messes up
> > @@ -689,6 +727,7 @@ static int fec_enet_mii_probe(struct net_device *dev)
> >       char mdio_bus_id[MII_BUS_ID_SIZE];
> >       char phy_name[MII_BUS_ID_SIZE + 3];
> >       int phy_id;
> > +     int dev_id = fep->pdev->id;
> >
> >       fep->phy_dev = NULL;
> >
> > @@ -700,6 +739,8 @@ static int fec_enet_mii_probe(struct net_device *dev)
> >                       continue;
> >               if (fep->mii_bus->phy_map[phy_id]->phy_id == 0)
> >                       continue;
> > +             if (fec_is_enetmac && dev_id--)
> > +                     continue;
> >               strncpy(mdio_bus_id, fep->mii_bus->id, MII_BUS_ID_SIZE);
> >               break;
> >       }
> > @@ -741,6 +782,28 @@ static int fec_enet_mii_init(struct platform_device *pdev)
> >       struct fec_enet_private *fep = netdev_priv(dev);
> >       int err = -ENXIO, i;
> >
> > +     /*
> > +      * The dual fec interfaces are not equivalent with enet-mac.
> > +      * Here are the differences:
> > +      *
> > +      *  - fec0 supports MII & RMII modes while fec1 only supports RMII
> > +      *  - fec0 acts as the 1588 time master while fec1 is slave
> > +      *  - external phys can only be configured by fec0
> > +      *
> > +      * That is to say fec1 can not work independently. It only works
> > +      * when fec0 is working. The reason behind this design is that the
> > +      * second interface is added primarily for Switch mode.
> > +      *
> > +      * Because of the last point above, both phys are attached on fec0
> > +      * mdio interface in board design, and need to be configured by
> > +      * fec0 mii_bus.
> > +      */
> > +     if (fec_is_enetmac && pdev->id) {
> > +             /* fec1 uses fec0 mii_bus */
> > +             fep->mii_bus = fec_mii_bus;
> > +             return 0;
> > +     }
> > +
> >       fep->mii_timeout = 0;
> >
> >       /*
> > @@ -777,6 +840,10 @@ static int fec_enet_mii_init(struct platform_device *pdev)
> >       if (mdiobus_register(fep->mii_bus))
> >               goto err_out_free_mdio_irq;
> >
> > +     /* save fec0 mii_bus */
> > +     if (fec_is_enetmac)
> > +             fec_mii_bus = fep->mii_bus;
> > +
> >       return 0;
> >
> >  err_out_free_mdio_irq:
> > @@ -1149,11 +1216,22 @@ fec_restart(struct net_device *dev, int duplex)
> >  {
> >       struct fec_enet_private *fep = netdev_priv(dev);
> >       int i;
> > +     u32 val, temp_mac[2];
> >
> >       /* Whack a reset.  We should wait for this. */
> >       writel(1, fep->hwp + FEC_ECNTRL);
> >       udelay(10);
> >
> > +     /*
> > +      * enet-mac reset will reset mac address registers too,
> > +      * so need to reconfigure it.
> > +      */
> > +     if (fec_is_enetmac) {
> > +             memcpy(&temp_mac, dev->dev_addr, ETH_ALEN);
		  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +             writel(cpu_to_be32(temp_mac[0]), fep->hwp + FEC_ADDR_LOW);
> > +             writel(cpu_to_be32(temp_mac[1]), fep->hwp + FEC_ADDR_HIGH);
> where is the value saved to temp_mac[]?  For me it looks you write
> uninitialized data into the mac registers.

memcpy above.

-- 
Regards,
Shawn
