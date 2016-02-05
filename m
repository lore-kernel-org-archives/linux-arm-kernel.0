From: akpm@linux-foundation.org (Andrew Morton)
Date: Thu, 4 Feb 2016 16:14:38 -0800
Subject: [PATCH v8] kernel: add kcov code coverage
In-Reply-To: <1454600441-70701-1-git-send-email-dvyukov@google.com>
References: <1454600441-70701-1-git-send-email-dvyukov@google.com>
Message-ID: <20160204161438.a6c7fb568a00a42c179a20de@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu,  4 Feb 2016 16:40:41 +0100 Dmitry Vyukov <dvyukov@google.com> wrote:

> kcov provides code coverage collection for coverage-guided fuzzing
> (randomized testing).

# make allmodconfig
# make
Makefile:679: Cannot use CONFIG_KCOV: -fsanitize-coverage=trace-pc is not supported by compiler
scripts/kconfig/conf  --silentoldconfig Kconfig
Makefile:679: Cannot use CONFIG_KCOV: -fsanitize-coverage=trace-pc is not supported by compiler
  CHK     include/config/kernel.release
  CHK     include/generated/uapi/linux/version.h
  CHK     include/generated/utsrelease.h
  CC      arch/x86/purgatory/purgatory.o
gcc: error: unrecognized command line option '-fsanitize-coverage=trace-pc'
make[1]: *** [arch/x86/purgatory/purgatory.o] Error 1
make: *** [archprepare] Error 2


We can't break allmodconfig and allyesconfig!

I did this:

--- a/Makefile~kernel-add-kcov-code-coverage-fix-2
+++ a/Makefile
@@ -678,6 +678,7 @@ ifdef CONFIG_KCOV
   ifeq ($(call cc-option, $(CFLAGS_KCOV)),)
     $(warning Cannot use CONFIG_KCOV: \
              -fsanitize-coverage=trace-pc is not supported by compiler)
+    CFLAGS_KCOV =
   endif
 endif
 
but hopefully there's a better way: it's a bit silly to build in the
kcov code but to not have the compiler-generated instrumentation which
calls it.
