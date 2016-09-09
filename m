From: james.morse@arm.com (James Morse)
Date: Fri, 09 Sep 2016 10:31:39 +0100
Subject: [PATCH v3 2/3] hwmon: xgene: Add hwmon driver
In-Reply-To: <20160909031809.GG16712@linaro.org>
References: <1469134557-26869-1-git-send-email-hotran@apm.com>
 <13081573.BbD3TmEU5Y@wuerfel> <20160907223705.GA31582@roeck-us.net>
 <2992356.ULGoZEEDZp@wuerfel> <57D141DF.2010603@arm.com>
 <20160909031809.GG16712@linaro.org>
Message-ID: <57D2817B.8030007@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 09/09/16 04:18, AKASHI Takahiro wrote:
> On Thu, Sep 08, 2016 at 11:47:59AM +0100, James Morse wrote:
>> On 08/09/16 09:14, Arnd Bergmann wrote:
>>> On Wednesday, September 7, 2016 3:37:05 PM CEST Guenter Roeck wrote:
>>>> On Wed, Sep 07, 2016 at 11:41:44PM +0200, Arnd Bergmann wrote:
>>>>> On Thursday, July 21, 2016 1:55:56 PM CEST Hoan Tran wrote:
>>>>>> +               ctx->comm_base_addr = cppc_ss->base_address;
>>>>>> +               if (ctx->comm_base_addr) {
>>>>>> +                       ctx->pcc_comm_addr =
>>>>>> +                                       acpi_os_ioremap(ctx->comm_base_addr,
>>>>>> +                                                       cppc_ss->length);
>>>>>>
>>>>>
>>>>> This causes the arm64 allmodconfig build to fail now, according to
>>>>> kernelci:
>>>>>
>>>>>       1  ERROR: "memblock_is_memory" [drivers/hwmon/xgene-hwmon.ko] undefined!
>>>>>
>>>>> Should this perhaps call ioremap() or memremap() instead?
>>>>>
>>>> Hmmm ... almost sounds to me like blaming the messenger. e7cd190385d1 ("arm64:
>>>> mark reserved memblock regions explicitly in iomem") starts using a function
>>>> in acpi_os_ioremap() which is not exported. On top of that, memblock_is_memory()
>>>> is declared as __init_memblock, which makes me really uncomfortable.
>>>> If acpi_os_ioremap() must not be used by modules, and possibly only during
>>>> early (?) initialization, maybe its declaration should state those limitations ?
>>>
>>> Ah, I didn't notice that. I guess both patches were correct individually and
>>> got added to linux-next around the same time but caused allmodconfig to blow up
>>> when used together.
>>>
>>> Adding everyone who was involved in the memblock patch to Cc here, maybe one
>>> of them has an idea what the correct fix is. There are only two other drivers
>>> using acpi_os_ioremap() and one of them is x86-specific, so it's still likely
>>> that drivers are not actually supposed to use this symbol. Making
>>> acpi_os_ioremap() an exported function in arm64 would also work.
>>
>> You could use acpi_os_map_iomem()/acpi_os_unmap_iomem() from acpi/acpi_io.h.
>> If there isn't an existing mapping these end up in acpi_os_ioremap(), and are
>> already EXPORT_SYMBOL_GPL().
> 
> acpi_os_ioremap() is re-defined in arm64/include/asm/acpi.h.
> 
> The problem is that, as memblock_is_memory() is declared as __init,

__init_memblock ...

... as is memblock_is_map_memory(), which we call from pfn_valid() which is
EXPORT_SYMBOL()'d
and used from modules, (e.g. mac80211.ko). So something fishy is going on...

>From include/linux/memblock.h:
> #ifdef CONFIG_ARCH_DISCARD_MEMBLOCK
> #define __init_memblock __meminit
> #define __initdata_memblock __meminitdata
> #else
> #define __init_memblock
> #define __initdata_memblock
> #endif

arm64 doesn't define ARCH_DISCARD_MEMBLOCK, so we always keep these symbols.
If we didn't, pfn_valid() would break too.


Thanks,

James
