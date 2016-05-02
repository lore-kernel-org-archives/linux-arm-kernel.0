From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 02 May 2016 17:20:22 +0200
Subject: [question] pread2, pwrite2 unistd symbols for compat
In-Reply-To: <20160502134706.GA11396@yury-N73SV>
References: <20160502134706.GA11396@yury-N73SV>
Message-ID: <9552994.HgmuyIW9Ty@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 02 May 2016 16:47:06 Yury Norov wrote:
> Hi Andre, 
> 
> In patch 987aedb5d (eneric syscalls: wire up preadv2 and pwritev2
> syscalls) you add those syscalls with __SYSCALL macro. However,
> compat architectures that does not use generic unistd (mips, s390),
> declare compat version in their syscall tables. Maybe we'd replace
> __SYSCALL macro with __SC_COMP?

I think you are right and your change looks good.

After I got the original patch from Andre and the same one from Christoph,
I did not consider the possibility that they were both wrong and so I
applied Andre's version.

Can you resend the patch in proper form (with a Signed-off-by line,
rebased to mainline and with a changelog I can use)? I'll apply it as
soon as I get an Ack from Christoph then.

Thanks!

	Arnd

> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> index 723479c..6ed4613 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -721,9 +721,9 @@ __SC_WRAP(__NR_mlock2, sys_mlock2)
>  #define __NR_copy_file_range 285
>  __SC_WRAP(__NR_copy_file_range, sys_copy_file_range)
>  #define __NR_preadv2 286
> -__SYSCALL(__NR_preadv2, sys_preadv2)
> +__SC_COMP(__NR_preadv2, sys_preadv2, compat_sys_preadv2)
>  #define __NR_pwritev2 287
> -__SYSCALL(__NR_pwritev2, sys_pwritev2)
> +__SC_COMP(__NR_pwritev2, sys_pwritev2, compat_sys_pwritev2)
>  
>  #undef __NR_syscalls
>  #define __NR_syscalls 288
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
