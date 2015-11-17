From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Tue, 17 Nov 2015 14:58:47 +0000
Subject: [PATCH v7 0/4] KASAN for arm64
In-Reply-To: <5649F783.40109@gmail.com>
References: <1444665180-301-1-git-send-email-ryabinin.a.a@gmail.com>
 <20151013083432.GG6320@e104818-lin.cambridge.arm.com>
 <5649BAFD.6030005@arm.com> <5649F783.40109@gmail.com>
Message-ID: <564B40A7.1000206@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/11/15 15:34, Andrey Ryabinin wrote:
> On 11/16/2015 02:16 PM, Suzuki K. Poulose wrote:
>> On 13/10/15 09:34, Catalin Marinas wrote:
>>> On Mon, Oct 12, 2015 at 06:52:56PM +0300, Andrey Ryabinin wrote:

>> Hi,
>>
>> I get the following failure with KASAN + 16K_PAGES + 48BIT_VA, with 4.4-rc1:
>>
>>
>> arch/arm64/mm/kasan_init.c: In function ?kasan_early_init?:
>> include/linux/compiler.h:484:38: error: call to ?__compiletime_assert_95? declared with attribute error: BUILD_BUG_ON failed: !IS_ALIGNED(KASAN_SHADOW_END, PGDIR_SIZE)
>>    _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
>>                                        ^

...

>
> Yes, it's really needed, because some code relies on this (e.g.  clear_pgs() and kasan_init()).
> But it should be possible to get rid of this requirement.

And the other important point I missed mentioning was that, my tool chain doesn't
support KASAN. But still the KASAN support files are still compiled and generates
the above error. Shouldn't we disable it at build time if we detect that compiler
doesn't support it ? Something like we do for LSE_ATOMICS.


commit c09d6a04d17d730b0463207a26ece082772b59ee
Author: Will Deacon <will.deacon@arm.com>
Date:   Tue Feb 3 16:14:13 2015 +0000

     arm64: atomics: patch in lse instructions when supported by the CPU
     
     On CPUs which support the LSE atomic instructions introduced in ARMv8.1,
     it makes sense to use them in preference to ll/sc sequences.
     
...

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 0953a97..15ff5b4 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -17,7 +17,18 @@ GZFLAGS              :=-9
  
  KBUILD_DEFCONFIG := defconfig
  
-KBUILD_CFLAGS  += -mgeneral-regs-only
+# Check for binutils support for specific extensions
+lseinstr := $(call as-instr,.arch_extension lse,-DCONFIG_AS_LSE=1)
+
+ifeq ($(CONFIG_ARM64_LSE_ATOMICS), y)
+  ifeq ($(lseinstr),)
+$(warning LSE atomics not supported by binutils)
+  endif
+endif
+
+KBUILD_CFLAGS  += -mgeneral-regs-only $(lseinstr)
+KBUILD_AFLAGS  += $(lseinstr)
+



Thanks
Suzuki
