From: michael.williamson@criticallink.com (Michael Williamson)
Date: Thu, 26 Aug 2010 20:12:27 -0400
Subject: [PATCH v4] davinci: Add MityDSP-L138/MityARM-1808 SOM support
In-Reply-To: <877hjd106u.fsf@deeprootsystems.com>
References: <4C516634.5040804@criticallink.com>
	<877hjd106u.fsf@deeprootsystems.com>
Message-ID: <4C7702EB.8040905@criticallink.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On 08/26/2010 06:25 PM, Kevin Hilman wrote:
> Michael Williamson<michael.williamson@criticallink.com>  writes:
>
>    
>>   This patch adds support for the MityDSP-L138 and MityARM-1808 system on
>> module (SOM) under the registered machine "mityomapl138".  These SOMs
>> are based on the da850 davinci CPU architecture.  Information on these
>> SOMs may be found at http://www.mitydsp.com.
>>
>> Signed-off-by: Michael Williamson<michael.williamson@criticallink.com>
>> ---
>> This patch is against Kevin's tree, but is dependent on the following patch,
>> which is queued for 2.6.36:
>>
>> [1] http://git.kernel.org/?p=linux/kernel/git/broonie/sound-2.6.git;a=commit;h=48519f0ae03bc7e86b3dc93e56f1334d53803770
>>      
> Running this patch through scripts/checkpatch.pl, I get:
>
>     total: 268 errors, 586 warnings, 1632 lines checked
>
> Please fix all errors and warnings.
>
> For future reference, normally, I don't even read the rest of a patch if
> there are any checkpatch errors.
>
>    

As expected. At the time I submitted this (before your comments came in
on V3, actually), I had run a checkpatch.pl and it had passed.  That was
prior to the 2.6.35 merge when you got back from vacation.  Given your
comments on V3, I had withdrawn the submission.  This submission should
have been dropped.  I'm sorry if I generated extra reviewing work for you.
I didn't catch that our thread of discussion was on the V3 submission.

Please drop all submissions relating to this subject.  If there was 
something
more I should have done, please let me know.

>> Changes since v3 patch was submitted:
>>      * renamed ATAG_PERIPHERALS to ATAG_MITYDSPL138
>>      
> This new ATAG should be a separate patch.
>
> However, as I mentioned in earlier versions, new ATAGs are not welcome
> upstream, and I will not merge this.  Other suggestions have been
> proposed to solve this.
>
> If you insist, after the bare board support is merged, you can post your
> ATAG patch to linux-arm-kernel and see if Russell is willing to merge
> this, but I doubt it.
>    

Understood.  Not trying to use this ATAG patch for the mainline anymore,
trying other techniques but not ready for resubmission.
>    
>>      * removed unused header files
>>      * renamed config structure items to remove camel case naming
>>      * don't use GPIO if resources aren't acquired
>>      * don't use device_initcall on emac config
>>      * handle upcoming patch to platform sound config
>>      * clean up mcasp configuration
>>      * misc cleanup per comments
>>
>>   arch/arm/configs/da8xx_omapl_defconfig             |  291 ++++++-
>>      
> The defconfig change needs to be redone against current tree, since some
> major changes where done here for 2.6.36.
>    
I saw that go by.  If I get around to a resubmission, I'll be sure to 
sync up.
>    
>>   arch/arm/include/asm/setup.h                       |    5 +
>>   arch/arm/mach-davinci/Kconfig                      |    8 +
>>   arch/arm/mach-davinci/Makefile                     |    1 +
>>   arch/arm/mach-davinci/board-mityomapl138.c         |  806 ++++++++++++++++++++
>>   .../mach-davinci/include/mach/cb-mityomapl138.h    |  120 +++
>>   arch/arm/mach-davinci/include/mach/da8xx.h         |    1 +
>>   arch/arm/mach-davinci/include/mach/uncompress.h    |    1 +
>>   8 files changed, 1190 insertions(+), 43 deletions(-)
>>      
> Normally, I like to see new board support broken down more.  It's rather
> difficult to do a good review of new board file when everything is added
> in a single patch.
>
> Typically, a basic patch that just supports basic boot (typically to
> UART console) is the first patch.  Then additional patches are added to
> add peripheral support (display, MMC, SPI, flash, regulators, ...)
>
> Breaking things up this way helps reviewers and maintainers greatly.
>
> [...]
>    
OK.  Most of the board file is a large cut-and-paste of the da850
EVM.  It seems unlikely that I'll have any measure of success here, but if
I get time I might try again.

