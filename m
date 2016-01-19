From: dvyukov@google.com (Dmitry Vyukov)
Date: Tue, 19 Jan 2016 15:06:10 +0100
Subject: [PATCH v5] kernel: add kcov code coverage
In-Reply-To: <1453207342-46254-1-git-send-email-dvyukov@google.com>
References: <1453207342-46254-1-git-send-email-dvyukov@google.com>
Message-ID: <CACT4Y+YeM+_12e9WzG3306QPEDspNiHFmCBO4yjW_B-jzPrzdw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 19, 2016 at 1:42 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> kcov provides code coverage collection for coverage-guided fuzzing
> (randomized testing). Coverage-guided fuzzing is a testing technique
> that uses coverage feedback to determine new interesting inputs to a
> system. A notable user-space example is AFL
> (http://lcamtuf.coredump.cx/afl/). However, this technique is not
> widely used for kernel testing due to missing compiler and kernel
> support.
>
> kcov does not aim to collect as much coverage as possible. It aims
> to collect more or less stable coverage that is function of syscall
> inputs. To achieve this goal it does not collect coverage in
> soft/hard interrupts and instrumentation of some inherently
> non-deterministic or non-interesting parts of kernel is disbled
> (e.g. scheduler, locking).
>
> Currently there is a single coverage collection mode (tracing),
> but the API anticipates additional collection modes.
> Initially I also implemented a second mode which exposes
> coverage in a fixed-size hash table of counters (what Quentin
> used in his original patch). I've dropped the second mode for
> simplicity.
>
> This patch adds the necessary support on kernel side.
> The complimentary compiler support was added in gcc revision 231296.
>
> We've used this support to build syzkaller system call fuzzer,
> which has found 90 kernel bugs in just 2 months:
> https://github.com/google/syzkaller/wiki/Found-Bugs
> We've also found 30+ bugs in our internal systems with syzkaller.
> Another (yet unexplored) direction where kcov coverage would greatly
> help is more traditional "blob mutation". For example, mounting
> a random blob as a filesystem, or receiving a random blob over wire.
>
> Why not gcov. Typical fuzzing loop looks as follows: (1) reset
> coverage, (2) execute a bit of code, (3) collect coverage, repeat.
> A typical coverage can be just a dozen of basic blocks (e.g. an
> invalid input). In such context gcov becomes prohibitively expensive
> as reset/collect coverage steps depend on total number of basic
> blocks/edges in program (in case of kernel it is about 2M). Cost of
> kcov depends only on number of executed basic blocks/edges. On top of
> that, kernel requires per-thread coverage because there are
> always background threads and unrelated processes that also produce
> coverage. With inlined gcov instrumentation per-thread coverage is not
> possible.
>
> kcov exposes kernel PCs and control flow to user-space which
> is insecure. But debugfs should not be mapped as user accessible.
>
> Based on a patch by Quentin Casasnovas.
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
> Anticipating reasonable questions regarding usage of this feature.
> Quentin Casasnovas and Vegard Nossum also plan to use kcov for
> coverage-guided fuzzing. Currently they use a custom kernel patch
> for their fuzzer and found several dozens of bugs.
> There is also interest from Intel 0-DAY kernel test infrastructure.
>
> Based on commit a200dcb34693084e56496960d855afdeaaf9578f.
>
> v2: - added note to commit desciption that kcov is insecure,
>       but debugfs should not be mapped as user accessible.
>     - make CONFIG_KCOV depend on CONFIG_ARCH_HAS_KCOV
>       instead of conditional inclusion with if/endif
>       (as per Kees comments).
>
> v3: - disabled instrumentation of lib/hweight.c
>     - changed task_struct.kcov_size type to unsigned
>     - moved kcov.c from kernel/kcov/ to kernel/
>     - fixed multi-line comment formatting
>     - changed BUG_ONs to WARN_ONs
>     - added kcov_get() helper
>
> v4: - pre-populate mapping with pages in kcov_mmap()
>     - don't get kcov references on vma open/copy,
>       vma holds a reference to the file which is enough
>     - extend KCOV_INIT_TRACE to support both compressed
>       4-byte PCs and full 8-byte PCs (it now accepts a struct)
>     - update example in Documentation/kcov.txt
>
> v5: - export only unsigned long PCs (no compression to 4 bytes)
>     - remove KCOV dependency on !RANDOMIZE_BASE


I've made some measurements. Currently I have ~30MB of coverage data.
Let's say it will grow 2x over time, that's 60MB. I also use a GC
language so it actually consumes 2x = 120MB. If PCs are doubled,
that's 240MB. I think I can live with this. Or I can somehow compress
PCs to 4 bytes in user-space.
So changed kcov to expose only unsigned-long-sized PCs as is. This
makes the interface much cleaner. And also removes all potential
issues wrt other archs and KASLR (user-space can canonicalize PCs
using /proc/modules and kaslr base for text).
