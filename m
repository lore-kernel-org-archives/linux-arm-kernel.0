From: olof@lixom.net (Olof Johansson)
Date: Sun, 30 Sep 2012 19:44:10 -0700
Subject: [PATCH] [ARM] Build failure CONFIG_ARCH_KIRKWOOD_DT relies on
 CACHE_FEROCEON_L2
In-Reply-To: <20120930232253.GD30637@obsidianresearch.com>
References: <20120930232253.GD30637@obsidianresearch.com>
Message-ID: <CAOesGMgpDs60jGsV4Wu-A7M+ThXh7YVkgb_mPgMJfPwNa_QbSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Sep 30, 2012 at 4:22 PM, Jason Gunthorpe
<jgunthorpe@obsidianresearch.com> wrote:
> Move the CACHE_FEROCEON_L2 test to kirkwood_l2_init, since linking
> fails on the reference to feroceon_l2_init.
>
> Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> ---
>  arch/arm/mach-kirkwood/board-dt.c |    2 --
>  arch/arm/mach-kirkwood/common.c   |    4 ++--
>  2 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
> index e4eb450..d00223e 100644
> --- a/arch/arm/mach-kirkwood/board-dt.c
> +++ b/arch/arm/mach-kirkwood/board-dt.c
> @@ -50,9 +50,7 @@ static void __init kirkwood_dt_init(void)
>
>         kirkwood_setup_cpu_mbus();
>
> -#ifdef CONFIG_CACHE_FEROCEON_L2
>         kirkwood_l2_init();
> -#endif
>
>         /* Setup root of clk tree */
>         kirkwood_clk_init();
> diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
> index 1201191..4177304 100644
> --- a/arch/arm/mach-kirkwood/common.c
> +++ b/arch/arm/mach-kirkwood/common.c
> @@ -645,6 +645,7 @@ char * __init kirkwood_id(void)
>
>  void __init kirkwood_l2_init(void)
>  {
> +#ifdef CONFIG_CACHE_FEROCEON_L2
>  #ifdef CONFIG_CACHE_FEROCEON_L2_WRITETHROUGH

Aren't these added ifdefs completely redundant? L2_WRITETHROUGH is
dependent on the outer options anyway.


-Olof
