From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 02 Jul 2013 14:51:16 +0200
Subject: [PATCH v4 5/7] ARM: kirkwood: convert to DT irqchip and
 clocksource
In-Reply-To: <20130702115311.GG19937@titan.lakedaemon.net>
References: <1372763023-12374-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1372763023-12374-6-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130702115311.GG19937@titan.lakedaemon.net>
Message-ID: <51D2CCC4.30109@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/02/13 13:53, Jason Cooper wrote:
> On Tue, Jul 02, 2013 at 01:03:41PM +0200, Sebastian Hesselbarth wrote:
>> With recent support for true irqchip and clocksource drivers for Orion
>> SoCs, now make use of it on DT enabled Kirkwood boards.
>>
>> This also introduces a new Kconfig option for legacy (non-DT) Kirkwood
>> where old code is moved out to and polishes DT board file a little bit.
>>
>> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>> ---
[...]
>> diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
>> index 881f37e..385244c 100644
>> --- a/arch/arm/mach-kirkwood/board-dt.c
>> +++ b/arch/arm/mach-kirkwood/board-dt.c
>> @@ -15,6 +15,9 @@
>>   #include <linux/of.h>
>>   #include <linux/of_platform.h>
>>   #include <linux/clk-provider.h>
>> +#include <linux/clocksource.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/irqchip.h>
>>   #include <linux/kexec.h>
>>   #include <asm/mach/arch.h>
>>   #include <asm/mach/map.h>
>> @@ -67,10 +70,18 @@ static void __init kirkwood_legacy_clk_init(void)
>>   	clk_prepare_enable(clk);
>>   }
>>
>> -static void __init kirkwood_of_clk_init(void)
>> +static void __init kirkwood_dt_time_init(void)
>>   {
>>   	of_clk_init(NULL);
>> -	kirkwood_legacy_clk_init();
>> +	clocksource_of_init();
>> +}
>> +
>> +static void __init kirkwood_dt_init_early(void)
>> +{
>
>
>> +	init_dma_coherent_pool_size(SZ_1M);
>
> This shouldn't be needed any more.  Is there a reason you're adding it
> back in?

Jason, thanks for catching this. The last patch I had was before removal
of init_dma_coherent_pool_size. I slipped back in because I missed the
removal patches.

Can you remove it prior merge, should I prepare a fixup patch, or respin
this patch?

Sebastian
