From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 30 Jul 2016 09:30:01 +0800
Subject: [PATCH v2 1/5] ethernet: add sun8i-emac driver
In-Reply-To: <20160729172526.GE6215@lukather>
References: <1469001800-11615-1-git-send-email-clabbe.montjoie@gmail.com>
 <1469001800-11615-2-git-send-email-clabbe.montjoie@gmail.com>
 <20160725195455.GQ7419@lukather> <20160728145734.GD7582@Red>
 <20160729172526.GE6215@lukather>
Message-ID: <CAGb2v678MidsiV=QJjk1bvAPL-hRFyNzZy636aObEG+HC908xw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 30, 2016 at 1:25 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Thu, Jul 28, 2016 at 04:57:34PM +0200, LABBE Corentin wrote:
>> > > +static int sun8i_mdio_write(struct mii_bus *bus, int phy_addr, int phy_reg,
>> > > +                     u16 data)
>> > > +{
>> > > + struct net_device *ndev = bus->priv;
>> > > + struct sun8i_emac_priv *priv = netdev_priv(ndev);
>> > > + u32 reg;
>> > > + int err;
>> > > +
>> > > + err = readl_poll_timeout(priv->base + SUN8I_EMAC_MDIO_CMD, reg,
>> > > +                          !(reg & MDIO_CMD_MII_BUSY), 100, 10000);
>> > > + if (err) {
>> > > +         dev_err(priv->dev, "%s timeout %x\n", __func__, reg);
>> > > +         return err;
>> > > + }
>> >
>> > Why the poll_timeout variant?
>> >
>> Because, in case of bad clock/reset/regulator setting, the value
>> expected to come could never be set.
>
> Ah, I missed that it was for a busy bit, my bad. However, you seem to
> be using that on several occasions, maybe you could turn that into a
> function?
>
>> > > +static void sun8i_emac_unset_syscon(struct net_device *ndev)
>> > > +{
>> > > + struct sun8i_emac_priv *priv = netdev_priv(ndev);
>> > > + u32 reg = 0;
>> > > +
>> > > + if (priv->variant == H3_EMAC)
>> > > +         reg = H3_EPHY_DEFAULT_VALUE;
>> >
>> > Why do you need that?
>> >
>> For resetting the syscon to the factory default.
>
> Yes, but does it matter? Does it have any side effect? Is that
> register shared with another device?
>
> Otherwise, either it won't be used anymore, and you don't care, or you
> will reload the driver later, and the driver should work whatever
> state is programmed in there. In both cases, you don't need to reset
> that value.

The "default" setting also disables and powers down the internal PHY.
I think that's a good thing? The naming could be better.

>> > > +static irqreturn_t sun8i_emac_dma_interrupt(int irq, void *dev_id)
>> > > +{
>> > > + struct net_device *ndev = dev_id;
>> > > + struct sun8i_emac_priv *priv = netdev_priv(ndev);
>> > > + u32 v, u;
>> > > +
>> > > + v = readl(priv->base + SUN8I_EMAC_INT_STA);
>> > > +
>> > > + /* When this bit is asserted, a frame transmission is completed. */
>> > > + if (v & BIT(0)) {
>> > > +         priv->estats.tx_int++;
>> > > +         writel(0, priv->base + SUN8I_EMAC_INT_EN);
>> > > +         napi_schedule(&priv->napi);
>> > > + }
>> > > +
>> > > + /* When this bit is asserted, the TX DMA FSM is stopped. */
>> > > + if (v & BIT(1))
>> > > +         priv->estats.tx_dma_stop++;
>> > > +
>> > > + /* When this asserted, the TX DMA can not acquire next TX descriptor
>> > > +  * and TX DMA FSM is suspended.
>> > > + */
>> > > + if (v & BIT(2))
>> > > +         priv->estats.tx_dma_ua++;
>> > > +
>> > > + if (v & BIT(3))
>> > > +         netif_dbg(priv, intr, ndev, "Unhandled interrupt TX TIMEOUT\n");
>> >
>> > Why do you enable that interrupt if you can't handle it?
>>
>> Some interrupt fire even when not enabled (like RX_BUF_UA_INT/TX_BUF_UA_INT)
>
> So the bits 9 and 2, respectively, in the interrupt enable register
> are useless?

Does it actually fire, i.e. pull the interrupt line on the GIC? Or is it just
the interrupt state showing an event? IIRC some other hardware blocks have this
behavior, such as the timer.

ChenYu

>> > And printing in the interrupt handler is a very bad idea.
>>
>> There are printed only when DEBUG is set, so not a problem ?
>
> It's always a problem, this adds a very significant latency and will
> fill the kernel log buffer at an insane rate, flushing out actual
> important messages, for no particular reason.
>> > > +
>> > > + return IRQ_HANDLED;
>> >
>> > The lack of spinlocks in there is quite worrying.
>> >
>>
>> The interrupt handler just do nothing harmfull if it race with itself.
>> Just stats, enabling NAPI etc..
>> Anyway, It miss a comment for that non-locking strategy
>
> The interrupt handler cannot race with itself. The interrupts will be
> masked on the local CPU and the interrupt can only be delivered to a
> single CPU (so, the one that the handler is currently running from).
>
>> > > +}
>> > > +
>> > > +static int sun8i_emac_probe(struct platform_device *pdev)
>> > > +{
>> > > + struct device_node *node = pdev->dev.of_node;
>> > > + struct sun8i_emac_priv *priv;
>> > > + struct net_device *ndev;
>> > > + struct resource *res;
>> > > + int ret;
>> > > +
>> > > + ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
>> > > + if (ret) {
>> > > +         dev_err(&pdev->dev, "No suitable DMA available\n");
>> > > +         return ret;
>> > > + }
>> >
>> > Isn't that the default?
>> >
>> No, it is necessary on arm64 as apritzel requested.
>
> http://lxr.free-electrons.com/source/drivers/of/device.c#L93
>
> It seems to be shared between the two.
>
> Thanks!
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
