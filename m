From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 19 Jun 2018 20:17:11 +0200
Subject: [RFC PATCH] ARM: Use logical or instead of addition for badr
 address calculation
In-Reply-To: <20180619172422.GB16846@roeck-us.net>
References: <1529384828-2452-1-git-send-email-linux@roeck-us.net>
 <CAKv+Gu8Byj7G3Awnq4Y90Wot=GJTx0gO5A7-960au9ZkBBL2=A@mail.gmail.com>
 <b8bff03d-91a7-0e53-a44e-d1924beb382d@roeck-us.net>
 <CAKv+Gu-T8Fx3Nry7pUdOoOeRU-Ns89w3oo4itmu1q4FzYF5Rag@mail.gmail.com>
 <20180619172422.GB16846@roeck-us.net>
Message-ID: <CAKv+Gu9JTsKEwwKN4OjmNHLf_86s753f2yEdo=7esERdUCaWiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 June 2018 at 19:24, Guenter Roeck <linux@roeck-us.net> wrote:
> On Tue, Jun 19, 2018 at 03:35:07PM +0200, Ard Biesheuvel wrote:
>> >>
>> >> +       /* this needs to be a separate macro or \@ does not work correctly
>> >> */
>> >> +       .macro  __badr, c, rd, sym
>> >> +       .eqv    .Lsym\@, \sym
>> >> +       adr\c   \rd, .Lsym\@ + 1
>> >
>> >
>> > Wild shot, but the following works for me.
>> >
>> >         .eqv    .Lsym\@, \sym + 1
>> >         adr\c   \rd, .Lsym\@
>> >
>> > Does it make sense ?
>> >
>>
>> Interesting. Do you mean this works with your 2.30 binutils that
>> triggers the original issue?
>>
>
> Yes, it does. It is also the solution used for some graphics libraries,
> though of course now I don't find the link anymore.
>
> Guess this is going nowhere given Russell's response, so I'll just
> live with it, like obviously everyone else does already. I built
> a toolchain using gcc 7.3.0 and binutils 2.28.1 which "solves"
> the problem for me.
>

If we can live with using a wide encoding unconditionally, we could
consider something like below. That forces the symbol references to be
resolved at link time, which means we completely sidestep the new GAS
code.

-----------8<----------------
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 16 Jan 2018 12:12:45 +0000
Subject: [PATCH] ARM: assembler: prevent ADR from setting the Thumb bit twice

To work around recent issues where ADR references to Thumb function
symbols may or may not have the Thumb bit set already when they are
resolved by GAS, reference the symbol indirectly via a global symbol
typed as 'function', and emit a relocation that lets the linker fix
up the reference.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 6ae42ad29518..1a55ce4b245c 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -195,13 +195,22 @@
        .irp    c,,eq,ne,cs,cc,mi,pl,vs,vc,hi,ls,ge,lt,gt,le,hs,lo
        .macro  badr\c, rd, sym
 #ifdef CONFIG_THUMB2_KERNEL
-       adr\c   \rd, \sym + 1
+       __badr  \c, \rd, \sym
 #else
        adr\c   \rd, \sym
 #endif
        .endm
        .endr

+       /* this needs to be a separate macro or \@ does not work correctly */
+       .macro          __badr, c, rd, sym
+       .globl          .Lsym_\sym\()_\@
+       .type           .Lsym_\sym\()_\@, %function
+       .set            .Lsym_\sym\()_\@, \sym
+       .reloc          ., R_ARM_THM_ALU_PREL_11_0, .Lsym_\sym\()_\@
+       adr\c\().w      \rd, .
+       .endm
+
 /*
  * Get current thread_info.
  */
