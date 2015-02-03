From: emilio@elopez.com.ar (=?UTF-8?B?RW1pbGlvIEzDs3Bleg==?=)
Date: Tue, 03 Feb 2015 15:43:32 -0300
Subject: [PATCH v4] dma: sun4i: Add support for the DMA engine on sun[457]i
 SoCs
In-Reply-To: <1422785038.28275.34.camel@plaes.org>
References: <1422745124-22103-1-git-send-email-emilio@elopez.com.ar>	
 <1422745124-22103-2-git-send-email-emilio@elopez.com.ar>
 <1422785038.28275.34.camel@plaes.org>
Message-ID: <54D116D4.3030004@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

El 01/02/15 a las 07:03, Priit Laes escibi?:
> On Sat, 2015-01-31 at 19:58 -0300, Emilio L?pez wrote:
>> This patch adds support for the DMA engine present on Allwinner A10,
>> A13, A10S and A20 SoCs. This engine has two kinds of channels:
>> normal and dedicated. The main difference is in the mode of
>> operation; while a single normal channel may be operating at any
>> given time, dedicated channels may operate simultaneously provided
>> there is no overlap of source or destination.
>>
>> Hardware documentation can be found on A10 User Manual (section 12),
>> A13 User Manual (section 14) and A20 User Manual (section 1.12)
>>
>> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
(...)
>> diff --git a/Documentation/devicetree/bindings/dma/sun4i-dma.txt b/Documentation/devicetree/bindings/dma/sun4i-dma.txt
>> new file mode 100644
>> index 0000000..f1634a2
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/dma/sun4i-dma.txt
>> @@ -0,0 +1,46 @@
>> +Allwinner A10 DMA Controller
>
> Don't you want to mention A13, A10S and A20 too?

What if a new SoC shows up with this controller? :) I'd rather give a
single name to the IP, like we do with the compatible strings.

(...)

>> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
>> index 2022b54..675b98f 100644
>> --- a/drivers/dma/Makefile
>> +++ b/drivers/dma/Makefile
>> @@ -50,3 +50,4 @@ obj-y += xilinx/
>>  obj-$(CONFIG_INTEL_MIC_X100_DMA) += mic_x100_dma.o
>>  obj-$(CONFIG_NBPFAXI_DMA) += nbpfaxi.o
>>  obj-$(CONFIG_DMA_SUN6I) += sun6i-dma.o
>> +obj-$(CONFIG_SUN4I_DMA) += sun4i-dma.o
>> diff --git a/drivers/dma/sun4i-dma.c b/drivers/dma/sun4i-dma.c new file mode 100644
>> index 0000000..a025405
>> --- /dev/null
>> +++ b/drivers/dma/sun4i-dma.c
>> @@ -0,0 +1,1264 @@
>> +/*
>> + * Copyright (C) 2014 Emilio L?pez
>
> 2014, 2015 ?

I guess so :)

(...)
>> +static int convert_burst(u32 maxburst)
>> +{
>> +       if (maxburst > 8)
>> +               return -EINVAL;
> Would it make sense to add check for maxburst = 0 too?

I can add one if you feel it's needed.

>> +
>> +       /* 1 -> 0, 4 -> 1, 8 -> 2 */
>> +       return (maxburst >> 2);
>> +}
>> +
>> +static int convert_buswidth(enum dma_slave_buswidth addr_width)
>> +{
>> +       if (addr_width > DMA_SLAVE_BUSWIDTH_4_BYTES)
>> +               return -EINVAL;
>> +
>> +       /* 8 (1 byte) -> 0, 16 (2 bytes) -> 1, 32 (4 bytes) -> 2 */
>> +       return (addr_width >> 1);
>> +}
>> +
>> +static int choose_optimal_buswidth(dma_addr_t addr)
>> +{
>> +       /* On 32 bit aligned addresses, we can use a 32 bit bus width */
>> +       if (addr % 4 == 0)
>
> Not sure, whether it makes sense to optimize or not, but this can be
> calculated like this:
>
> (addr & (4 - 1)) == 0

It looks like IS_ALIGNED() in <linux/kernel.h> is what we need here.

>> +static struct sun4i_dma_promise *
>> +generate_ddma_promise(struct dma_chan *chan, dma_addr_t src, dma_addr_t dest,
>> +                                                               size_t len, struct dma_slave_config *sconfig)
>> +{
>> +       struct sun4i_dma_promise *promise;
>> +       int ret;
>> +
>> +       promise = kzalloc(sizeof(*promise), GFP_NOWAIT);
>> +       if (!promise)
>> +               return NULL;
>> +
>> +       promise->src = src;
>> +       promise->dst = dest;
>> +       promise->len = len;
>> +
>
> No timing parameters or this is just a quirk required for SPI?

They're filled together with the endpoints, in case we need different
ones for some other device. There's a big comment block explaining the
situation on top of their assignment.

>>        promise->cfg = DDMA_CFG_LOADING |
>> DDMA_CFG_BYTE_COUNT_MODE_REMAIN;
>> +
>> +       /* Source burst */
>> +       ret = convert_burst(sconfig->src_maxburst);
>> +       if (IS_ERR_VALUE(ret))
>> +               goto fail;
>> +       promise->cfg |= DDMA_CFG_SRC_BURST_LENGTH(ret);
>> +

Thanks for reviewing this! :)

Emilio
