From: akpm@linux-foundation.org (Andrew Morton)
Date: Wed, 17 Apr 2013 14:56:28 -0700
Subject: [PATCH V2 1/3] seccomp: add generic code for jitted seccomp
 filters.
In-Reply-To: <1363618233-6375-2-git-send-email-nschichan@freebox.fr>
References: <1363618233-6375-1-git-send-email-nschichan@freebox.fr>
 <1363618233-6375-2-git-send-email-nschichan@freebox.fr>
Message-ID: <20130417145628.88058f0f3104ab9ae551ddd3@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 18 Mar 2013 15:50:30 +0100 Nicolas Schichan <nschichan@freebox.fr> wrote:

> Architecture must select HAVE_SECCOMP_FILTER_JIT and implement
> seccomp_jit_compile() and seccomp_jit_free() if they intend to support
> jitted seccomp filters.
> 
> struct seccomp_filter has been moved to <linux/seccomp.h> to make its
> content available to the jit compilation code.
> 
> In a way similar to the net BPF, the jit compilation code is expected
> to updates struct seccomp_filter.bpf_func pointer to the generated
> code.
> 

This patch is killing me.

> --- a/include/linux/seccomp.h
> +++ b/include/linux/seccomp.h
> @@ -6,6 +6,7 @@
>  #ifdef CONFIG_SECCOMP
>  
>  #include <linux/thread_info.h>
> +#include <linux/filter.h>
>  #include <asm/seccomp.h>

In file included from include/linux/compat.h:18,
                 from include/linux/filter.h:9,
                 from include/linux/seccomp.h:9,
                 from include/linux/sched.h:39,
                 from arch/x86/kernel/asm-offsets.c:9:
/usr/src/25/arch/x86/include/asm/compat.h: In function 'arch_compat_alloc_user_space':
/usr/src/25/arch/x86/include/asm/compat.h:301: error: dereferencing pointer to incomplete type

Problem is, compat.h's arch_compat_alloc_user_space() needs sched.h for
task_struct but as you can see from the above include tree, sched.h
includes seccomp.h and everything falls over.  The preprocessed code
contains the definition of arch_compat_alloc_user_space() *before* the
definition of task_struct.

This is a basic x86_64 "make clean; make allmodconfig; make".

I had a few slashes at fixing it but got all frustrated.
