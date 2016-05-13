From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Fri, 13 May 2016 09:44:49 +0800
Subject: [PATCH v4 10/18] sh: Remove unnecessary of_platform_populate with
 default match table
In-Reply-To: <20160512183822.GL21636@brightrain.aerifal.cx>
References: <1463054775-18170-1-git-send-email-wangkefeng.wang@huawei.com>
 <1463054775-18170-11-git-send-email-wangkefeng.wang@huawei.com>
 <20160512183822.GL21636@brightrain.aerifal.cx>
Message-ID: <57353191.7020609@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/5/13 2:38, Rich Felker wrote:
> On Thu, May 12, 2016 at 08:06:07PM +0800, Kefeng Wang wrote:
>> After patch "of/platform: Add common method to populate default bus",
>> it is possible for arch code to remove unnecessary callers about the
>> of_platform_populate with default match table.
> 
> s/about the/of/ ?

Ok, will update.

> 
>> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
>> Cc: Rich Felker <dalias@libc.org>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>  arch/sh/boards/of-generic.c | 14 --------------
>>  1 file changed, 14 deletions(-)
>>
>> diff --git a/arch/sh/boards/of-generic.c b/arch/sh/boards/of-generic.c
>> index b4d4313..911ffb9 100644
>> --- a/arch/sh/boards/of-generic.c
>> +++ b/arch/sh/boards/of-generic.c
>> @@ -9,7 +9,6 @@
>>   */
>>  
>>  #include <linux/of.h>
>> -#include <linux/of_platform.h>
>>  #include <linux/of_fdt.h>
>>  #include <linux/clocksource.h>
>>  #include <linux/irqchip.h>
>> @@ -179,16 +178,3 @@ void __init arch_init_clk_ops(struct sh_clk_ops **ops, int idx)
>>  void __init plat_irq_setup(void)
>>  {
>>  }
>> -
>> -static int __init sh_of_device_init(void)
>> -{
>> -	pr_info("SH generic board support: populating platform devices\n");
>> -	if (of_have_populated_dt()) {
>> -		of_platform_populate(NULL, of_default_bus_match_table,
>> -				     NULL, NULL);
>> -	} else {
>> -		pr_crit("Device tree not populated\n");
>> -	}
>> -	return 0;
>> -}
>> -arch_initcall_sync(sh_of_device_init);
>> -- 
>> 1.7.12.4
> 
> I have not tested this, but as long as the new arch-generic code takes
> place at the same point in the init sequence (arch_initcall_sync), as
> it seems to, I don't expect any sh-specific breakage. In general I'm
> happy to see this kind of change.

Hope no breakage in all archs, but I can only test this in few arm/arm64 boards :(

Thanks,
Kefeng

> 
> Rich
> 
> .
> 
