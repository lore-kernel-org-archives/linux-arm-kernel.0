From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Tue, 15 Sep 2015 16:46:33 +0200
Subject: [PATCH v7 3/3] can: Allwinner A10/A20 CAN Controller support -
 Kernel module
In-Reply-To: <20150915142810.GM4684@lukather>
References: <1442272632-20251-1-git-send-email-info@gerhard-bertelsmann.de>
 <1442272632-20251-4-git-send-email-info@gerhard-bertelsmann.de>
 <20150915142810.GM4684@lukather>
Message-ID: <55F82F49.8020901@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/15/2015 04:28 PM, Maxime Ripard wrote:
>> +static int sunxican_get_berr_counter(const struct net_device *dev,
>> +				     struct can_berr_counter *bec)
>> +{
>> +	struct sunxican_priv *priv = netdev_priv(dev);
>> +	u32 errors;
>> +	int err;
>> +
>> +	err = clk_prepare_enable(priv->clk);
>> +	if (err) {
>> +		netdev_err(dev, "could not enable clock\n");
>> +		return err;
>> +	}
> 
> Can this function be called if the device is closed? If not, then this
> clock calls are useless.

Yes, that's why there are there.

> 
>> +	errors = readl(priv->base + SUNXI_REG_ERRC_ADDR);
>> +
>> +	bec->txerr = errors & 0xFF;
>> +	bec->rxerr = (errors >> 16) & 0xFF;
>> +
>> +	clk_disable_unprepare(priv->clk);
>> +
>> +	return 0;
>> +}

[...]

>> +static int sunxican_open(struct net_device *dev)
>> +{
>> +	struct sunxican_priv *priv = netdev_priv(dev);
>> +	int err;
>> +
>> +	/* common open */
>> +	err = open_candev(dev);
>> +	if (err)
>> +		return err;
>> +
>> +	/* register interrupt handler */
>> +	err = request_irq(dev->irq, sunxi_can_interrupt, IRQF_SHARED,
> 
> We don't have any shared interrupt as far as I know, do you really
> need this flag?

Not needed, but the IRQ handler properly returns HANDLED or NONE. So
it's better to remove this flag then?

> 
>> +			  dev->name, dev);
>> +	if (err) {
>> +		netdev_err(dev, "request_irq err: %d\n", err);
>> +		goto exit_irq;
>> +	}
>> +
>> +	/* turn on clocking for CAN peripheral block */
>> +	err = clk_prepare_enable(priv->clk);
>> +	if (err) {
>> +		netdev_err(dev, "could not enable CAN peripheral clock\n");
>> +		goto exit_clock;
>> +	}
>> +
>> +	err = sunxi_can_start(dev);
>> +	if (err) {
>> +		netdev_err(dev, "could not start CAN peripheral\n");
>> +		goto exit_can_start;
>> +	}
>> +
>> +	can_led_event(dev, CAN_LED_EVENT_OPEN);
>> +	netif_start_queue(dev);
>> +
>> +	return 0;
>> +
>> +exit_can_start:
>> +	clk_disable_unprepare(priv->clk);
>> +exit_clock:
>> +	free_irq(dev->irq, dev);
>> +exit_irq:
>> +	close_candev(dev);
>> +	return err;
>> +}

Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 455 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150915/9ddd99fc/attachment-0001.sig>
