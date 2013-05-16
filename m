From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 16 May 2013 18:25:13 +0400
Subject: [PATCH v3 1/1] ARM: shmobile: r8a7778: add I2C support
In-Reply-To: <87txm3wwzh.wl%kuninori.morimoto.gx@renesas.com>
References: <201304232012.57619.sergei.shtylyov@cogentembedded.com>
 <201304232015.59697.sergei.shtylyov@cogentembedded.com>
 <87txm3wwzh.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <5194EC49.9000508@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 16-05-2013 5:10, Kuninori Morimoto wrote:

> Basically, this patch is good for me.
> But I have some comment.

> Sergei Shtylyov wrote:

>> From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>

>> Add I2C clocks and platform devices for R8A7778 SoC.
>> Don't forget to also add the peripheral clock which the I2C driver uses.

>> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
>> [Sergei: changed the registration function to platform_device_register_simple(),
>> annotated I2C resources as '__initdata', regrouped MSTPxxx *enum* members, added
>> the copyright.]
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> (snip)
>> -	MSTP026, MSTP025, MSTP024, MSTP023, MSTP022, MSTP021,
>> +	MSTP030, MSTP029,
>> +	MSTP028, MSTP027, MSTP026, MSTP025, MSTP024, MSTP023, MSTP022, MSTP021,
>
> It should be

> 	MSTP30,
> 	MSPT029, MSPT028, MSPT027...

    This will cause a warning from checkpatch.pl for the violation of 
80-column line limit, I think.

>> +/* I2C */
>> +static struct resource i2c0_resources[] __initdata = {
>> +	DEFINE_RES_MEM(0xffc70000, 0x1000),
>> +	DEFINE_RES_IRQ(gic_iid(0x63)),
>> +};
>> +
>> +static struct resource i2c1_resources[] __initdata = {
>> +	DEFINE_RES_MEM(0xffc71000, 0x1000),
>> +	DEFINE_RES_IRQ(gic_iid(0x6e)),
>> +};
>> +
>> +static struct resource i2c2_resources[] __initdata = {
>> +	DEFINE_RES_MEM(0xffc72000, 0x1000),
>> +	DEFINE_RES_IRQ(gic_iid(0x6c)),
>> +};
>> +
>> +static struct resource i2c3_resources[] __initdata = {
>> +	DEFINE_RES_MEM(0xffc73000, 0x1000),
>> +	DEFINE_RES_IRQ(gic_iid(0x6d)),
>> +};
>> +
>> +#define r8a7778_register_i2c(idx)			\
>> +	platform_device_register_simple(		\
>> +		"i2c-rcar", idx,			\
>> +		i2c##idx##_resources,			\
>> +		ARRAY_SIZE(i2c##idx##_resources))
>> +
>>   /* USB PHY */
>>   static struct resource usb_phy_resources[] __initdata = {
>>   	DEFINE_RES_MEM(0xffe70800, 0x100),
>> @@ -294,6 +321,11 @@ void __init r8a7778_add_standard_devices
>>
>>   	r8a7778_register_tmu(0);
>>   	r8a7778_register_tmu(1);
>> +
>> +	r8a7778_register_i2c(0);
>> +	r8a7778_register_i2c(1);
>> +	r8a7778_register_i2c(2);
>> +	r8a7778_register_i2c(3);
>>   }
>
> i2c1 - i2c3 pins are pin-multi.

    Ah, you mean there should be I2C related entries in the pinmux table
in the BOCK-W code?

> I guess using r8a7778_add_i2c_devices(idx) from board code is better method

    Why? Not at all, I think, since we don't have the platform data.

> Best regards
> ---
> Kuninori Morimoto

WBR, Sergei
