From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Sat, 18 Jul 2015 14:54:07 -0400
Subject: [PATCH] mm: Fix up new locking syscalls
In-Reply-To: <1437055226-18351-1-git-send-email-broonie@kernel.org>
References: <1437055226-18351-1-git-send-email-broonie@kernel.org>
Message-ID: <CAP=VYLoN3fLJS5cPFJytdhMjqD21jado+unf0eZD6SYXM5rpyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 16, 2015 at 10:00 AM, Mark Brown <broonie@kernel.org> wrote:
> Extend the arm64 compat syscall table for the new syscalls to fix build
> errors introduced by "mm: mlock: add new mlock, munlock, and munlockall
> system calls":

The ia64 builds also are failing with:

arch/ia64/kernel/entry.S:1775: Error: attempt to move .org backwards

and a mindless bisect leads to the same commit listed above, presumably
for the same NR_syscall issue Mark fixes here.

http://kisskb.ellerman.id.au/kisskb/buildresult/12465244/

Paul.
--

>
>  ../arch/arm64/include/asm/unistd32.h:801:1: error: array index in initializer exceeds array bounds
>  ../arch/arm64/include/asm/unistd32.h:801:1: error: (near initialization for 'compat_sys_call_table')
>  ../arch/arm64/include/asm/unistd32.h:803:1: error: array index in initializer exceeds array bounds
>  ../arch/arm64/include/asm/unistd32.h:803:1: error: (near initialization for 'compat_sys_call_table')
>  ../arch/arm64/include/asm/unistd32.h:805:1: error: array index in initializer exceeds array bounds
>  ../arch/arm64/include/asm/unistd32.h:805:1: error: (near initialization for 'compat_sys_call_table')
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/include/asm/unistd.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
> index 3bc498c..aa537a4 100644
> --- a/arch/arm64/include/asm/unistd.h
> +++ b/arch/arm64/include/asm/unistd.h
> @@ -44,7 +44,7 @@
>  #define __ARM_NR_compat_cacheflush     (__ARM_NR_COMPAT_BASE+2)
>  #define __ARM_NR_compat_set_tls                (__ARM_NR_COMPAT_BASE+5)
>
> -#define __NR_compat_syscalls           388
> +#define __NR_compat_syscalls           391
>  #endif
>
>  #define __ARCH_WANT_SYS_CLONE
> --
> 2.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-next" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
