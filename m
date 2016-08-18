From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 18 Aug 2016 12:04:24 +0200
Subject: [PATCH v3 0/4] ARM: kernel: module PLT optimizations
In-Reply-To: <1471514563-28172-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1471514563-28172-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <CAKv+Gu-+VW4G0=gKJagJEbbhXKwxxoOM5UE1vro4GS8cjS2iyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 August 2016 at 12:02, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> As reported by Jongsung, the O(n^2) search in the PLT allocation code may
> disproportionately affect module load time for modules with a larger number
> of relocations.
>
> Since the existing routines rather naively take branch instructions into
> account that are internal to the module, we can improve the situation
> significantly by checking the symbol section index first, and disregarding
> symbols that are defined in the same module. Also, we can reduce the
> algorithmic complexity to O(n log n) by sorting the reloc section before
> processing it, and disregarding zero-addend relocations in the optimization.
>
> Patch #1 merge the core and init PLTs, since the latter is virtually empty
> anyway.
>
> Patch #2 implements the optimization to only take SHN_UNDEF symbols into
> account.
>
> Patch #3 sort the reloc section, so that the duplicate check can be done by
> comparing an entry with the previous one. Since REL entries (as opposed to
> RELA entries) do not contain the addend, simply disregard non-zero addends
> in the optimization since those are rare anyway.
>
> Patch #4 replaces the brute force search for a matching existing entry in
> the PLT generation routine with a simple check against the last entry that
> was emitted. This is now sufficient since the relocation section is sorted,
> and presented at relocation time in the same order.
>
> Note that this implementation is now mostly aligned with the arm64 version
> (with the exception that the arm64 implementation stashes the address of the
> PLT entry in the symtab instead of comparing the last emitted entry)
>
> v3:
> - move the SHN_UNDEF check into the switch statement, so that we only
>   dereference the symbol for relocations we care about (#2)
> - compare the undecoded addend values bitwise when checking for zero addends,
>   rather than fully decoding the offsets and doing an arithmetic comparison
>   against '-8' (or '-4' for Thumb)
> - added patch #4
>
> v2:
> - added patch #3
>
> Ard Biesheuvel (4):
>   ARM: kernel: merge core and init PLTs
>   ARM: kernel: allocate PLT entries only for external symbols
>   ARM: kernel: sort relocation sections before allocating PLTs
>   arm64: kernel: avoid brute force search on PLT generation
>

^^^ $SUBJECT fail: this should be ARM, of course

-- 
Ard.
