From: jean.pihet@linaro.org (Jean Pihet)
Date: Wed, 7 May 2014 14:24:53 +0200
Subject: [PATCH 2/3] perf tests: Add dwarf unwind test on ARM
In-Reply-To: <20140507120603.GC2019@krava.brq.redhat.com>
References: <1399389979-11279-1-git-send-email-jean.pihet@linaro.org>
 <1399389979-11279-3-git-send-email-jean.pihet@linaro.org>
 <20140507120603.GC2019@krava.brq.redhat.com>
Message-ID: <CAFrcx1=-Q7t3ShLy=Ky9RNFfvMb=tdgSLh6bqFDXp59auXetFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jiri,

On 7 May 2014 14:06, Jiri Olsa <jolsa@redhat.com> wrote:
> On Tue, May 06, 2014 at 05:26:18PM +0200, Jean Pihet wrote:
>
SNIP
>
> there's a memory leak of 'buf' already fixed fox x86:
>
>   perf tests x86: Fix memory leak in sample_ustack()
>   commit 763d7f5f2718f085bab5a9e63308349728f3ad12
>   Author: Masanari Iida <standby24x7@gmail.com>
>   Date:   Sun Apr 20 00:16:41 2014 +0900
>
> jirka

Ok

Here is the diff between the x86 and the ARM implementations:
$ diff -urN tools/perf/arch/arm64/tests/dwarf-unwind.c
tools/perf/arch/x86/tests/dwarf-unwind.c
--- tools/perf/arch/arm64/tests/dwarf-unwind.c    2014-05-06
17:31:17.507961045 +0200
+++ tools/perf/arch/x86/tests/dwarf-unwind.c    2014-05-06
16:52:00.589776839 +0200
@@ -21,11 +21,12 @@
         return -1;
     }

-    sp = (unsigned long) regs[PERF_REG_ARM64_SP];
+    sp = (unsigned long) regs[PERF_REG_X86_SP];

-    map = map_groups__find(&thread->mg, MAP__FUNCTION, (u64) sp);
+    map = map_groups__find(thread->mg, MAP__VARIABLE, (u64) sp);
     if (!map) {
         pr_debug("failed to get stack map\n");
+        free(buf);
         return -1;
     }

Which leads to a few questions:
- the map_groups__find parameters need to be fixed too, right?
- the free(buf) needs to be fixed,
- given that the remaining difference in the file is just a register
macro, it is worth to factor the code in a single file. Does that make
sense? If worthwhile I can do that once the ARM and ARM64 support is
merged in.

What do you think?

Regards,
Jean
