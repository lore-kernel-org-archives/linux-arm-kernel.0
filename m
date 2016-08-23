From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 23 Aug 2016 13:30:46 +0200
Subject: [PATCH v3 0/4] ARM: kernel: module PLT optimizations
In-Reply-To: <24dd6017-97ad-0051-9a4f-8a76e50076d9@lge.com>
References: <1471514563-28172-1-git-send-email-ard.biesheuvel@linaro.org>
 <24dd6017-97ad-0051-9a4f-8a76e50076d9@lge.com>
Message-ID: <CAKv+Gu-hvgs-73ErCmkj58u5gu18V7JGZLpg400trCyGgNJW1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 August 2016 at 08:06, Jongsung Kim <neidhard.kim@lge.com> wrote:
> Hi Ard,
>
> I did some rough performance tests for your patchset with my large ko.
>

Thanks! Could you please confirm that the module still works as expected?

> On 2016? 08? 18? 19:02, Ard Biesheuvel wrote:
>> As reported by Jongsung, the O(n^2) search in the PLT allocation code may > disproportionately affect module load time for modules with a larger number > of relocations. > > Since the existing routines rather naively take branch instructions into > account that are internal to the module, we can improve the situation > significantly by checking the symbol section index first, and disregarding > symbols that are defined in the same module. Also, we can reduce the > algorithmic complexity to O(n log n) by sorting the reloc section before > processing it, and disregarding zero-addend relocations in the optimization. > > Patch #1 merge the core and init PLTs, since the latter is virtually empty > anyway. >
>
> Patch #1 didn't make noticable difference in performance. Found 4,860 PLTs
> from 262,573 RELs in ~10secs.
>

OK, that is expected. This is not a performance optimization but a
[minor] size optimization (and a simplification).

>> Patch #2 implements the optimization to only take SHN_UNDEF symbols into > account. >
>
> After patch #2 applied, found 249 PLTs from 262,573 RELs in ~680msecs.
>

Nice

>> Patch #3 sort the reloc section, so that the duplicate check can be done by > comparing an entry with the previous one. Since REL entries (as opposed to > RELA entries) do not contain the addend, simply disregard non-zero addends > in the optimization since those are rare anyway. >
>
> After patch #3 applied, found 249 PLTs from 262,573 RELs in ~6msecs.
>

Even better!

>> Patch #4 replaces the brute force search for a matching existing entry in > the PLT generation routine with a simple check against the last entry that > was emitted. This is now sufficient since the relocation section is sorted, > and presented at relocation time in the same order. >
>
> Finally with patch #4 applied, found 249 PLTs from 262,573 RELs in < 6msecs.
>

This is also expected, given that you only measured the time spent in
count_plts(). Patch #4 optimizes get_module_plt(), which is called
when the relocations are actually processed. I don't expect a huge
speedup, but it should be an improvement nonetheless.

>> Note that this implementation is now mostly aligned with the arm64 version > (with the exception that the arm64 implementation stashes the address of the > PLT entry in the symtab instead of comparing the last emitted entry) >
>
> Time measured around calling count_plts() with preemption disabled. My O(n)
> implementation over patch #1 and #2 took over 10msecs to handle the same ko.
> I'd better to use your patchset. :-)
>
> Thank you for your works!
>

Likewise! May I take this as a 'Tested-by: ' ?

Regards,
Ard.
