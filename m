From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 23 Nov 2017 14:26:09 +0000
Subject: Fwd: [PATCH] arm: ensure symbol is a thumb symbol in new binutils
In-Reply-To: <20171123140228.GP31757@n2100.armlinux.org.uk>
References: <20171121172751.29545-1-Jason@zx2c4.com>
 <20171121173857.GJ31757@n2100.armlinux.org.uk>
 <CAHmME9quDFbdOR9hKRz-Px=Mh3FvYEyhVrs4V_+JT+GjDajMrA@mail.gmail.com>
 <20171121174942.GK31757@n2100.armlinux.org.uk>
 <CAHmME9oMTNJFnOwfhu26QSRSP92Axbc-+v9cCPsTKxekZvGvxg@mail.gmail.com>
 <20171123103518.GL31757@n2100.armlinux.org.uk>
 <CAHmME9qBxgDV-HGeqj75ohr=4Bf+TD73PcC0DUqTRh5PTOKyhQ@mail.gmail.com>
 <20171123140228.GP31757@n2100.armlinux.org.uk>
Message-ID: <CAKv+Gu8TJi8qSWAkL231WhQkWxK+vSQm2tnQn_qN-2wdFaNaEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 November 2017 at 14:02, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Thu, Nov 23, 2017 at 11:47:56AM +0100, Jason A. Donenfeld wrote:
>> Hello Nick & Binutils developers,
>>
>> It would appear that recent changes in the binutils assembler (perhaps
>> 52a86f843b6dee1de9977293da9786649b146b05? perhaps not?) have broken
>> the kernel when compiled in thumb2 mode. We currently do not have a
>> way of working around your breaking changes without adding additional
>> runtime instructions, which isn't acceptable for us. Details are
>> included in the thread below.
>
> Hi Nick,
>
> I have to ask why it was thought a good idea to change the behaviour
> of the assembler's "adr" pseudo-instruction after it's had the existing
> behaviour for such a long time.
>

I think part of the confusion comes from the fact that ADR is no
longer a pseudo-instruction on Thumb2, and can be used to create
cross-section symbol references that are fixed up by the linker (using
a dedicated relocation type)

So before the change, we were in the situation where ADR behaved
differently when used on symbols, depending on whether they were
defined in the same section or not:
- cross section symbol references are fixed up by the linker, and do
take the Thumb bit into account for function symbols,
- local symbol references and label references are not fixed up at
all, regardless of their type annotation.

Note that external symbol references are hardly ever used, given that
they don't work in ARM mode (since it is a pseudo op there), so in the
kernel, we only care about local symbol references and label
references.

After the change, internal symbol references behave differently, but
label references behave the same. So the uniform behavior we care
about and rely on is no longer there, and even worse, we cannot deal
with this in the code because we cannot detect which binutils version
we are using without intrusive workarounds)

-- 
Ard.
