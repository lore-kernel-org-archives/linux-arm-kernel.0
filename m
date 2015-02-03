From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 03 Feb 2015 17:08:42 +0800
Subject: [PATCH v8 02/21] acpi: fix acpi_os_ioremap for arm64
In-Reply-To: <2422968.Es7R0p3loO@vostro.rjw.lan>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
 <1422881149-8177-3-git-send-email-hanjun.guo@linaro.org>
 <2422968.Es7R0p3loO@vostro.rjw.lan>
Message-ID: <54D0901A.2080406@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?02?03? 06:14, Rafael J. Wysocki wrote:
> On Monday, February 02, 2015 08:45:30 PM Hanjun Guo wrote:
>> From: Mark Salter <msalter@redhat.com>
>>
>> The acpi_os_ioremap() function may be used to map normal RAM or IO
>> regions. The current implementation simply uses ioremap_cache(). This
>> will work for some architectures, but arm64 ioremap_cache() cannot be
>> used to map IO regions which don't support caching. So for arm64, use
>> ioremap() for non-RAM regions.
>>
>> CC: Rafael J Wysocki <rjw@rjwysocki.net>
>> Signed-off-by: Mark Salter <msalter@redhat.com>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>   include/acpi/acpi_io.h | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/include/acpi/acpi_io.h b/include/acpi/acpi_io.h
>> index 444671e..9d573db 100644
>> --- a/include/acpi/acpi_io.h
>> +++ b/include/acpi/acpi_io.h
>> @@ -1,11 +1,17 @@
>>   #ifndef _ACPI_IO_H_
>>   #define _ACPI_IO_H_
>>
>> +#include <linux/mm.h>
>>   #include <linux/io.h>
>>
>>   static inline void __iomem *acpi_os_ioremap(acpi_physical_address phys,
>>   					    acpi_size size)
>>   {
>> +#ifdef CONFIG_ARM64
>> +	if (!page_is_ram(phys >> PAGE_SHIFT))
>> +		return ioremap(phys, size);
>> +#endif
>
> I don't want to see #ifdef CONFIG_ARM64 in this file.
>
> There are multiple examples of how things like this are done.  Generally,
> the logic is "If the architecture provides its own function for this, use
> that one, or use the generic one provided here otherwise."

OK. I think weak function would work.

Thanks
Hanjun
