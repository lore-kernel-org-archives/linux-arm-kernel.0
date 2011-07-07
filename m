From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 7 Jul 2011 12:29:11 -0500
Subject: [PATCH 10/37] ARM: mach-ep93xx: remove mach/memory.h and
	Kconfig selection of SDRAM bank
In-Reply-To: <alpine.LFD.2.00.1107071301160.14596@xanadu.home>
References: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
	<1309923021-23487-10-git-send-email-nicolas.pitre@linaro.org>
	<ADE657CA350FB648AAC2C43247A983F001F383D6CEEA@AUSP01VMBX24.collaborationhost.net>
	<alpine.LFD.2.00.1107071301160.14596@xanadu.home>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F383D6CF29@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, July 07, 2011 10:19 AM, Nicolas Pitre wrote:
> On Thu, 7 Jul 2011, H Hartley Sweeten wrote:
>
>> On Tuesday, July 05, 2011 8:30 PM, Nicolas Pitre wrote:
>>>
>>> This all can be selected automatically by default at run time.
>> 
>> How?  It would be nice if you mentioned that this patch makes ARCH_EP93XX
>> use ARM_PATCH_PHYS_VIRT.  It took a bit of digging for me to figure out
>> where PHYS_OFFSET was now getting set.
>
> OK, I'll add some precisions to the commit message.  Of course the first 
> patch of the series contains detailed information on what is happening 
> but I don't want to repeat that into the 51 subsequent patches.

Ah.. I read the first patch to quickly...  Still an updated commit would
keep it clear.  Something as simple as this.

This all can be selected automatically by default at run time using
ARM_PATCH_PHYS_VIRT.

>>> Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
>>> ---
>>>  arch/arm/Kconfig                           |    2 +
>>>  arch/arm/mach-ep93xx/Kconfig               |   53 ----------------------------
>>>  arch/arm/mach-ep93xx/Makefile.boot         |   14 -------
>>>  arch/arm/mach-ep93xx/include/mach/memory.h |   22 -----------
>>>  4 files changed, 2 insertions(+), 89 deletions(-)
>>>  delete mode 100644 arch/arm/mach-ep93xx/include/mach/memory.h
>>>
>>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>>> index c4b6e4a..48b2e88 100644
>>> --- a/arch/arm/Kconfig
>>> +++ b/arch/arm/Kconfig
>>> @@ -371,6 +371,8 @@ config ARCH_EP93XX
>>>  	select ARCH_REQUIRE_GPIOLIB
>>>  	select ARCH_HAS_HOLES_MEMORYMODEL
>>>  	select ARCH_USES_GETTIMEOFFSET
>>> +	select NO_MACH_MEMORY_H
>>> +	select AUTO_ZRELADDR if !ZBOOT_ROM
>> 
>> I would like to see a:
>> 
>> +	select ARM_PATCH_PHYS_VIRT
>> 
>> here.  I realize that the select of NO_MACH_MEMORY_H will cause the selection
>> but it's a bit hidden.
>
> True.  However the default for ARM_PATCH_PHYS_VIRT is set to y when 
> NO_MACH_MEMORY_H is selected which effectively achieve the same thing 
> while allowing you to override that and 
> revert to a constant PHYS_OFFSET if some regression is suspected, or if 
> you use a XIP kernel.  Doing a forceful select of ARM_PATCH_PHYS_VIRT 
> here would prevent that..

Ah.. I overlooked that part.  Leave it as-is then.

>> [snip]
>> 
>>> diff --git a/arch/arm/mach-ep93xx/Makefile.boot b/arch/arm/mach-ep93xx/Makefile.boot
>>> index 0ad33f1..e69de29 100644
>>> --- a/arch/arm/mach-ep93xx/Makefile.boot
>>> +++ b/arch/arm/mach-ep93xx/Makefile.boot
>>> @@ -1,14 +0,0 @@
>>> -   zreladdr-$(CONFIG_EP93XX_SDCE3_SYNC_PHYS_OFFSET)	:= 0x00008000
>>> -params_phys-$(CONFIG_EP93XX_SDCE3_SYNC_PHYS_OFFSET)	:= 0x00000100
>>> -
>>> -   zreladdr-$(CONFIG_EP93XX_SDCE0_PHYS_OFFSET)		:= 0xc0008000
>>> -params_phys-$(CONFIG_EP93XX_SDCE0_PHYS_OFFSET)		:= 0xc0000100
>>> -
>>> -   zreladdr-$(CONFIG_EP93XX_SDCE1_PHYS_OFFSET)		:= 0xd0008000
>>> -params_phys-$(CONFIG_EP93XX_SDCE1_PHYS_OFFSET)		:= 0xd0000100
>>> -
>>> -   zreladdr-$(CONFIG_EP93XX_SDCE2_PHYS_OFFSET)		:= 0xe0008000
>>> -params_phys-$(CONFIG_EP93XX_SDCE2_PHYS_OFFSET)		:= 0xe0000100
>>> -
>>> -   zreladdr-$(CONFIG_EP93XX_SDCE3_ASYNC_PHYS_OFFSET)	:= 0xf0008000
>>> -params_phys-$(CONFIG_EP93XX_SDCE3_ASYNC_PHYS_OFFSET)	:= 0xf0000100
>> 
>> Is Makefile.boot still needed for anything?
>
> Not if AUTO_ZRELADDR is used and you are not using the bootpImage 
> wrapper.

Ok.  Just seems weird to have an empty Makefile.boot...

>> Other than those comments.  I have boot tested this on a couple ep93xx
>> boards and everything looks fine.
>
> This should allow you to have a kernel configured for multiple ep93xx 
> boards where this was not possible before due to the different RAM 
> offsets hardcoded at build time.

Actually it was "kind" of possible before.  The limitation was that all the
ep93xx boards needed to use the same phys offset.

>> Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>
> May I add a Tested-by tag as well?

Sure...

Tested-by: H Hartley Sweeten <hsweeten@visionengravers.com>
