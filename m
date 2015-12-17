From: pinskia@gmail.com (Andrew Pinski)
Date: Thu, 17 Dec 2015 12:14:20 -0800
Subject: [PATCH v6 12/20] arm64:ilp32: add sys_ilp32.c and a separate
 table (in entry.S) to use it
In-Reply-To: <2105480.kqDuemge8n@wuerfel>
References: <1450215766-14765-1-git-send-email-ynorov@caviumnetworks.com>
 <1450215766-14765-13-git-send-email-ynorov@caviumnetworks.com>
 <20151217182753.GF25232@e104818-lin.cambridge.arm.com>
 <2105480.kqDuemge8n@wuerfel>
Message-ID: <CA+=Sn1ktUCa_8MzMvZtQhE+fUNY5-V9JXTLXKDDe8a0iENgd=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 17, 2015 at 12:10 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 17 December 2015 18:27:53 Catalin Marinas wrote:
>> On Wed, Dec 16, 2015 at 12:42:38AM +0300, Yury Norov wrote:
>
>> > +#define compat_sys_lookup_dcookie      sys_lookup_dcookie
>> > +#define compat_sys_pread64             sys_pread64
>> > +#define compat_sys_pwrite64            sys_pwrite64
>> > +#define compat_sys_readahead           sys_readahead
>> > +#define compat_sys_shmat               sys_shmat
>>
>> I wonder whether we need wrappers (actually, not only for these but
>> sys_read etc.). These functions take either a pointer or a size_t
>> argument which are 32-bit with ILP32 but treated as 64-bit by an LP64
>> kernel. Can we guarantee that user space zeros the top 32-bit of the
>> arguments passed here?
>
> I'm pretty sure that is safe. I haven't read the calling conventions
> specification for arm64 ilp32, but usually all function arguments are
> passed as 64-bit registers with proper sign-extend or zero-extend.

Well (just like LP64 on AARCH64), when passing a 32bit value to a
function, the upper 32bits are undefined.  I ran into this when I was
debugging the GCC go library on ILP32 (though reproduced with pure C
code) and the assembly functions inside glibc where pointers are
passed with the upper 32bits as undefined.
So we have an issue if called with syscall function or using pure
assembly to create the syscall functions (which glibc does).

Thanks,
Andrew

>
> Most other syscalls rely on this behavior too, not just the ones that
> are being modified here.
>
>> With compat/AArch32, this is guaranteed by the kernel since EL0 won't be
>> able to touch the top part but here I'm not entirely sure. As long as
>> user space used Wn registers for 32-bit types, we are probably fine (the
>> architecture guarantees the top 32-bit zeroing following a MOV, LDR etc.
>> instruction into a Wn register). We just need to mention this in the ABI
>> document (ilp32.txt).
>
> I think the aarch32 case is actually the hard one, because it has to
> worry about explicitly sign-extending 32-bit arguments (signed int or
> signed long) that might be negative, e.g. user space passes -1
> as 0xffffffff, which the kernel entry turns into 0x00000000ffffffff
> when it should use 0xffffffffffffffff. The COMPAT_SYSCALL_DEFINEx
> macros take care of this.
>
>> > +
>> > +#define compat_sys_open_by_handle_at   sys_open_by_handle_at
>> > +#define compat_sys_openat              sys_openat
>>
>> So using sys_openat() forces O_LARGEFILE and we don't have a problem
>> with (f)truncate. We may have an issue with AArch32 compat though.
>
> aarch32 uses the correct compat functions in asm/unistd32.h
>
>         Arnd
