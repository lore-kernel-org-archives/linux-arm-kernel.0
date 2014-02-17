From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 17 Feb 2014 19:17:12 +0100
Subject: [PATCH] arm64: add workaround for ambiguous C99 stdint.h types
In-Reply-To: <20140217180237.GC8361@arm.com>
References: <1390768248-1688-1-git-send-email-ard.biesheuvel@linaro.org>
 <20140217122334.GA19102@arm.com>
 <CAKv+Gu_=kgP1LS-HN6n+QfHMyi142aNpGR0roqRo2tinYXdxPw@mail.gmail.com>
 <20140217174247.GA8361@arm.com>
 <CAKv+Gu-RmZ4h=6+h_Fn+NQbDN81FNZHhnVd7Nfspx_LynJ1w6Q@mail.gmail.com>
 <20140217180237.GC8361@arm.com>
Message-ID: <CAKv+Gu-rV5mvfegjqGUb+nET8FLsB2Xx0DdXjnNU0BCUUOYBTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 February 2014 19:02, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Mon, Feb 17, 2014 at 05:57:22PM +0000, Ard Biesheuvel wrote:
>> On 17 February 2014 18:42, Catalin Marinas <catalin.marinas@arm.com> wrote:
>> > On Mon, Feb 17, 2014 at 12:40:18PM +0000, Ard Biesheuvel wrote:
>> >> On 17 February 2014 13:23, Catalin Marinas <catalin.marinas@arm.com> wrote:
>> >> > On Sun, Jan 26, 2014 at 08:30:48PM +0000, Ard Biesheuvel wrote:
>> >> >> In a way similar to ARM commit 09096f6a0ee2 ("ARM: 7822/1: add workaround
>> >> >> for ambiguous C99 stdint.h types"), this patch redefines the macros that
>> >> >> are used in stdint.h so its definitions of uint64_t and int64_t are
>> >> >> compatible with those of the kernel.
>> >> >>
>> >> >> In order to do so, drop types.h from generic-y and create a specific arm64
>> >> >> version identical to the generic one with just the #define overrides added.
>> >> >
>> >> > I tried but still can't get what this patch is about. Do the
>> >> > linux/types.h types ever get to user space? We have uapi/linux/types.h
>> >> > for this.
>> >> >
>> >> > Can you give an example of where this is needed? Which source file
>> >> > includes both stdint.h and linux/types.h (non-uapi version)?
>> >>
>> >> It's not about user space, it is mainly about the use of NEON
>> >> instrinsics in the kernel.
>> >>
>> >> If you do the following:
>> >>
>> >> #Include <linux/types.h>
>> >> #include <arm_neon.h>
>> >
>> > For other intrinsics that we use like __builtin_ctzl(), do we need to
>> > explicitly include gcc headers? I don't think we do and I really don't
>> > like such arm_neon.h include which brings in other user headers. Don't
>> > we have any work around this?
>>
>> Well, I talked to the toolchain guys at the time and they really
>> disliked the idea of coding directly against the __builtins because
>> they are not considered a stable interface, especially because the
>> interface that /is/ considered stable (arm_neon.h) is supported both
>> on ARM and on arm64.
>
> Than we don't use the Neon __builtins in the kernel.
>
>> > My inbox only has some discussion in May last year on the linaro-kernel
>> > list without any clear conclusion (it could be that I deleted other
>> > emails).
>>
>> There was some discussion, indeed, but for ARM, with the conclusion
>> being the fix I mentioned in the patch: 09096f6a0ee2 ("ARM: 7822/1:
>> add workaround
>> for ambiguous C99 stdint.h types"), only in that case, the ambiguity
>> is (unsurprisingly) about the 32 bit types, not the 64 bit ones.
>
> My worry is that some future toolchain may include something else in
> this file and get other type conflicts. It really looks fragile.
>

Well, the GCC folks are quite careful not to depend on arbitrary user
headers when the -ffreestanding option is set. Also, the real problem
is the fact that Linux defines C99 types, but does so in an
incompatible way. (I.e., one could also argue that the Linux typedefs
should be based on GCC's builtin #defines of __INT64_TYPE,
__UINT64_TYPE, etc if defined). So the chances of something similar
reappearing all of a sudden are quite slim imo.

Regards,
Ard.
