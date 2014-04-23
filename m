From: will.deacon@arm.com (Will Deacon)
Date: Wed, 23 Apr 2014 13:38:45 +0100
Subject: [PATCH] ARM64: disable DCACHE_WORD_ACCESS in big endian case
In-Reply-To: <CAA3XUr20eFyLshVM+7VBSMz4a4-cCA0PLrYGN5oyk-wOM2NLtg@mail.gmail.com>
References: <1398119770-27817-1-git-send-email-victor.kamensky@linaro.org>
 <20140422094659.GB6979@arm.com>
 <CAA3XUr20eFyLshVM+7VBSMz4a4-cCA0PLrYGN5oyk-wOM2NLtg@mail.gmail.com>
Message-ID: <20140423123845.GB5649@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 23, 2014 at 07:37:11AM +0100, Victor Kamensky wrote:
> Hi Will,

Hi Victor,

Thanks for investigating this!

> On 22 April 2014 02:46, Will Deacon <will.deacon@arm.com> wrote:
> > On Mon, Apr 21, 2014 at 11:36:10PM +0100, Victor Kamensky wrote:
> The issue turned out to be in another commit: "word-at-a-time:
> provide generic big-endian zero_bytemask implementation". Because
> of the issue in zero_bytemask function full_name_hash and
> hash_name were giving different hash results for the same path
> name (without slash). The issue is that (~0ul << 64) gives
> ~0ul not 0. I could not come up with more elegant solution other
> than use inline function that check shift value against type maximum
> width. Please take a look below.

Ah yes, we're in UNDEFINED territory here and AArch64 differs from AArch32
wrt LSL >= register width. Can you try the following instead of your patch
please? I think it should be more efficient.

Cheers,

Will

--->8

diff --git a/include/asm-generic/word-at-a-time.h b/include/asm-generic/word-at-a-time.h
index d3909effd725..243ce8c84ee9 100644
--- a/include/asm-generic/word-at-a-time.h
+++ b/include/asm-generic/word-at-a-time.h
@@ -50,11 +50,7 @@ static inline bool has_zero(unsigned long val, unsigned long *data, const struct
 }
 
 #ifndef zero_bytemask
-#ifdef CONFIG_64BIT
-#define zero_bytemask(mask)    (~0ul << fls64(mask))
-#else
-#define zero_bytemask(mask)    (~0ul << fls(mask))
-#endif /* CONFIG_64BIT */
+#define zero_bytemask(mask)    (mask ? ~0ul << __fls(mask) << 1 : ~0ul)
 #endif /* zero_bytemask */
 
 #endif /* _ASM_WORD_AT_A_TIME_H */
