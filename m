From: bintian.wang@huawei.com (Bintian)
Date: Mon, 13 Apr 2015 21:17:59 +0800
Subject: [PATCH v2 4/6] clk: hi6220: Clock driver support for Hisilicon
 hi6220 SoC
In-Reply-To: <1428926202.11113.77.camel@x220>
References: <1428916660-25910-1-git-send-email-bintian.wang@huawei.com>	
 <1428916660-25910-5-git-send-email-bintian.wang@huawei.com>
 <1428926202.11113.77.camel@x220>
Message-ID: <552BC207.40807@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Paul,

Thank you very much for code review and testing on arm!

On 2015/4/13 19:56, Paul Bolle wrote:
> On Mon, 2015-04-13 at 17:17 +0800, Bintian Wang wrote:
>> --- /dev/null
>> +++ b/drivers/clk/hisilicon/Kconfig
>> @@ -0,0 +1,5 @@
>> +config COMMON_CLK_HI6220
>> +	tristate "Hi6220 Clock Driver"
>> +	depends on OF && ARCH_HISI
>> +	help
>> +	  Build the Hisilicon Hi6220 clock driver based on the common clock framework.
>
> In 5/6 you make arm64's ARCH_HISI (a bool) select COMMON_CLK_HI6220. So
> for arm64 this driver will always be built-in.
>
> For arm's ARCH_HISI it's possible to set COMMON_CLK_HI6220 to 'm'.

Setting COMMON_CLK_HI6220 to a bool symbol is a good solution based on
current code base, I will fix it in next version.

>
>> --- a/drivers/clk/hisilicon/Makefile
>> +++ b/drivers/clk/hisilicon/Makefile
>> @@ -2,8 +2,9 @@
>>   # Hisilicon Clock specific Makefile
>>   #
>>
>> -obj-y	+= clk.o clkgate-separated.o
>> +obj-y	+= clk.o clkgate-separated.o clkdivider-hi6220.o
>
> These objects will always be built-in, right?
>
>>   obj-$(CONFIG_ARCH_HI3xxx)	+= clk-hi3620.o
>>   obj-$(CONFIG_ARCH_HIP04)	+= clk-hip04.o
>>   obj-$(CONFIG_ARCH_HIX5HD2)	+= clk-hix5hd2.o
>> +obj-$(CONFIG_COMMON_CLK_HI6220)	+= clk-hi6220.o
>
> If CONFIG_COMMON_CLK_HI6220 is 'm' this will build a module named
> clk-hi6220.ko. If I try to do that I get:
>      $ make -C ../../.. ARCH=arm CROSS_COMPILE=arm-linux-gnu- M=$PWD clk-hi6220.ko
>      make: Entering directory `[...]'
>        CC [M]  [...]/drivers/clk/hisilicon/clk-hi6220.o
>        MODPOST 1 modules
>      WARNING: "hisi_clk_register_gate" [[...]/drivers/clk/hisilicon/clk-hi6220.ko] undefined!
>      WARNING: "hi6220_clk_register_divider" [[...]/drivers/clk/hisilicon/clk-hi6220.ko] undefined!
>      WARNING: "hisi_clk_register_mux" [[...]/drivers/clk/hisilicon/clk-hi6220.ko] undefined!
>      WARNING: "hisi_clk_register_gate_sep" [[...]/drivers/clk/hisilicon/clk-hi6220.ko] undefined!
>      WARNING: "hisi_clk_register_fixed_factor" [[...]/drivers/clk/hisilicon/clk-hi6220.ko] undefined!
>      WARNING: "hisi_clk_register_fixed_rate" [[...]/drivers/clk/hisilicon/clk-hi6220.ko] undefined!
>      WARNING: "hisi_clk_init" [[...]/drivers/clk/hisilicon/clk-hi6220.ko] undefined!
>        CC      [...]/drivers/clk/hisilicon/clk-hi6220.mod.o
>        LDFINAL [M]  [...]/drivers/clk/hisilicon/clk-hi6220.ko
>      make: Leaving directory `[...]'
>
> That is, I think, because nothing exports these symbols.

[...]

> There's nothing module specific in this file. And the lack of a
> MODULE_LICENSE() macro is also telling. If this was built as a module
> loading that module - ignoring the undefined symbols - would taint the
> kernel.
>
> It seems to me that COMMON_CLK_HI6220 is meant to be a bool symbol.
You are right.

>
>
> Paul Bolle
>
> I wonder what checkpatch had to say about the length of the lines seen
> in this patch.

Yes, I ran this script before sending out this patch set, it reports
warnings about "line over 80 characters ", but I find it's easier to
read than shrinking one line to several lines, so just keep it, do I
need to fix it?

Thanks,

Bintian

>
> .
>
