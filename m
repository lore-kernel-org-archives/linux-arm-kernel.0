From: netz.kernel@gmail.com (Marty Plummer)
Date: Tue, 30 Aug 2016 15:01:03 -0500
Subject: [PATCH 1/1] mach-hisi: Make Hi3620 explicit, remove wildcard
In-Reply-To: <20160830194452.GV10637@io.lakedaemon.net>
References: <07dd3b37-3cd9-6f89-4c84-ce534880d200@gmail.com>
 <20160830191729.GT10637@io.lakedaemon.net>
 <891242ab-6792-282f-4df4-b2aef34d8a3d@gmail.com>
 <20160830194452.GV10637@io.lakedaemon.net>
Message-ID: <12e27a85-620a-8ed3-15cb-db6c4ed3e342@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/30/2016 02:44 PM, Jason Cooper wrote:
> On Tue, Aug 30, 2016 at 02:29:36PM -0500, Marty Plummer wrote:
>> On 08/30/2016 02:17 PM, Jason Cooper wrote:
>>> On Tue, Aug 30, 2016 at 12:38:27PM -0500, Marty Plummer wrote:
>>>
>>> Please put an explanation in the commit log that gives future readers
>>> (and reviewers) the "why".
>>>
>>> e.g. "This is a preparatory series for adding the ARMv5 hisi35xx SoCs.
>>> Assumptions were made when adding hisi 36xx that don't hold water in
>>> light of adding support for the ARMv5 SoC.  Fix the issue by renaming
>>> config options and other namespaces to avoid collisions with the new
>>> work.
>>>
>>> Only internal APIs are modified with this series."
>>>
>>> Or something like that.
>>>
>> Ah, well since it pretty much only consists of renames and no actual
>> changes in behavior I though it fell under the category of a trivial
>> patch.
> 
> Right, we try not to add useless dogma, but this helps reviewers quickly
> assess the magnitude of the patch and why it exists.  The easier we can
> make it for them to go "Uh-huh... Got it, Acked-by ---" the better off
> we are.
> 
A gotcha. Basically a "Hey, this patch is nothing really too much to
worry about, just some renames".

Also, 'commit log' is what, here?
>>>> Signed-off-by: Marty Plummer <netz.kernel@gmail.com>
>>>> ---
>>>
>>> This needs to be split up into a series of patches:
>>>
>>>>  arch/arm/Kconfig.debug              |  2 +-
>>>
>>>>  arch/arm/boot/dts/Makefile          |  2 +-
>>>
>>>>  arch/arm/configs/hisi_defconfig     |  2 +-
>>>
>>>>  arch/arm/configs/multi_v7_defconfig |  2 +-
>>>
>>>>  arch/arm/mach-hisi/Kconfig          |  6 +++---
>>>>  arch/arm/mach-hisi/core.h           | 10 +++++-----
>>>>  arch/arm/mach-hisi/hisilicon.c      |  4 ++--
>>>>  arch/arm/mach-hisi/hotplug.c        | 16 ++++++++--------
>>>>  arch/arm/mach-hisi/platsmp.c        | 24 ++++++++++++------------
>>>
>>>>  drivers/clk/hisilicon/Makefile      |  2 +-
>>>
>>>>  drivers/dma/Kconfig                 |  2 +-
>>>
>>> Most likely, the subsystem maintainers will Ack the relevant patch and
>>> then they'll go in together to avoid bisection issues.
>>>
>> Ah, ok. Once again, I thought since it made little in the way of 'real'
>> changes it was more or less irrelevant. I used `git format-patch' to
>> make the patch, and it was all one commit. should I instead then break
>> it down into multiple commits, then?
> 
> Please do.
> 
>>>>  11 files changed, 36 insertions(+), 36 deletions(-)
>>>>
>>>> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
>>>> index a9693b6..9094ca6 100644
>>>> --- a/arch/arm/Kconfig.debug
>>>> +++ b/arch/arm/Kconfig.debug
>>>> @@ -280,7 +280,7 @@ choice
>>>>  
>>>>  	config DEBUG_HI3620_UART
>>>>  		bool "Hisilicon HI3620 Debug UART"
>>>> -		depends on ARCH_HI3xxx
>>>> +		depends on ARCH_HI3620
>>>
>>> Is there a general rule like
>>>
>>> 	ARCH_HI36xx = ARMv7
>>> 	ARCH_HI35xx = ARMv5
>>>
>>> ?
>> Unsure about all Hi35xx chipsets, I've not had reason to look into those
>> yet for lack of hardware. However, ARCH_HI3520 is ARMv6/ARMv5, it has
>> two cores, arm1176/arm926
> 
> Ok, I'll defer to Arnd on this one.  I'd be inclined to do the above, or
> _HI36xx, _HI3520 at least.  Since you run separate kernels on each core,
> it's probably best to treat them like two different boards.  Perhaps we
> need _HI3520_ARM1176, _HI3520_ARM926?
> 
Yeah. I was going to go with HI3520, HI3520_SLAVE, but I suppose a more
explicit naming would be better in this instance.
>> Also, there is one area I'd simply like to reorder some struct
>> initialization so it matches the definition, iirc it was the struct
>> map_desc.
> 
> Let's get the 'trivial' stuff in first.  There may be a good reason for
> the ordering.
> 
> thx,
> 
> Jason.
> 
Alrigty... funny how getting a patch submitted right is far harder than
making one :P
