From: keescook@chromium.org (Kees Cook)
Date: Tue, 15 Aug 2017 12:02:34 -0700
Subject: [PATCH] mm: Revert x86_64 and arm64 ELF_ET_DYN_BASE base
In-Reply-To: <CAGXu5jJPrgG9e6pRx_Yc9Y_X7hE8GC5JTbi2QaprfUt16xKaGA@mail.gmail.com>
References: <20170807201542.GA21271@beast> <20170808093450.GA13355@arm.com>
 <CAGXu5jJPrgG9e6pRx_Yc9Y_X7hE8GC5JTbi2QaprfUt16xKaGA@mail.gmail.com>
Message-ID: <CAGXu5jLuBNUeaT4mR7yHCsgX+C=P2+iE0OHeodWaxXyGGtQsyg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ping to akpm to please pick this up for -mm...

On Tue, Aug 8, 2017 at 7:00 PM, Kees Cook <keescook@chromium.org> wrote:
> On Tue, Aug 8, 2017 at 2:34 AM, Will Deacon <will.deacon@arm.com> wrote:
>> On Mon, Aug 07, 2017 at 01:15:42PM -0700, Kees Cook wrote:
>>> Moving the x86_64 and arm64 PIE base from 0x555555554000 to 0x000100000000
>>> broke AddressSanitizer. This is a partial revert of:
>>>
>>>   commit eab09532d400 ("binfmt_elf: use ELF_ET_DYN_BASE only for PIE")
>>>   commit 02445990a96e ("arm64: move ELF_ET_DYN_BASE to 4GB / 4MB")
>>>
>>> The AddressSanitizer tool has hard-coded expectations about where
>>> executable mappings are loaded. The motivation for changing the PIE
>>> base in the above commits was to avoid the Stack-Clash CVEs that
>>> allowed executable mappings to get too close to heap and stack. This
>>> was mainly a problem on 32-bit, but the 64-bit bases were moved too,
>>> in an effort to proactively protect those systems (proofs of concept
>>> do exist that show 64-bit collisions, but other recent changes to fix
>>> stack accounting and setuid behaviors will minimize the impact).
>>>
>>> The new 32-bit PIE base is fine for ASan (since it matches the ET_EXEC
>>> base), so only the 64-bit PIE base needs to be reverted to let x86 and
>>> arm64 ASan binaries run again. Future changes to the 64-bit PIE base on
>>> these architectures can be made optional once a more dynamic method for
>>> dealing with AddressSanitizer is found. (e.g. always loading PIE into
>>> the mmap region for marked binaries.)
>>>
>>> Reported-by: Kostya Serebryany <kcc@google.com>
>>> Cc: stable at vger.kernel.org
>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>> ---
>>>  arch/arm64/include/asm/elf.h | 4 ++--
>>>  arch/x86/include/asm/elf.h   | 4 ++--
>>>  2 files changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
>>> index acae781f7359..3288c2b36731 100644
>>> --- a/arch/arm64/include/asm/elf.h
>>> +++ b/arch/arm64/include/asm/elf.h
>>> @@ -114,10 +114,10 @@
>>>
>>>  /*
>>>   * This is the base location for PIE (ET_DYN with INTERP) loads. On
>>> - * 64-bit, this is raised to 4GB to leave the entire 32-bit address
>>> + * 64-bit, this is above 4GB to leave the entire 32-bit address
>>>   * space open for things that want to use the area for 32-bit pointers.
>>>   */
>>> -#define ELF_ET_DYN_BASE              0x100000000UL
>>> +#define ELF_ET_DYN_BASE              (2 * TASK_SIZE_64 / 3)
>>>
>>>  #ifndef __ASSEMBLY__
>>
>> Acked-by: Will Deacon <will.deacon@arm.com>
>>
>> I assume this is going via akpm like the original commit?
>
> That's my expectation, yup. Thanks for the Ack!
>
> -Kees
>
> --
> Kees Cook
> Pixel Security



-- 
Kees Cook
Pixel Security
