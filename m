From: lznuaa@gmail.com (Frank Li)
Date: Fri, 21 Mar 2014 10:50:41 -0500
Subject: PL310 errata workarounds
In-Reply-To: <20140319225137.GM7528@n2100.arm.linux.org.uk>
References: <20140314144835.GP21483@n2100.arm.linux.org.uk>
 <CAL_JsqLDun2VkCFK9Fec6n38bNz2w9mscPdXcGYeLiZtiXkVDg@mail.gmail.com>
 <20140318172615.GX21483@n2100.arm.linux.org.uk>
 <201403192252.32443.marex@denx.de>
 <20140319225137.GM7528@n2100.arm.linux.org.uk>
Message-ID: <CAHrpEqSaV951SGctNdHGtbX-ksv=OEv2KSY_QBpZ_Qu2c_Ka-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 19, 2014 at 5:51 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Mar 19, 2014 at 10:52:32PM +0100, Marek Vasut wrote:
>> On Tuesday, March 18, 2014 at 06:26:15 PM, Russell King - ARM Linux wrote:
>> > On Mon, Mar 17, 2014 at 09:00:03AM -0500, Rob Herring wrote:
>> > > Setting prefetch enables and early BRESP could all be done
>> > > unconditionally in the core code.
>> >
>> > I think we can do a few things here, if we know that the CPUs we're
>> > connected to are all Cortex-A9:
>> >
>> > 1. Enable BRESP.
>> >
>> > 2. Enable I+D prefetching - but we really need to tune the prefetch offset
>> >    for this to be worthwhile.  The value depends on the L3 memory system
>> >    latency, so isn't something that should be specified at the SoC level.
>> >    It may also change with different operating points.
>> >
>> > 3. Full line of zeros - I think this is a difficult one to achieve
>> > properly. The required sequence:
>> >
>> >    - enable FLZ in L2 cache
>> >    - enable L2 cache
>> >    - enable FLZ in Cortex A9
>> >
>> >    I'd also assume that when we turn the L2 cache off, we need the reverse
>> >    sequence too.  So this sequence can't be done entirely by the boot
>> > loader.
>> >
>> > With (1) enabled and (2) properly tuned, I see a performance increase of
>> > around 60Mbps on transmission, bringing the Cubox-i4 up from 250Mbps to
>> > 315Mbps transmit on its gigabit interface with cpufreq ondemand enabled.
>> > With "performance", this goes up to [323, 323, 321, 325, 322]Mbps.  On
>> > receive [446, 603, 605, 605, 601]Mbps, which hasn't really changed
>> > very much (and still impressively exceeds the Freescale stated maximum
>> > total bandwidth of the gigabit interface.)
>>
>> Speaking of FEC and slightly off-topic, have you ever seen this on your box
>> [1]/[2]/[3] ? I wonder if this might be cache-related as well, since I saw
>> similar issue on MX6 with PCIe-connected ethernet. I cannot put a finger on
>> this though.
>
> I think I've seen something similar once or twice.
>
> Let me just pull up the transmit function.  This is the code which
> writes to the descriptors (which frankly is pretty horrid):
>
>         bdp->cbd_datlen = skb->len;
>         bdp->cbd_bufaddr = dma_map_single(&fep->pdev->dev, bufaddr,
>                         skb->len, DMA_TO_DEVICE); <-- barrier inside
>                 ebdp->cbd_bdu = 0;
>                         ebdp->cbd_esc = BD_ENET_TX_INT;
>                                 ebdp->cbd_esc |= BD_ENET_TX_PINS;
>         bdp->cbd_sc = status;
>         writel(0, fep->hwp + FEC_X_DES_ACTIVE); <-- barrier before write
>
> A couple of points here:
>
> 1. The hardware operates in a ring - it can read the next ring if it
>    sees the BD_ENET_TX_READY bit set if has just finished processing
>    the previous descriptor - this can happen before the write to
>    FEC_X_DES_ACTIVE.

Correct. uDMA will start transfer when D_ENET_TX_READY bit.
I think other network MAC work similar with this one.

>
> 2. The ARM can re-order writes.  The writes it can re-order are:
>
>         bdp->cbd_bufaddr
>         ebdp->cbd_bdu
>         ebdp->cbd_esc
>         ebdp->cbd_sc
>
> Hence, it's entirely possible for the FEC to see the updated descriptor
> status before the rest of the descriptor has been written.  What's missing
> is a barrier between the descriptor writes, and the final write to
> bdp->cbd_sc.

Possible. I also consider this when debug the other issues.
Just bdp->bufaddr and bdp->buflen is important.
bdu, hardware don't care it.
esc is the same for each BD.  When software go though BD ring once,
esc will be not changed again, even though we write.

but if sc write before buffaddr and bullen, there will be issue.
Add memory barre here is better before  ebdp->cbd_sc.

I also want to add it before, But I have not found a test case to
verify it is necessary.

>
> Had I not got distracted by the L2 issues, I'd have posted my FEC patches
> by now... in any case, my current xmit function looks a little different -
> I've organised it such that:
>
> 1. We don't modify anything until we're past the point where things can
>    error out.
>
> 2. Writes to the descriptor are localised in one area.
>
> 3. There's a wmb() barrier between cbd_sc and the previous writes - I
>    discussed this with Will Deacon, which resulted in this documentation
>    for the barrier:
>
>         /*
>          * We need the preceding stores to the descriptor to complete
>          * before updating the status field, which hands it over to the
>          * hardware.  The corresponding rmb() is "in the hardware".
>          */

It is better.
>
> The second thing that causes the transmit timeouts is the horrid way
> NAPI has been added to the driver - it's racy.  NAPI itself isn't the
> problem, it's this (compressed a bit to show only the relevant bits):
>
>         do {
>                 int_events = readl(fep->hwp + FEC_IEVENT);
>                 writel(int_events, fep->hwp + FEC_IEVENT);
>                 if (int_events & (FEC_ENET_RXF | FEC_ENET_TXF)) {
>                         if (napi_schedule_prep(&fep->napi)) {
>                                 writel(FEC_RX_DISABLED_IMASK,
>                                         fep->hwp + FEC_IMASK);
>                                 __napi_schedule(&fep->napi);
>                         }
>                 }
>                 if (int_events & FEC_ENET_MII) {
>                         complete(&fep->mdio_done);
>                 }
>         } while (int_events);
>
> Consider what happens here if:
> - we talk in the MII bus and receive a MII interrupt
> - we're just finishing NAPI processing but haven't quite got around to
>   calling napi_complete()
> - the ethernet has sent all packets, and has also raised a transmit
>   interrupt
>
> The result is the handler is entered, FEC_IEVENT contains TXF and MII
> events.  Both these events are cleared down, (and thus no longer exist
> as interrupt-causing events.)  napi_schedule_prep() returns false as
> the NAPI rx function is still running, and doesn't mark it for a re-run.
> We then do the MII interrupt.  Loop again, and int_events is zero,
> we exit.
>
> Meanwhile, the NAPI rx function calls napi_complete() and re-enables
> the receive interrupt.  If you're unlucky enough that the RX ring is
> also full... no RXF interrupt.  So no further interrupts except maybe
> MII interrupts.
>
> NAPI never gets scheduled.  RX ring never gets emptied.  TX ring never
> gets reaped.  The result is a timeout with a completely full TX ring.

Do you see RX ring full?

