From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 21 Apr 2011 21:10:26 +0300
Subject: [PATCH] Fix for missed MII interrupts and MDIO timeouts when FEC
	is in STOP
In-Reply-To: <BANLkTinkkquz1d=T-PpTSz1dpsBswD19tQ@mail.gmail.com>
References: <BANLkTinkkquz1d=T-PpTSz1dpsBswD19tQ@mail.gmail.com>
Message-ID: <20110421181026.GA429@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matteo,

On Thu, Apr 21, 2011 at 04:03:49PM +0200, Matteo Fortini wrote:
> We are experiencing unrecoverable timeouts if we disconnect a cable from the
> FEC. This patch solves the issue by keeping the Ethernet enabled even in
> STOP. The RM doesn't state it, but i seems that if disabled, the Ethernet is
> not issuing interrupts to the core.
> (See
> http://forums.freescale.com/t5/i-MX-Microprocessors/iMX28-Network-MDIO-timeout-recovery-and-lost-IRQs/td-p/73309
> )

Please send network driver patches to the network drivers mailing list at 
netdev at vger.kernel.org.

This patch does not apply to the current mainline kernel. Which kernel tree 
are you using?

baruch

> ---
> ?drivers/net/fec.c | ? ?7 ++++++-
> ?1 files changed, 6 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/net/fec.c b/drivers/net/fec.c
> index d0e2e69..26ea72d 100644
> --- a/drivers/net/fec.c
> +++ b/drivers/net/fec.c
> @@ -121,8 +121,10 @@
> ?#if defined(CONFIG_FEC_1588) && defined(CONFIG_ARCH_MX28)
> ?#define FEC_DEFAULT_IMASK (FEC_ENET_TXF | FEC_ENET_RXF | FEC_ENET_MII | \
> ? ? ? ? ? ? ? ? FEC_ENET_TS_AVAIL | FEC_ENET_TS_TIMER)
> +#define FEC_STOP_IMASK (FEC_ENET_MII)
> ?#else
> ?#define FEC_DEFAULT_IMASK (FEC_ENET_TXF | FEC_ENET_RXF | FEC_ENET_MII)
> +#define FEC_STOP_IMASK (FEC_ENET_MII)
> ?#endif
> 
> ?/* The FEC stores dest/src/type, data, and checksum for receive packets.
> @@ -1409,6 +1411,9 @@ fec_stop(struct net_device *dev)
> ? ? writel(1, fep->hwp + FEC_ECNTRL);
> ? ? udelay(10);
> 
> + ? ?/* Reactivate the controller to get the IRQs */
> + ? ?writel(0x00000002, fep->hwp + FEC_ECNTRL);
> +
> ?#ifdef CONFIG_ARCH_MXS
> ? ? /* Check MII or RMII */
> ? ? if (fep->phy_interface == PHY_INTERFACE_MODE_RMII)
> @@ -1423,7 +1428,7 @@ fec_stop(struct net_device *dev)
> ? ? writel(fep->phy_speed, fep->hwp + FEC_MII_SPEED);
> ? ? if (fep->ptimer_present)
> ? ? ? ? fec_ptp_stop(fep->ptp_priv);
> - ? ?writel(FEC_DEFAULT_IMASK, fep->hwp + FEC_IMASK);
> + ? ?writel(FEC_STOP_IMASK, fep->hwp + FEC_IMASK);
> 
> ? ? netif_stop_queue(dev);
> ? ? fep->link = 0;

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
