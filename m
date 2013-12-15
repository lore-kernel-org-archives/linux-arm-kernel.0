From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 15 Dec 2013 15:20:19 +0100
Subject: [PATCH 1/5] ARM: sunxi: Add driver for SD/MMC hosts found on
 Allwinner sunxi SoCs
In-Reply-To: <20131215134415.GE3651@lukather>
References: <1387058295-20641-1-git-send-email-hdegoede@redhat.com>
 <1387058295-20641-2-git-send-email-hdegoede@redhat.com>
 <20131215134415.GE3651@lukather>
Message-ID: <52ADBAA3.7060507@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 12/15/2013 02:44 PM, Maxime Ripard wrote:
> Hi Hans,
>
> I won't comment on the MMC driver itself, and leave Chris comment on
> that, but still, I have a few things.
>
> On Sat, Dec 14, 2013 at 10:58:11PM +0100, Hans de Goede wrote:
>> From: David Lanzend?rfer <david.lanzendoerfer@o2s.ch>
>>
>> This is based on the driver Allwinner ships in there Android kernel sources.
>>
>> Initial porting to upstream kernels done by David Lanzend?rfer, additional
>> fixes and cleanups by Hans de Goede.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>
> Your commit log is a bit sparse. What capabilities this controller
> has? Is it using DMA? If so, how? What SoCs are supported/it has been
> tested on? etc.

David, since you'll be doing v2 I guess you'll be filling in v2. FYI
I've tested this on sun4i-a10, sun5i-a10s sun5i-a13 and sun7i-a20.

It uses dma in bus-master mode using a built-in designware idmac controller,
which is identical to the one found in the mmc-dw hosts. Note the rest of
the host is not identical, I've looked into reusing the mmc-dw driver but
that does not seem like a good idea (manual sending stop commands
versus auto stop on sunxi, completely different registers, etc.).

>
> Also, you probably needs David's SoB here.

The plan is for David to send v2 of this patch-set so that should take care of
that :)

>
>> ---
>>   drivers/mmc/host/Kconfig     |   8 +
>>   drivers/mmc/host/Makefile    |   2 +
>>   drivers/mmc/host/sunxi-mci.c | 908 +++++++++++++++++++++++++++++++++++++++++++
>>   drivers/mmc/host/sunxi-mci.h | 246 ++++++++++++
>>   include/linux/clk/sunxi.h    |  22 ++
>
> Please add your dt bindings documentation in Documentation/devicetree/bindings
>

<snip>

