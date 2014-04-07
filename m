From: monstr@monstr.eu (Michal Simek)
Date: Mon, 07 Apr 2014 08:22:06 +0200
Subject: [PATCH 00/75] l2c series
In-Reply-To: <20140404192824.GG7528@n2100.arm.linux.org.uk>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
 <533D7672.4090003@monstr.eu> <20140403193328.GY7528@n2100.arm.linux.org.uk>
 <533E5B71.20406@monstr.eu> <20140404192824.GG7528@n2100.arm.linux.org.uk>
Message-ID: <5342440E.2020301@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/04/2014 09:28 PM, Russell King - ARM Linux wrote:
> On Fri, Apr 04, 2014 at 09:12:49AM +0200, Michal Simek wrote:
>> On 04/03/2014 09:33 PM, Russell King - ARM Linux wrote:
>>> On Thu, Apr 03, 2014 at 04:55:46PM +0200, Michal Simek wrote:
>>>> Hi Russell,
>>>>
>>>> On 03/28/2014 04:12 PM, Russell King - ARM Linux wrote:
>>>>> This is another posting of the L2 cache controller series.  I'm not
>>>>> planning for this for the upcoming merge window, but the one after,
>>>>> as people need to test it and still need to feed back to me on
>>>>> various issues.  Hence, this is not a finalised series.
>>>>>
>>>>> There are still various issues which I've raised, and have had no
>>>>> feedback on.
>>>>>
>>>>> This series is being posted with Cc's on the individual patches.
>>>>
>>>> I just want to also point you that we have sent EDAC support for pl310
>>>> which will be good to have it for L2.
>>>> [RFC PATCH] EDAC support for ARM PL310 cache controller
>>>> [RFC PATCH] edac: add support for ARM PL310 L2 cache parity
>>>> http://lkml.org/lkml/2014/3/2/85
>>>> http://lkml.org/lkml/2014/3/2/87
>>>
>>> As seems to be the norm, lkml.org is broken... please find a different
>>> archive instead. :)
>>>
>>
>> Here it is:
>> http://lkml.iu.edu/hypermail/linux/kernel/1403.0/00250.html
>> http://lkml.iu.edu/hypermail/linux/kernel/1403.0/00251.html
> 
> A number of comments immediately spring to mind:
> 
> - the use of writel/readl rather than their ARM specific _relaxed
>   versions is not a good idea: using the standard macros will result
>   in another write due to the barrier.

Not a problem to use _relaxed version.

My concern about using _relaxed version is that
everybody is still saying use COMPILE_TEST or just enable drivers
for all archs. With using _relaxed IO helper function it is ending
up in compilation problems for i386.
Last time with our i2c driver.
http://www.spinics.net/lists/arm-kernel/msg320255.html

It means shouldn't be that _relaxed version listed in asm-generic/io.h
or just limit it to use this driver just for ARM like we have done for
this edac driver.


> - a driver coupled to the arm,pl310-cache compatible for this which is
>   distinctly separate from the main "driver" is probably a bad idea.
>   what if we want our existing l2 stuff to couple into the driver model
>   to expose some properties at a later date (eg, maybe to deal with
>   stuff like the power management settings?)  For example, it may be
>   that we want to expose the prefetch offset so that people can easily
>   play with the value to determine the correct tuning for their workload.

We choose that name for starting to discuss this how to do it better.
We could use zynq-edac-l2 or zynq-edac-r3p2, etc version.

Moving it to driver model will be perfect. Also considering to
move this driver out or arch/arm is a good idea.


> - casting to void * is unnecessary for devm_request_irq()

ok. We will fix it.

> 
> - you really ought to check whether the interrupt registers are accessible
>   in non-secure mode - and I guess if we're going to have this driver, we
>   should have the L2 cache enabling code always try to set the NS access
>   bit for the interrupt registers.

Our kernel for historical reasons runs in secure mode that's why
I don't know if this will work for us but easy to try.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140407/16ebc6cf/attachment-0001.sig>
