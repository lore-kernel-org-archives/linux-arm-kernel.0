From: yuanzhichang@hisilicon.com (zhichang.yuan)
Date: Thu, 8 Sep 2016 16:06:01 +0800
Subject: [PATCH V2 2/4] ARM64 LPC: LPC driver implementation on Hip06
In-Reply-To: <2175767.JxAh0qjf0L@wuerfel>
References: <1473255233-154297-1-git-send-email-yuanzhichang@hisilicon.com>
 <1473255233-154297-3-git-send-email-yuanzhichang@hisilicon.com>
 <2175767.JxAh0qjf0L@wuerfel>
Message-ID: <57D11BE9.7010709@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Arnd


On 2016/9/7 23:27, Arnd Bergmann wrote:
> On Wednesday, September 7, 2016 9:33:51 PM CEST Zhichang Yuan wrote:
> 
>> +
>> +struct hisilpc_dev;
>> +
>> +/* This flag is specific to differentiate earlycon operations and the others */
>> +#define FG_EARLYCON_LPC		(0x01U << 0)
>> +/*
>> + * this bit set means each IO operation will target to different port address;
>> + * 0 means repeatly IO operations will be sticked on the same port, such as BT;
>> + */
>> +#define FG_INCRADDR_LPC		(0x01U << 1)
> 
> Better express the constants as
> 
> #define FG_EARLYCON_LPC	0x0001
> #define FG_INCRADDR_LPC	0x0002
Ok. Will revise.
> 
>> +struct lpc_io_ops {
>> +	unsigned int periosz;
>> +	int (*lpc_iord)(struct hisilpc_dev *pdev, struct lpc_cycle_para *para,
>> +				unsigned long ptaddr, unsigned char *buf,
>> +				unsigned long dlen);
>> +	int (*lpc_iowr)(struct hisilpc_dev *pdev, struct lpc_cycle_para *para,
>> +				unsigned long ptaddr,
>> +				const unsigned char *buf,
>> +				unsigned long dlen);
>> +};
> 
> The operations are not needed unless we also put the earlycon support
> in, so maybe leave them out from the first patch and only add them
> later (or drop the earlycon support if possible).

Do you want to remove the struct lpc_io_ops member from struct hisilpc_dev??
I think we can not do that.

These two functions are essential rd/wr operation for Hip06 LPC. They will be fallen into
when the upper layer drivers call their own IO in/out functions, such as serial_in/serial_out
for 8250 serial.

I can define lpc_iord/lpc_iowr directly in struct hisilpc_dev and cancel the definition of
struct lpc_io_ops. In my original idea, several LPC cycle types will be supported. Each cycle
type has its specific ops. Now, only one cycle type is needed, the struct lpc_io_ops is not
meaningful.

> 
>> +/**
>> + * hisilpc_remove - the remove callback function for hisi lpc device.
>> + * @pdev: the platform device corresponding to hisi lpc that is to be removed.
>> + *
>> + * Returns 0 on success, non-zero on fail.
>> + *
>> + */
>> +static int hisilpc_remove(struct platform_device *pdev)
>> +{
>> +	return 0;
>> +}
> 
> It seems that it should not be possible to remove this driver,
> please use builtin_platform_driver() then and remove this callback.
Yes. Will use builtin_platform_driver for the unnecessary remove callback.

Best,
Zhichang
> 
> 	Arnd
> 
> .
> 
