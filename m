From: zijun_hu@zoho.com (zijun_hu)
Date: Fri, 2 Sep 2016 00:03:58 +0800
Subject: [PATCH 2/2] arm64: regard FDT_SW_MAGIC as good fdt magic
In-Reply-To: <20160901112113.GA4220@leverpostej>
References: <a6a8826c-3006-ae43-ef4c-8049ef93cd9f@zoho.com>
 <20160901112113.GA4220@leverpostej>
Message-ID: <57C8516E.7000105@zoho.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/01/2016 07:21 PM, Mark Rutland wrote:
> On Thu, Sep 01, 2016 at 06:58:29PM +0800, zijun_hu wrote:
>> From: zijun_hu <zijun_hu@htc.com>
>>
>> regard FDT_SW_MAGIC as good fdt magic during mapping fdt area
>> see fdt_check_header() for details
> 
> It looks like we should only see FDT_SW_MAGIC for a FDT that was in the
> process of being created, but was not finished. So I'm somewhat confused
> as to why fdt_check_header() would allow this.
> 
> Neither ePAPR nor the new devicetree spec define FDT_SW_MAGIC. They both
> only define 0xd00dfeed as a valid magic value. In libfdt, FDT_SW_MAGIC
> is an internal constant, and it looks like fdt_check_header() simply
> accepts this for convenience within libfdt.
> 
> Given all of that, it looks like the kernel should *not* accept
> FDT_SW_MAGIC in any case.
> 
> Why do you think this is necessary? Have you seen a problem in practice?
>

i don't understand function modules involved with FDT_SW_MAGIC very well
i just think it isn't a bad thing to keep consistent with fdt_check_header()

no, i have no problem about fdt magic in practice

BTW
it seems FDT_SW_MAGIC is involved in fdt_create_empty_tree()@fdt_sw.c which
operate fdt in runtime
in kernel, this function is used in drivers/firmware/efi/libstub/fdt.c
in u-boot, in arch/sandbox/cpu/cpu.c an arch/sandbox/cpu/state.c
the sources mentioned above maybe help you for further decision

>> --- a/scripts/dtc/libfdt/fdt.h
>> +++ b/scripts/dtc/libfdt/fdt.h
>> @@ -92,7 +92,8 @@ struct fdt_property {
>>  
>>  #endif /* !__ASSEMBLY */
>>  
>> -#define FDT_MAGIC	0xd00dfeed	/* 4: version, 4: total size */
>> +/* 4: version, 4: total size */
>> +#define FDT_MAGIC	((fdt32_t)0xd00dfeed)
>>  #define FDT_TAGSIZE	sizeof(fdt32_t)
>>  
>>  #define FDT_BEGIN_NODE	0x1		/* Start node: full name */
>> diff --git a/scripts/dtc/libfdt/libfdt.h b/scripts/dtc/libfdt/libfdt.h
>> index 59ca33976e56..6998f9249183 100644
>> --- a/scripts/dtc/libfdt/libfdt.h
>> +++ b/scripts/dtc/libfdt/libfdt.h
>> @@ -54,6 +54,8 @@
>>  #include "libfdt_env.h"
>>  #include "fdt.h"
>>  
>> +#define FDT_SW_MAGIC           (~FDT_MAGIC)
>> +
>>  #define FDT_FIRST_SUPPORTED_VERSION	0x10
>>  #define FDT_LAST_SUPPORTED_VERSION	0x11
>>  
>> diff --git a/scripts/dtc/libfdt/libfdt_internal.h b/scripts/dtc/libfdt/libfdt_internal.h
>> index 02cfa6fb612d..f4efde0119f2 100644
>> --- a/scripts/dtc/libfdt/libfdt_internal.h
>> +++ b/scripts/dtc/libfdt/libfdt_internal.h
>> @@ -90,6 +90,4 @@ static inline struct fdt_reserve_entry *_fdt_mem_rsv_w(void *fdt, int n)
>>  	return (void *)(uintptr_t)_fdt_mem_rsv(fdt, n);
>>  }
>>  
>> -#define FDT_SW_MAGIC		(~FDT_MAGIC)
>> -
>>  #endif /* _LIBFDT_INTERNAL_H */
> 
> Regardless of the above, changes to libfdt must happen in the upstream
> libfdt codebase first.

okay, make sense
FDT team maybe help decide whether to expose FDT_SW_MAGIC to users
>
> Thanks,
> Mark.
> 
