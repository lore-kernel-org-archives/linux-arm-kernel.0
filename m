From: psodagud@codeaurora.org (Sodagudi Prasad)
Date: Wed, 14 Jun 2017 15:33:59 -0700
Subject: Using __always_inline attribute
In-Reply-To: <20170614100641.GB16190@arm.com>
References: <2a762f1f3b355e71c5bca6a6e00bffe0@codeaurora.org>
 <20170614100641.GB16190@arm.com>
Message-ID: <9198053a46999b0b46dcab992527d0d7@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-06-14 03:06, Will Deacon wrote:
> Hi Prasad,
> 
> On Tue, Jun 13, 2017 at 03:39:37PM -0700, Sodagudi Prasad wrote:
>> With a variant of a CLANG(based on 4.0) following errors observed on 
>> Linux
>> 4.12-rc5 tag.
> 
> How are you building the kernel with clang, btw? I'd be keen to try the 
> same
> thing, but I thought the LLVMLinux project was largely dead at his 
> point. Do
> you still need build system patches, or is this now integrated with 
> Kbuild?
Hi Will,
Trying clang patches from below tree -
https://android.googlesource.com/kernel/common/+/experimental/android-4.4-llvm

> 
>> net/built-in.o: In function `__xchg_mb':
>> arch/arm64/include/asm/cmpxchg.h:99: \
>>                     undefined reference to `__compiletime_assert_99'
>> arch/arm64/include/asm/cmpxchg.h:99: \
>>                     undefined reference to `__compiletime_assert_99
>> 
>> Clang does not seems to be marking this macro as inline and causing 
>> above
>> compilation issue due to BUILD_BUG().
> 
> The only BUILD_BUG I see around here is if the size parameter (which is
> calculated using sizeof) is not known to be 1,2,4 or 8 at compile time. 
> It
> would be interesting to know which call site is confusing clang in this 
> way
> and what code is actually being emitted here.
> 
> If it's just that __xchg_mb isn't being inlined into the __xchg_wrapper
> macro, then your patch should be ok, but I'd like to be sure it's not
> something else. I'm also surprised you haven't see this crop up in 
> other
> places.
After digging further, we observed that inline definition was changed 
recently and causing this issue.
Here is missing part of inline macro definition __attribute__((unused)).

Commit abb2ea7dfd82 ("compiler, clang: suppress warning for unused
static inline functions") have redefined the inline macro as below
#define inline inline __attribute__((unused))

But actual definition of inline macro defined compiler-gcc.h file as 
shown below.
#define inline          inline          __attribute__((always_inline)) 
notrace

As always_inline attribute is missing in inline definition, compile may 
not inline macros __xchg_mb in
arch/arm64/include/asm/cmpxchg.h file and leading to error.

Some compilers may not honor inline as inline if always_inline attribute 
is removed because of
-inline-threshold compiler options.

Here is the change to fix this issue-
diff --git a/include/linux/compiler-clang.h 
b/include/linux/compiler-clang.h
index d614c5e..a0e6433 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -22,4 +22,4 @@
   * directives.  Suppress the warning in clang as well.
   */
  #undef inline
-#define inline inline __attribute__((unused)) notrace
+#define inline __attribute__((always_inline)) __attribute__((unused)) 
notrace

-Thanks, Prasad
> 
> Will

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
Linux Foundation Collaborative Project