>> +#include "sunxi-mci.h"
>> +
>> +static void sunxi_mmc_init_host(struct mmc_host *mmc)
>> +{
>> +	u32 rval;
>> +	struct sunxi_mmc_host *smc_host = mmc_priv(mmc);
>> +
>> +	/* reset controller */
>> +	rval = mci_readl(smc_host, REG_GCTRL) | SDXC_HWReset;
>> +	mci_writel(smc_host, REG_GCTRL, rval);
>> +
>> +	mci_writel(smc_host, REG_FTRGL, 0x20070008);

These set tx/rx FIFO thresholds, I think 7 is one, 8 is the
other (no idea which is which) and the 2 is magic ...

>> +	mci_writel(smc_host, REG_TMOUT, 0xffffffff);
>> +	mci_writel(smc_host, REG_IMASK, smc_host->sdio_imask);
>> +	mci_writel(smc_host, REG_RINTR, 0xffffffff);

This simple clears any interrupt flags left set by uboot

>> +	mci_writel(smc_host, REG_DBGC, 0xdeb);

Unknown

>> +	mci_writel(smc_host, REG_FUNS, 0xceaa0000);

There actually is a define for this in the .h file
called: "SDXC_CEATAOn" no idea what that means though,
I guess we should use the define here. David can you
fix this in v2 ?

>> +	mci_writel(smc_host, REG_DLBA, smc_host->sg_dma);
>
> I suppose we have no idea what these magics are all about ? :(

See above, we have some idea, but not much.

>
>> +	rval = mci_readl(smc_host, REG_GCTRL)|SDXC_INTEnb;
>> +	rval &= ~SDXC_AccessDoneDirect;
>> +	mci_writel(smc_host, REG_GCTRL, rval);
>> +}

<snip>

>> +static const struct of_device_id sunxi_mmc_of_match[] = {
>> +	{ .compatible = "allwinner,sun4i-mmc", },
>> +	{ .compatible = "allwinner,sun5i-mmc", },
>
> Please use sun5i-a13-mmc as your compatible.

Can you explain a bit why? In essence currently we have
2 versions of the mmc controller, those found on sun4i
and those found on sun5i and sun7i. I thought that the
norm was to use the oldest soc version in which a revision
of an ip-block first appears as the compatible string ?

Note I've tested this with both a13 and a10s SOCs, if we
add a sun5i-a13-mmc we should also add a sun5i-a10s-mmc
and a sun5i-a20-mmc, or would that then be sun7i-a20-mmc?

To me just having sun5i-mmc for sun5i+ socs seems simpler.

<snip>

>> +	mmc->ops		= &sunxi_mmc_ops;
>> +	mmc->max_blk_count	= 8192;
>> +	mmc->max_blk_size	= 4096;
>> +	mmc->max_segs		= PAGE_SIZE / sizeof(struct sunxi_idma_des);
>> +	mmc->max_seg_size	= (1 << host->idma_des_size_bits);
>> +	mmc->max_req_size	= mmc->max_seg_size * mmc->max_segs;
>> +	/* 400kHz ~ 50MHz */
>> +	mmc->f_min		=   400000;
>> +	mmc->f_max		= 50000000;
>
> Hmmm, the tables earlier seem to suggest it can do much more than that.

I know, but this is what the allwinner android kernels are using, actually
in case of sdc3 they are putting 200000000 in f_max (as that is often
used for sdio cards) but then later in set_ios they clamp the passed
in clock to 47000000 Mhz, so I seriously doubt that 200Mhz has actually
worked. Hence I've simply gone for a safe range for now. If someone has
cards capable of doing 200 MHz we could certainly run various tests and
try to improve this, but for now this seems a sane range to start with.

<snip>

 >> +	/* indicator pins */
 >> +	int wp_pin;
 >> +	int cd_pin;
 >> +	int cd_mode;
 >> +#define CARD_DETECT_BY_GPIO_POLL (1)	/* mmc detected by gpio check */
 >> +#define CARD_ALWAYS_PRESENT      (2)	/* mmc always present */
 >
 > Just a question here, have you tested to use the external interrupts?
 > (Is that even possible on the pins that are used as card detect?)
 >

No I've not tried that, there was code for this in the original allwinner
driver, but no boards were actually using it.

As for it being possible on the pins being used, it is possible on (most)
port H pins and the cubie* and a20-olinuxino-micro boards are using PH pins
for cd. Others are not.  One thing which worries me about this is debouncing,
using polling is automatically debounced, using an external interrupt won't
be. Ideally there would be some common code somewhere to deal with gpio
connected buttons (which this in essence is) which does debouncing ...

Again I think this is something best left as a future enhancement.

<snip>

>> diff --git a/include/linux/clk/sunxi.h b/include/linux/clk/sunxi.h
>> new file mode 100644
>> index 0000000..1ef5c89
>> --- /dev/null
>> +++ b/include/linux/clk/sunxi.h
>> @@ -0,0 +1,22 @@
>> +/*
>> + * Copyright 2013 - Hans de Goede <hdegoede@redhat.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#ifndef __LINUX_CLK_SUNXI_H_
>> +#define __LINUX_CLK_SUNXI_H_
>> +
>> +#include <linux/clk.h>
>> +
>> +void clk_sunxi_mmc_phase_control(struct clk_hw *hw, u8 sample, u8 output);
>> +
>> +#endif
>
> Hmmm, I see no implementation for this function. Didn't you forget
> a file here? (and it should probably be a separate patch anyway).

The implementation is part of Emilio's clk branch, but he forgot
to add a header for it, so I'm fixing that up here, I guess this
should go through Emlio's tree as a separate patch.

> Thanks a lot for this work,

You're welcome. I think it is great to see how far along upstream sunxi
support has come thanks to work of all involved. It is really becoming
usable now :)

Regards,

Hans
