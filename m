From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 9 Oct 2017 13:20:37 +0100
Subject: [PATCH] nvmem: sunxi-sid: add support for A64/H5's SID controller
In-Reply-To: <20170919082019.6bopwauso4mbslqo@flea.lan>
References: <20170918154204.54427-1-icenowy@aosc.io>
 <20170919082019.6bopwauso4mbslqo@flea.lan>
Message-ID: <6c9c7797-8b6a-39fd-267c-82d89f71cb67@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 19/09/17 09:20, Maxime Ripard wrote:
> On Mon, Sep 18, 2017 at 11:42:04PM +0800, Icenowy Zheng wrote:
>> Allwinner A64/H5 SoCs come with a SID controller like the one in H3, but
>> without the silicon bug that makes the initial value at 0x200 wrong, so
>> the value at 0x200 can be directly read.
>>
>> Add support for this kind of SID controller.
>>
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> ---
>>   Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt | 1 +
>>   drivers/nvmem/sunxi_sid.c                                       | 6 ++++++
>>   2 files changed, 7 insertions(+)


TBH, I don't fully understand the soc specifics here, but if you want me 
to queue this patch, I would need an ack from Maxime.


thanks,
srini



>>
>> diff --git a/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt b/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
>> index ef06d061913c..6ea0836939ee 100644
>> --- a/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
>> +++ b/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
>> @@ -5,6 +5,7 @@ Required properties:
>>     "allwinner,sun4i-a10-sid"
>>     "allwinner,sun7i-a20-sid"
>>     "allwinner,sun8i-h3-sid"
>> +  "allwinner,sun50i-a64-sid"
>>   
>>   - reg: Should contain registers location and length
>>   
>> diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
>> index 0d6648be93b8..3c9fd4fb9207 100644
>> --- a/drivers/nvmem/sunxi_sid.c
>> +++ b/drivers/nvmem/sunxi_sid.c
>> @@ -199,10 +199,16 @@ static const struct sunxi_sid_cfg sun8i_h3_cfg = {
>>   	.need_register_readout = true,
>>   };
>>   
>> +static const struct sunxi_sid_cfg sun50i_a64_cfg = {
>> +	.value_offset = 0x200,
>> +	.size = 0x100,
>> +};
>> +
> 
> How did you get those values?
> 
> Also, it's reported that the SID can only be accessed in secure mode,
> did you test it?
> 
> Maxime
> 
