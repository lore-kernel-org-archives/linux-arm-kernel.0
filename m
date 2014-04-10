From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 9 Apr 2014 22:55:44 -0300
Subject: [PATCH] ARM: imx6: Fix procedure to switch the parent of
 LDB_DI_CLK
In-Reply-To: <20140410012140.GC2334@dragon>
References: <1397044538-12676-1-git-send-email-festevam@gmail.com>
 <20140409133422.GA2334@dragon>
 <CAOMZO5CO8ucya8qmVXBo5kgRmuLqKGtpub07o1DuE9yh5LmmPQ@mail.gmail.com>
 <20140409145936.GB2334@dragon>
 <CAOMZO5AuwgVijZ_SMYZBOxbq8dVtvUzcQ06TFmmDtiaEQJrYRw@mail.gmail.com>
 <20140410012140.GC2334@dragon>
Message-ID: <CAOMZO5Cj3yoY-Y+uD5XAW8tgyd3_Be-VCUEkEHh+gNjoKdF-6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 9, 2014 at 10:21 PM, Shawn Guo <shawn.guo@freescale.com> wrote:

> For the record, here is my printk gives.
...
> *** clk_register_mux: ldb_di0_sel
> *** clk_register_mux: ldb_di1_sel

Ok, I ran it again and yes, I can see it now. Sorry for the previous
wrong printk's.

>>
>> >
>> > Furthermore, some re-parenting happens in a way you may not be aware of.
>> > See commit e366fdd (clk: clk-mux: implement remuxing on set_rate), for
>> > example.
>>
>> This commit does not affect us as we pass the CLK_SET_RATE_NO_REPARENT flag.
>
> You did not get my point.  This is just an example, and we happen to set
> this flag for now.  My point is that as long as you register a clk to
> clock framework, you do not have a way to stop one from calling clk
> API on the clock then.  This is how clk framework and API work, simple
> as it is.

The issue that this patch wants to solve is that we need to perform
this protection clock switching mechanism prior to doing the
clk_set_parent for the ldb clocks.

Putting a printk in clk_set_parent like this:

--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1719,6 +1719,8 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
        if (!clk->ops)
                return -EINVAL;

+       pr_info(" *** Calling clk_set_parent for %s clock\n", clk->name);
+
        /* verify ops for for multi-parent clks */
        if ((clk->num_parents > 1) && (!clk->ops->set_parent))
                return -ENOSYS;
,results in:

 *** Calling clk_set_parent for ldb_di0_sel clock
 *** Calling clk_set_parent for ldb_di1_sel clock
 *** Calling clk_set_parent for enfc_sel clock
 *** Calling clk_set_parent for cko2_sel clock
 *** Calling clk_set_parent for cko clock
 *** Calling clk_set_parent for spdif_sel clock
 *** Calling clk_set_parent for lvds1_sel clock
 *** Calling clk_set_parent for ipu1_di0_sel clock

Which shows that there is only one clk_set_parent being called for the
ldb_di clocks and this one is in clk-mx6q.c.

So it is safe to perform this workaround in clk-imx6q.c.

Don't you agree?

Thanks,

Fabio Estevam
