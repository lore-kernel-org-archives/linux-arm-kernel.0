From: mka@chromium.org (Matthias Kaehlcke)
Date: Wed, 2 Aug 2017 16:44:31 -0700
Subject: [PATCH 2/2] arm64: Define PAGE_OFFSET using GENMASK_ULL
In-Reply-To: <CAKwvOdn3sBibVa=ai2ZPeBdHb=v=0qJ9+HYAFr-umhEzQtwY7w@mail.gmail.com>
References: <20170802225159.159536-1-mka@chromium.org>
 <20170802225159.159536-2-mka@chromium.org>
 <CAKwvOdmjTRJd+UB+0WU3umQZ3YYvOhh9tM3sN8HJLz6qpkaQQw@mail.gmail.com>
 <CAKwvOdn3sBibVa=ai2ZPeBdHb=v=0qJ9+HYAFr-umhEzQtwY7w@mail.gmail.com>
Message-ID: <20170802234431.GH84665@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

El Wed, Aug 02, 2017 at 04:19:11PM -0700 Nick Desaulniers ha dit:

> hmm, seems including the definition of GENMASK_ULL causes tons of issues
> see definition of UL() macro
> defines _AC
> token pastes UL on literal when not assembly
> so looks like GENMASK_ULL is not ready to be used from assembly

sorry, it seems I only did a partial build when testing this :/

> On Wed, Aug 2, 2017 at 4:13 PM, Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> > don't forget to include linux/bitops.h now in memory.h
> >
> > /usr/local/google/home/ndesaulniers/android/kernel-wahoo/private/msm-google/arch/arm64/kernel/head.S:47:8:
> > error:
> >       function-like macro 'GENMASK_ULL' is not defined
> > #elif (PAGE_OFFSET & 0x1fffff) != 0
> >        ^
> > /usr/local/google/home/ndesaulniers/android/kernel-wahoo/private/msm-google/arch/arm64/include/asm/memory.h:52:22:
> > note:
> >
> >       expanded from macro 'PAGE_OFFSET'
> > #define PAGE_OFFSET             GENMASK_ULL(BITS_PER_LONG_LONG - 1, VA_BITS - 1)
> >                                 ^
> > 1 error generated.
> >
> > On Wed, Aug 2, 2017 at 3:51 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> >> As is the definition causes an integer overflow, which is expected,
> >> however clang raises the following warning:
> >>
> >> arch/arm64/kernel/head.S:47:8: warning:
> >>       integer overflow in preprocessor expression
> >>   #elif (PAGE_OFFSET & 0x1fffff) != 0
> >>          ^~~~~~~~~~~
> >> arch/arm64/include/asm/memory.h:52:46: note:
> >>       expanded from macro 'PAGE_OFFSET'
> >>   #define PAGE_OFFSET             (UL(0xffffffffffffffff) << (VA_BITS - 1))
> >>                                       ~~~~~~~~~~~~~~~~~~  ^  ~~~~~~~~~~~~~
> >>
> >> Use GENMASK_ULL() instead of shifting explicitly, the macro takes care
> >> of avoiding the overflow.
> >>
> >> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> >> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> >> ---
> >>  arch/arm64/include/asm/memory.h | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> >> index 32f82723338a..732d4eed8edd 100644
> >> --- a/arch/arm64/include/asm/memory.h
> >> +++ b/arch/arm64/include/asm/memory.h
> >> @@ -65,7 +65,7 @@
> >>   */
> >>  #define VA_BITS                        (CONFIG_ARM64_VA_BITS)
> >>  #define VA_START               (UL(0xffffffffffffffff) << VA_BITS)
> >> -#define PAGE_OFFSET            (UL(0xffffffffffffffff) << (VA_BITS - 1))
> >> +#define PAGE_OFFSET            GENMASK_ULL(BITS_PER_LONG_LONG - 1, VA_BITS - 1)
> >>  #define KIMAGE_VADDR           (MODULES_END)
> >>  #define MODULES_END            (MODULES_VADDR + MODULES_VSIZE)
> >>  #define MODULES_VADDR          (VA_START + KASAN_SHADOW_SIZE)
> >>
> >
> >
> >
> 
> 
> 
