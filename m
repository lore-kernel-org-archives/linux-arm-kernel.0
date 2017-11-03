From: ndesaulniers@google.com (Nick Desaulniers)
Date: Fri, 3 Nov 2017 11:15:55 -0700
Subject: [PATCH 13/15] arm64: fix mrs_s/msr_s macros for clang LTO
In-Reply-To: <20171103180620.47yrko7apk52imri@lakrids.cambridge.arm.com>
References: <20171103171203.107569-1-samitolvanen@google.com>
 <20171103171203.107569-18-samitolvanen@google.com>
 <CAKwvOd=mG-X1DpUk+6hNXkoE-5hLGHe654ZKGEv=Dx1mnVJt5w@mail.gmail.com>
 <20171103180620.47yrko7apk52imri@lakrids.cambridge.arm.com>
Message-ID: <CAKwvOd=zNQqyta42hm86rXquCd67OoO=azT7NWMF94=6xVS_4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 3, 2017 at 11:06 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Fri, Nov 03, 2017 at 10:53:08AM -0700, Nick Desaulniers wrote:
>> These mrs_s and msr_s macros in particular were preventing us from
>> linking arm64 with Clang's integrated assembler, regardless of LTO.
>> Those macros ran into: https://bugs.llvm.org/show_bug.cgi?id=19749.
>> So while I appreciate how clever they are, they prevent us from
>> assembling with Clang so I would like to see them go.
>
> They're necessary to work with some currently-supported toolchains
> (which don't support the s*_*_c*_c*_* syntax), so they're not going to
> go completely.
>
> If you could suggest something that clang might prefer, which doesn't
> adversely affect GCC, I'm all ears.

I wasn't clear in my point; I recognize what they do and agree that
they are needed.

More specifically, my problem is the use of .macro assembly
directives, since Clang "considers it a feature" not to let you invoke
a .macro defined in one inline asm block from another asm inline
block.

So I would like to see *the use of .macro in separate inline asm
blocks within mrs_s and msr_s c-preprocessor macros go.*
