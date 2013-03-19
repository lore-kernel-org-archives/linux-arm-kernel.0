From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 19 Mar 2013 19:39:07 +0100
Subject: [PATCH 1/5] net: Add davicom wemac ethernet driver found on
 Allwinner A10 SoC's
In-Reply-To: <201303161541.37341.florian@openwrt.org>
References: <1363380605-6577-1-git-send-email-maxime.ripard@free-electrons.com>
 <1363380605-6577-2-git-send-email-maxime.ripard@free-electrons.com>
 <201303161541.37341.florian@openwrt.org>
Message-ID: <5148B0CB.4020605@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

Le 16/03/2013 15:41, Florian Fainelli a ?crit :
> Hello Maxime, Stefan,
> 
> Please find below some comments regarding your PHY implementation in the driver 
> as well as the transmit and transmit completion routines.

Stefan implemented the changes you asked about the PHY, it will be in
the next iteration of this patchset.

On a general basis, we don't really know much about this chip, since
we're working without any datasheet on this.

> 
>> +#define WEMAC_PHY		0x100	/* PHY address 0x01 */
> 
> This should be made configurable if possible.

Ok

>> +	unsigned		power_gpio;
> 
> you could make this an int, so that you use gpio_is_valid() on this one.

Alexander Shiyan suggested to move to the regulator API, so I guess we
will just remove that variable.

>> +
>> +static void wemac_dumpblk_32bit(void __iomem *reg, int count)
>> +{
>> +	int i;
>> +	int tmp;
>> +
>> +	for (i = 0; i < (round_up(count, 4) / 4); i++)
>> +		tmp = readl(reg);
>> +}
> 
> This could probably be removed, tmp is a write only location, did you remove 
> the variable printing that came along this?

Hmmm, it looks that way yes. I'll remove it

>> +
>> +static int wemac_ioctl(struct net_device *dev, struct ifreq *req, int cmd)
>> +{
>> +	struct wemac_board_info *dm = to_wemac_board(dev);
>> +
>> +	if (!netif_running(dev))
>> +		return -EINVAL;
>> +
>> +	return generic_mii_ioctl(&dm->mii, if_mii(req), cmd, NULL);
>> +}
>> +
>> +/* ethtool ops */
>> +static void wemac_get_drvinfo(struct net_device *dev,
>> +			      struct ethtool_drvinfo *info)
>> +{
>> +	strcpy(info->driver, DRV_NAME);
>> +	strcpy(info->version, DRV_VERSION);
> 
> You should use strlcpy() here to ensure null-termination, and you should also 
> fill in the bus_info member of struct ethtool_drvinfo.

ok, will do.

>> +	/* Init Driver variable */
>> +	db->tx_fifo_stat = 0;
>> +	dev->trans_start = 0;
> 
> I do not think this is required you are supposed to update this field only in 
> the receive path.

Ok, I'll remove that part.

>> +
>> +	channel = (channel == 1 ? 1 : 0);
>> +
>> +	spin_lock_irqsave(&db->lock, flags);
>> +
>> +	writel(channel, db->membase + EMAC_TX_INS_REG);
>> +
>> +	wemac_outblk_32bit(db->membase + EMAC_TX_IO_DATA_REG,
>> +			skb->data, skb->len);
>> +	dev->stats.tx_bytes += skb->len;
>> +
>> +	db->tx_fifo_stat |= 1 << channel;
>> +	/* TX control: First packet immediately send, second packet queue */
>> +	if (channel == 0) {
>> +		/* set TX len */
>> +		writel(skb->len, db->membase + EMAC_TX_PL0_REG);
>> +		/* start translate from fifo to phy */
>> +		writel(readl(db->membase + EMAC_TX_CTL0_REG) | 1,
>> +		       db->membase + EMAC_TX_CTL0_REG);
> 
> Do not you need some write barrier here to ensure your descriptor address and 
> control are properly written before the EMAC will see these?

writel has a write barrier, so it shouldn't be a problem I guess.

> 
>> +
>> +		/* save the time stamp */
>> +		dev->trans_start = jiffies;
>> +	} else if (channel == 1) {
>> +		/* set TX len */
>> +		writel(skb->len, db->membase + EMAC_TX_PL1_REG);
>> +		/* start translate from fifo to phy */
>> +		writel(readl(db->membase + EMAC_TX_CTL1_REG) | 1,
>> +		       db->membase + EMAC_TX_CTL1_REG);
>> +
>> +		/* save the time stamp */
>> +		dev->trans_start = jiffies;
>> +	}
>> +
>> +	if ((db->tx_fifo_stat & 3) == 3) {
>> +		/* Second packet */
>> +		netif_stop_queue(dev);
> 
> Why is that required? Does that mean that your EMAC can only transmit one 
> packet at a time?

The original driver was working that way, so the hardware can probably
send several packet at a time, but we don't really know how...

>> +static void wemac_tx_done(struct net_device *dev, struct wemac_board_info
>> *db, +			  unsigned int tx_status)
>> +{
>> +	/* One packet sent complete */
>> +	db->tx_fifo_stat &= ~(tx_status & 3);
>> +	if (3 == (tx_status & 3))
>> +		dev->stats.tx_packets += 2;
>> +	else
>> +		dev->stats.tx_packets++;
>> +
>> +	if (netif_msg_tx_done(db))
>> +		dev_dbg(db->dev, "tx done, NSR %02x\n", tx_status);
>> +
>> +	netif_wake_queue(dev);
> 
> Why is that also required? According to your start_xmit function you should do 
> this only when you have transmitted 2 packets no?

I don't know, maybe the code here is more about always having a buffer
of one packet at any point in time. With the current code, when you have
to send packets, it will:
  - send the packet 1
  - stop the queue
  - wait for the packet 1 to be sent
  - once packet 1 is sent, restart the queue, so that it can load a
    packet 3
  - start transmitting packet 2 if there's one, and loop, or just wait
    for it

Which would make sense, and for this, it looks to me that you should
always restart the queue, no matter what the number of packets to send was.

>> +
>> +		reg_val = readl(db->membase + EMAC_RX_IO_DATA_REG);
>> +		if (netif_msg_rx_status(db))
>> +			dev_dbg(db->dev, "receive header: %x\n", reg_val);
>> +		if (reg_val != 0x0143414d) {
> 
> Where is that magic value coming from?

The original code.

Maybe I should define it to something like "UNDOCUMENTED_VOODOO_MAGIC1",
or something like that, but I have no idea what it relates to in the
hardware :S

Thanks for your review,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
