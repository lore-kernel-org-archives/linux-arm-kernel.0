From: monstr@monstr.eu (Michal Simek)
Date: Fri, 14 Feb 2014 10:13:20 +0100
Subject: [PATCH v2] can: xilinx CAN controller support.
In-Reply-To: <52FDDC24.8070805@pengutronix.de>
References: <\> <0dc128ac-e5cd-47bd-9ab1-3a545c3e2043@CO9EHSMHS012.ehs.local>
 <52FD1B16.6020600@pengutronix.de> <52FDD9FE.8040908@monstr.eu>
 <52FDDC24.8070805@pengutronix.de>
Message-ID: <52FDDE30.8020405@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/14/2014 10:04 AM, Marc Kleine-Budde wrote:
> On 02/14/2014 09:55 AM, Michal Simek wrote:
>> Hi Marc,
>>
>>>> +	int waiting_ech_skb_num;
>>>> +	int xcan_echo_skb_max_tx;
>>>> +	int xcan_echo_skb_max_rx;
>>>> +	struct napi_struct napi;
>>>> +	spinlock_t ech_skb_lock;
>>>> +	u32 (*read_reg)(const struct xcan_priv *priv, int reg);
>>>> +	void (*write_reg)(const struct xcan_priv *priv, int reg, u32 val);
>>>
>>> Please remove read_reg, write_reg, as long as there isn't any BE support
>>> in the driver, call them directly.
>>
>> That's not entirely truth. If you look at Microblaze then you will see
>> that Microblaze can be BE and LE.
>> There is just missing endian detection which we will add to the next version.
> 
> As far as I know the endianess of the kernel is fixed and known during
> compile time. Correct me if I'm wrong. So there is no need for a runtime
> detection of the endianess and so no need for {read,write}_reg function
> pointers.

Endianess of the kernel is fixed and know during compile time
but what it is not fixed is endianess of that IP at compile time.

On fpga you can use bridges, partial reconfiguration, etc where
the only solution which is run-time endian detection via registers.

For example: drivers/block/xsysace.c, drivers/spi/spi-xilinx.c, etc

>> But because MB io helper functions are broken for a while you should be
>> able to use this driver on both endianess.
>>
>> btw: I would prefer to use ioread32 and ioread32be instead of readl.
>> Is it OK for you?
> 
> Make it so. :)

Thanks,
Michal


-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140214/6445e2d1/attachment-0001.sig>
