From: mturquette@ti.com (Turquette, Mike)
Date: Tue, 13 Mar 2012 19:10:59 -0700
Subject: [PATCH 1/7] clk: fix orphan list iterator to be safe
In-Reply-To: <1331680947-29861-2-git-send-email-robherring2@gmail.com>
References: <1331680947-29861-1-git-send-email-robherring2@gmail.com>
 <1331680947-29861-2-git-send-email-robherring2@gmail.com>
Message-ID: <CAJOA=zMRnnQmSzOf_Vtvk_1tVooXoKD0oeKeyFWRzLkneRmKiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 13, 2012 at 4:22 PM, Rob Herring <robherring2@gmail.com> wrote:
> From: Rob Herring <rob.herring@calxeda.com>
>
> __clk_reparent can remove orphans, so the list iterator needs to be the
> safe from removal version.
>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>

Thanks Rob.  I've taken this in for the next series.

Regards,
Mike

> ---
> ?drivers/clk/clk.c | ? ?4 ++--
> ?1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index c7c3bc5..802eda4 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -1172,7 +1172,7 @@ void __clk_init(struct device *dev, struct clk *clk)
> ?{
> ? ? ? ?int i;
> ? ? ? ?struct clk *orphan;
> - ? ? ? struct hlist_node *tmp;
> + ? ? ? struct hlist_node *tmp, *tmp2;
>
> ? ? ? ?if (!clk)
> ? ? ? ? ? ? ? ?return;
> @@ -1246,7 +1246,7 @@ void __clk_init(struct device *dev, struct clk *clk)
> ? ? ? ? * walk the list of orphan clocks and reparent any that are children of
> ? ? ? ? * this clock
> ? ? ? ? */
> - ? ? ? hlist_for_each_entry(orphan, tmp, &clk_orphan_list, child_node)
> + ? ? ? hlist_for_each_entry_safe(orphan, tmp, tmp2, &clk_orphan_list, child_node)
> ? ? ? ? ? ? ? ?__clk_reparent(orphan, __clk_init_parent(orphan));
>
> ? ? ? ?/*
> --
> 1.7.5.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
