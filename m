From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Tue, 15 Jul 2014 10:46:32 +0200
Subject: [PATCH v4 2/2] can: m_can: add Bosch M_CAN controller support
In-Reply-To: <20140715082637.GA2601@shlinux1.ap.freescale.net>
References: <1405338041-19945-1-git-send-email-b29396@freescale.com>
 <1405338041-19945-2-git-send-email-b29396@freescale.com>
 <53C3C97A.7080102@pengutronix.de>
 <20140715033324.GC21584@shlinux1.ap.freescale.net>
 <53C4D872.9060707@pengutronix.de>
 <20140715082637.GA2601@shlinux1.ap.freescale.net>
Message-ID: <53C4EA68.5090606@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/15/2014 10:26 AM, Dong Aisheng wrote:
>>>>> +static void m_can_read_fifo(const struct net_device *dev, struct can_frame *cf,
>>>>> +			    u32 rxfs)
>>>>> +{
>>>>> +	struct m_can_priv *priv = netdev_priv(dev);
>>>>> +	u32 flags, fgi;
>>>>> +
>>>>> +	/* calculate the fifo get index for where to read data */
>>>>> +	fgi = (rxfs & RXFS_FGI_MASK) >> RXFS_FGI_OFF;
>>>>> +	flags = m_can_fifo_read(priv, fgi, 0x0);
>>>>                                            ^^^
>>>>
>>>> Can you introduce an enum for the offsets, please adjust the signature
>>>> of m_can_fifo_read() accordingly.
>>>>
>>>
>>> I wonder enum may not be suitable.
>>> The Rx Buffer and FIFO Element is as follows:
>>>    31 24 23 16 15 8 7 0
>>> R0 ESI XTD RTR ID[28:0]
>>
>> M_CAN_FIFO_ID
>>
>>> R1 ANMF FIDX[6:0] res EDL BRS DLC[3:0] RXTS[15:0]
>>
>> M_CAN_FIFO_DLC
>>
>>> R2 DB3[7:0] DB2[7:0] DB1[7:0] DB0[7:0]
>>> R3 DB7[7:0] DB6[7:0] DB5[7:0] DB4[7:0]
>>
>> M_CAN_FIFO_DATA0
>> M_CAN_FIFO_DATA1
>>
> 
> You mean as follows?
> enum m_can_fifo {
>         M_CAN_FIFO_ID = 0,
>         M_CAN_FIFO_DLC,
= 0x4,
>         M_CAN_FIFO_DATA0,
= 0x8,
>         M_CAN_FIFO_DATA1,
= 0xc,
> };
> 
> static inline u32 m_can_fifo_read(const struct m_can_priv *priv,
>                                   u32 fgi, enum m_can_fifo fifo)
> {
>         return readl(priv->mram_base + priv->mcfg[MRAM_RXF0].off +
>                      fgi * RXF0_ELEMENT_SIZE + fifo * 0x4);
> }

without the * 0x4

> id = m_can_fifo_read(priv, fgi, M_CAN_FIFO_ID);
> 
> The problem is when adding long frames support, it becomes:
> enum m_can_fifo {
>         M_CAN_FIFO_ID = 0,
>         M_CAN_FIFO_DLC,
>         M_CAN_FIFO_DATA0,
>         M_CAN_FIFO_DATA1,
>         ....
>         M_CAN_FIFO_DATA15,
> };

#define M_CAN_FIFO_DATA(n)
	(enum m_can_fifo)(M_CAN_FIFO_DATA_0 + (n) << 2)

> But it's useless because we may not use enum to read fifo data anymore.
> It's not suitable to read fifo one by one:
> m_can_fifo_read(priv, fgi, M_CAN_FIFO_DATA0);
> m_can_fifo_read(priv, fgi, M_CAN_FIFO_DATA1);
> ..
> m_can_fifo_read(priv, fgi, M_CAN_FIFO_DATA15);
> 
> 
> Instead, we may read data according to real dlc value within a for loop like:
> #define M_CAN_FIFO(n)   (n * 0x4)
> id = m_can_fifo_read(priv, fgi, M_CAN_FIFO(0));
> dlc = m_can_fifo_read(priv, fgi, M_CAN_FIFO(1));
> for (i = 0; dlc > 0; dlc -= 0x4, i++) {
>         ....
>         data[i] = m_can_fifo_read(priv, fgi, M_CAN_FIFO(i + 2));
> }

id = m_can_fifo_read(priv, fgi, M_CAN_FIFO_ID);
dlc = m_can_fifo_read(priv, fgi, M_CAN_FIFO_DLC);
for (i = 0; i <= dlc; i++)
	data[i] = m_can_fifo_read(priv, fgi, M_CAN_FIFO_DATA(i));

> So i'm not sure define that enum now is really needed.

[...]

>>>>> +static int m_can_handle_lec_err(struct net_device *dev,
>>>>> +				enum m_can_lec_type lec_type)
>>>>> +{
>>>>> +	struct m_can_priv *priv = netdev_priv(dev);
>>>>> +	struct net_device_stats *stats = &dev->stats;
>>>>> +	struct can_frame *cf;
>>>>> +	struct sk_buff *skb;
>>>>> +
>>>>> +	/* early exit if no lec update */
>>>>> +	if (lec_type == LEC_UNUSED)
>>>>> +		return 0;
>>>>
>>>> I think this is not needed, as checked by the only caller.
>>>
>>> You mean move it to caller as follows?
>>>         /* handle lec errors on the bus */
>>>         if ((psr & LEC_UNUSED) && ((psr & LEC_UNUSED)!= LEC_UNUSED) &&
>>
>> yes - or something like this:
>>
>> static inline bool is_lec(u32 psr)
>> {
>> 	u32 psr &= LEC_UNUSED
>>
>> 	return psr && (psr != LEC_UNUSED)
>> }
>>
>> 	if ((priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING) &&
>> 		is_lec(psr)) {
>> 	}
>>
> 
> 
> Looks fine.
> Maybe is_lec_err(u32 psr) better? :-)

Yes, is_lec() was just a random placeholder :) Descriptive function
names are always preferred.

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
Size: 242 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140715/ec989657/attachment-0001.sig>
