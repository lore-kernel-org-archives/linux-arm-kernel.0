From: b29396@freescale.com (Dong Aisheng)
Date: Wed, 15 Jul 2015 20:25:24 +0800
Subject: [PATCH v2 1/5] clk: remove duplicated code with
 __clk_set_parent_after
In-Reply-To: <20150528040919.22384.79189@quantum>
References: <1431610143-21853-1-git-send-email-aisheng.dong@freescale.com>
 <1431610143-21853-2-git-send-email-aisheng.dong@freescale.com>
 <20150528040919.22384.79189@quantum>
Message-ID: <20150715122522.GA30570@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On Wed, May 27, 2015 at 09:09:19PM -0700, Michael Turquette wrote:
> Quoting Dong Aisheng (2015-05-14 06:28:59)
> > __clk_set_parent_after() actually used the second argument then we
> > could put this duplicate logic in there and call it with a different
> > order of arguments in the success vs. error paths in this function.
> > 
> > Cc: Mike Turquette <mturquette@linaro.org>
> > Cc: Stephen Boyd <sboyd@codeaurora.org>
> > Suggested-by: Stephen Boyd <sboyd@codeaurora.org>
> > Signed-off-by: Dong Aisheng <aisheng.dong@freescale.com>
> 
> Patch looks good to me.
> 
> Also just noticed that the second argument to __clk_set_parent_after is
> never used :-(
> 

Ping...

I did not see this patch series in your tree for v4.2 rc.
Is this got missed?

Regards
Dong Aisheng

> Regards,
> Mike
> 
> > ---
> >  drivers/clk/clk.c | 8 +-------
> >  1 file changed, 1 insertion(+), 7 deletions(-)
> > 
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index 659f2b0..0e813ea 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -1159,14 +1159,8 @@ static int __clk_set_parent(struct clk_core *core, struct clk_core *parent,
> >                 flags = clk_enable_lock();
> >                 clk_reparent(core, old_parent);
> >                 clk_enable_unlock(flags);
> > +               __clk_set_parent_after(core, old_parent, parent);
> >  
> > -               if (core->prepare_count) {
> > -                       flags = clk_enable_lock();
> > -                       clk_core_disable(core);
> > -                       clk_core_disable(parent);
> > -                       clk_enable_unlock(flags);
> > -                       clk_core_unprepare(parent);
> > -               }
> >                 return ret;
> >         }
> >  
> > -- 
> > 1.9.1
> > 
