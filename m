From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 2 Oct 2014 16:23:13 +0100
Subject: [PATCH 21/24] ARM64:ILP32: Use a seperate syscall table as a few
 syscalls need to be using the compat syscalls
In-Reply-To: <1409779158-30963-22-git-send-email-apinski@cavium.com>
References: <1409779158-30963-1-git-send-email-apinski@cavium.com>
 <1409779158-30963-22-git-send-email-apinski@cavium.com>
Message-ID: <20141002152312.GF32147@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 03, 2014 at 10:19:15PM +0100, Andrew Pinski wrote:
> +/*
> + * sigaltstack needs some special handling as the
> + * padding for stack_t might not be non-zero.
> + */
> +long ilp32_sys_sigaltstack(const stack_t __user *uss_ptr,
> +                          stack_t __user *uoss_ptr)
> +{
> +       stack_t uss, uoss;
> +       int ret;
> +       mm_segment_t seg;
> +
> +       if (uss_ptr) {
> +               if (!access_ok(VERIFY_READ, uss_ptr, sizeof(*uss_ptr)))
> +                       return -EFAULT;
> +               if (__get_user(uss.ss_sp, &uss_ptr->ss_sp) |
> +                       __get_user(uss.ss_flags, &uss_ptr->ss_flags) |
> +                       __get_user(uss.ss_size, &uss_ptr->ss_size))
> +                       return -EFAULT;
> +               /* Zero extend the sp address and the size. */
> +               uss.ss_sp = (void *)(uintptr_t)(unsigned int)(uintptr_t)uss.ss_sp;

Do you need the first (uintptr_t) cast here?

> +               uss.ss_size = (size_t)(unsigned int)uss.ss_size;
> +       }
> +       seg = get_fs();
> +       set_fs(KERNEL_DS);
> +       /*
> +        * Note we need to use uoss as we have changed the segment to the
> +        * kernel one so passing an user one around is wrong.
> +        */

I wonder whether it would be safe to just zero the top 32 bits of ss_sp
on the user stack directly. Would we ever expect this to be read-only?

> +       ret = sys_sigaltstack((stack_t __force __user *) (uss_ptr ? &uss : NULL),
> +                             (stack_t __force __user *) &uoss);

Nitpick: there shouldn't be any space after the type cast.

-- 
Catalin