>
> I think I've seen both cases: I've seen the case where the TX ring is
> completely empty, but it hasn't been reaped.   I've also seen the case
> where the TX ring contains packets to be transmitted but the hardware
> isn't sending them.
>
> That all said - with the patch below I haven't seen problems since.
> (which is the quickest way I can think of to get you a copy of what
> I'm presently running - I've killed a number of debug bits denoted by
> all the blank lines - and this is against -rc7.)  You may notice that
> I added some TX ring dumping code to the driver - always useful in
> these situations. ;-)
>
> This patch is of course the consolidated version: individually, this
> would be at least 19 patches with nice commit messages describing
> each change...
>
> As far as the 600Mbps receive - you need the right conditions for that.
> I select the performance cpufreq governor after boot, and let the boot
> quiesce.  It doesn't take much for it to drop back to 460Mbps - another
> running process other than iperf -s is sufficient to do that.
>
> Let me know how you get on with this.
>
> diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
> index 3b8d6d19ff05..510580eeae4b 100644
> --- a/drivers/net/ethernet/freescale/fec.h
> +++ b/drivers/net/ethernet/freescale/fec.h
> @@ -170,6 +170,11 @@ struct bufdesc_ex {
>         unsigned short res0[4];
>  };
>
> +union bufdesc_u {
> +       struct bufdesc bd;
> +       struct bufdesc_ex ebd;
> +};
> +
>  /*
>   *     The following definitions courtesy of commproc.h, which where
>   *     Copyright (c) 1997 Dan Malek (dmalek at jlc.net).
> @@ -240,14 +245,14 @@ struct bufdesc_ex {
>   * the skbuffer directly.
>   */
>
> -#define FEC_ENET_RX_PAGES      8
> +#define FEC_ENET_RX_PAGES      32
>  #define FEC_ENET_RX_FRSIZE     2048
>  #define FEC_ENET_RX_FRPPG      (PAGE_SIZE / FEC_ENET_RX_FRSIZE)
>  #define RX_RING_SIZE           (FEC_ENET_RX_FRPPG * FEC_ENET_RX_PAGES)
>  #define FEC_ENET_TX_FRSIZE     2048
>  #define FEC_ENET_TX_FRPPG      (PAGE_SIZE / FEC_ENET_TX_FRSIZE)
> -#define TX_RING_SIZE           16      /* Must be power of two */
> -#define TX_RING_MOD_MASK       15      /*   for this to work */
> +#define TX_RING_SIZE           64      /* Must be power of two */
> +#define TX_RING_MOD_MASK       63      /*   for this to work */
>
>  #define BD_ENET_RX_INT          0x00800000
>  #define BD_ENET_RX_PTP          ((ushort)0x0400)
> @@ -289,12 +294,12 @@ struct fec_enet_private {
>         /* CPM dual port RAM relative addresses */
>         dma_addr_t      bd_dma;
>         /* Address of Rx and Tx buffers */
> -       struct bufdesc  *rx_bd_base;
> -       struct bufdesc  *tx_bd_base;
> +       union bufdesc_u *rx_bd_base;
> +       union bufdesc_u *tx_bd_base;
>         /* The next free ring entry */
> -       struct bufdesc  *cur_rx, *cur_tx;
> -       /* The ring entries to be free()ed */
> -       struct bufdesc  *dirty_tx;
> +       unsigned short tx_next;
> +       unsigned short tx_dirty;
> +       unsigned short rx_next;
>
>         unsigned short tx_ring_size;
>         unsigned short rx_ring_size;
> @@ -335,6 +340,9 @@ struct fec_enet_private {
>         struct timer_list time_keep;
>         struct fec_enet_delayed_work delay_work;
>         struct regulator *reg_phy;
> +       unsigned long quirks;
> +
> +
>  };
>
>  void fec_ptp_init(struct platform_device *pdev);
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index 03a351300013..8105697d5a99 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -101,6 +101,8 @@ static void set_multicast_list(struct net_device *ndev);
>   * ENET_TDAR[TDAR].
>   */
>  #define FEC_QUIRK_ERR006358            (1 << 7)
> +/* Controller has ability to offset rx packets */
> +#define FEC_QUIRK_RX_SHIFT16           (1 << 8)
>
>  static struct platform_device_id fec_devtype[] = {
>         {
> @@ -120,7 +122,8 @@ static struct platform_device_id fec_devtype[] = {
>                 .name = "imx6q-fec",
>                 .driver_data = FEC_QUIRK_ENET_MAC | FEC_QUIRK_HAS_GBIT |
>                                 FEC_QUIRK_HAS_BUFDESC_EX | FEC_QUIRK_HAS_CSUM |
> -                               FEC_QUIRK_HAS_VLAN | FEC_QUIRK_ERR006358,
> +                               FEC_QUIRK_HAS_VLAN | FEC_QUIRK_ERR006358 |
> +                               FEC_QUIRK_RX_SHIFT16,
>         }, {
>                 .name = "mvf600-fec",
>                 .driver_data = FEC_QUIRK_ENET_MAC,
> @@ -200,6 +203,7 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address");
>  /* FEC receive acceleration */
>  #define FEC_RACC_IPDIS         (1 << 1)
>  #define FEC_RACC_PRODIS                (1 << 2)
> +#define FEC_RACC_SHIFT16       BIT(7)
>  #define FEC_RACC_OPTIONS       (FEC_RACC_IPDIS | FEC_RACC_PRODIS)
>
>  /*
> @@ -233,57 +237,54 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address");
>
>  static int mii_cnt;
>
> -static inline
> -struct bufdesc *fec_enet_get_nextdesc(struct bufdesc *bdp, struct fec_enet_private *fep)
> +static unsigned copybreak = 200;
> +module_param(copybreak, uint, 0644);
> +MODULE_PARM_DESC(copybreak,
> +                "Maximum size of packet that is copied to a new buffer on receive");
> +
> +
> +
> +
> +
> +static bool fec_enet_rx_zerocopy(struct fec_enet_private *fep, unsigned pktlen)
>  {
> -       struct bufdesc *new_bd = bdp + 1;
> -       struct bufdesc_ex *ex_new_bd = (struct bufdesc_ex *)bdp + 1;
> -       struct bufdesc_ex *ex_base;
> -       struct bufdesc *base;
> -       int ring_size;
> -
> -       if (bdp >= fep->tx_bd_base) {
> -               base = fep->tx_bd_base;
> -               ring_size = fep->tx_ring_size;
> -               ex_base = (struct bufdesc_ex *)fep->tx_bd_base;
> -       } else {
> -               base = fep->rx_bd_base;
> -               ring_size = fep->rx_ring_size;
> -               ex_base = (struct bufdesc_ex *)fep->rx_bd_base;
> -       }
> +#ifndef CONFIG_M5272
> +       if (fep->quirks & FEC_QUIRK_RX_SHIFT16 && pktlen >= copybreak)
> +               return true;
> +#endif
> +       return false;
> +}
> +
> +static union bufdesc_u *
> +fec_enet_tx_get(unsigned index, struct fec_enet_private *fep)
> +{
> +       union bufdesc_u *base = fep->tx_bd_base;
> +       union bufdesc_u *bdp;
> +
> +       index &= fep->tx_ring_size - 1;
>
>         if (fep->bufdesc_ex)
> -               return (struct bufdesc *)((ex_new_bd >= (ex_base + ring_size)) ?
> -                       ex_base : ex_new_bd);
> +               bdp = (union bufdesc_u *)(&base->ebd + index);
>         else
> -               return (new_bd >= (base + ring_size)) ?
> -                       base : new_bd;
> +               bdp = (union bufdesc_u *)(&base->bd + index);
> +
> +       return bdp;
>  }
>
> -static inline
> -struct bufdesc *fec_enet_get_prevdesc(struct bufdesc *bdp, struct fec_enet_private *fep)
> +static union bufdesc_u *
> +fec_enet_rx_get(unsigned index, struct fec_enet_private *fep)
>  {
> -       struct bufdesc *new_bd = bdp - 1;
> -       struct bufdesc_ex *ex_new_bd = (struct bufdesc_ex *)bdp - 1;
> -       struct bufdesc_ex *ex_base;
> -       struct bufdesc *base;
> -       int ring_size;
> -
> -       if (bdp >= fep->tx_bd_base) {
> -               base = fep->tx_bd_base;
> -               ring_size = fep->tx_ring_size;
> -               ex_base = (struct bufdesc_ex *)fep->tx_bd_base;
> -       } else {
> -               base = fep->rx_bd_base;
> -               ring_size = fep->rx_ring_size;
> -               ex_base = (struct bufdesc_ex *)fep->rx_bd_base;
> -       }
> +       union bufdesc_u *base = fep->rx_bd_base;
> +       union bufdesc_u *bdp;
> +
> +       index &= fep->rx_ring_size - 1;
>
>         if (fep->bufdesc_ex)
> -               return (struct bufdesc *)((ex_new_bd < ex_base) ?
> -                       (ex_new_bd + ring_size) : ex_new_bd);
> +               bdp = (union bufdesc_u *)(&base->ebd + index);
>         else
> -               return (new_bd < base) ? (new_bd + ring_size) : new_bd;
> +               bdp = (union bufdesc_u *)(&base->bd + index);
> +
> +       return bdp;
>  }
>
>  static void *swap_buffer(void *bufaddr, int len)
> @@ -297,6 +298,26 @@ static void *swap_buffer(void *bufaddr, int len)
>         return bufaddr;
>  }
>
> +static void fec_dump(struct net_device *ndev)
> +{
> +       struct fec_enet_private *fep = netdev_priv(ndev);
> +       unsigned index = 0;
> +
> +       netdev_info(ndev, "TX ring dump\n");
> +       pr_info("Nr    SC     addr       len  SKB\n");
> +
> +       for (index = 0; index < fep->tx_ring_size; index++) {
> +               union bufdesc_u *bdp = fec_enet_tx_get(index, fep);
> +
> +               pr_info("%2u %c%c 0x%04x 0x%08lx %4u %p\n",
> +                       index,
> +                       index == fep->tx_next ? 'S' : ' ',
> +                       index == fep->tx_dirty ? 'H' : ' ',
> +                       bdp->bd.cbd_sc, bdp->bd.cbd_bufaddr, bdp->bd.cbd_datlen,
> +                       fep->tx_skbuff[index]);
> +       }
> +}
> +
>  static int
>  fec_enet_clear_csum(struct sk_buff *skb, struct net_device *ndev)
>  {
> @@ -312,21 +333,42 @@ fec_enet_clear_csum(struct sk_buff *skb, struct net_device *ndev)
>         return 0;
>  }
>
> +static void
> +fec_enet_tx_unmap(struct bufdesc *bdp, struct fec_enet_private *fep)
> +{
> +       dma_addr_t addr = bdp->cbd_bufaddr;
> +       unsigned length = bdp->cbd_datlen;
> +
> +       bdp->cbd_bufaddr = 0;
> +
> +       dma_unmap_single(&fep->pdev->dev, addr, length, DMA_TO_DEVICE);
> +}
> +
>  static netdev_tx_t
>  fec_enet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>  {
>         struct fec_enet_private *fep = netdev_priv(ndev);
> -       const struct platform_device_id *id_entry =
> -                               platform_get_device_id(fep->pdev);
> -       struct bufdesc *bdp, *bdp_pre;
> +       union bufdesc_u *bdp, *bdp_pre;
>         void *bufaddr;
>         unsigned short  status;
> -       unsigned int index;
> +       unsigned index;
> +       unsigned length;
> +       dma_addr_t addr;
> +
> +
> +
> +
> +
> +
> +
> +
> +
>
>         /* Fill in a Tx ring entry */
> -       bdp = fep->cur_tx;
> +       index = fep->tx_next;
>
> -       status = bdp->cbd_sc;
> +       bdp = fec_enet_tx_get(index, fep);
> +       status = bdp->bd.cbd_sc;
>
>         if (status & BD_ENET_TX_READY) {
>                 /* Ooops.  All transmit buffers are full.  Bail out.
> @@ -347,21 +389,15 @@ fec_enet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>
>         /* Set buffer length and buffer pointer */
>         bufaddr = skb->data;
> -       bdp->cbd_datlen = skb->len;
> +       length = skb->len;
>
>         /*
>          * On some FEC implementations data must be aligned on
>          * 4-byte boundaries. Use bounce buffers to copy data
>          * and get it aligned. Ugh.
>          */
> -       if (fep->bufdesc_ex)
> -               index = (struct bufdesc_ex *)bdp -
> -                       (struct bufdesc_ex *)fep->tx_bd_base;
> -       else
> -               index = bdp - fep->tx_bd_base;
> -
>         if (((unsigned long) bufaddr) & FEC_ALIGNMENT) {
> -               memcpy(fep->tx_bounce[index], skb->data, skb->len);
> +               memcpy(fep->tx_bounce[index], skb->data, length);
>                 bufaddr = fep->tx_bounce[index];
>         }
>
> @@ -370,70 +406,72 @@ fec_enet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>          * the system that it's running on. As the result, driver has to
>          * swap every frame going to and coming from the controller.
>          */
> -       if (id_entry->driver_data & FEC_QUIRK_SWAP_FRAME)
> -               swap_buffer(bufaddr, skb->len);
> +       if (fep->quirks & FEC_QUIRK_SWAP_FRAME)
> +               swap_buffer(bufaddr, length);
>
> -       /* Save skb pointer */
> -       fep->tx_skbuff[index] = skb;
> -
> -       /* Push the data cache so the CPM does not get stale memory
> -        * data.
> -        */
> -       bdp->cbd_bufaddr = dma_map_single(&fep->pdev->dev, bufaddr,
> -                       skb->len, DMA_TO_DEVICE);
> -       if (dma_mapping_error(&fep->pdev->dev, bdp->cbd_bufaddr)) {
> -               bdp->cbd_bufaddr = 0;
> -               fep->tx_skbuff[index] = NULL;
> +       /* Push the data cache so the CPM does not get stale memory data. */
> +       addr = dma_map_single(&fep->pdev->dev, bufaddr, length, DMA_TO_DEVICE);
> +       if (dma_mapping_error(&fep->pdev->dev, addr)) {
>                 dev_kfree_skb_any(skb);
>                 if (net_ratelimit())
>                         netdev_err(ndev, "Tx DMA memory map failed\n");
>                 return NETDEV_TX_OK;
>         }
>
> -       if (fep->bufdesc_ex) {
> +       /* Save skb pointer */
> +       fep->tx_skbuff[index] = skb;
>
> -               struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
> -               ebdp->cbd_bdu = 0;
> +       bdp->bd.cbd_datlen = length;
> +       bdp->bd.cbd_bufaddr = addr;
> +
> +       if (fep->bufdesc_ex) {
> +               bdp->ebd.cbd_bdu = 0;
>                 if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP &&
>                         fep->hwts_tx_en)) {
> -                       ebdp->cbd_esc = (BD_ENET_TX_TS | BD_ENET_TX_INT);
> +                       bdp->ebd.cbd_esc = (BD_ENET_TX_TS | BD_ENET_TX_INT);
>                         skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
>                 } else {
> -                       ebdp->cbd_esc = BD_ENET_TX_INT;
> +                       bdp->ebd.cbd_esc = BD_ENET_TX_INT;
>
>                         /* Enable protocol checksum flags
>                          * We do not bother with the IP Checksum bits as they
>                          * are done by the kernel
>                          */
>                         if (skb->ip_summed == CHECKSUM_PARTIAL)
> -                               ebdp->cbd_esc |= BD_ENET_TX_PINS;
> +                               bdp->ebd.cbd_esc |= BD_ENET_TX_PINS;
>                 }
>         }
>
> +       /*
> +        * We need the preceding stores to the descriptor to complete
> +        * before updating the status field, which hands it over to the
> +        * hardware.  The corresponding rmb() is "in the hardware".
> +        */
> +       wmb();
> +
>         /* Send it on its way.  Tell FEC it's ready, interrupt when done,
>          * it's the last BD of the frame, and to put the CRC on the end.
>          */
>         status |= (BD_ENET_TX_READY | BD_ENET_TX_INTR
>                         | BD_ENET_TX_LAST | BD_ENET_TX_TC);
> -       bdp->cbd_sc = status;
> +       bdp->bd.cbd_sc = status;
>
> -       bdp_pre = fec_enet_get_prevdesc(bdp, fep);
> -       if ((id_entry->driver_data & FEC_QUIRK_ERR006358) &&
> -           !(bdp_pre->cbd_sc & BD_ENET_TX_READY)) {
> +       bdp_pre = fec_enet_tx_get(index - 1, fep);
> +       if ((fep->quirks & FEC_QUIRK_ERR006358) &&
> +           !(bdp_pre->bd.cbd_sc & BD_ENET_TX_READY)) {
>                 fep->delay_work.trig_tx = true;
>                 schedule_delayed_work(&(fep->delay_work.delay_work),
>                                         msecs_to_jiffies(1));
>         }
>
> -       /* If this was the last BD in the ring, start at the beginning again. */
> -       bdp = fec_enet_get_nextdesc(bdp, fep);
> -
>         skb_tx_timestamp(skb);
>
> -       fep->cur_tx = bdp;
> +       fep->tx_next = (index + 1) & (fep->tx_ring_size - 1);
>
> -       if (fep->cur_tx == fep->dirty_tx)
> +       if (fep->tx_next == fep->tx_dirty) {
> +
>                 netif_stop_queue(ndev);
> +       }
>
>         /* Trigger transmission start */
>         writel(0, fep->hwp + FEC_X_DES_ACTIVE);
> @@ -446,46 +484,43 @@ fec_enet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>  static void fec_enet_bd_init(struct net_device *dev)
>  {
>         struct fec_enet_private *fep = netdev_priv(dev);
> -       struct bufdesc *bdp;
>         unsigned int i;
>
>         /* Initialize the receive buffer descriptors. */
> -       bdp = fep->rx_bd_base;
>         for (i = 0; i < fep->rx_ring_size; i++) {
> +               union bufdesc_u *bdp = fec_enet_rx_get(i, fep);
>
>                 /* Initialize the BD for every fragment in the page. */
> -               if (bdp->cbd_bufaddr)
> -                       bdp->cbd_sc = BD_ENET_RX_EMPTY;
> +               if (bdp->bd.cbd_bufaddr)
> +                       bdp->bd.cbd_sc = BD_ENET_RX_EMPTY;
>                 else
> -                       bdp->cbd_sc = 0;
> -               bdp = fec_enet_get_nextdesc(bdp, fep);
> +                       bdp->bd.cbd_sc = 0;
> +               if (i == fep->rx_ring_size - 1)
> +                       bdp->bd.cbd_sc |= BD_SC_WRAP;
>         }
>
> -       /* Set the last buffer to wrap */
> -       bdp = fec_enet_get_prevdesc(bdp, fep);
> -       bdp->cbd_sc |= BD_SC_WRAP;
> -
> -       fep->cur_rx = fep->rx_bd_base;
> +       fep->rx_next = 0;
>
>         /* ...and the same for transmit */
> -       bdp = fep->tx_bd_base;
> -       fep->cur_tx = bdp;
>         for (i = 0; i < fep->tx_ring_size; i++) {
> +               union bufdesc_u *bdp = fec_enet_tx_get(i, fep);
>
>                 /* Initialize the BD for every fragment in the page. */
> -               bdp->cbd_sc = 0;
> -               if (bdp->cbd_bufaddr && fep->tx_skbuff[i]) {
> +               /* Set the last buffer to wrap */
> +               if (i == fep->tx_ring_size - 1)
> +                       bdp->bd.cbd_sc = BD_SC_WRAP;
> +               else
> +                       bdp->bd.cbd_sc = 0;
> +               if (bdp->bd.cbd_bufaddr)
> +                       fec_enet_tx_unmap(&bdp->bd, fep);
> +               if (fep->tx_skbuff[i]) {
>                         dev_kfree_skb_any(fep->tx_skbuff[i]);
>                         fep->tx_skbuff[i] = NULL;
>                 }
> -               bdp->cbd_bufaddr = 0;
> -               bdp = fec_enet_get_nextdesc(bdp, fep);
>         }
>
> -       /* Set the last buffer to wrap */
> -       bdp = fec_enet_get_prevdesc(bdp, fep);
> -       bdp->cbd_sc |= BD_SC_WRAP;
> -       fep->dirty_tx = bdp;
> +       fep->tx_next = 0;
> +       fep->tx_dirty = fep->tx_ring_size - 1;
>  }
>
>  /* This function is called to start or restart the FEC during a link
> @@ -496,8 +531,6 @@ static void
>  fec_restart(struct net_device *ndev, int duplex)
>  {
>         struct fec_enet_private *fep = netdev_priv(ndev);
> -       const struct platform_device_id *id_entry =
> -                               platform_get_device_id(fep->pdev);
>         int i;
>         u32 val;
>         u32 temp_mac[2];
> @@ -519,7 +552,7 @@ fec_restart(struct net_device *ndev, int duplex)
>          * enet-mac reset will reset mac address registers too,
>          * so need to reconfigure it.
>          */
> -       if (id_entry->driver_data & FEC_QUIRK_ENET_MAC) {
> +       if (fep->quirks & FEC_QUIRK_ENET_MAC) {
>                 memcpy(&temp_mac, ndev->dev_addr, ETH_ALEN);
>                 writel(cpu_to_be32(temp_mac[0]), fep->hwp + FEC_ADDR_LOW);
>                 writel(cpu_to_be32(temp_mac[1]), fep->hwp + FEC_ADDR_HIGH);
> @@ -568,6 +601,8 @@ fec_restart(struct net_device *ndev, int duplex)
>  #if !defined(CONFIG_M5272)
>         /* set RX checksum */
>         val = readl(fep->hwp + FEC_RACC);
> +       if (fep->quirks & FEC_QUIRK_RX_SHIFT16)
> +               val |= FEC_RACC_SHIFT16;
>         if (fep->csum_flags & FLAG_RX_CSUM_ENABLED)
>                 val |= FEC_RACC_OPTIONS;
>         else
> @@ -579,7 +614,7 @@ fec_restart(struct net_device *ndev, int duplex)
>          * The phy interface and speed need to get configured
>          * differently on enet-mac.
>          */
> -       if (id_entry->driver_data & FEC_QUIRK_ENET_MAC) {
> +       if (fep->quirks & FEC_QUIRK_ENET_MAC) {
>                 /* Enable flow control and length check */
>                 rcntl |= 0x40000000 | 0x00000020;
>
> @@ -602,7 +637,7 @@ fec_restart(struct net_device *ndev, int duplex)
>                 }
>         } else {
>  #ifdef FEC_MIIGSK_ENR
> -               if (id_entry->driver_data & FEC_QUIRK_USE_GASKET) {
> +               if (fep->quirks & FEC_QUIRK_USE_GASKET) {
>                         u32 cfgr;
>                         /* disable the gasket and wait */
>                         writel(0, fep->hwp + FEC_MIIGSK_ENR);
> @@ -655,7 +690,7 @@ fec_restart(struct net_device *ndev, int duplex)
>         writel(0, fep->hwp + FEC_HASH_TABLE_LOW);
>  #endif
>
> -       if (id_entry->driver_data & FEC_QUIRK_ENET_MAC) {
> +       if (fep->quirks & FEC_QUIRK_ENET_MAC) {
>                 /* enable ENET endian swap */
>                 ecntl |= (1 << 8);
>                 /* enable ENET store and forward mode */
> @@ -692,8 +727,6 @@ static void
>  fec_stop(struct net_device *ndev)
>  {
>         struct fec_enet_private *fep = netdev_priv(ndev);
> -       const struct platform_device_id *id_entry =
> -                               platform_get_device_id(fep->pdev);
>         u32 rmii_mode = readl(fep->hwp + FEC_R_CNTRL) & (1 << 8);
>
>         /* We cannot expect a graceful transmit stop without link !!! */
> @@ -711,7 +744,7 @@ fec_stop(struct net_device *ndev)
>         writel(FEC_DEFAULT_IMASK, fep->hwp + FEC_IMASK);
>
>         /* We have to keep ENET enabled to have MII interrupt stay working */
> -       if (id_entry->driver_data & FEC_QUIRK_ENET_MAC) {
> +       if (fep->quirks & FEC_QUIRK_ENET_MAC) {
>                 writel(2, fep->hwp + FEC_ECNTRL);
>                 writel(rmii_mode, fep->hwp + FEC_R_CNTRL);
>         }
> @@ -723,6 +756,8 @@ fec_timeout(struct net_device *ndev)
>  {
>         struct fec_enet_private *fep = netdev_priv(ndev);
>
> +       fec_dump(ndev);
> +
>         ndev->stats.tx_errors++;
>
>         fep->delay_work.timeout = true;
> @@ -751,34 +786,28 @@ static void fec_enet_work(struct work_struct *work)
>  static void
>  fec_enet_tx(struct net_device *ndev)
>  {
> -       struct  fec_enet_private *fep;
> -       struct bufdesc *bdp;
> +       struct fec_enet_private *fep = netdev_priv(ndev);
> +       union bufdesc_u *bdp;
>         unsigned short status;
>         struct  sk_buff *skb;
> -       int     index = 0;
> -
> -       fep = netdev_priv(ndev);
> -       bdp = fep->dirty_tx;
> +       unsigned index = fep->tx_dirty;
>
> -       /* get next bdp of dirty_tx */
> -       bdp = fec_enet_get_nextdesc(bdp, fep);
> +       do {
> +               index = (index + 1) & (fep->tx_ring_size - 1);
> +               bdp = fec_enet_tx_get(index, fep);
>
> -       while (((status = bdp->cbd_sc) & BD_ENET_TX_READY) == 0) {
> +               status = bdp->bd.cbd_sc;
> +               if (status & BD_ENET_TX_READY)
> +                       break;
>
>                 /* current queue is empty */
> -               if (bdp == fep->cur_tx)
> +               if (index == fep->tx_next)
>                         break;
>
> -               if (fep->bufdesc_ex)
> -                       index = (struct bufdesc_ex *)bdp -
> -                               (struct bufdesc_ex *)fep->tx_bd_base;
> -               else
> -                       index = bdp - fep->tx_bd_base;
> +               fec_enet_tx_unmap(&bdp->bd, fep);
>
>                 skb = fep->tx_skbuff[index];
> -               dma_unmap_single(&fep->pdev->dev, bdp->cbd_bufaddr, skb->len,
> -                               DMA_TO_DEVICE);
> -               bdp->cbd_bufaddr = 0;
> +               fep->tx_skbuff[index] = NULL;
>
>                 /* Check for errors. */
>                 if (status & (BD_ENET_TX_HB | BD_ENET_TX_LC |
> @@ -797,19 +826,18 @@ fec_enet_tx(struct net_device *ndev)
>                                 ndev->stats.tx_carrier_errors++;
>                 } else {
>                         ndev->stats.tx_packets++;
> -                       ndev->stats.tx_bytes += bdp->cbd_datlen;
> +                       ndev->stats.tx_bytes += bdp->bd.cbd_datlen;
>                 }
>
>                 if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_IN_PROGRESS) &&
>                         fep->bufdesc_ex) {
>                         struct skb_shared_hwtstamps shhwtstamps;
>                         unsigned long flags;
> -                       struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
>
>                         memset(&shhwtstamps, 0, sizeof(shhwtstamps));
>                         spin_lock_irqsave(&fep->tmreg_lock, flags);
>                         shhwtstamps.hwtstamp = ns_to_ktime(
> -                               timecounter_cyc2time(&fep->tc, ebdp->ts));
> +                               timecounter_cyc2time(&fep->tc, bdp->ebd.ts));
>                         spin_unlock_irqrestore(&fep->tmreg_lock, flags);
>                         skb_tstamp_tx(skb, &shhwtstamps);
>                 }
> @@ -825,45 +853,252 @@ fec_enet_tx(struct net_device *ndev)
>
>                 /* Free the sk buffer associated with this last transmit */
>                 dev_kfree_skb_any(skb);
> -               fep->tx_skbuff[index] = NULL;
> -
> -               fep->dirty_tx = bdp;
> -
> -               /* Update pointer to next buffer descriptor to be transmitted */
> -               bdp = fec_enet_get_nextdesc(bdp, fep);
>
>                 /* Since we have freed up a buffer, the ring is no longer full
>                  */
> -               if (fep->dirty_tx != fep->cur_tx) {
> -                       if (netif_queue_stopped(ndev))
> -                               netif_wake_queue(ndev);
> +               if (netif_queue_stopped(ndev)) {
> +
> +
> +
> +
> +
> +                       netif_wake_queue(ndev);
> +
>                 }
> -       }
> +
> +               fep->tx_dirty = index;
> +       } while (1);

where break this while(1);

>         return;
>  }
>
>
> -/* During a receive, the cur_rx points to the current incoming buffer.
> +static void
> +fec_enet_receive(struct sk_buff *skb, union bufdesc_u *bdp, struct net_device *ndev)
> +{
> +       struct fec_enet_private *fep = netdev_priv(ndev);
> +
> +       skb->protocol = eth_type_trans(skb, ndev);
> +
> +       /* Get receive timestamp from the skb */
> +       if (fep->hwts_rx_en && fep->bufdesc_ex) {
> +               struct skb_shared_hwtstamps *shhwtstamps =
> +                                                   skb_hwtstamps(skb);
> +               unsigned long flags;
> +
> +               memset(shhwtstamps, 0, sizeof(*shhwtstamps));
> +
> +               spin_lock_irqsave(&fep->tmreg_lock, flags);
> +               shhwtstamps->hwtstamp = ns_to_ktime(
> +                   timecounter_cyc2time(&fep->tc, bdp->ebd.ts));
> +               spin_unlock_irqrestore(&fep->tmreg_lock, flags);
> +       }
> +
> +       if (fep->csum_flags & FLAG_RX_CSUM_ENABLED) {
> +               if (!(bdp->ebd.cbd_esc & FLAG_RX_CSUM_ERROR)) {
> +                       /* don't check it */
> +                       skb->ip_summed = CHECKSUM_UNNECESSARY;
> +               } else {
> +                       skb_checksum_none_assert(skb);
> +               }
> +       }
> +
> +       napi_gro_receive(&fep->napi, skb);
> +}
> +
> +static void noinline
> +fec_enet_receive_copy(unsigned pkt_len, unsigned index, union bufdesc_u *bdp, struct net_device *ndev)
> +{
> +       struct fec_enet_private *fep = netdev_priv(ndev);
> +       struct sk_buff *skb;
> +       unsigned char *data;
> +       bool vlan_packet_rcvd = false;
> +
> +       /*
> +        * Detect the presence of the VLAN tag, and adjust
> +        * the packet length appropriately.
> +        */
> +       if (ndev->features & NETIF_F_HW_VLAN_CTAG_RX &&
> +           bdp->ebd.cbd_esc & BD_ENET_RX_VLAN) {
> +               pkt_len -= VLAN_HLEN;
> +               vlan_packet_rcvd = true;
> +       }
> +
> +       /* This does 16 byte alignment, exactly what we need. */
> +       skb = netdev_alloc_skb(ndev, pkt_len + NET_IP_ALIGN);
> +       if (unlikely(!skb)) {
> +               ndev->stats.rx_dropped++;
> +               return;
> +       }
> +
> +       dma_sync_single_for_cpu(&fep->pdev->dev, bdp->bd.cbd_bufaddr,
> +                               FEC_ENET_RX_FRSIZE, DMA_FROM_DEVICE);
> +
> +       data = fep->rx_skbuff[index]->data;
> +
> +#ifndef CONFIG_M5272
> +       /*
> +        * If we have enabled this feature, we need to discard
> +        * the two bytes at the beginning of the packet before
> +        * copying it.
> +        */
> +       if (fep->quirks & FEC_QUIRK_RX_SHIFT16) {
> +               pkt_len -= 2;
> +               data += 2;
> +       }
> +#endif
> +
> +       if (fep->quirks & FEC_QUIRK_SWAP_FRAME)
> +               swap_buffer(data, pkt_len);
> +
> +       skb_reserve(skb, NET_IP_ALIGN);
> +       skb_put(skb, pkt_len);  /* Make room */
> +
> +       /* If this is a VLAN packet remove the VLAN Tag */
> +       if (vlan_packet_rcvd) {
> +               struct vlan_hdr *vlan = (struct vlan_hdr *)(data + ETH_HLEN);
> +
> +               __vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q),
> +                                      ntohs(vlan->h_vlan_TCI));
> +
> +               /* Extract the frame data without the VLAN header. */
> +               skb_copy_to_linear_data(skb, data, 2 * ETH_ALEN);
> +               skb_copy_to_linear_data_offset(skb, 2 * ETH_ALEN,
> +                                              data + 2 * ETH_ALEN + VLAN_HLEN,
> +                                              pkt_len - 2 * ETH_ALEN);
> +       } else {
> +               skb_copy_to_linear_data(skb, data, pkt_len);
> +       }
> +
> +       dma_sync_single_for_device(&fep->pdev->dev, bdp->bd.cbd_bufaddr,
> +                                  FEC_ENET_RX_FRSIZE, DMA_FROM_DEVICE);
> +
> +       fec_enet_receive(skb, bdp, ndev);
> +}
> +
> +static void noinline
> +fec_enet_receive_nocopy(unsigned pkt_len, unsigned index, union bufdesc_u *bdp, struct net_device *ndev)
> +{
> +       struct fec_enet_private *fep = netdev_priv(ndev);
> +       struct sk_buff *skb, *skb_new;
> +       unsigned char *data;
> +       dma_addr_t addr;
> +
> +#if 0
> +       skb_new = netdev_alloc_skb(ndev, FEC_ENET_RX_FRSIZE);
> +       if (!skb_new) {
> +               ndev->stats.rx_dropped++;
> +               return;
> +       }
> +
> +       addr = dma_map_single(&fep->pdev->dev, skb_new->data,
> +                             FEC_ENET_RX_FRSIZE, DMA_FROM_DEVICE);
> +       if (dma_mapping_error(&fep->pdev->dev, addr)) {
> +               dev_kfree_skb(skb_new);
> +               ndev->stats.rx_dropped++;
> +               return;
> +       }
> +#else
> +       skb_new = NULL;
> +       addr = 0;
> +#endif
> +
> +       /*
> +        * We have the new skb, so proceed to deal with the
> +        * received data.
> +        */
> +       dma_unmap_single(&fep->pdev->dev, bdp->bd.cbd_bufaddr,
> +                        FEC_ENET_RX_FRSIZE, DMA_FROM_DEVICE);
> +
> +       skb = fep->rx_skbuff[index];
> +
> +       /* Now subsitute in the new skb */
> +       fep->rx_skbuff[index] = skb_new;
> +       bdp->bd.cbd_bufaddr = addr;
> +
> +       /*
> +        * Update the skb length according to the raw packet
> +        * length.  Then remove the two bytes of additional
> +        * padding.
> +        */
> +       skb_put(skb, pkt_len);
> +       data = skb_pull_inline(skb, 2);
> +
> +       if (fep->quirks & FEC_QUIRK_SWAP_FRAME)
> +               swap_buffer(data, skb->len);
> +
> +       /*
> +        * Now juggle things for the VLAN tag - if the hardware
> +        * flags this as present, we need to read the tag, and
> +        * then shuffle the ethernet addresses up.
> +        */
> +       if (ndev->features & NETIF_F_HW_VLAN_CTAG_RX &&
> +           bdp->ebd.cbd_esc & BD_ENET_RX_VLAN) {
> +               struct vlan_hdr *vlan = (struct vlan_hdr *)(data + ETH_HLEN);
> +
> +               __vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q),
> +                                      ntohs(vlan->h_vlan_TCI));
> +
> +               memmove(data + VLAN_HLEN, data, 2 * ETH_ALEN);
> +               skb_pull_inline(skb, VLAN_HLEN);
> +       }
> +
> +       fec_enet_receive(skb, bdp, ndev);
> +}
> +
> +static int
> +fec_enet_refill_ring(unsigned first, unsigned last, struct net_device *ndev)
> +{
> +       struct fec_enet_private *fep = netdev_priv(ndev);
> +       unsigned i = first;
> +
> +       do {
> +               union bufdesc_u *bdp = fec_enet_rx_get(i, fep);
> +               struct sk_buff *skb;
> +               dma_addr_t addr;
> +
> +               if (!fep->rx_skbuff[i]) {
> +                       skb = netdev_alloc_skb(ndev, FEC_ENET_RX_FRSIZE);
> +                       if (!skb)
> +                               return -ENOMEM;
> +
> +                       addr = dma_map_single(&fep->pdev->dev, skb->data,
> +                                             FEC_ENET_RX_FRSIZE, DMA_FROM_DEVICE);
> +                       if (dma_mapping_error(&fep->pdev->dev, addr)) {
> +                               dev_kfree_skb(skb);
> +                               return -ENOMEM;
> +                       }
> +
> +                       fep->rx_skbuff[i] = skb;
> +                       bdp->bd.cbd_bufaddr = addr;
> +               }
> +
> +               bdp->bd.cbd_sc = (bdp->bd.cbd_sc & BD_SC_WRAP) |
> +                                BD_ENET_RX_EMPTY;
> +
> +               if (fep->bufdesc_ex) {
> +                       bdp->ebd.cbd_esc = BD_ENET_RX_INT;
> +                       bdp->ebd.cbd_prot = 0;
> +                       bdp->ebd.cbd_bdu = 0;
> +               }
> +               i = (i + 1) & (fep->rx_ring_size - 1);
> +       } while (i != last);
> +
> +       return 0;
> +}
> +
> +/* During a receive, the rx_next points to the current incoming buffer.
>   * When we update through the ring, if the next incoming buffer has
>   * not been given to the system, we just set the empty indicator,
>   * effectively tossing the packet.
>   */
> -static int
> +static int noinline
>  fec_enet_rx(struct net_device *ndev, int budget)
>  {
>         struct fec_enet_private *fep = netdev_priv(ndev);
> -       const struct platform_device_id *id_entry =
> -                               platform_get_device_id(fep->pdev);
> -       struct bufdesc *bdp;
>         unsigned short status;
> -       struct  sk_buff *skb;
> -       ushort  pkt_len;
> -       __u8 *data;
> +       unsigned pkt_len;
>         int     pkt_received = 0;
> -       struct  bufdesc_ex *ebdp = NULL;
> -       bool    vlan_packet_rcvd = false;
> -       u16     vlan_tag;
> -       int     index = 0;
> +       unsigned index = fep->rx_next;
>
>  #ifdef CONFIG_M532x
>         flush_cache_all();
> @@ -872,12 +1107,16 @@ fec_enet_rx(struct net_device *ndev, int budget)
>         /* First, grab all of the stats for the incoming packet.
>          * These get messed up if we get called due to a busy condition.
>          */
> -       bdp = fep->cur_rx;
> +       do {
> +               union bufdesc_u *bdp = fec_enet_rx_get(index, fep);
>
> -       while (!((status = bdp->cbd_sc) & BD_ENET_RX_EMPTY)) {
> +               status = bdp->bd.cbd_sc;
> +               if (status & BD_ENET_RX_EMPTY)
> +                       break;
>
>                 if (pkt_received >= budget)
>                         break;
> +
>                 pkt_received++;
>
>                 /* Since we have allocated space to hold a complete frame,
> @@ -917,124 +1156,33 @@ fec_enet_rx(struct net_device *ndev, int budget)
>
>                 /* Process the incoming frame. */
>                 ndev->stats.rx_packets++;
> -               pkt_len = bdp->cbd_datlen;
> -               ndev->stats.rx_bytes += pkt_len;
> -
> -               if (fep->bufdesc_ex)
> -                       index = (struct bufdesc_ex *)bdp -
> -                               (struct bufdesc_ex *)fep->rx_bd_base;
> -               else
> -                       index = bdp - fep->rx_bd_base;
> -               data = fep->rx_skbuff[index]->data;
> -               dma_sync_single_for_cpu(&fep->pdev->dev, bdp->cbd_bufaddr,
> -                                       FEC_ENET_RX_FRSIZE, DMA_FROM_DEVICE);
> -
> -               if (id_entry->driver_data & FEC_QUIRK_SWAP_FRAME)
> -                       swap_buffer(data, pkt_len);
> -
> -               /* Extract the enhanced buffer descriptor */
> -               ebdp = NULL;
> -               if (fep->bufdesc_ex)
> -                       ebdp = (struct bufdesc_ex *)bdp;
> -
> -               /* If this is a VLAN packet remove the VLAN Tag */
> -               vlan_packet_rcvd = false;
> -               if ((ndev->features & NETIF_F_HW_VLAN_CTAG_RX) &&
> -                   fep->bufdesc_ex && (ebdp->cbd_esc & BD_ENET_RX_VLAN)) {
> -                       /* Push and remove the vlan tag */
> -                       struct vlan_hdr *vlan_header =
> -                                       (struct vlan_hdr *) (data + ETH_HLEN);
> -                       vlan_tag = ntohs(vlan_header->h_vlan_TCI);
> -                       pkt_len -= VLAN_HLEN;
> -
> -                       vlan_packet_rcvd = true;
> -               }
>
> -               /* This does 16 byte alignment, exactly what we need.
> -                * The packet length includes FCS, but we don't want to
> -                * include that when passing upstream as it messes up
> -                * bridging applications.
> +               /*
> +                * The packet length includes FCS, but we don't want
> +                * to include that when passing upstream as it messes
> +                * up bridging applications.
>                  */
> -               skb = netdev_alloc_skb(ndev, pkt_len - 4 + NET_IP_ALIGN);
> +               pkt_len = bdp->bd.cbd_datlen - 4;
> +               ndev->stats.rx_bytes += pkt_len;
>
> -               if (unlikely(!skb)) {
> -                       ndev->stats.rx_dropped++;
> +               if (fec_enet_rx_zerocopy(fep, pkt_len)) {
> +                       fec_enet_receive_nocopy(pkt_len, index, bdp, ndev);
>                 } else {
> -                       int payload_offset = (2 * ETH_ALEN);
> -                       skb_reserve(skb, NET_IP_ALIGN);
> -                       skb_put(skb, pkt_len - 4);      /* Make room */
> -
> -                       /* Extract the frame data without the VLAN header. */
> -                       skb_copy_to_linear_data(skb, data, (2 * ETH_ALEN));
> -                       if (vlan_packet_rcvd)
> -                               payload_offset = (2 * ETH_ALEN) + VLAN_HLEN;
> -                       skb_copy_to_linear_data_offset(skb, (2 * ETH_ALEN),
> -                                                      data + payload_offset,
> -                                                      pkt_len - 4 - (2 * ETH_ALEN));
> -
> -                       skb->protocol = eth_type_trans(skb, ndev);
> -
> -                       /* Get receive timestamp from the skb */
> -                       if (fep->hwts_rx_en && fep->bufdesc_ex) {
> -                               struct skb_shared_hwtstamps *shhwtstamps =
> -                                                           skb_hwtstamps(skb);
> -                               unsigned long flags;
> -
> -                               memset(shhwtstamps, 0, sizeof(*shhwtstamps));
> -
> -                               spin_lock_irqsave(&fep->tmreg_lock, flags);
> -                               shhwtstamps->hwtstamp = ns_to_ktime(
> -                                   timecounter_cyc2time(&fep->tc, ebdp->ts));
> -                               spin_unlock_irqrestore(&fep->tmreg_lock, flags);
> -                       }
> -
> -                       if (fep->bufdesc_ex &&
> -                           (fep->csum_flags & FLAG_RX_CSUM_ENABLED)) {
> -                               if (!(ebdp->cbd_esc & FLAG_RX_CSUM_ERROR)) {
> -                                       /* don't check it */
> -                                       skb->ip_summed = CHECKSUM_UNNECESSARY;
> -                               } else {
> -                                       skb_checksum_none_assert(skb);
> -                               }
> -                       }
> -
> -                       /* Handle received VLAN packets */
> -                       if (vlan_packet_rcvd)
> -                               __vlan_hwaccel_put_tag(skb,
> -                                                      htons(ETH_P_8021Q),
> -                                                      vlan_tag);
> -
> -                       napi_gro_receive(&fep->napi, skb);
> +                       fec_enet_receive_copy(pkt_len, index, bdp, ndev);
>                 }
>
> -               dma_sync_single_for_device(&fep->pdev->dev, bdp->cbd_bufaddr,
> -                                       FEC_ENET_RX_FRSIZE, DMA_FROM_DEVICE);
>  rx_processing_done:
> -               /* Clear the status flags for this buffer */
> -               status &= ~BD_ENET_RX_STATS;
> -
> -               /* Mark the buffer empty */
> -               status |= BD_ENET_RX_EMPTY;
> -               bdp->cbd_sc = status;
> -
> -               if (fep->bufdesc_ex) {
> -                       struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
> -
> -                       ebdp->cbd_esc = BD_ENET_RX_INT;
> -                       ebdp->cbd_prot = 0;
> -                       ebdp->cbd_bdu = 0;
> -               }
> -
> -               /* Update BD pointer to next entry */
> -               bdp = fec_enet_get_nextdesc(bdp, fep);
> +               index = (index + 1) & (fep->rx_ring_size - 1);
> +               if (index == fep->rx_next)
> +                       break;
> +       } while (1);
>
> -               /* Doing this here will keep the FEC running while we process
> -                * incoming frames.  On a heavily loaded network, we should be
> -                * able to keep up at the expense of system resources.
> -                */
> +       if (pkt_received) {
> +               fec_enet_refill_ring(fep->rx_next, index, ndev);
>                 writel(0, fep->hwp + FEC_R_DES_ACTIVE);
>         }
> -       fep->cur_rx = bdp;
> +
> +       fep->rx_next = index;
>
>         return pkt_received;
>  }
> @@ -1044,29 +1192,25 @@ fec_enet_interrupt(int irq, void *dev_id)
>  {
>         struct net_device *ndev = dev_id;
>         struct fec_enet_private *fep = netdev_priv(ndev);
> +       const unsigned napi_mask = FEC_ENET_RXF | FEC_ENET_TXF;
>         uint int_events;
>         irqreturn_t ret = IRQ_NONE;
>
> -       do {
> -               int_events = readl(fep->hwp + FEC_IEVENT);
> -               writel(int_events, fep->hwp + FEC_IEVENT);
> +       int_events = readl(fep->hwp + FEC_IEVENT);
> +       writel(int_events & ~napi_mask, fep->hwp + FEC_IEVENT);
>
> -               if (int_events & (FEC_ENET_RXF | FEC_ENET_TXF)) {
> -                       ret = IRQ_HANDLED;
> +       if (int_events & napi_mask) {
> +               ret = IRQ_HANDLED;
>
> -                       /* Disable the RX interrupt */
> -                       if (napi_schedule_prep(&fep->napi)) {
> -                               writel(FEC_RX_DISABLED_IMASK,
> -                                       fep->hwp + FEC_IMASK);
> -                               __napi_schedule(&fep->napi);
> -                       }
> -               }
> +               /* Disable the NAPI interrupts */
> +               writel(FEC_ENET_MII, fep->hwp + FEC_IMASK);
> +               napi_schedule(&fep->napi);
> +       }
>
> -               if (int_events & FEC_ENET_MII) {
> -                       ret = IRQ_HANDLED;
> -                       complete(&fep->mdio_done);
> -               }
> -       } while (int_events);
> +       if (int_events & FEC_ENET_MII) {
> +               ret = IRQ_HANDLED;
> +               complete(&fep->mdio_done);
> +       }
>
>         return ret;
>  }
> @@ -1074,10 +1218,24 @@ fec_enet_interrupt(int irq, void *dev_id)
>  static int fec_enet_rx_napi(struct napi_struct *napi, int budget)
>  {
>         struct net_device *ndev = napi->dev;
> -       int pkts = fec_enet_rx(ndev, budget);
>         struct fec_enet_private *fep = netdev_priv(ndev);
> +       unsigned status;
> +       int pkts = 0;
> +
> +       status = readl(fep->hwp + FEC_IEVENT) & (FEC_ENET_RXF | FEC_ENET_TXF);
> +       if (status) {
> +               /*
> +                * Clear any pending transmit or receive interrupts before
> +                * processing the rings to avoid racing with the hardware.
> +                */
> +               writel(status, fep->hwp + FEC_IEVENT);
>
> -       fec_enet_tx(ndev);
> +               if (status & FEC_ENET_RXF)
> +                       pkts = fec_enet_rx(ndev, budget);
> +
> +               if (status & FEC_ENET_TXF)
> +                       fec_enet_tx(ndev);
> +       }
>
>         if (pkts < budget) {
>                 napi_complete(napi);
> @@ -1263,8 +1421,6 @@ static int fec_enet_mdio_reset(struct mii_bus *bus)
>  static int fec_enet_mii_probe(struct net_device *ndev)
>  {
>         struct fec_enet_private *fep = netdev_priv(ndev);
> -       const struct platform_device_id *id_entry =
> -                               platform_get_device_id(fep->pdev);
>         struct phy_device *phy_dev = NULL;
>         char mdio_bus_id[MII_BUS_ID_SIZE];
>         char phy_name[MII_BUS_ID_SIZE + 3];
> @@ -1302,7 +1458,7 @@ static int fec_enet_mii_probe(struct net_device *ndev)
>         }
>
>         /* mask with MAC supported features */
> -       if (id_entry->driver_data & FEC_QUIRK_HAS_GBIT) {
> +       if (fep->quirks & FEC_QUIRK_HAS_GBIT) {
>                 phy_dev->supported &= PHY_GBIT_FEATURES;
>  #if !defined(CONFIG_M5272)
>                 phy_dev->supported |= SUPPORTED_Pause;
> @@ -1329,8 +1485,6 @@ static int fec_enet_mii_init(struct platform_device *pdev)
>         static struct mii_bus *fec0_mii_bus;
>         struct net_device *ndev = platform_get_drvdata(pdev);
>         struct fec_enet_private *fep = netdev_priv(ndev);
> -       const struct platform_device_id *id_entry =
> -                               platform_get_device_id(fep->pdev);
>         int err = -ENXIO, i;
>
>         /*
> @@ -1349,7 +1503,7 @@ static int fec_enet_mii_init(struct platform_device *pdev)
>          * mdio interface in board design, and need to be configured by
>          * fec0 mii_bus.
>          */
> -       if ((id_entry->driver_data & FEC_QUIRK_ENET_MAC) && fep->dev_id > 0) {
> +       if ((fep->quirks & FEC_QUIRK_ENET_MAC) && fep->dev_id > 0) {
>                 /* fec1 uses fec0 mii_bus */
>                 if (mii_cnt && fec0_mii_bus) {
>                         fep->mii_bus = fec0_mii_bus;
> @@ -1370,7 +1524,7 @@ static int fec_enet_mii_init(struct platform_device *pdev)
>          * document.
>          */
>         fep->phy_speed = DIV_ROUND_UP(clk_get_rate(fep->clk_ahb), 5000000);
> -       if (id_entry->driver_data & FEC_QUIRK_ENET_MAC)
> +       if (fep->quirks & FEC_QUIRK_ENET_MAC)
>                 fep->phy_speed--;
>         fep->phy_speed <<= 1;
>         writel(fep->phy_speed, fep->hwp + FEC_MII_SPEED);
> @@ -1405,7 +1559,7 @@ static int fec_enet_mii_init(struct platform_device *pdev)
>         mii_cnt++;
>
>         /* save fec0 mii_bus */
> -       if (id_entry->driver_data & FEC_QUIRK_ENET_MAC)
> +       if (fep->quirks & FEC_QUIRK_ENET_MAC)
>                 fec0_mii_bus = fep->mii_bus;
>
>         return 0;
> @@ -1694,23 +1848,24 @@ static void fec_enet_free_buffers(struct net_device *ndev)
>         struct fec_enet_private *fep = netdev_priv(ndev);
>         unsigned int i;
>         struct sk_buff *skb;
> -       struct bufdesc  *bdp;
>
> -       bdp = fep->rx_bd_base;
>         for (i = 0; i < fep->rx_ring_size; i++) {
> -               skb = fep->rx_skbuff[i];
> +               union bufdesc_u *bdp = fec_enet_rx_get(i, fep);
>
> -               if (bdp->cbd_bufaddr)
> -                       dma_unmap_single(&fep->pdev->dev, bdp->cbd_bufaddr,
> +               skb = fep->rx_skbuff[i];
> +               if (skb) {
> +                       dma_unmap_single(&fep->pdev->dev, bdp->bd.cbd_bufaddr,
>                                         FEC_ENET_RX_FRSIZE, DMA_FROM_DEVICE);
> -               if (skb)
>                         dev_kfree_skb(skb);
> -               bdp = fec_enet_get_nextdesc(bdp, fep);
> +               }
>         }
>
> -       bdp = fep->tx_bd_base;
> -       for (i = 0; i < fep->tx_ring_size; i++)
> +       for (i = 0; i < fep->tx_ring_size; i++) {
> +               union bufdesc_u *bdp = fec_enet_tx_get(i, fep);
> +               if (bdp->bd.cbd_bufaddr)
> +                       fec_enet_tx_unmap(&bdp->bd, fep);
>                 kfree(fep->tx_bounce[i]);
> +       }
>  }
>
>  static int fec_enet_alloc_buffers(struct net_device *ndev)
> @@ -1718,58 +1873,54 @@ static int fec_enet_alloc_buffers(struct net_device *ndev)
>         struct fec_enet_private *fep = netdev_priv(ndev);
>         unsigned int i;
>         struct sk_buff *skb;
> -       struct bufdesc  *bdp;
>
> -       bdp = fep->rx_bd_base;
>         for (i = 0; i < fep->rx_ring_size; i++) {
> +               union bufdesc_u *bdp = fec_enet_rx_get(i, fep);
> +               dma_addr_t addr;
> +
>                 skb = netdev_alloc_skb(ndev, FEC_ENET_RX_FRSIZE);
>                 if (!skb) {
>                         fec_enet_free_buffers(ndev);
>                         return -ENOMEM;
>                 }
> -               fep->rx_skbuff[i] = skb;
>
> -               bdp->cbd_bufaddr = dma_map_single(&fep->pdev->dev, skb->data,
> -                               FEC_ENET_RX_FRSIZE, DMA_FROM_DEVICE);
> -               if (dma_mapping_error(&fep->pdev->dev, bdp->cbd_bufaddr)) {
> +               addr = dma_map_single(&fep->pdev->dev, skb->data,
> +                                     FEC_ENET_RX_FRSIZE, DMA_FROM_DEVICE);
> +               if (dma_mapping_error(&fep->pdev->dev, addr)) {
> +                       dev_kfree_skb(skb);
>                         fec_enet_free_buffers(ndev);
>                         if (net_ratelimit())
>                                 netdev_err(ndev, "Rx DMA memory map failed\n");
>                         return -ENOMEM;
>                 }
> -               bdp->cbd_sc = BD_ENET_RX_EMPTY;
>
> -               if (fep->bufdesc_ex) {
> -                       struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
> -                       ebdp->cbd_esc = BD_ENET_RX_INT;
> -               }
> +               fep->rx_skbuff[i] = skb;
>
> -               bdp = fec_enet_get_nextdesc(bdp, fep);
> -       }
> +               bdp->bd.cbd_bufaddr = addr;
> +               bdp->bd.cbd_sc = BD_ENET_RX_EMPTY;
> +               /* Set the last buffer to wrap. */
> +               if (i == fep->rx_ring_size - 1)
> +                       bdp->bd.cbd_sc |= BD_SC_WRAP;
>
> -       /* Set the last buffer to wrap. */
> -       bdp = fec_enet_get_prevdesc(bdp, fep);
> -       bdp->cbd_sc |= BD_SC_WRAP;
> +               if (fep->bufdesc_ex)
> +                       bdp->ebd.cbd_esc = BD_ENET_RX_INT;
> +       }
>
> -       bdp = fep->tx_bd_base;
>         for (i = 0; i < fep->tx_ring_size; i++) {
> +               union bufdesc_u *bdp = fec_enet_tx_get(i, fep);
>                 fep->tx_bounce[i] = kmalloc(FEC_ENET_TX_FRSIZE, GFP_KERNEL);
>
> -               bdp->cbd_sc = 0;
> -               bdp->cbd_bufaddr = 0;
> -
> -               if (fep->bufdesc_ex) {
> -                       struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
> -                       ebdp->cbd_esc = BD_ENET_TX_INT;
> -               }
> +               /* Set the last buffer to wrap. */
> +               if (i == fep->tx_ring_size - 1)
> +                       bdp->bd.cbd_sc = BD_SC_WRAP;
> +               else
> +                       bdp->bd.cbd_sc = 0;
> +               bdp->bd.cbd_bufaddr = 0;
>
> -               bdp = fec_enet_get_nextdesc(bdp, fep);
> +               if (fep->bufdesc_ex)
> +                       bdp->ebd.cbd_esc = BD_ENET_TX_INT;
>         }
>
> -       /* Set the last buffer to wrap. */
> -       bdp = fec_enet_get_prevdesc(bdp, fep);
> -       bdp->cbd_sc |= BD_SC_WRAP;
> -
>         return 0;
>  }
>
> @@ -1990,9 +2141,7 @@ static const struct net_device_ops fec_netdev_ops = {
>  static int fec_enet_init(struct net_device *ndev)
>  {
>         struct fec_enet_private *fep = netdev_priv(ndev);
> -       const struct platform_device_id *id_entry =
> -                               platform_get_device_id(fep->pdev);
> -       struct bufdesc *cbd_base;
> +       union bufdesc_u *cbd_base;
>
>         /* Allocate memory for buffer descriptors. */
>         cbd_base = dma_alloc_coherent(NULL, PAGE_SIZE, &fep->bd_dma,
> @@ -2014,10 +2163,11 @@ static int fec_enet_init(struct net_device *ndev)
>         /* Set receive and transmit descriptor base. */
>         fep->rx_bd_base = cbd_base;
>         if (fep->bufdesc_ex)
> -               fep->tx_bd_base = (struct bufdesc *)
> -                       (((struct bufdesc_ex *)cbd_base) + fep->rx_ring_size);
> +               fep->tx_bd_base = (union bufdesc_u *)
> +                       (&cbd_base->ebd + fep->rx_ring_size);
>         else
> -               fep->tx_bd_base = cbd_base + fep->rx_ring_size;
> +               fep->tx_bd_base = (union bufdesc_u *)
> +                       (&cbd_base->bd + fep->rx_ring_size);
>
>         /* The FEC Ethernet specific entries in the device structure */
>         ndev->watchdog_timeo = TX_TIMEOUT;
> @@ -2027,19 +2177,24 @@ static int fec_enet_init(struct net_device *ndev)
>         writel(FEC_RX_DISABLED_IMASK, fep->hwp + FEC_IMASK);
>         netif_napi_add(ndev, &fep->napi, fec_enet_rx_napi, NAPI_POLL_WEIGHT);
>
> -       if (id_entry->driver_data & FEC_QUIRK_HAS_VLAN) {
> -               /* enable hw VLAN support */
> -               ndev->features |= NETIF_F_HW_VLAN_CTAG_RX;
> -               ndev->hw_features |= NETIF_F_HW_VLAN_CTAG_RX;
> -       }
> +       if (fep->bufdesc_ex) {
> +               /* Features which require the enhanced buffer descriptors */
> +               netdev_features_t features = 0;
>
> -       if (id_entry->driver_data & FEC_QUIRK_HAS_CSUM) {
> -               /* enable hw accelerator */
> -               ndev->features |= (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM
> -                               | NETIF_F_RXCSUM);
> -               ndev->hw_features |= (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM
> -                               | NETIF_F_RXCSUM);
> -               fep->csum_flags |= FLAG_RX_CSUM_ENABLED;
> +               if (fep->quirks & FEC_QUIRK_HAS_VLAN) {
> +                       /* enable hw VLAN support */
> +                       features |= NETIF_F_HW_VLAN_CTAG_RX;
> +               }
> +
> +               if (fep->quirks & FEC_QUIRK_HAS_CSUM) {
> +                       /* enable hw accelerator */
> +                       features |= NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM |
> +                                   NETIF_F_RXCSUM;
> +                       fep->csum_flags |= FLAG_RX_CSUM_ENABLED;
> +               }
> +
> +               ndev->hw_features |= features;
> +               ndev->features |= features;
>         }
>
>         fec_restart(ndev, 0);
> @@ -2110,13 +2265,6 @@ fec_probe(struct platform_device *pdev)
>         /* setup board info structure */
>         fep = netdev_priv(ndev);
>
> -#if !defined(CONFIG_M5272)
> -       /* default enable pause frame auto negotiation */
> -       if (pdev->id_entry &&
> -           (pdev->id_entry->driver_data & FEC_QUIRK_HAS_GBIT))
> -               fep->pause_flag |= FEC_PAUSE_FLAG_AUTONEG;
> -#endif
> -
>         r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         fep->hwp = devm_ioremap_resource(&pdev->dev, r);
>         if (IS_ERR(fep->hwp)) {
> @@ -2126,6 +2274,14 @@ fec_probe(struct platform_device *pdev)
>
>         fep->pdev = pdev;
>         fep->dev_id = dev_id++;
> +       if (pdev->id_entry)
> +               fep->quirks = pdev->id_entry->driver_data;
> +
> +#if !defined(CONFIG_M5272)
> +       /* default enable pause frame auto negotiation */
> +       if (fep->quirks & FEC_QUIRK_HAS_GBIT)
> +               fep->pause_flag |= FEC_PAUSE_FLAG_AUTONEG;
> +#endif
>
>         fep->bufdesc_ex = 0;
>
> @@ -2160,8 +2316,7 @@ fec_probe(struct platform_device *pdev)
>                 fep->clk_enet_out = NULL;
>
>         fep->clk_ptp = devm_clk_get(&pdev->dev, "ptp");
> -       fep->bufdesc_ex =
> -               pdev->id_entry->driver_data & FEC_QUIRK_HAS_BUFDESC_EX;
> +       fep->bufdesc_ex = fep->quirks & FEC_QUIRK_HAS_BUFDESC_EX;
>         if (IS_ERR(fep->clk_ptp)) {
>                 fep->clk_ptp = NULL;
>                 fep->bufdesc_ex = 0;
>
>
> --
> FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
> improving, and getting towards what was expected from it.
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
