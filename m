From: rmallon@gmail.com (Ryan Mallon)
Date: Sat, 14 Jan 2012 08:16:53 +1100
Subject: [PATCH 09/11] ep93xx: Move crunch code to mach-ep93xx directory
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F001F3F99EBB11@AUSP01VMBX24.collaborationhost.net>
References: <1326251676-7593-1-git-send-email-rmallon@gmail.com>
 <1326251676-7593-10-git-send-email-rmallon@gmail.com>
 <ADE657CA350FB648AAC2C43247A983F001F3F99EBB11@AUSP01VMBX24.collaborationhost.net>
Message-ID: <4F109F45.9020105@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/01/12 04:51, H Hartley Sweeten wrote:
> On Tuesday, January 10, 2012 8:15 PM, Ryan Mallon wrote:
>> The crunch code in arch/arm/kernel is specific to the EP93xx. Move
>> it to the mach-ep93xx directory. This removes the need for the
>> EP93XX_SYSCON defines to be exported to arch/arm/kernel.
>>
>> Cc: Hartley Sweeten <hsweeten@visionengravers.com>
>> Cc: Mika Westerberg <mika.westerberg@iki.fi>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Signed-off-by: Ryan Mallon <rmallon@gmail.com>
>> ---
>>  arch/arm/kernel/Makefile                       |    3 ---
>>  arch/arm/mach-ep93xx/Makefile                  |    3 +++
>>  arch/arm/{kernel => mach-ep93xx}/crunch-bits.S |    0
>>  arch/arm/{kernel => mach-ep93xx}/crunch.c      |    2 ++
>>  4 files changed, 5 insertions(+), 3 deletions(-)  rename arch/arm/{kernel => mach-ep93xx}/crunch-bits.S (100%)  rename arch/arm/{kernel => mach-ep93xx}/crunch.c (99%)
>>
>> diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile index 16eed6a..57aa6c9 100644
>> --- a/arch/arm/kernel/Makefile
>> +++ b/arch/arm/kernel/Makefile
>> @@ -62,9 +62,6 @@ obj-$(CONFIG_SWP_EMULATE)	+= swp_emulate.o
>>  CFLAGS_swp_emulate.o		:= -Wa,-march=armv7-a
>>  obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
>>  
>> -obj-$(CONFIG_CRUNCH)		+= crunch.o crunch-bits.o
>> -AFLAGS_crunch-bits.o		:= -Wa,-mcpu=ep9312
>> -
>>  obj-$(CONFIG_CPU_XSCALE)	+= xscale-cp0.o
>>  obj-$(CONFIG_CPU_XSC3)		+= xscale-cp0.o
>>  obj-$(CONFIG_CPU_MOHAWK)	+= xscale-cp0.o
>> diff --git a/arch/arm/mach-ep93xx/Makefile b/arch/arm/mach-ep93xx/Makefile index 574209d..0dc51f9 100644
>> --- a/arch/arm/mach-ep93xx/Makefile
>> +++ b/arch/arm/mach-ep93xx/Makefile
>> @@ -8,6 +8,9 @@ obj-			:=
>>  
>>  obj-$(CONFIG_EP93XX_DMA)	+= dma.o
>>  
>> +obj-$(CONFIG_CRUNCH)		+= crunch.o crunch-bits.o
>> +AFLAGS_crunch-bits.o		:= -Wa,-mcpu=ep9312
>> +
> Nitpick... Care to align the core stuff above this while you are touching this file?
>
> Also, does the compile order matter here? Should the crunch stuff come before
> the dma driver?

I was hoping that Russell would make some comment here about whether
moving this file out of arch/arm/kernel is okay to do. I assume it had
some reason to be there in the first place. I have only done build
testing so far since I don't have any ep93xx hardware to test on, and
have never actually used crunch anyway.

I don't want to make unnecessary changes in this patch. I think the
include of "soc.h" should actually get moved to the next patch also, so
that this patch becomes a straight out move.

>>  obj-$(CONFIG_MACH_ADSSPHERE)	+= adssphere.o
>>  obj-$(CONFIG_MACH_EDB93XX)	+= edb93xx.o
>>  obj-$(CONFIG_MACH_GESBC9312)	+= gesbc9312.o
>> diff --git a/arch/arm/kernel/crunch-bits.S b/arch/arm/mach-ep93xx/crunch-bits.S
>> similarity index 100%
>> rename from arch/arm/kernel/crunch-bits.S rename to arch/arm/mach-ep93xx/crunch-bits.S
>> diff --git a/arch/arm/kernel/crunch.c b/arch/arm/mach-ep93xx/crunch.c similarity index 99% rename from arch/arm/kernel/crunch.c rename to arch/arm/mach-ep93xx/crunch.c index > 25ef223..d05ed0b 100644
>> --- a/arch/arm/kernel/crunch.c
>> +++ b/arch/arm/mach-ep93xx/crunch.c
>> @@ -19,6 +19,8 @@
>>  #include <mach/ep93xx-regs.h>
>>  #include <asm/thread_notify.h>
>>  
>> +#include "soc.h"
>> +
>>  struct crunch_state *crunch_owner;
>>  
>>  void crunch_task_release(struct thread_info *thread)
> While you are moving this, is there anything you can do about the sparse
> warning regarding the crunch_owner variable?
>

What is the warning?

> Regardless, looks good.
>
> Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>
Thanks,
~Ryan
