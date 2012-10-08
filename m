From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 8 Oct 2012 13:20:45 +0800
Subject: imx6q: high interrupt latencies
In-Reply-To: <50676F21.4000705@xenomai.org>
References: <50676F21.4000705@xenomai.org>
Message-ID: <20121008052043.GA10023@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 29, 2012 at 11:58:57PM +0200, Gilles Chanteperdrix wrote:
> 
> Hi,
> 
> I have been observing high interrupt latencies on imx6q, the problem
> seems to be in the FEC driver, function fec_enet_tx. The following line:
> 
>         while (((status = bdp->cbd_sc) & BD_ENET_TX_READY) == 0) {
> 
> can take 100us or more to execute, during which the local timer
> interrupt are postponed.
> 
> As far as I understand, bdp is a pointer to a "struct bufdesc" shared
> with the hardware and its status member is updated by the hardware when
> the corresponding ethernet packet transmission is complete.
> 
> Adding a call to "mb()" or "outer_sync()" before reading the status
> seems to avoid the issue, though I do not know if this is the proper fix.
> 
> Some more data. The boot logs say:
> CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=10c53c7d
> CPU identified as i.MX6Q, silicon rev 1.0
> l2x0: 16 ways, CACHE_ID 0x410000c7
> 
> the kernel is compiled with the following errata enabled:
> CONFIG_PL310_ERRATA_588369
> CONFIG_PL310_ERRATA_727915
> CONFIG_ARM_ERRATA_743622
> CONFIG_ARM_ERRATA_751472
> CONFIG_ARM_ERRATA_754322
> CONFIG_ARM_ERRATA_764369
> CONFIG_PL310_ERRATA_769419
> 
Are you running mainline kernel?  The boot log and the errata settings
are different from what we have with mainline kernel.

I'm using the following patch to measure the time on with v3.6 kernel,
and seeing the output is mostly 2 ~ 4 us.

diff --git a/drivers/net/ethernet/freescale/fec.c b/drivers/net/ethernet/freescale/fec.c
index fffd205..f72955a 100644
--- a/drivers/net/ethernet/freescale/fec.c
+++ b/drivers/net/ethernet/freescale/fec.c
@@ -566,11 +566,13 @@ fec_enet_tx(struct net_device *ndev)
        struct bufdesc *bdp;
        unsigned short status;
        struct  sk_buff *skb;
+       struct timeval time1, time2;

        fep = netdev_priv(ndev);
        spin_lock(&fep->hw_lock);
        bdp = fep->dirty_tx;

+       do_gettimeofday(&time1);
        while (((status = bdp->cbd_sc) & BD_ENET_TX_READY) == 0) {
                if (bdp == fep->cur_tx && fep->tx_full == 0)
                        break;
@@ -627,6 +629,8 @@ fec_enet_tx(struct net_device *ndev)
                                netif_wake_queue(ndev);
                }
        }
+       do_gettimeofday(&time2);
+       printk("*** %s: %lu\n", __func__, timeval_to_ns(&time2) - timeval_to_ns(&time1));
        fep->dirty_tx = bdp;
        spin_unlock(&fep->hw_lock);
 }

Shawn
