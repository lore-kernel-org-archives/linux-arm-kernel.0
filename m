From: will.deacon@arm.com (Will Deacon)
Date: Thu, 29 Nov 2018 10:49:03 +0000
Subject: [PATCH] arm64: io: specify asm operand width for __iormb()
In-Reply-To: <fe3cba43-935b-448c-46e9-90ea75593e5b@arm.com>
References: <20181129041912.5918-1-nick.desaulniers@gmail.com>
 <fe3cba43-935b-448c-46e9-90ea75593e5b@arm.com>
Message-ID: <20181129104902.GA2377@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 29, 2018 at 09:03:54AM +0000, Julien Thierry wrote:
> 
> 
> On 29/11/18 04:19, Nick Desaulniers wrote:
> > Fixes the warning produced from Clang:
> > ./include/asm-generic/io.h:711:9: warning: value size does not match
> > register size specified by the constraint and modifier
> > [-Wasm-operand-widths]
> >         return readl(addr);
> >                ^
> > ./arch/arm64/include/asm/io.h:149:58: note: expanded from macro 'readl'
> >                                                           ^
> > ./include/asm-generic/io.h:711:9: note: use constraint modifier "w"
> > ./arch/arm64/include/asm/io.h:149:50: note: expanded from macro 'readl'
> >                                                   ^
> > ./arch/arm64/include/asm/io.h:118:25: note: expanded from macro '__iormb'
> >         asm volatile("eor       %w0, %1, %1\n" \
> >                                      ^
> 
> Why does the "eor %0, %1, %1" become "eor %w0, %1, %1" ?
> The variable passed to the inline assembly for %0 is unsigned long, so
> always 64-bits wide on arm64. Why is clang trying to use a 32-bit
> register for it?

Yeah, the message above looks bogus to me. I can see %1 being 32-bit for
read[bwl], so maybe clang is just getting the diagnostic wrong. If so,
I wonder if the following fixes the problem:


diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index d42d00d8d5b6..13befec8b64e 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -117,7 +117,7 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
         */                                                             \
        asm volatile("eor       %0, %1, %1\n"                           \
                     "cbnz      %0, ."                                  \
-                    : "=r" (tmp) : "r" (v) : "memory");                \
+                    : "=r" (tmp) : "r" (unsigned long)(v) : "memory"); \
 })
 
 #define __iowmb()              wmb()


Will
