From: vitalya@ti.com (Vitaly Andrianov)
Date: Wed, 3 Feb 2016 10:43:23 -0500
Subject: [PATCH 1/2] ARM: make virt_to_idmap() return unsigned long
In-Reply-To: <56B20B2E.7060408@ti.com>
References: <E1aO8F2-00074N-E8@rmk-PC.arm.linux.org.uk>
 <56A84748.3040108@oracle.com> <20160201152015.GU10826@n2100.arm.linux.org.uk>
 <56AF8F54.7030805@ti.com> <56AF917F.9030505@oracle.com>
 <56B14546.4070808@oracle.com> <56B20B2E.7060408@ti.com>
Message-ID: <56B2201B.7020205@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/03/2016 09:14 AM, Grygorii Strashko wrote:
> On 02/03/2016 02:09 AM, santosh shilimkar wrote:
>> Vitaly,
>>
>> On 2/1/2016 9:10 AM, santosh shilimkar wrote:
>>> On 2/1/2016 9:01 AM, Vitaly Andrianov wrote:
>>>>
>>>>
>>>> On 02/01/2016 10:20 AM, Russell King - ARM Linux wrote:
>>>>> On Tue, Jan 26, 2016 at 08:27:52PM -0800, santosh.shilimkar at oracle.com
>>>>> wrote:
>>>>>> On 1/26/16 10:21 AM, Russell King wrote:
>>>>>>> Make virt_to_idmap() return an unsigned long rather than phys_addr_t.
>>>>>>>
>>>>>>> Returning phys_addr_t here makes no sense, because the definition of
>>>>>>> virt_to_idmap() is that it shall return a physical address which maps
>>>>>>> identically with the virtual address.  Since virtual addresses are
>>>>>>> limited to 32-bit, identity mapped physical addresses are as well.
>>>>>>>
>>>>>>> Almost all users already had an implicit narrowing cast to unsigned
>>>>>>> long
>>>>>>> so let's make this official and part of this interface.
>>>>>>>
>>>>>>> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>>>>>>> ---
>>>>>> Looks correct to me.
>>>>>>
>>>>>> Vitaly,
>>>>>> Could you please try out this patch and see everything continue to
>>>>>> work ?
>>>>>
>>>>> I haven't heard anything yet...  Vitaly?
>>>>>
>>>> Russel, Santosh,
>>>>
>>>> I'm not working with the latest kernel, but with the stable v4.1.y. So I
>>>> couldn't apply the patch to it. I checked out 4.5.0-rc1 and applied the
>>>> patch to it. Tried to boot and it crashed. I'm not sure either because
>>>> of the patch or because of the network driver.
>>>>
>>> Thanks for checking.
>>>
>>>> Here is the log:
>>>>
>>> Based on the log, I think the patch seems to work fine since the boot
>>> reached upto rootfs. The crash seems to be coming from mostky NetCP
>>> related compents.
>>>
>> The NETCP crash you saw could be the same one others stumbled as
>> mentioned in below thread. You can try the fix and see if the
>> crash goes away.
>>
>> http://marc.info/?l=linux-netdev&m=145445399232540&w=2
>
> 100%. I came up with absolutely similar fix.
>
>
> Regarding, kexec:
> - it seems can't be tested on ks2 out of the box, because there is unmet dependency in kconfig
>   config KEXEC
>          bool "Kexec system call (EXPERIMENTAL)"
> -       depends on (!SMP || PM_SLEEP_SMP)
>          depends on !CPU_V7M
>          select KEXEC_CORE
>          help
>
> - any way, i've hacked kernel as above;
> - downloaded and built kexec-tools
> git://git.kernel.org/pub/scm/linux/kernel/git/geoff/kexec-tools.git
> - tried to run it using different combination of parameters, but always
> with below result:
> # kexec -l /boot/zImage
> kexec version: 15.12.22.16.38-g6503cb3
> Could not find a free area of memory of 0x3b2ca0 bytes...
> Cannot load /boot/zImage
>
> I'm doing something wrong, but don't know what yet :(
> - these patches were not applied, I'd like to see kexec not working first
>
>
I'm not sure about that particular issue, but when I worked on KS2 kexec 
I had to patch kexec-tools to support KS2 LPAE memory.

Regards,
Vitaly
