From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 22 Apr 2013 10:27:58 -0700
Subject: [PATCH] clk: vexpress: Add separate SP810 driver
In-Reply-To: <1366641279.3203.15.camel@hornet>
References: <1363358409-5693-1-git-send-email-pawel.moll@arm.com>
 <20130417222630.19887.75481@quantum> <1366305802.3077.37.camel@hornet>
 <20130422142555.GN14496@n2100.arm.linux.org.uk>
 <1366641279.3203.15.camel@hornet>
Message-ID: <20130422172758.17530.12432@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Pawel Moll (2013-04-22 07:34:39)
> On Mon, 2013-04-22 at 15:25 +0100, Russell King - ARM Linux wrote:
> > >         /* Switch the parent if necessary */
> > > -       if (old_parent != new_parent)
> > > +       if (old_parent != new_parent) {
> > > +               clk_prepare(new_parent);
> > >                 clk_set_parent(hw->clk, new_parent);
> > > +               clk_unprepare(old_parent);
> > > +       }
> > > 
> > > So, to summarize, the patch that works for me is below.
> > 
> > So what if the old parent clock wasn't prepared?
> 
> The clk_prepare() does __clk_prepare(clk->parent) before
> clk->ops->prepare(clk->kw), so the old_parent is always prepared.
> 

Yes, this hack is subtle.  The reparent operation happens within the
.prepare callback, so the old parent chain is implicitly prepared.

Regards,
Mike

> Pawe?
