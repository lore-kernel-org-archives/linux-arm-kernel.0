From: jamesjj.liao@mediatek.com (James Liao)
Date: Wed, 11 May 2016 10:51:29 +0800
Subject: [PATCH v7 7/9] clk: mediatek: Enable critical clocks for MT2701
In-Reply-To: <20160509221321.GT3492@codeaurora.org>
References: <1460621514-65191-1-git-send-email-jamesjj.liao@mediatek.com>
 <1460621514-65191-8-git-send-email-jamesjj.liao@mediatek.com>
 <20160506231229.GJ3492@codeaurora.org> <1462772426.5344.7.camel@mtksdaap41>
 <20160509221321.GT3492@codeaurora.org>
Message-ID: <1462935089.28773.11.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen, Mike, Lee,

On Mon, 2016-05-09 at 15:13 -0700, Stephen Boyd wrote:
> On 05/09, James Liao wrote:
> > Hi Stephen,
> > 
> > On Fri, 2016-05-06 at 16:12 -0700, Stephen Boyd wrote:
> > > On 04/14, James Liao wrote:
> > > > Some system clocks should be turned on by default on MT2701.
> > > > This patch enable these clocks when related clocks have
> > > > been registered.
> > > > 
> > > > Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
> > > > ---
> > > 
> > > critical clks got merged now (sorry I'm slowly getting back to
> > > looking at patches). Please use that flag.
> > 
> > I don't see critical clock support in v4.6-rc7. Is there a repo/branch
> > that has critical clocks merged?
> > 
> 
> Right, it's in clk-next in the clk tree.

I got the latest code from clk-next and tried to use CLK_IS_CRITICAL fro
critical clocks. But There is something wrong with CLK_IS_CRITICAL. For
example, if we set vdec_sel as a critical clock, we'll get the following
result:

    vdecpll                               0            0
       vdecpll_ck                         1            1
          vdec_sel                        1            1

vdec_sel and vdecpll_ck are TOPCKGEN clocks. vdecpll is a APMIXEDSYS
PLL, which will be registered after TOPCKGEN clocks. The prepare and
enable count are incorrect in this case.

We may need to prepare/enable a parent clock if an enabled orphan clock
re-parent to it. I tried the following modification and it can resolve
this issue. But I'm not sure it's a correct place to enable parent
clcoks. May I have your comment on this?

------------------------------------------------------------
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index ce39add..db1bc3a 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2388,8 +2388,15 @@ static int __clk_core_init(struct clk_core *core)
        hlist_for_each_entry_safe(orphan, tmp2, &clk_orphan_list,
child_node) {
                struct clk_core *parent = __clk_init_parent(orphan);

-               if (parent)
+               if (parent) {
                        clk_core_reparent(orphan, parent);
+
+                       if (orphan->prepare_count)
+                               clk_core_prepare(parent);
+
+                       if (orphan->enable_count )
+                               clk_core_enable(parent);
+               }
        }

        /*
------------------------------------------------------------


Best regards,

James
