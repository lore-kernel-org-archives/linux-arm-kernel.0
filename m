From: dvyukov@google.com (Dmitry Vyukov)
Date: Sun, 11 Dec 2016 10:32:08 +0100
Subject: [PATCH 2/2] kcov: make kcov work properly with KASLR enabled
In-Reply-To: <1481417456-28826-3-git-send-email-alex.popov@linux.com>
References: <1481417456-28826-1-git-send-email-alex.popov@linux.com>
 <1481417456-28826-3-git-send-email-alex.popov@linux.com>
Message-ID: <CACT4Y+bOd-Lzs45jyEr73GkRc7zZDxL8Z3fSc+TeZVRNVC6M-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 11, 2016 at 1:50 AM, Alexander Popov <alex.popov@linux.com> wrote:
> Subtract KASLR offset from the kernel addresses reported by kcov.
> Tested on x86_64 and AArch64 (Hikey LeMaker).
>
> Signed-off-by: Alexander Popov <alex.popov@linux.com>
> ---
>  kernel/kcov.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/kcov.c b/kernel/kcov.c
> index 3cbb0c8..f8f3f4c 100644
> --- a/kernel/kcov.c
> +++ b/kernel/kcov.c
> @@ -14,6 +14,7 @@
>  #include <linux/debugfs.h>
>  #include <linux/uaccess.h>
>  #include <linux/kcov.h>
> +#include <asm/setup.h>
>
>  /*
>   * kcov descriptor (one per opened debugfs file).
> @@ -68,6 +69,11 @@ void notrace __sanitizer_cov_trace_pc(void)
>         if (mode == KCOV_MODE_TRACE) {
>                 unsigned long *area;
>                 unsigned long pos;
> +               unsigned long ip = _RET_IP_;
> +
> +#ifdef CONFIG_RANDOMIZE_BASE
> +               ip -= kaslr_offset();
> +#endif
>
>                 /*
>                  * There is some code that runs in interrupts but for which
> @@ -81,7 +87,7 @@ void notrace __sanitizer_cov_trace_pc(void)
>                 /* The first word is number of subsequent PCs. */
>                 pos = READ_ONCE(area[0]) + 1;
>                 if (likely(pos < t->kcov_size)) {
> -                       area[pos] = _RET_IP_;
> +                       area[pos] = ip;
>                         WRITE_ONCE(area[0], pos);
>                 }
>         }
> --
> 2.7.4


Hi,

I think generally this is the right thing to do.

 There are 2 pending patches for kcov by +Quentin (hopefully in mm):
"kcov: add AFL-style tracing"
"kcov: size of arena is now given in bytes"
https://groups.google.com/forum/#!topic/syzkaller/gcqbIhKjGcY
https://groups.google.com/d/msg/syzkaller/gcqbIhKjGcY/KQFryjBKCAAJ

Your patch probably conflicts with them.
Should you base them on top of these patches, so that Andrew can merge
it without conflicts?
