From: tim.bird@am.sony.com (Tim Bird)
Date: Thu, 9 Dec 2010 10:18:01 -0800
Subject: Problem with sram size on OMAP1611 (OSK)
In-Reply-To: <1291769811.2796.39.camel@localhost>
References: <4CE73921.6030908@am.sony.com>	 <20101207001831.GX8345@atomide.com>
	<1291769811.2796.39.camel@localhost>
Message-ID: <4D011D59.4060304@am.sony.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/7/2010 4:56 PM, Kevin Hilman wrote:
> On Mon, 2010-12-06 at 16:18 -0800, Tony Lindgren wrote:
>> Hi,
>>
>> * Tim Bird<tim.bird@am.sony.com>  [101119 18:48]:
>>> Santosh,
>>>
>>> I just tried the latest kernel (well, v2.6.36), and found a problem
>>> that bisected to the following commit:
>>>
>>> commit e546f21b4b7af012d9f18edad6237339adfeb681
>>> Author: Santosh Shilimkar<santosh.shilimkar@ti.com>
>>> Date:   Fri Sep 24 07:19:49 2010 +0100
>>>
>>>      ARM: 6408/1: omap: Map only available sram memory
>>>
>>> I am testing Linux on an OSK board (with an OMAP1611),
>>> and the above commmit causes the machine to hang.
>>> I isolated the problem to the sram length.  The commit
>>> above changes it to a value detected in omap_detect_sram(),
>>> but when this value is used, my OSK hangs on boot.
>>>
>>> Below is the hack I used to work around this.  I'm not sure
>>> what the problem is, but I'd be happy to provide more information
>>> or try other things, to fix support for omap1611 in mainline.
>>> I tried putting the 1024 * 1024 value into omap_detect_sram(),
>>> with no luck.  There's some additional processing there which
>>> might alter the value.  Or perhaps the current value there
>>> for omap_sram_size on a 1611 is just wrong.
>>>
>>> diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
>>> index 10b3b4c..d4ba4fa 100644
>>> --- a/arch/arm/plat-omap/sram.c
>>> +++ b/arch/arm/plat-omap/sram.c
>>> @@ -236,6 +236,8 @@ void __init omap_map_sram(void)
>>>          base = ROUND_DOWN(base, PAGE_SIZE);
>>>          omap_sram_io_desc[0].pfn = __phys_to_pfn(base);
>>>          omap_sram_io_desc[0].length = ROUND_DOWN(omap_sram_size, PAGE_SIZE);
>>> +       if (cpu_is_omap1611())
>>> +               omap_sram_io_desc[0].length = 1024 * 1024;
>>>          iotable_init(omap_sram_io_desc, ARRAY_SIZE(omap_sram_io_desc));
>>>
>>>          printk(KERN_INFO "SRAM: Mapped pa 0x%08lx to va 0x%08lx size: 0x%lx\n",
>> I'm not seeing this on my OSK, can you please check if this still
>> happening with v2.6.37-rc4?

Sorry I didn't report back sooner.  I was going to try another test to see
if I could determine what size *did* work, but ran out of time.  However,
I tested v2.6.37-rc4, and it had the same problem I originally reported.

Kevin's explanation sounds likely to me.
>> I have the same problem as Tim on my OSK using latest l-o master.
>> Debugging this with Tony, we realized his OSK has a 1623 whereas mine
>> (and presumably Tim's) has an omap1611.  The SRAM code uses different
>> SRAM sizes for 1611 and 1610/1623.
>>
>> I have no idea what the "right" values of the SRAM size are for these
>> parts.
>>
>> Setting it to 256k got it booting for me, so will send a patch for that
>> shortly.
>>
