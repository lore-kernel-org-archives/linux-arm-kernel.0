From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun, 6 Nov 2016 00:45:30 +0900
Subject: [PATCH v4] ARM: w90x900: let clk_disable() return immediately if
 clk is NULL
In-Reply-To: <1474221559-21269-1-git-send-email-yamada.masahiro@socionext.com>
References: <1474221559-21269-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAK7LNARJ647+pmADPO=Q33ie9EsmH_Yu+US3HiwertzEw4CnSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wan,

This patch was acked by you long before,
but it has not been pulled-in yet for some reasons.

Now the patch was split per platform.

So, could you apply this patch to your tree, please?


2016-09-19 2:59 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> In many of clk_disable() implementations, it is a no-op for a NULL
> pointer input, but this is one of the exceptions.
>
> Making it treewide consistent will allow clock consumers to call
> clk_disable() without NULL pointer check.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Acked-by: Wan Zongshun <mcuos.com@gmail.com>
> ---
>
> Changes in v4:
>   - Split into per-arch patches
>
> Changes in v3:
>   - Return only when clk is NULL.  Do not take care of error pointer.
>
> Changes in v2:
>   - Rebase on Linux 4.6-rc1
>
>  arch/arm/mach-w90x900/clock.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm/mach-w90x900/clock.c b/arch/arm/mach-w90x900/clock.c
> index 2c371ff..ac6fd1a 100644
> --- a/arch/arm/mach-w90x900/clock.c
> +++ b/arch/arm/mach-w90x900/clock.c
> @@ -46,6 +46,9 @@ void clk_disable(struct clk *clk)
>  {
>         unsigned long flags;
>
> +       if (!clk)
> +               return;
> +
>         WARN_ON(clk->enabled == 0);
>
>         spin_lock_irqsave(&clocks_lock, flags);
> --
> 1.9.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



-- 
Best Regards
Masahiro Yamada
