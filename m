From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 16 Nov 2017 22:25:46 +0000
Subject: [PATCH v2 08/18] arm64: don't disable ADR_PREL_PG_HI21* with
 ARM64_ERRATUM_843419
In-Reply-To: <CAKv+Gu_3R4SUC2hCUtEX_4ut9admtrBZS-S-mzQnQsoJoHPcBw@mail.gmail.com>
References: <20171115213428.22559-1-samitolvanen@google.com>
 <20171115213428.22559-9-samitolvanen@google.com>
 <CAKv+Gu-wYwBMV7tdb+Kax_cyPsmAB2R2ZVwJuNi9qM0kaYAs=Q@mail.gmail.com>
 <20171116114406.GB9361@arm.com>
 <20171116163132.GC94341@samitolvanen.mtv.corp.google.com>
 <CAKv+Gu8yPSwZep-S_ke_P5BiZ3o72R=ykhixoXcyGUHa1ZxGGw@mail.gmail.com>
 <20171116213702.GA10616@samitolvanen.mtv.corp.google.com>
 <CAKv+Gu_3R4SUC2hCUtEX_4ut9admtrBZS-S-mzQnQsoJoHPcBw@mail.gmail.com>
Message-ID: <CAKv+Gu8uWq+T2AJQvBqwb-hMeZgFJQUQozsr4Ufwwp2hheRXcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 November 2017 at 22:14, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 16 November 2017 at 21:37, Sami Tolvanen <samitolvanen@google.com> wrote:
>> On Thu, Nov 16, 2017 at 04:34:03PM +0000, Ard Biesheuvel wrote:
>>> You still have not explained to us how GOLD avoids the erratum.
>>
>> Sorry, I didn't realize you were asking that. If gold spots erratum
>> sequences, looks like it creates stubs to break them up:
>>
>>   https://sourceware.org/git/?p=binutils-gdb.git;a=blob;f=gold/aarch64.cc#l8396
>>
>> It also attempts to optimize the code by replacing adrps in these
>> sequences with adr where possible, but otherwise doesn't appear to
>> touch them:
>>
>>   https://sourceware.org/git/?p=binutils-gdb.git;a=blob;f=gold/aarch64.cc#l2053
>>
>
> OK, so my concern here is that this code probably only operates on
> fully linked binaries, and not partially linked object files like
> kernel modules. The same applies to ld.bfd, which is why we need to
> use the large module

*model* not module

> instead of a code model that may emit adrp
> instructions..
>
> What is preventing us from using the large model with clang? I know it
> uses movk/movz pairs rather than literals, but this shouldn't matter
> for modules, given that we support static ELF relocations.
