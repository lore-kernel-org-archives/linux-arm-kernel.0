From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sat, 4 Mar 2017 00:00:55 +0100
Subject: [PATCH v3 20/25] ARM: owl: Implement CPU enable-method for S500
In-Reply-To: <1639218b-a78a-4c49-17b6-eaf1173c2762@suse.de>
References: <201703011539.2lGXT7m0%fengguang.wu@intel.com>
 <1639218b-a78a-4c49-17b6-eaf1173c2762@suse.de>
Message-ID: <1e196fc4-bc4c-5c81-7662-c76e2bc5f8d9@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 01.03.2017 um 11:40 schrieb Andreas F?rber:
> Am 01.03.2017 um 08:19 schrieb kbuild test robot:
>> Hi Andreas,
>>
>> [auto build test ERROR on next-20170228]
>> [also build test ERROR on v4.10]
>> [cannot apply to robh/for-next linus/master linux/master v4.9-rc8 v4.9-rc7 v4.9-rc6]
>> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>>
>> url:    https://github.com/0day-ci/linux/commits/Andreas-F-rber/ARM-Initial-Actions-Semi-S500-and-S900-enablement/20170301-110028
>> config: arm-allmodconfig (attached as .config)
>> compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
>> reproduce:
>>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # save the attached .config to linux build tree
>>         make.cross ARCH=arm 
>>
>> All errors (new ones prefixed by >>):
>>
>>    arch/arm/mach-actions/headsmp.S: Assembler messages:
>>>> arch/arm/mach-actions/headsmp.S:43: Error: selected processor does not support `dsb' in ARM mode
>>>> arch/arm/mach-actions/headsmp.S:44: Error: selected processor does not support `isb' in ARM mode
>>
>> vim +43 arch/arm/mach-actions/headsmp.S
>>
>>     37		mov	r6, r2, lsl r0
>>     38		orr	r5, r5, r6	@ Reg = (Temp<<WayShift)|(NumSets<<SetShift)
>>     39		mcr	p15, 0, r5, c7, c6, 2
>>     40		bgt	2b
>>     41		cmp	r2, #0
>>     42		bgt	1b
>>   > 43		dsb
>>   > 44		isb
> 
> Any suggestion what to do about this error? Obviously it built fine for
> me, and the only thing I spotted in the attached config was that it's
> apparently a BE8 build...

And it has V6 enabled. If I set

AFLAGS_headsmp.o := -Wa,-march=armv7-a

then the error seems resolved.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
