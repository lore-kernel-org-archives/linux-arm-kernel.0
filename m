From: huziji@marvell.com (Ziji Hu)
Date: Wed, 15 Mar 2017 21:46:07 +0800
Subject: [PATCH v6 03/14] mmc: core: Add mmc-card dt sub-node parse in
 core layer
In-Reply-To: <CAPDyKFoqxMCSe-2bt2dz1AM_2X7dtVe4w6e7+oAQ==HO_=XKQw@mail.gmail.com>
References: <cover.ff78bebe0384f650a51e5e6f0f1dca6e7894b53b.1487091464.git-series.gregory.clement@free-electrons.com>
 <34e51d32c82b57571e061e80df3bbaed731db554.1487091464.git-series.gregory.clement@free-electrons.com>
 <CAPDyKFoqxMCSe-2bt2dz1AM_2X7dtVe4w6e7+oAQ==HO_=XKQw@mail.gmail.com>
Message-ID: <f6a64290-47fb-b9c7-384f-ee87c97ce399@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulf,

On 2017/3/15 20:43, Ulf Hansson wrote:
> On 14 February 2017 at 18:01, Gregory CLEMENT
> <gregory.clement@free-electrons.com> wrote:
>> From: Hu Ziji <huziji@marvell.com>
>>
>> Some vendor host, like Xenon, can support multiple types.
>> In dts, use mmc-card dt sub-node to indicate eMMC is in use.
>>
>> Add a generic mmc-card parse function in mmc core layer.
>> If mmc-card sub-node is detected, set eMMC common caps, such as
>> MMC_CAP_NONREMOVABLE, MMC_CAP2_NO_SD and MMC_CAP2_NO_SDIO.
>>
>> Since it is likely that struct mmc_card is not allocated yet when
>> this mmc-card parse function is called, it will return true if
>> mmc-card sub-node is detected. Otherwise, return false.
>> It can help vendor host determine if the card type is eMMC.
>>
<snip>
>> +bool mmc_of_parse_mmc_card(struct mmc_host *host)
>> +{
>> +       struct device_node *np;
>> +       bool ret = false;
>> +
>> +       np = mmc_of_find_child_device(host, 0);
> 
> There are already some places in the mmc core where child nodes are
> being parsed. You may have a look for mmc_of_find_child_device() and
> find the callers of it.
> 
> Additionally, we need a generic method of how to describe in DT, when
> an mmc host controller has more than one mmc slot. This will also be
> done using child nodes.
> 

	I'd like to confirm if you require a universal child node
	parsing function to deal with all the child node use cases.
	It might be a little difficult to us.

> So, before starting hacking on this, it seems like we need some
> consolidation of the code. In principle, I would like to move the APIs
> for parsing of the child nodes into host.c, along with existing
> mmc_of_parse() function.
> 

	I guess that your requirement is like:
	int mmc_of_pars(struct mmc_host *host)
	{

		...

		np = mmc_of_find_child_device(host, 0);
		if (np && of_device_is_compatible(np, "mmc-card")) {
			...
		}

		...

	}
	Am I correct?

	Actually, I previously tried this implementation.
	But I found that it is difficult to return eMMC card type information
	to our vendor driver. Our Xenon driver expects to know if the device
	is eMMC card through this parse.

>> +       if (np && of_device_is_compatible(np, "mmc-card")) {
>> +               /* mmc-card sub-node indicates eMMC card is in use. */
>> +               host->caps |= MMC_CAP_NONREMOVABLE;
>> +               host->caps2 |= MMC_CAP2_NO_SDIO | MMC_CAP2_NO_SD;
>> +               ret = true;
>> +       }
>> +
> 
> So instead of providing a new mmc OF parse API, let's make
> mmc_of_parse() call another internal function which deals with child
> node parsing.
> 
>> +       of_node_put(np);
>> +       return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(mmc_of_parse_mmc_card);
>> +
>> +/*
>>   * Starting point for MMC card init.
>>   */
>>  int mmc_attach_mmc(struct mmc_host *host)
>> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
>> index e33cc748dcfe..1b27323f3b6e 100644
>> --- a/include/linux/mmc/core.h
>> +++ b/include/linux/mmc/core.h
>> @@ -234,4 +234,6 @@ struct device_node;
>>  extern u32 mmc_vddrange_to_ocrmask(int vdd_min, int vdd_max);
>>  extern int mmc_of_parse_voltage(struct device_node *np, u32 *mask);
>>
>> +extern bool mmc_of_parse_mmc_card(struct mmc_host *host);
>> +
>>  #endif /* LINUX_MMC_CORE_H */
>> --
>> git-series 0.9.1
> 
> If you didn't quite understand my comments, then please tell me. Then
> I can help out cooking some patches for you.

	Thanks a lot. Actually I'm not sure if our implementation to detect
	eMMC card type can meet your requirement of child node parsing.
	Please help provide me some examples or patches.

	Thank you.

Best regards,
Hu Ziji

> 
> Kind regards
> Uffe
> 
