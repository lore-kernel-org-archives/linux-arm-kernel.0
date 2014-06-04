From: yi.li@linaro.org (Yi Li)
Date: Wed, 04 Jun 2014 23:01:36 +0800
Subject: [PATCH] ARM64:DMI: Add smbios/dmi support on arm64
In-Reply-To: <20140604133200.GA4329@leverpostej>
References: <1401811033-16478-1-git-send-email-yi.li@linaro.org>
 <20140604133200.GA4329@leverpostej>
Message-ID: <538F34D0.5090905@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

     Please see the comments below:

On Wednesday, June 04, 2014 09:32 PM, Mark Rutland wrote:
> On Tue, Jun 03, 2014 at 04:57:13PM +0100, Yi Li wrote:
>> Add smbios/dmi support on arm64 system, it depends on
>> EFI boot.
> And what exactly does this provide us with?
>
> What is exposed through SMBIOS/DMI, and why would I want to enable it?
Yi: SMBIOS/DMI is one basic spec/feature for server product(like x86 and 
IA64).
      Many OEMs/ODMs hope to use ARM64 as server's processor.
      So we need to support SMBIOS on ARM64.

     SMBIOS mainly describes some hardware and software information for 
the system, like BIOS information
     CPU information,  Memory information ,and so on. please refer to 
http://www.dmtf.org/standards/smbios

>
>> Signed-off-by: Yi Li <yi.li@linaro.org>
>> ---
>>
>> Changes since v1:
>>    -Followed Ard Biesheuvel's suggestion to rebase the patch on
>>     Matt Fleming's arm64-efi branch.
>>
>>   arch/arm64/Kconfig           |   10 ++++++++++
>>   arch/arm64/include/asm/dmi.h |   28 ++++++++++++++++++++++++++++
>>   arch/arm64/kernel/setup.c    |    2 ++
>>   3 files changed, 40 insertions(+)
>>   create mode 100644 arch/arm64/include/asm/dmi.h
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 6c71f12..13ee261 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -294,6 +294,16 @@ config EFI
>>   	  allow the kernel to be booted as an EFI application. This
>>   	  is only useful on systems that have UEFI firmware.
>>   
>> +config DMI
>> +	bool "Enable support for SMBIOS (DMI) tables"
>> +	depends on EFI
>> +	default y
>> +	help
>> +	  This enables SMBIOS/DMI feature for systems.
>> +
>> +	  This option is only useful on systems that have UEFI firmware.
>> +	  However, even with this option, the resultant kernel should
>> +	  continue to boot on existing non-UEFI platforms.
>>   endmenu
>>   
>>   menu "Userspace binary formats"
>> diff --git a/arch/arm64/include/asm/dmi.h b/arch/arm64/include/asm/dmi.h
>> new file mode 100644
>> index 0000000..f2198bf
>> --- /dev/null
>> +++ b/arch/arm64/include/asm/dmi.h
>> @@ -0,0 +1,28 @@
>> +/*
>> + * arch/arm64/include/asm/dmi.h
>> + *
>> + * Copyright (C) 2013 Linaro Limited.
>> + * Written by: Yi Li (yi.li at linaro.org)
>> + *
>> + * based on arch/ia64/include/asm/dmi.h
>> + *
>> + * This file is subject to the terms and conditions of the GNU General Public
>> + * License.  See the file "COPYING" in the main directory of this archive
>> + * for more details.
>> + */
>> +
>> +
>> +#ifndef _ASM_DMI_H
>> +#define _ASM_DMI_H 1
>> +
>> +#include <linux/slab.h>
>> +#include <asm/io.h>
> Shouldn't that be linux/efi.h?
>
> Why do we need asm/io.h?
     Yi: porting it from IA64 , so the io.h is not needed exactly!
          but slab.h is must included ,not efi.h (tested by compiling)
>> +
>> +/* Use efi mappings for DMI */
>> +#define dmi_early_remap(x, l)	efi_lookup_mapped_addr(x)
>> +#define dmi_early_unmap(x, l)
>> +#define dmi_remap(x, l)			efi_lookup_mapped_addr(x)
>> +#define dmi_unmap(x)
>> +#define dmi_alloc(l)			kzalloc(l, GFP_ATOMIC)
>> +
>> +#endif
> None of these seem to use anything from io.h directly.
     Yi: You are right , io.h doesn't need.
> Cheers,
> Mark.
