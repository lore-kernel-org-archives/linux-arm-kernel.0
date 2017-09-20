From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 Sep 2017 22:35:39 +0200
Subject: [PATCH] ARM: unaligned.h: Use an arch-specific version
In-Reply-To: <CAKv+Gu_ZMy-A-Du3ikVe47pcUR7hSBFHY+hQQ8APGGP1iRcigA@mail.gmail.com>
References: <20170920151802.7609-1-romain.izard.pro@gmail.com>
 <CAKv+Gu_ZMy-A-Du3ikVe47pcUR7hSBFHY+hQQ8APGGP1iRcigA@mail.gmail.com>
Message-ID: <CAK8P3a17y1zfhOPShjpbt+wf5B=ZyTb1jL1WiBHCz_rU4pNnnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 20, 2017 at 5:26 PM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 20 September 2017 at 08:18, Romain Izard <romain.izard.pro@gmail.com> wrote:
>> Add an arch-specific header to ARM, to retain other optimizations that
>> rely on HAVE_EFFICIENT_UNALIGNED_ACCESS, while making sure that access
>> that explicitly rely on the unaligned accessors are correctly handled by
>> the compiler.
>>
>> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
>> ---
>>
>
> If access_ok.h has been observed to produce different output from the
> struct versions (using any compiler), I guess we cannot simply change
> the asm-generic default and expect everybody to be ok with that. So I
> agree this is the most appropriate course of action.

But is that actually the case? I think patching ARM like this is
correct, but perhaps we can simply remove the access_ok.h
version entirely and just use the struct version everywhere.

Unfortunately it's been almost 10 years since the various
implementations got introduced, so it's hard to find out all
the concerns that went into it then.

Commit 064106a91be5 ("kernel: add common
infrastructure for unaligned access") lists

    Currently there are five implementations:
    1) packed_struct.h: C-struct based, from asm-generic/unaligned.h
    2) le_byteshift.h: Open coded byte-swapping, heavily based on asm-arm
    3) be_byteshift.h: Open coded byte-swapping, heavily based on asm-arm
    4) memmove.h: taken from multiple implementations in tree
    5) access_ok.h: taken from x86 and others, unaligned access is ok.

The only architectectures that use memmove.h are m32r (always has,
probably not intentionally) and openrisc. That one says that GCC on
OR32 "optimizes too aggressively" for struct.h, which is a bit scary
but wouldn't change anything here since they don't use the asm-generic
file.

The architectures that do use include/asm-generic/unaligned.h and
also set HAVE_EFFICIENT_UNALIGNED_ACCESS in some configurations
are arm, arm64, metag, s390 and arc.

This is a rather short list, and three of them (arm64, metag and arc) only
support very recent compilers, so we can probably just ask the respective
arch maintainers to ack the patch that changes the asm-generic file
for everyone.

        Arnd
