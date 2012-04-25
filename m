From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 24 Apr 2012 18:36:41 -0700
Subject: [PATCH 1/6] ARM: S3C24XX: Add forgotten clock lookup table to
 S3C2443
In-Reply-To: <201204030037.07993.heiko@sntech.de>
References: <201203121959.32966.heiko@sntech.de>
 <201203122000.31216.heiko@sntech.de> <4F7A153A.5070701@samsung.com>
 <201204030037.07993.heiko@sntech.de>
Message-ID: <4F975529.8030203@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko St?bner wrote:
> Am Montag 02 April 2012, 23:08:10 schrieb Kukjin Kim:
>> Heiko St?bner wrote:
>>> When the hsmmc clock lookup was changed to be lookup tables based,
>>> it seems the S3C2443 was forgotten.
>>>
>>> As subsequent patches will want to add more lookups to it, this
>>> patch adds the base table with the missing hsmmc lookup.
>>>
>>> Signed-off-by: Heiko Stuebner<heiko@sntech.de>
>>> ---
>>>
>>>    arch/arm/mach-s3c24xx/clock-s3c2443.c |    5 +++++
>>>    1 files changed, 5 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-s3c24xx/clock-s3c2443.c
>>> b/arch/arm/mach-s3c24xx/clock-s3c2443.c index efb3ac3..bce1cd3 100644
>>> --- a/arch/arm/mach-s3c24xx/clock-s3c2443.c
>>> +++ b/arch/arm/mach-s3c24xx/clock-s3c2443.c
>>> @@ -179,6 +179,10 @@ static struct clk *clks[] __initdata = {
>>>
>>>    	&clk_hsmmc,
>>>
>>>    };
>>>
>>> +static struct clk_lookup s3c2443_clk_lookup[] = {
>>> +	CLKDEV_INIT("s3c-sdhci.1", "mmc_busclk.2",&clk_hsmmc),
>>> +};
>>> +
>>>
>>>    void __init s3c2443_init_clocks(int xtal)
>>>    {
>>>
>>>    	unsigned long epllcon = __raw_readl(S3C2443_EPLLCON);
>>>
>>> @@ -210,6 +214,7 @@ void __init s3c2443_init_clocks(int xtal)
>>>
>>>    	s3c_register_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
>>>    	s3c_disable_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
>>>
>>> +	clkdev_add_table(s3c2443_clk_lookup, ARRAY_SIZE(s3c2443_clk_lookup));
>>>
>>>    	s3c_pwmclk_init();
>>>
>>>    }
>>
>> Uhm..how about mach-s3c24xx/common-s3c2443.c?
>
> Nope. This clock is really specific to only the s3c2443. There is only one
> hsmmc clock that is identical on both the s3c2443 and s3c2416/2450 and this
> one already is in common-s3c2443.c .
>
OK, you're right, I forgot s3c2443_common_init_clocks() is for s3c2416 
and s3c2443 :-)

> common-s3c2443.c was meant for stuff common to s3c2443 _and newer_, i.e.
> common clocks and so on.
>
>> I think, we need to sort out some files in mach-s3c24xx/ and some
>> remained mach-s3c24.. directories, actually, as you know, we didn't have
>> much time to do it last time :)
>
> yeah, we did cut it quite close :-), but it also doesn't seem to have produced
> much fall-out. I moved my s3c2416 based development code to 3.4-rc1 without
> major hickups.
>
> Getting rid of the remaining mach-directories and also the plat-s3c24xx would
> be good. But I'm not sure what you would want to change in mach-s3c24xx
> directory itself.
>
> I don't know the earlier SoCs, but the s3c2443 and s3c2416/2450 SoCs currently
> don't have redundancies and in the current layout it's quite easy to
> understand what belongs to which SoC.
>
Hmm...I'm sorting that out and if any updates, let you know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
