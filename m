From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 07 Oct 2017 10:00:16 +0200
Subject: [PATCH] ARM: pxa: cm-x255: Fix up GPIO NAND device name in table
In-Reply-To: <20171007074939.516ae693@bbrezillon> (Boris Brezillon's message
 of "Sat, 7 Oct 2017 07:49:39 +0200")
References: <20171006215144.18039-1-linus.walleij@linaro.org>
 <20171007074939.516ae693@bbrezillon>
Message-ID: <877ew7fkvj.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Boris Brezillon <boris.brezillon@free-electrons.com> writes:

> On Fri,  6 Oct 2017 23:51:44 +0200
> Linus Walleij <linus.walleij@linaro.org> wrote:
>
>> My patch set the device name wrong because I confused the
>> device name for a partition name. Sorry.
>> 
>> Cc: arm at kernel.org
>> Fixes: ("mtd: nand: gpio: Convert to use GPIO descriptors")
>> Reported-by: Robert Jarzmik <robert.jarzmik@free.fr>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> This can be squashed into the commit or applied on top
>> as a fix. The original patch was ACKed by the ARM SoC
>> maintainers so I believe this is fine to apply.
>> ---
>>  arch/arm/mach-pxa/cm-x255.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/arch/arm/mach-pxa/cm-x255.c b/arch/arm/mach-pxa/cm-x255.c
>> index f8d67acb7194..fa8e7dd4d898 100644
>> --- a/arch/arm/mach-pxa/cm-x255.c
>> +++ b/arch/arm/mach-pxa/cm-x255.c
>> @@ -178,7 +178,7 @@ static inline void cmx255_init_nor(void) {}
>>  #if defined(CONFIG_MTD_NAND_GPIO) || defined(CONFIG_MTD_NAND_GPIO_MODULE)
>>  
>>  static struct gpiod_lookup_table cmx255_nand_gpiod_table = {
>> -	.dev_id         = "cmx255-nand",
>> +	.dev_id         = "gpio-nand",
>
> Are you sure it works? AFAIR, you have to set "<driver-name>.<dev-id>"
> here, which, assuming there's only one gpio-nand dev, would give
>
> 	.dev_id		= "gpio-nand.0",
I'm sure Linus is correct this time.
This is because :
static struct platform_device cmx255_nand = {
...
	.id		= -1,
...

This -1 is the reason it will be "gpio-nand".

Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

-- 
Robert

PS: For the next time for pxa patches I'd appreciate to be in the "To:" list, as
my other pxa co-maintainers.
