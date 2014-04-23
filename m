From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Tue, 22 Apr 2014 23:37:11 -0700
Subject: [PATCH] ARM64: disable DCACHE_WORD_ACCESS in big endian case
In-Reply-To: <20140422094659.GB6979@arm.com>
References: <1398119770-27817-1-git-send-email-victor.kamensky@linaro.org>
 <20140422094659.GB6979@arm.com>
Message-ID: <CAA3XUr20eFyLshVM+7VBSMz4a4-cCA0PLrYGN5oyk-wOM2NLtg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 22 April 2014 02:46, Will Deacon <will.deacon@arm.com> wrote:
> On Mon, Apr 21, 2014 at 11:36:10PM +0100, Victor Kamensky wrote:
>> If DCACHE_WORD_ACCESS is enabled big endian image failed to
>> boot. commit 7bc13fd33adb9536bd73965cd46bbf7377df097c
>> "arm64: dcache: select DCACHE_WORD_ACCESS for little-endian CPUs"
>> enabled this setting for both big endian and little endian
>> cpus. And code in commit itself seems to be endian agnostic,
>> however other, i.e C, code that sits under DCACHE_WORD_ACCESS
>> seems to be not endian agnostic, I could not figure out where
>> though.
>>
>> Solution is to enable DCACHE_WORD_ACCESS only if little
>> endian mode is enabled (default).
>>
>> Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
>
> NAK, this really should work for big-endian machines. If it doesn't, we
> should figure out why and fix the problem.

Fair enough. Thanks for encouragement :)

> As a start, can you share further details of the failure please?

Failure was that kernel could not find init in case of initramfs image or
could not do nfs mount in nfs boot case ..

The issue turned out to be in another commit: "word-at-a-time:
provide generic big-endian zero_bytemask implementation". Because
of the issue in zero_bytemask function full_name_hash and
hash_name were giving different hash results for the same path
name (without slash). The issue is that (~0ul << 64) gives
~0ul not 0. I could not come up with more elegant solution other
than use inline function that check shift value against type maximum
width. Please take a look below.

The patch below is not correctly formatted because of my gmail
client line wrapping issue, and others. I will resend it with
git send-mail later. For now could you please take a look and
maybe suggest something more nicer other than inline function
and explicit check.

Also, if you can, could you please advise on what mailing list
should I post it and who is appropriate maintainer. I could use
get_maintainer.pl but would appreciate expert advice.

With below patch aarch64 big-endian image with
DCACHE_WORD_ACCESS enabled boots OK.

>From 47293e5e020ee8ad6233474a1eb13a149378de9d Mon Sep 17 00:00:00 2001
From: Victor Kamensky <victor.kamensky@linaro.org>
Date: Tue, 22 Apr 2014 21:05:07 -0700
Subject: [PATCH] word-at-a-time: fix generic big-endian zero_bytemask in max
 width case

Commit 11ec50caedb56e3a87715edeff6a1852e6ae5416 "word-at-a-time:
provide generic big-endian zero_bytemask implementation" added
generic zero_bytemask implementation for big-endian system. But it
gives incorrect result in case where fls gives shift value that
equals to the width of unsigned long.

As per C standard left shifting for the full width of type is
undefined: "If the value of the right operand is negative or is
greater than or equal to the width of the promoted left operand, the
behavior is undefined."

For example in arrach64 big-endian (~0ul << 64) will produce
~0ul. As result aarch64 big-endian is broken when
CONFIG_DCACHE_WORD_ACCESS is defined and zero_bytemask
is used.

Solution to check shift size and if it is equal to width of
unsigned long return 0.

Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
---
 include/asm-generic/word-at-a-time.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/word-at-a-time.h
b/include/asm-generic/word-at-a-time.h
index d3909ef..6c80ead 100644
--- a/include/asm-generic/word-at-a-time.h
+++ b/include/asm-generic/word-at-a-time.h
@@ -50,10 +50,20 @@ static inline bool has_zero(unsigned long val,
unsigned long *data, const struct
 }

 #ifndef zero_bytemask
+static inline unsigned long __zero_bytemask(unsigned long shift)
+{
+    unsigned long ret;
+    if (shift != BITS_PER_LONG)
+        ret = (~0ul << shift);
+    else
+        ret = 0;
+    return ret;
+}
+
 #ifdef CONFIG_64BIT
-#define zero_bytemask(mask)    (~0ul << fls64(mask))
+#define zero_bytemask(mask)    (__zero_bytemask(fls64(mask)))
 #else
-#define zero_bytemask(mask)    (~0ul << fls(mask))
+#define zero_bytemask(mask)    (__zero_bytemask(fls(mask)))
 #endif /* CONFIG_64BIT */
 #endif /* zero_bytemask */

-- 
1.8.1.4

Thanks,
Victor

> Will
>
>> ---
>>  arch/arm64/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index e6e4d37..106ac4f 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -13,7 +13,7 @@ config ARM64
>>       select CLONE_BACKWARDS
>>       select COMMON_CLK
>>       select CPU_PM if (SUSPEND || CPU_IDLE)
>> -     select DCACHE_WORD_ACCESS
>> +     select DCACHE_WORD_ACCESS if !CPU_BIG_ENDIAN
>>       select GENERIC_CLOCKEVENTS
>>       select GENERIC_CLOCKEVENTS_BROADCAST if SMP
>>       select GENERIC_CPU_AUTOPROBE
>> --
>> 1.8.1.4
>>
>>
