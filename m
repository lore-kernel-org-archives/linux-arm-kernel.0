From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat, 11 Jan 2014 19:35:21 +0100
Subject: [PATCH v2 13/28] drm/i2c: tda998x: use irq for connection status
 and EDID read
In-Reply-To: <20140111181432.GB15937@n2100.arm.linux.org.uk>
References: <20140109120412.7697d23c@armhf>
 <20140111181432.GB15937@n2100.arm.linux.org.uk>
Message-ID: <52D18EE9.5030305@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/11/2014 07:14 PM, Russell King - ARM Linux wrote:
> On Thu, Jan 09, 2014 at 12:04:12PM +0100, Jean-Francois Moine wrote:
>> @@ -1250,6 +1311,39 @@ tda998x_encoder_init(struct i2c_client *client,
>>   		priv->vip_cntrl_2 = video;
>>   	}
>>
>> +	/* install the optional HDMI connect IRQ */
>> +	priv->int_irq = irq_of_parse_and_map(np, 0);
>> +	if (priv->int_irq < 0)
>> +		priv->int_irq = NO_IRQ;
>> +	if (priv->int_irq != NO_IRQ) {
>
> NAK.  Do not use NO_IRQ.  Use <= 0 instead, or just test against zero for
> no IRQ.  It would also be nice to offer this facility to non-DT platforms
> via client->irq.  Not every arch in the Linux kernel uses DT.

At least for the DT part, I'd suggest to not ask for interrupt directly
but use a proper gpios property. The can of course be converted to
priv->int_irq in some tda998x_dt_probe.

Sebastian
