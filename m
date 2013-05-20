From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 20 May 2013 09:15:04 +0200
Subject: [PATCH] arm64: kernel: compiling issue,
 need =?UTF-8?Q?=27EXPORT=5FSY?=
 =?UTF-8?Q?MBOL=5FGPL=28read=5Fcurrent=5Ftimer=29=27?=
In-Reply-To: <5199C725.8050102@asianux.com>
References: <5199C725.8050102@asianux.com>
Message-ID: <168084c28e8ba5124c05553e97463172@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 20 May 2013 14:48:05 +0800, Chen Gang <gang.chen@asianux.com>
wrote:
> Need 'EXPORT_SYMBOL_GPL(read_current_timer)' if build with allmodconfig.
> 
> The related error:
>   ERROR: "read_current_timer" [lib/rbtree_test.ko] undefined!
>   ERROR: "read_current_timer" [lib/interval_tree_test.ko] undefined!
>   ERROR: "read_current_timer" [fs/ext4/ext4.ko] undefined!
>   ERROR: "read_current_timer" [crypto/tcrypt.ko] undefined!
> 
> 
> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> ---
>  arch/arm64/kernel/time.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm64/kernel/time.c b/arch/arm64/kernel/time.c
> index a551f88..7fcba80 100644
> --- a/arch/arm64/kernel/time.c
> +++ b/arch/arm64/kernel/time.c
> @@ -73,6 +73,7 @@ int read_current_timer(unsigned long *timer_value)
>  	*timer_value = arch_timer_read_counter();
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(read_current_timer);
>  
>  void __init time_init(void)
>  {

While this solves the problem, I'm not sure this is the best fix. The real
issue is with get_cycles, which is a macro around read_current_timer.

AArch32 exports it because of the number of timer implementations. On
arm64, we should be able to just return CNTVCT_EL0.

Catalin, Will, what do you think?

        M.
-- 
Fast, cheap, reliable. Pick two.
