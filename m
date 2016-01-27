From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 27 Jan 2016 20:39:23 +0100
Subject: [PATCH v2 resend 6/6] arm64: switch to relative exception tables
In-Reply-To: <20160127113548.d4f2f2a7029b3b89f0e596da@linux-foundation.org>
References: <1453892123-17973-1-git-send-email-ard.biesheuvel@linaro.org>
 <1453892123-17973-7-git-send-email-ard.biesheuvel@linaro.org>
 <20160127113548.d4f2f2a7029b3b89f0e596da@linux-foundation.org>
Message-ID: <CAKv+Gu8hvxcc6Tiu0q7=HWqkEf4ZLfOvyoLGkp2mEgjz_1R9ew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 January 2016 at 20:35, Andrew Morton <akpm@linux-foundation.org> wrote:
> On Wed, 27 Jan 2016 11:55:23 +0100 Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
>> Instead of using absolute addresses for both the exception location
>> and the fixup, use offsets relative to the exception table entry values.
>> Not only does this cut the size of the exception table in half, it is
>> also a prerequisite for KASLR, since absolute exception table entries
>> are subject to dynamic relocation, which is incompatible with the sorting
>> of the exception table that occurs at build time.
>>
>> This patch also introduces the _ASM_EXTABLE preprocessor macro (which
>> exists on x86 as well) and its _asm_extable assembly counterpart, as
>> shorthands to emit exception table entries.
>
> checkpatch speaketh truth:
>
> ERROR: #define of 'ARCH_HAS_RELATIVE_EXTABLE' is wrong - use Kconfig variables or standard guards instead
> #113: FILE: arch/arm64/include/asm/uaccess.h:56:

That may be true, but it extends an established pattern of #defines in
the various uaccess.h versions, i.e., ARCH_HAS_SORT_EXTABLE, and
ARCH_HAS_SEARCH_EXTABLE
