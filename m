From: vzapolskiy@gmail.com (Vladimir Zapolskiy)
Date: Thu, 18 Mar 2010 17:23:34 +0300
Subject: [PATCH 1/2 v2] imx: optimize __clk_enable() and __clk_disable()
	functions.
In-Reply-To: <1268918865-15401-1-git-send-email-vzapolskiy@gmail.com>
References: <20100318083728.GB1369@pengutronix.de>
	<1268918865-15401-1-git-send-email-vzapolskiy@gmail.com>
Message-ID: <fcda838a1003180723x42eb01f1rcf0843aacb7b5f82@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 18, 2010 at 4:27 PM, Vladimir Zapolskiy
<vzapolskiy@gmail.com> wrote:
> To remove unnecessary calls of functions with invalid argumets make
> the checks before a call.
>
> Signed-off-by: Vladimir Zapolskiy <vzapolskiy@gmail.com>
> ---
> ?arch/arm/plat-mxc/clock.c | ? 25 ++++++++++++-------------
> ?1 files changed, 12 insertions(+), 13 deletions(-)
>
> diff --git a/arch/arm/plat-mxc/clock.c b/arch/arm/plat-mxc/clock.c
> index 323ff8c..ec4af90 100644
> --- a/arch/arm/plat-mxc/clock.c
> +++ b/arch/arm/plat-mxc/clock.c
> @@ -50,24 +50,25 @@ static DEFINE_MUTEX(clocks_mutex);
>
> ?static void __clk_disable(struct clk *clk)
> ?{
> - ? ? ? if (clk == NULL || IS_ERR(clk))
> - ? ? ? ? ? ? ? return;
> -
> - ? ? ? __clk_disable(clk->parent);
> - ? ? ? __clk_disable(clk->secondary);
> -
> ? ? ? ?WARN_ON(!clk->usecount);
> +
> ? ? ? ?if (!(--clk->usecount) && clk->disable)
> ? ? ? ? ? ? ? ?clk->disable(clk);
> +
> + ? ? ? if (clk->secondary)
> + ? ? ? ? ? ? ? __clk_disable(clk->secondary);
> +
> + ? ? ? if (clk->parent)
> + ? ? ? ? ? ? ? __clk_disable(clk->parent);
> ?}
>
> ?static int __clk_enable(struct clk *clk)
> ?{
> - ? ? ? if (clk == NULL || IS_ERR(clk))
> - ? ? ? ? ? ? ? return -EINVAL;
> + ? ? ? if (clk->parent)
> + ? ? ? ? ? ? ? __clk_enable(clk->parent);
>
> - ? ? ? __clk_enable(clk->parent);
> - ? ? ? __clk_enable(clk->secondary);
> + ? ? ? if (clk->secondary)
> + ? ? ? ? ? ? ? __clk_enable(clk->secondary);
>
> ? ? ? ?if (clk->usecount++ == 0 && clk->enable)
> ? ? ? ? ? ? ? ?clk->enable(clk);
> @@ -99,9 +100,7 @@ EXPORT_SYMBOL(clk_enable);
> ?*/
> ?void clk_disable(struct clk *clk)
> ?{
> - ? ? ? if (clk == NULL || IS_ERR(clk))
> - ? ? ? ? ? ? ? return;
> -
> + ? ? ? BUG_ON(clk == NULL || IS_ERR(clk));
> ? ? ? ?mutex_lock(&clocks_mutex);
> ? ? ? ?__clk_disable(clk);
> ? ? ? ?mutex_unlock(&clocks_mutex);
> --
> 1.6.6.1
>
>
One potential issue is still exists, there is no valid checks and
unbinding of return values in __clk_enable() recursive calls.

With best wishes,
Vladimir
