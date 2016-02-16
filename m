From: keescook@chromium.org (Kees Cook)
Date: Tue, 16 Feb 2016 13:55:40 -0800
Subject: [PATCH] ARM: drop unused DEBUG_RODATA from XIP_KERNEL
In-Reply-To: <alpine.LFD.2.20.1602161539550.13632@knanqh.ubzr>
References: <20160216202957.GA1826@www.outflux.net>
 <alpine.LFD.2.20.1602161539550.13632@knanqh.ubzr>
Message-ID: <CAGXu5jJAzrkoNxj48NRQmfUh2Ej1DOfjZETz2wFJQnO_OxJy-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 16, 2016 at 12:41 PM, Nicolas Pitre
<nicolas.pitre@linaro.org> wrote:
> On Tue, 16 Feb 2016, Kees Cook wrote:
>
>> With CONFIG_DEBUG_RODATA not being sensible under XIP_KERNEL, remove it
>> from the XIP linker script.
>
> If so you should also make DEBUG_RODATA depend on !XIP_KERNEL in Kconfig
> to avoid offering a config option that does nothing.

Yeah, that's what Arnd's other patch does. This is intended to follow
his cleanups that do this.

-Kees

>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>> Effectively the patch after Arnd's "ARM: mm: hide
>> __start_rodata_section_aligned for non-debug builds"
>> ---
>>  arch/arm/kernel/vmlinux-xip.lds.S | 10 ----------
>>  1 files changed, 0 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
>> index 40bc4cadb959..cba1ec899a69 100644
>> --- a/arch/arm/kernel/vmlinux-xip.lds.S
>> +++ b/arch/arm/kernel/vmlinux-xip.lds.S
>> @@ -8,9 +8,6 @@
>>  #include <asm/thread_info.h>
>>  #include <asm/memory.h>
>>  #include <asm/page.h>
>> -#ifdef CONFIG_DEBUG_RODATA
>> -#include <asm/pgtable.h>
>> -#endif
>>
>>  #define PROC_INFO                                                    \
>>       . = ALIGN(4);                                                   \
>> @@ -92,10 +89,6 @@ SECTIONS
>>               HEAD_TEXT
>>       }
>>
>> -#ifdef CONFIG_DEBUG_RODATA
>> -     . = ALIGN(1<<SECTION_SHIFT);
>> -#endif
>> -
>>       .text : {                       /* Real text segment            */
>>               _stext = .;             /* Text and read-only data      */
>>                       IDMAP_TEXT
>> @@ -115,9 +108,6 @@ SECTIONS
>>                       ARM_CPU_KEEP(PROC_INFO)
>>       }
>>
>> -#ifdef CONFIG_DEBUG_RODATA
>> -     . = ALIGN(1<<SECTION_SHIFT);
>> -#endif
>>       RO_DATA(PAGE_SIZE)
>>
>>       . = ALIGN(4);
>> --
>> 2.6.3
>>
>>
>> --
>> Kees Cook
>> Chrome OS & Brillo Security
>>
>>



-- 
Kees Cook
Chrome OS & Brillo Security
