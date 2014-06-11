From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 11 Jun 2014 14:34:50 +0200
Subject: [PATCH v8 1/8] ftrace: make CALLER_ADDRx macros more generic
In-Reply-To: <1398851676-16389-2-git-send-email-takahiro.akashi@linaro.org>
References: <1394862048-28758-1-git-send-email-takahiro.akashi@linaro.org>
 <1398851676-16389-1-git-send-email-takahiro.akashi@linaro.org>
 <1398851676-16389-2-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <CAMuHMdWs9i4pBNbn-RTpv_-K5W7YGED=KtEtFSci=7YHdNKpfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 30, 2014 at 11:54 AM, AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
> Most archs with HAVE_ARCH_CALLER_ADDR have the almost same definitions
> of CALLER_ADDRx(n), and so put them into linux/ftrace.h.
>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>

On arm (at least shmobile_defconfig and versatile_defconfig) with gcc 4.6.3:

kernel/sched/core.c: In function 'get_parent_ip':
kernel/sched/core.c:2520:10: warning: unsupported argument to
'__builtin_return_address' [enabled by default]
kernel/sched/core.c:2522:11: warning: unsupported argument to
'__builtin_return_address' [enabled by default]

With gcc 4.9.0:

kernel/sched/core.c: In function 'get_parent_ip':
include/linux/ftrace.h:627:36: warning: unsupported argument to
'__builtin_return_address'
 #  define ftrace_return_address(n) __builtin_return_address(n)
                                    ^
include/linux/ftrace.h:635:38: note: in expansion of macro
'ftrace_return_address'
 #define CALLER_ADDR2 ((unsigned long)ftrace_return_address(2))
                                      ^
kernel/sched/core.c:2520:10: note: in expansion of macro 'CALLER_ADDR2'
   addr = CALLER_ADDR2;
          ^
include/linux/ftrace.h:627:36: warning: unsupported argument to
'__builtin_return_address'
 #  define ftrace_return_address(n) __builtin_return_address(n)
                                    ^
include/linux/ftrace.h:636:38: note: in expansion of macro
'ftrace_return_address'
 #define CALLER_ADDR3 ((unsigned long)ftrace_return_address(3))
                                      ^
kernel/sched/core.c:2522:11: note: in expansion of macro 'CALLER_ADDR3'
    addr = CALLER_ADDR3;
           ^

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
