From: psodagud@codeaurora.org (Sodagudi Prasad)
Date: Tue, 13 Jun 2017 15:39:37 -0700
Subject: Using __always_inline attribute
Message-ID: <2a762f1f3b355e71c5bca6a6e00bffe0@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi All,

With a variant of a CLANG(based on 4.0) following errors observed on 
Linux 4.12-rc5 tag.

net/built-in.o: In function `__xchg_mb':
arch/arm64/include/asm/cmpxchg.h:99: \
                     undefined reference to `__compiletime_assert_99'
arch/arm64/include/asm/cmpxchg.h:99: \
                     undefined reference to `__compiletime_assert_99

Clang does not seems to be marking this macro as inline and causing 
above compilation issue due to BUILD_BUG().

We added  __always_inline attribute to this macro as shown below, so 
that clang forces this macro to be always inline.
Based on definition of __xchg##sfx, it should always be inline.  Can we 
force this macro to be __always_inline ?


diff --git a/arch/arm64/include/asm/cmpxchg.h 
b/arch/arm64/include/asm/cmpxchg.h
index ae852ad..ce57cec 100644
--- a/arch/arm64/include/asm/cmpxchg.h
+++ b/arch/arm64/include/asm/cmpxchg.h
@@ -73,7 +73,7 @@
  #undef __XCHG_CASE

  #define __XCHG_GEN(sfx)                                                 
        \
-static inline unsigned long __xchg##sfx(unsigned long x,               
\
+static __always_inline unsigned long __xchg##sfx(unsigned long x,       
        \
                                         volatile void *ptr,             
\
                                         int size)                       
\
  {                                                                      
\


-Thanks, Prasad

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
Linux Foundation Collaborative Project