>    
>> diff --git a/arch/arm/include/asm/setup.h b/arch/arm/include/asm/setup.h
>> index f392fb4..1d3a8cf 100644
>> --- a/arch/arm/include/asm/setup.h
>> +++ b/arch/arm/include/asm/setup.h
>> @@ -143,6 +143,11 @@ struct tag_memclk {
>>       __u32 fmemclk;
>>   };
>>
>> +/** MityDSP-L138 peripheral configuration info,
>>      
> please fix multi-line comment style.  search for 'multi-line' in
> Documentation/CodingStytle.  There are several instances of this problem
> in the patch.
>
>    
OK.  I'll watch for that if I resubmit.  Thanks.
>> +  *  see arch/arm/mach-davinci/include/mach/cb-mityomapl138.h
>> +  */
>> +#define ATAG_MITYDSPL138 0x42000101
>> +
>>   struct tag {
>>       struct tag_header hdr;
>>       union {
>> diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
>> index 71f90f8..8fcf47d 100644
>> --- a/arch/arm/mach-davinci/Kconfig
>> +++ b/arch/arm/mach-davinci/Kconfig
>> @@ -178,6 +178,14 @@ config DA850_UI_RMII
>>
>>   endchoice
>>
>> +config MACH_MITYOMAPL138
>> +    bool "Critical Link MityDSP-L138/MityARM-1808 SoM"
>> +    depends on ARCH_DAVINCI_DA850
>> +    help
>> +      Say Y here to select the Critical Link MityDSP-L138/MityARM-1808
>> +      System on Module.  Information on this SoM may be found at
>> +      http://www.mitydsp.com.
>> +
>>   config MACH_TNETV107X
>>       bool "TI TNETV107X Reference Platform"
>>       default ARCH_DAVINCI_TNETV107X
>> diff --git a/arch/arm/mach-davinci/Makefile b/arch/arm/mach-davinci/Makefile
>> index eab4c0f..dfc0fc4 100644
>> --- a/arch/arm/mach-davinci/Makefile
>> +++ b/arch/arm/mach-davinci/Makefile
>> @@ -32,6 +32,7 @@ obj-$(CONFIG_MACH_DAVINCI_DM6467_EVM)    += board-dm646x-evm.o cdce949.o
>>   obj-$(CONFIG_MACH_DAVINCI_DM365_EVM)    += board-dm365-evm.o
>>   obj-$(CONFIG_MACH_DAVINCI_DA830_EVM)    += board-da830-evm.o
>>   obj-$(CONFIG_MACH_DAVINCI_DA850_EVM)    += board-da850-evm.o
>> +obj-$(CONFIG_MACH_MITYOMAPL138)    += board-mityomapl138.o
>>   obj-$(CONFIG_MACH_TNETV107X)        += board-tnetv107x-evm.o
>>
>>   # Power Management
>> diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
>> new file mode 100644
>> index 0000000..57a4ab4
>> --- /dev/null
>> +++ b/arch/arm/mach-davinci/board-mityomapl138.c
>> @@ -0,0 +1,806 @@
>> +/*
>> + * Critical Link MityOMAP-L138 SoM
>> + *
>> + * Copyright (C) 2010 Critical Link LLC - http://www.criticallink.com
>> + *
>> + * Derived from board-da850-evm.c
>> + * Original Copyrights follow:
>> + *
>> + * Copyright (C) 2009 Texas Instruments Incorporated - http://www.ti.com/
>> + *
>> + * Derived from: arch/arm/mach-davinci/board-da830-evm.c
>> + * Original Copyrights follow:
>> + *
>> + * 2007, 2009 (c) MontaVista Software, Inc. This file is licensed under
>> + * the terms of the GNU General Public License version 2. This program
>> + * is licensed "as is" without any warranty of any kind, whether express
>> + * or implied.
>> + */
>> +
>> +#define pr_fmt(fmt) "%s: " fmt, __func__
>>      
> I don't find any users of this in the patch.  Please remove.
>
>    
OK.  Thanks (I had another comment recommending I use that).
>> +#include<linux/kernel.h>
>> +#include<linux/init.h>
>> +#include<linux/console.h>
>> +#include<linux/i2c.h>
>> +#include<linux/i2c/at24.h>
>>      
> I don't think you need at24.h here.  Please remove any headers that you
> are not actually using.
>
> [...]
>
> Kevin
>    
Thanks.
