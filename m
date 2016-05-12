From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 12 May 2016 10:25:45 +0100
Subject: [PATCH] arm64: do not enforce strict 16 byte alignment to stack
 pointer
In-Reply-To: <1462985814-16146-1-git-send-email-colin.king@canonical.com>
References: <1462985814-16146-1-git-send-email-colin.king@canonical.com>
Message-ID: <20160512092545.GC11226@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 11, 2016 at 05:56:54PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> copy_thread should not be enforcing 16 byte aligment and returning
> -EINVAL. Other architectures trap misaligned stack access with SIGBUS
> so arm64 should follow this convention, so remove the strict enforcement
> check.
> 
> For example, currently clone(2) fails with -EINVAL when passing
> a misaligned stack and this gives little clue to what is wrong. Instead,
> it is arguable that a SIGBUS on the fist access to a misaligned stack
> allows one to figure out that it is a misaligned stack issue rather
> than trying to figure out why an unconventional (and undocumented)
> -EINVAL is being returned.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  arch/arm64/kernel/process.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 5655f756..8414971 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -258,9 +258,6 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
>  		if (stack_start) {
>  			if (is_compat_thread(task_thread_info(p)))
>  				childregs->compat_sp = stack_start;
> -			/* 16-byte aligned stack mandatory on AArch64 */
> -			else if (stack_start & 15)
> -				return -EINVAL;
>  			else
>  				childregs->sp = stack_start;
>  		}

As we discussed on the linux-man list, I don't expect this change to
break existing working user apps since they pass an aligned stack
already. I really doubt anyone relies on the -EINVAL here.

That said, I don't think we should add a cc stable (which you haven't
anyway), at least we have a point in time where this change was made. As
the patch stands:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

(but let's wait for Will's opinion as well)
