From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Fri, 14 Feb 2014 10:04:36 +0100
Subject: [PATCH v2] can: xilinx CAN controller support.
In-Reply-To: <52FDD9FE.8040908@monstr.eu>
References: <\> <0dc128ac-e5cd-47bd-9ab1-3a545c3e2043@CO9EHSMHS012.ehs.local>
 <52FD1B16.6020600@pengutronix.de> <52FDD9FE.8040908@monstr.eu>
Message-ID: <52FDDC24.8070805@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/14/2014 09:55 AM, Michal Simek wrote:
> Hi Marc,
> 
>>> +	int waiting_ech_skb_num;
>>> +	int xcan_echo_skb_max_tx;
>>> +	int xcan_echo_skb_max_rx;
>>> +	struct napi_struct napi;
>>> +	spinlock_t ech_skb_lock;
>>> +	u32 (*read_reg)(const struct xcan_priv *priv, int reg);
>>> +	void (*write_reg)(const struct xcan_priv *priv, int reg, u32 val);
>>
>> Please remove read_reg, write_reg, as long as there isn't any BE support
>> in the driver, call them directly.
> 
> That's not entirely truth. If you look at Microblaze then you will see
> that Microblaze can be BE and LE.
> There is just missing endian detection which we will add to the next version.

As far as I know the endianess of the kernel is fixed and known during
compile time. Correct me if I'm wrong. So there is no need for a runtime
detection of the endianess and so no need for {read,write}_reg function
pointers.

> But because MB io helper functions are broken for a while you should be
> able to use this driver on both endianess.
> 
> btw: I would prefer to use ioread32 and ioread32be instead of readl.
> Is it OK for you?

Make it so. :)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140214/93e45d11/attachment.sig>
