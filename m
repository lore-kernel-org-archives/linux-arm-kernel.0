From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 5 May 2017 21:16:14 +0100
Subject: [GIT PULL] arm64 updates for 4.12
In-Reply-To: <CA+55aFxFoV_BUbQ=fUAWd2WxGRPe3K_eb7yfZYrh7oa6UOgOCA@mail.gmail.com>
References: <20170505161345.GA23336@e104818-lin.cambridge.arm.com>
 <CA+55aFxFoV_BUbQ=fUAWd2WxGRPe3K_eb7yfZYrh7oa6UOgOCA@mail.gmail.com>
Message-ID: <20170505201613.GA26309@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 05, 2017 at 12:38:32PM -0700, Linus Torvalds wrote:
> On Fri, May 5, 2017 at 9:13 AM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > diff --cc arch/arm64/include/asm/bug.h
> 
> Hmm. The trivial resolution I did gets a different diff as the end
> result, but your diff looks different.
> 
> I think you used "-U2" to make for a smaller and more targeted context..
> 
> So I think the trivial resolution is what you meant. But I couldn't
> test it, so I thought I'd mention this oddity.

I indeed used -U2 as I thought that the rest of non-conflicting changes
were just complicating the diff. Sorry about the confusion. Here's the
default diff:

diff --cc arch/arm64/include/asm/bug.h
index a9be1072933c,0bfe1df12b19..000000000000
--- a/arch/arm64/include/asm/bug.h
+++ b/arch/arm64/include/asm/bug.h
@@@ -45,19 -42,27 +42,26 @@@
  _BUGVERBOSE_LOCATION(__FILE__, __LINE__)		\
  		".short " #flags "\n\t"			\
  		".popsection\n"				\
- 							\
- 	"1:	brk %[imm]"				\
- 		:: [imm] "i" (BUG_BRK_IMM)		\
- )
+ 	"1:	"
+ #else
+ #define __BUG_ENTRY(flags) ""
+ #endif
+ 
+ #define __BUG_FLAGS(flags)				\
+ 	asm volatile (					\
+ 		__BUG_ENTRY(flags)			\
+ 		"brk %[imm]" :: [imm] "i" (BUG_BRK_IMM)	\
+ 	);
  
- #define BUG() do {				\
- 	_BUG_FLAGS(0);				\
- 	unreachable();				\
+ 
+ #define BUG() do {					\
+ 	__BUG_FLAGS(0);					\
+ 	unreachable();					\
  } while (0)
  
- #define __WARN_FLAGS(flags) _BUG_FLAGS(BUGFLAG_WARNING|(flags))
 -#define __WARN_TAINT(taint) 				\
 -	__BUG_FLAGS(BUGFLAG_TAINT(taint))
++#define __WARN_FLAGS(flags) __BUG_FLAGS(BUGFLAG_WARNING|(flags))
  
- #endif /* ! CONFIG_GENERIC_BUG */
+ #define HAVE_ARCH_BUG
  
  #include <asm-generic/bug.h>
  

-- 
Catalin
