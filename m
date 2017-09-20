From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 20 Sep 2017 09:28:23 -0700
Subject: [PATCH] ARM: unaligned.h: Use an arch-specific version
In-Reply-To: <20170920154143.GO20805@n2100.armlinux.org.uk>
References: <20170920151802.7609-1-romain.izard.pro@gmail.com>
 <CAKv+Gu_ZMy-A-Du3ikVe47pcUR7hSBFHY+hQQ8APGGP1iRcigA@mail.gmail.com>
 <20170920154143.GO20805@n2100.armlinux.org.uk>
Message-ID: <CAKv+Gu8q1bqe6hHpK98eskF5qmtLu6+Hqw6S7i6qgZy3OjErXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 September 2017 at 08:41, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Wed, Sep 20, 2017 at 08:26:09AM -0700, Ard Biesheuvel wrote:
>> Hi Romain,
>>
>> On 20 September 2017 at 08:18, Romain Izard <romain.izard.pro@gmail.com> wrote:
>> > For the 32-bit ARM architecture, unaligned access support is variable.
>> > On a chip without a MMU, an unaligned access returns a rotated data word
>> > and must be avoided.
>> >
>> > When a MMU is available, it can be trapped. On ARMv6 or ARMv7, it can also
>> > be handled by the hardware, depending on the type of access instruction.
>> > Unaligned access of 32 bits or less are corrected, while larger access
>> > provoke a trap.
>> >
>> > Unfortunately, the compiler is able to merge two 32-bit access that
>> > would generate a LDR instruction, that works on unaligned access, into a
>> > single LDM access that will not work. This is not a common situation,
>> > but it has been observed in the LZ4 decompression code.
>> >
>> > To prevent this type of optimization, it is necessary to change the
>> > explicit accessors for unaligned addresses from those defined in the
>> > access_ok.h header, to those defined in the packed_struct.h header.
>> >
>> > Add an arch-specific header to ARM, to retain other optimizations that
>> > rely on HAVE_EFFICIENT_UNALIGNED_ACCESS, while making sure that access
>> > that explicitly rely on the unaligned accessors are correctly handled by
>> > the compiler.
>> >
>> > Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
>> > ---
>> >
>>
>> If access_ok.h has been observed to produce different output from the
>> struct versions (using any compiler), I guess we cannot simply change
>> the asm-generic default and expect everybody to be ok with that. So I
>> agree this is the most appropriate course of action.
>
> However, what effect does this have on the code generated for the rest
> of the kernel?
>

On v6/v7, we may currently rely on alignment fixups for unaligned
ldm/stm instructions in the core kernel, and so avoiding those sounds
like an improvement to me. The 'struct' unaligned accessor type looks
like the sweet spot for ARM, since it will prevent the compiler from
using ldm/stm/ldrd/etc on quantities that may be unaligned, but does
not fall back to byte accesses on CPUs that can perform unaligned
accesses in hardware when using ldr/str.

I guess you may be concerned about performance regressions for
scenarios where the alignment fixup is only rarely triggered? Do you
have anything specific in mind?
