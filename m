From: d-gerlach@ti.com (Dave Gerlach)
Date: Mon, 18 Sep 2017 14:57:36 -0500
Subject: [PATCH v3 2/2] memory: ti-emif-sram: introduce relocatable
 suspend/resume handlers
In-Reply-To: <20170831140332.GD23750@n2100.armlinux.org.uk>
References: <20170724212454.27574-1-d-gerlach@ti.com>
 <20170724212454.27574-3-d-gerlach@ti.com>
 <20170831140332.GD23750@n2100.armlinux.org.uk>
Message-ID: <d68b90bb-fa93-24e5-08f0-ab6d7bd2df22@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,
On 08/31/2017 09:03 AM, Russell King - ARM Linux wrote:
> On Mon, Jul 24, 2017 at 04:24:54PM -0500, Dave Gerlach wrote:
>> diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
>> index 608008229c7d..46a7a6c41db7 100644
>> --- a/arch/arm/kernel/asm-offsets.c
>> +++ b/arch/arm/kernel/asm-offsets.c
>> @@ -28,6 +28,7 @@
>>  #include <asm/vdso_datapage.h>
>>  #include <asm/hardware/cache-l2x0.h>
>>  #include <linux/kbuild.h>
>> +#include <linux/ti-emif-sram.h>
>>  
>>  /*
>>   * Make sure that the compiler and target are compatible.
>> @@ -183,5 +184,8 @@ int main(void)
>>  #ifdef CONFIG_VDSO
>>    DEFINE(VDSO_DATA_SIZE,	sizeof(union vdso_data_store));
>>  #endif
>> +  BLANK();
>> +  ti_emif_offsets();
>> +
>>    return 0; 
>>  }
> 
> This doesn't make me happy - I've been thinking about this for some time,
> and I think it's completely wrong for drivers to hook into asm-offsets.
> 
> Looking at the top-level Kbuild file, it looks like it would be easy
> for emif to auto-generate its own offsets.h header - it looks like it's
> a matter of using linux/kbuild.h to get the definitions, compiling to
> assembly (using $(call if_changed_dep,cc_s_c)) and then converting the
> assembly to the header file format ( using
> $(call filechk,offsets,__ASM_OFFSETS_H__), replacing __ASM_OFFSETS_H__
> with a more appropriate symbol.)
> 
> Could you please check whether this is possible, so we don't end up
> needing to hook lots of driver-specific assembly offsets stuff into
> the arch files?
> 

I was able to try this out and was successful, I will send an updated version
that generates a local emif-asm-offsets.h. Thanks for the suggestion.

Regards,
Dave
