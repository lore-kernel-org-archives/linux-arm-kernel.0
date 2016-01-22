From: wcohen@redhat.com (William Cohen)
Date: Fri, 22 Jan 2016 09:43:25 -0500
Subject: [PATCH] Eliminate the .eh_frame sections from the aarch64 vmlinux
 and kernel modules
In-Reply-To: <CAKv+Gu9j7VGqoOWOZ1T1CVQZfSy9HL9wzvAX83bRiks=6b3dzw@mail.gmail.com>
References: <1453434986-19307-1-git-send-email-wcohen@redhat.com>
 <CAKv+Gu9j7VGqoOWOZ1T1CVQZfSy9HL9wzvAX83bRiks=6b3dzw@mail.gmail.com>
Message-ID: <56A2400D.5080707@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/22/2016 02:41 AM, Ard Biesheuvel wrote:
> On 22 January 2016 at 04:56, William Cohen <wcohen@redhat.com> wrote:
>> By default the aarch64 gcc generates .eh_frame sections.  Unlike
>> .debug_frame sections, the .eh_frame sections are loaded into memory
>> when the associated code is loaded.  On an example kernel being built
>> with this default the .eh_frame section in vmlinux used an extra 1.7MB
>> of memory.  The x86 disables the creation of the .eh_frame section.
>> The aarch64 should probably do the same to save some memory.
>>
> 
> With my GCC-4.9.3 Linaro toolchain, I am not getting .eh_frame
> sections only .debug_frame sections. The patch still makes sense imo,
> but it appears to be redundant in some cases, and it would be useful
> to figure out why. Which toolchain have you tested this with?

Hi,

I have observed the .eh_frame being generated with gcc-5.3.1 that is in Fedora 23.

-Will

> 
> 
>> Signed-off-by: William Cohen <wcohen@redhat.com>
>> ---
>>  arch/arm64/Makefile | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
>> index cd822d8..094a137 100644
>> --- a/arch/arm64/Makefile
>> +++ b/arch/arm64/Makefile
>> @@ -27,6 +27,7 @@ $(warning LSE atomics not supported by binutils)
>>  endif
>>
>>  KBUILD_CFLAGS  += -mgeneral-regs-only $(lseinstr)
>> +KBUILD_CFLAGS  += -fno-asynchronous-unwind-tables
>>  KBUILD_AFLAGS  += $(lseinstr)
>>
>>  ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
>> --
>> 2.5.0
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
