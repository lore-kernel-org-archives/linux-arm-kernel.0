From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 3 Feb 2015 11:41:05 +0000
Subject: [PATCH v8 02/21] acpi: fix acpi_os_ioremap for arm64
In-Reply-To: <20150203113744.GA3677@e104818-lin.cambridge.arm.com>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
 <1422881149-8177-3-git-send-email-hanjun.guo@linaro.org>
 <2422968.Es7R0p3loO@vostro.rjw.lan> <54D0901A.2080406@linaro.org>
 <20150203113744.GA3677@e104818-lin.cambridge.arm.com>
Message-ID: <CAKv+Gu9LV_Uh9R84ixqgMRnDTvPtBzT5R-0BHDL=yomBY4E4dg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 February 2015 at 11:37, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Tue, Feb 03, 2015 at 09:08:42AM +0000, Hanjun Guo wrote:
>> On 2015?02?03? 06:14, Rafael J. Wysocki wrote:
>> > On Monday, February 02, 2015 08:45:30 PM Hanjun Guo wrote:
>> >> From: Mark Salter <msalter@redhat.com>
>> >>
>> >> The acpi_os_ioremap() function may be used to map normal RAM or IO
>> >> regions. The current implementation simply uses ioremap_cache(). This
>> >> will work for some architectures, but arm64 ioremap_cache() cannot be
>> >> used to map IO regions which don't support caching. So for arm64, use
>> >> ioremap() for non-RAM regions.
>> >>
>> >> CC: Rafael J Wysocki <rjw@rjwysocki.net>
>> >> Signed-off-by: Mark Salter <msalter@redhat.com>
>> >> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> >> ---
>> >>   include/acpi/acpi_io.h | 6 ++++++
>> >>   1 file changed, 6 insertions(+)
>> >>
>> >> diff --git a/include/acpi/acpi_io.h b/include/acpi/acpi_io.h
>> >> index 444671e..9d573db 100644
>> >> --- a/include/acpi/acpi_io.h
>> >> +++ b/include/acpi/acpi_io.h
>> >> @@ -1,11 +1,17 @@
>> >>   #ifndef _ACPI_IO_H_
>> >>   #define _ACPI_IO_H_
>> >>
>> >> +#include <linux/mm.h>
>> >>   #include <linux/io.h>
>> >>
>> >>   static inline void __iomem *acpi_os_ioremap(acpi_physical_address phys,
>> >>                                        acpi_size size)
>> >>   {
>> >> +#ifdef CONFIG_ARM64
>> >> +  if (!page_is_ram(phys >> PAGE_SHIFT))
>> >> +          return ioremap(phys, size);
>> >> +#endif
>> >
>> > I don't want to see #ifdef CONFIG_ARM64 in this file.
>> >
>> > There are multiple examples of how things like this are done.  Generally,
>> > the logic is "If the architecture provides its own function for this, use
>> > that one, or use the generic one provided here otherwise."
>>
>> OK. I think weak function would work.
>
> Probably not in a header file. It's better to define acpi_os_ioremap()
> in an arm64 kernel file, together with something like:
>
> #define ARCH_HAS_ACPI_OS_IOREMAP
>
> and the corresponding #ifdef's in the acpi_io.h file.
>
> On arm64 could we make this function call iorema (nocache) all the time?
> We need to clarify the contexts where this is used in the core ACPI
> code. The acpi_map() function for example checks if the page is ram and
> does a kmap(). Do we need to handle the NVS on arm64? AFAICT, we don't
> even compile drivers/acpi/sleep.c in.
>
> Are there other cases where acpi_os_ioremap() is called directly and it
> needs a cacheable mapping?
>

The logic behind acpi_os_ioremap() could be based on the physmem
series I am preparing for 3.21 timeframe.
It allows us to classify physical ranges as backed by RAM or not, and
call the appropriate flavor of ioremap()

-- 
Ard.
