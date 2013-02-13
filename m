From: monstr@monstr.eu (Michal Simek)
Date: Wed, 13 Feb 2013 18:35:58 +0100
Subject: zynq drivers/clocksource (was: Re: [GIT PULL] arm-soc: Xilinx
 zynq timer changes for v3.9)
In-Reply-To: <511BC199.8030907@wwwdotorg.org>
References: <CAHTX3dJftmsMvK1BMupZMfz7bmTBvsUq37fZaC=vd8yanYEasw@mail.gmail.com>
 <511BC199.8030907@wwwdotorg.org>
Message-ID: <CAHTX3d+Aw100TCX07-Pmafk-FAbYaf+m2aFoHiTPQabSsBTU9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/2/13 Stephen Warren <swarren@wwwdotorg.org>:
> On 02/13/2013 07:22 AM, Michal Simek wrote:
>> Hi,
>>
>> here is origin comment from Arnd.
>>
>>> Please have a look at the contents of the timer/cleanup and clocksource/cleanup
>>> branches in arm-soc, and merge them into your branch. If everything still
>>> works, you can add a patch on top of the merge to move your driver to
>>> drivers/clocksource and use the new infrastructure introduced there.
>>
>> based on Arnd request I have looked at moving zynq timer code to the
>> new infrastructure
>> in drivers/clocksource. I have done some investigation and I am not quite
>> sure if I understand the design correctly.
>>
>> I have looked at vt8500, tegra20 and bcm2835 drivers in arm-soc/for-next branch
>> and all of them use the same pattern with expectation that only
>> one timer with the same compatible property is available in the system.
>
> Oh right. When we spoke on IRC, I was thinking of multiple different
> types of clocksource driver, rather than multiple instances of the same
> type. Yes, my original patches wouldn't work well with multiple
> instances (DT nodes) with the same compatible property.

yep I meant multiple instances of the same type but also multiple different
types of clocksource should also work.

>> I have done some tests on zynq and the problem is with calling
>> of_find_matching_node(NULL, .._match); which will always return the same
>> device_node which end up with faults later when you try to request the same
>> irq.
>>
>> Is there any limitation/expectation that only one clocksource driver
>> should be probed?
>>
>> Also not sure if make sense to add of_find_matching_node for architectures
>> which select CONFIG_OF or USE_OF when we can pass device_node directly from
>> of_find_matching_node().
>
> ... but Rob's patches that I mentioned should solve this multiple
> instance issue, since they do indeed pass the found DT node into the
> timer init function.

yep. We are talking about it in the second thread.

thanks for your help,
Michal


-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform
