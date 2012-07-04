From: mturquette@ti.com (Turquette, Mike)
Date: Tue, 3 Jul 2012 23:22:21 -0700
Subject: [PATCH] clk: fix used-uninitialized warning in__clk_set_parent
In-Reply-To: <1341347160-21170-1-git-send-email-swarren@wwwdotorg.org>
References: <1341347160-21170-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <CAJOA=zN8KhSc57TgiRpcMnDHEHuDzj0Od1dhK02RP676YDsZ1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 3, 2012 at 1:26 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> From: Stephen Warren <swarren@nvidia.com>
>
> This fixes:
> drivers/clk/clk.c: In function '__clk_set_parent':
> drivers/clk/clk.c:1069:5: warning: 'i' may be used uninitialized in this function
>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Hi Stephen,

Thanks for the patch.  Rajendra already sent a fix for this one and
I've pulled it into clk-fixes and sent it for 3.5-rc6 (and Cc'd
stable), so I won't be taking in your patch.  You can view Rajendra's
patch on gitweb:
http://git.linaro.org/gitweb?p=people/mturquette/linux.git;a=commit;h=863b13271f1608ab3af6f7a371047d9a66693e38

Thanks again for submitting a fix.  Always appreciated.

Mike

> ---
>  drivers/clk/clk.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 026d901..42647ca 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -1071,13 +1071,15 @@ static int __clk_set_parent(struct clk *clk, struct clk *parent)
>         old_parent = clk->parent;
>
>         /* find index of new parent clock using cached parent ptrs */
> -       if (clk->parents)
> +       if (clk->parents) {
>                 for (i = 0; i < clk->num_parents; i++)
>                         if (clk->parents[i] == parent)
>                                 break;
> -       else
> +       } else {
>                 clk->parents = kzalloc((sizeof(struct clk*) * clk->num_parents),
>                                                                 GFP_KERNEL);
> +               i = clk->num_parents;
> +       }
>
>         /*
>          * find index of new parent clock using string name comparison
> --
> 1.7.0.4
>
