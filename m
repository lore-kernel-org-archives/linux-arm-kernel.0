From: mturquette@ti.com (Turquette, Mike)
Date: Fri, 16 Mar 2012 15:07:44 -0700
Subject: [RFC/PATCH 0/4] pxa: attempt at switch to common clock framework
In-Reply-To: <1331919343.31118.19.camel@flow>
References: <1331919343.31118.19.camel@flow>
Message-ID: <CAJOA=zPkTy=MqiGkuLsdGE_bLMVEipRh291EaP3BV-yHWbxFRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 16, 2012 at 10:35 AM, Philipp Zabel <philipp.zabel@gmail.com> wrote:
> Hi,
>
> I have made an attempt at an initial conversion of PXA clocks to the
> common clock framework (http://lkml.org/lkml/2012/3/16/25), and I'd
> like to know if somebody is already working on this, or if I am
> heading in the general right direction.
>
> Unfortunately, this set still hangs during boot on hx4700 (pxa270),
> unless I also disable the calls to __clk_lookup in drivers/clk/clk.c
> completely (or apply the patch below). I'll investigate once I get
> access to my serial cable and hx4700 charger, but I'd be grateful if
> somebody could spot any embarassingly obvious errors.

I responded with details for your patch #4.  Looks like the macros are
missing a bit of initialization data.  Definitely not an embarrassing
error!  Those macros are not small.  It does show yet one more reason
why it would be good to get rid of the static initialization code at
some point in the future.

Regards,
Mike

> For pxa25x and pxa3xx, it's compile-tested only.
>
> regards
> Philipp
>
> ---
> ?drivers/clk/clk.c | ? ?8 +++++---
> ?1 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index c7c3bc5..79b46af 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -336,14 +336,15 @@ static struct clk *__clk_lookup_subtree(const char *name, struct clk *clk)
> ? ? ? ?struct hlist_node *tmp;
>
> ? ? ? ?if (!strcmp(clk->name, name))
> - ? ? ? ? ? ? ? return clk;
> + ? ? ? ? ? ? ? return NULL;
>
> +#if 0
> ? ? ? ?hlist_for_each_entry(child, tmp, &clk->children, child_node) {
> ? ? ? ? ? ? ? ?ret = __clk_lookup_subtree(name, child);
> ? ? ? ? ? ? ? ?if (ret)
> ? ? ? ? ? ? ? ? ? ? ? ?return ret;
> ? ? ? ?}
> -
> +#endif
> ? ? ? ?return NULL;
> ?}
>
> --
> 1.7.9.1
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
