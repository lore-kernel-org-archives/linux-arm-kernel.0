From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Thu, 12 Mar 2015 15:34:05 +0000
Subject: [PATCH] n_tty: use kmalloc() instead of vmalloc() to avoid crash
 on armada-xp
In-Reply-To: <55019096.80605@list.ru>
References: <54FF21BE.2040506@list.ru>
 <20150310171751.GD13687@e104818-lin.cambridge.arm.com>
 <54FF2986.6020503@list.ru> <20150310173807.GU8656@n2100.arm.linux.org.uk>
 <55003569.1010200@list.ru> <20150311124730.GZ8656@n2100.arm.linux.org.uk>
 <5500502A.5060905@list.ru> <550187A4.8010704@hurleysoftware.com>
 <55018AE7.4070207@list.ru> <20150312130445.GO8656@n2100.arm.linux.org.uk>
 <55019096.80605@list.ru>
Message-ID: <5501B1ED.10600@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/03/15 13:11, Stas Sergeev wrote:
> 12.03.2015 16:04, Russell King - ARM Linux ?????:
>> On Thu, Mar 12, 2015 at 03:47:35PM +0300, Stas Sergeev wrote:
>>> 12.03.2015 15:33, Peter Hurley ?????:
>>>> On 03/11/2015 10:24 AM, Stas Sergeev wrote:
>>>>> However, while testing, I've suddenly got another crash happened
>>>>> a bit earlier than the previous one used to happen: (OOM? How??)
>>>>> ---
>>>>> [    0.000000] Booting Linux on physical CPU 0x0
>>>>> [    0.000000] Linux version 4.0.0-rc2-00137-gb672c98-dirty
>>>>> (root at host-010-117) (gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) )
>>>>> #2 SMP 5
>>>>> [    0.000000] CPU: ARMv7 Processor [562f5842] revision 2 (ARMv7),
>>>>> cr=10c5387d
>>>>> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction
>>>>> cache
>>>>> [    0.000000] Machine model: Marvell Armada XP Development Board
>>>>> DB-MV784MP-GP
>>>>> [    0.000000] Ignoring memory block 0x100000000 - 0x200000000
>>>> Once you patch your bootloader, you'll want to configure your kernel
>>>> for CONFIG_ARM_LPAE=y to enable the high 4GB of memory you have, as
>>>> it's being ignored in this config right now (as shown above and in
>>>> the oom message below).
>>> Hi Peter, thanks for this hint.
>>> I actually already tried with lpae, and, except for the missing
>>> 256Mb, everything works properly. :)
>> How reproducable is the OOM?  Have you tested LPAE as much as you did
>> without LPAE?
> Hi Russel, OOM is reproduceable quite fine only on old uboot
> and non-lpae mode.
> With lpae mode and old uboot OOM doesn't happen, but the board is not
> very reliable.
> With old uboot and mem=3G OOM is not reproduceable!
> With new uboot and whatever lpae more, OOM does not happen.
> So, after all, it still seems to be related to the problematic memory
> region. Let me know if you still suspect a bug and need more testing.
> 

Hi Stas,

Recently, I've done some work on memtest kernel feature [1]. It helped
to track down an issue with memory corruption on arm64 platform.

I wonder if it is able to catch your case?

[1] http://comments.gmane.org/gmane.linux.kernel.mm/129669

Thanks
Vladimir

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
