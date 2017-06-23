From: keescook@chromium.org (Kees Cook)
Date: Fri, 23 Jun 2017 06:52:24 -0700
Subject: [kernel-hardening] [PATCH 2/4] arm64: Reduce ELF_ET_DYN_BASE
In-Reply-To: <CAKv+Gu_2Wg_D+4c3-iqMr9hbKkGVdBtW6Bmxj-4=FOG9hVN5vA@mail.gmail.com>
References: <1498154792-49952-1-git-send-email-keescook@chromium.org>
 <1498154792-49952-3-git-send-email-keescook@chromium.org>
 <CAKv+Gu_2Wg_D+4c3-iqMr9hbKkGVdBtW6Bmxj-4=FOG9hVN5vA@mail.gmail.com>
Message-ID: <CAGXu5jLHOjg9+8xDSzs2nLKjoqUf3NAc_0a1Coo+4WnDYRT3=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 22, 2017 at 11:57 PM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> Hi Kees,
>
> On 22 June 2017 at 18:06, Kees Cook <keescook@chromium.org> wrote:
>> Now that explicitly executed loaders are loaded in the mmap region,
>> position PIE binaries lower in the address space to avoid possible
>> collisions with mmap or stack regions. For 64-bit, align to 4GB to
>> allow runtimes to use the entire 32-bit address space for 32-bit
>> pointers.
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  arch/arm64/include/asm/elf.h | 13 ++++++-------
>>  1 file changed, 6 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
>> index 5d1700425efe..f742af8f7c42 100644
>> --- a/arch/arm64/include/asm/elf.h
>> +++ b/arch/arm64/include/asm/elf.h
>> @@ -113,12 +113,13 @@
>>  #define ELF_EXEC_PAGESIZE      PAGE_SIZE
>>
>>  /*
>> - * This is the location that an ET_DYN program is loaded if exec'ed.  Typical
>> - * use of this is to invoke "./ld.so someprog" to test out a new version of
>> - * the loader.  We need to make sure that it is out of the way of the program
>> - * that it will "exec", and that there is sufficient room for the brk.
>> + * This is the base location for PIE (ET_DYN with INTERP) loads. On
>> + * 64-bit, this is raised to 4GB to leave the entire 32-bit address
>> + * space open for things that want to use the area for 32-bit pointers.
>>   */
>> -#define ELF_ET_DYN_BASE        (2 * TASK_SIZE_64 / 3)
>> +#define ELF_ET_DYN_BASE                (test_thread_flag(TIF_32BIT) ?  \
>> +                                       0x000400000UL :         \
>> +                                       0x100000000UL)
>>
>
> Why are you merging this with the COMPAT definition?

It seemed like the right thing to do since a single definition could
handle both cases. Is there something I'm overlooking in the arm64
case?

-Kees

>
>>  #ifndef __ASSEMBLY__
>>
>> @@ -173,8 +174,6 @@ extern int arch_setup_additional_pages(struct linux_binprm *bprm,
>>
>>  #ifdef CONFIG_COMPAT
>>
>> -#define COMPAT_ELF_ET_DYN_BASE         (2 * TASK_SIZE_32 / 3)
>> -
>>  /* AArch32 registers. */
>>  #define COMPAT_ELF_NGREG               18
>>  typedef unsigned int                   compat_elf_greg_t;
>> --
>> 2.7.4
>>



-- 
Kees Cook
Pixel Security
