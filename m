From: jgq516@gmail.com (jgq516 at gmail.com)
Date: Mon, 15 Jul 2013 10:50:50 +0800
Subject: v3.10 - big endian core support
In-Reply-To: <51DFEFD9.2060509@codethink.co.uk>
References: <CALicx6u89THSiRa4FzGZrcoG8q+o_BD8qVEC4CYXEjPUVK_fJw@mail.gmail.com>
 <20130712134726.0a909165@skate>
 <CALicx6sr=OXYAdSS-RXPCjSp4f_yLQyw6jJsQ2KyhgQ9fRtXag@mail.gmail.com>
 <51DFEFD9.2060509@codethink.co.uk>
Message-ID: <51E3638A.3080103@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/12/2013 08:00 PM, Ben Dooks wrote:
> On 12/07/13 12:56, Vijay Kilari wrote:
>> On Fri, Jul 12, 2013 at 5:17 PM, Thomas Petazzoni
>> <thomas.petazzoni@free-electrons.com>  wrote:
>>> Dear Vijay Kilari,
>>>
>>> On Fri, 12 Jul 2013 17:09:12 +0530, Vijay Kilari wrote:
>>>
>>>>> Ben Dooks has a separate branch on top of this base branch for
>>>>> big-endian support, that adds atags compat code to convert the ATAGs
>>>>> data from LE to BE. See the baserock/311/be/atags branch in
>>>>> git://git.baserock.org/delta/linux. Or
>>>>> http://git.baserock.org/cgi-bin/cgit.cgi/delta/linux.git/log/?h=baserock/311/be/atags. 
>>>>>
>>>>
>>>>   ARM VE TC2 board, enabling CONFIG_THUMB2_KERNEL failed to boot in 
>>>> BE mode
>>>> It hangs at very early stage of boot
>>>
>>> Yeah, the Thumb2 code is not supported by Ben Dooks patches, it's part
>>> of the TODO-list. I think Ben said he would probably not have much time
>>> to work on this. I might be able to spare some time on this, so just
>>> let me know if I should start working on this. If I remember correctly,
>>> it's mainly the fixup_pv_table code that needed some Thumb2/BE love.
>>
>> In fact, I tried with below changes.. still it fails
>>
>> diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
>> index 2de1114..7df64c7 100644
>> --- a/arch/arm/kernel/head.S
>> +++ b/arch/arm/kernel/head.S
>> @@ -592,8 +592,14 @@ __fixup_a_pv_table:
>>          b       2f
>>   1:     add     r7, r3
>>          ldrh    ip, [r7, #2]
>> +#ifdef CONFIG_CPU_ENDIAN_BE8
>> +       rev     ip, ip
>> +#endif
>
> Do you need a rev16 here? I think you may have tried
> reversing the full 32 bits here instead of just the
> 16bits of instruction that was loaded.
>
Thanks Ben, 3.4 kernel booted ok with your suggested modifications.

gjiang at gjiang-desktop:~/work/be-a15$ git diff
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 0ad3af8..1a0196c 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -600,8 +600,10 @@ __fixup_a_pv_table:
         b       2f
  1:     add     r7, r3
         ldrh    ip, [r7, #2]
+       rev16   ip, ip @be8
         and     ip, 0x8f00
         orr     ip, r6  @ mask in offset bits 31-24
+       rev16   ip, ip @be8
         strh    ip, [r7, #2]
  2:     cmp     r4, r5
         ldrcc   r7, [r4], #4    @ use branch for delay slot

root at localhost:~# zcat /proc/config.gz |grep BE8
CONFIG_CPU_ENDIAN_BE8=y
CONFIG_CPU_BE8_BOOT_LE=y
root at localhost:~# zcat /proc/config.gz |grep THUMB
CONFIG_ARM_THUMB=y
# CONFIG_ARM_THUMBEE is not set
CONFIG_THUMB2_KERNEL=y
CONFIG_THUMB2_AVOID_R_ARM_THM_JUMP11=y


Regards,
Xiao
>>          and     ip, 0x8f00
>>          orr     ip, r6  @ mask in offset bits 31-24
>> +#ifdef CONFIG_CPU_ENDIAN_BE8
>> +       rev     ip, ip
>> +#endif
>>          strh    ip, [r7, #2]
>>   2:     cmp     r4, r5
>>          ldrcc   r7, [r4], #4    @ use branch for delay slot
>>
>>>
>>> Will, is getting Thumb2 working a requirement to get the BE support
>>> merged, or can we for now make the BE option depends on 
>>> !THUMB2_KERNEL ?
>>>
>>> Thanks!
>>>
>>> Thomas
>>> -- 
>>> Thomas Petazzoni, Free Electrons
>>> Kernel, drivers, real-time and embedded Linux
>>> development, consulting, training and support.
>>> http://free-electrons.com
>
>
