From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 29 Aug 2012 14:41:02 -0700
Subject: [PATCH v2 1/4] [RFC] clk: new locking scheme for reentrancy
In-Reply-To: <CADTbHxob_pkYN_73AD4YL_Ki5i40iLTJuN0rPuFzYcyyhfoMAQ@mail.gmail.com>
References: <1345074214-17531-1-git-send-email-mturquette@linaro.org>
 <1345074214-17531-2-git-send-email-mturquette@linaro.org>
 <CADTbHxob_pkYN_73AD4YL_Ki5i40iLTJuN0rPuFzYcyyhfoMAQ@mail.gmail.com>
Message-ID: <20120829214102.4450.35547@nucleus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Pankaj Jangra (2012-08-27 10:05:29)
> Hi Mike,
> 
> On Thu, Aug 16, 2012 at 5:13 AM, Mike Turquette <mturquette@linaro.org> wrote:
> > +}
> > +
> > +void __clk_unprepare(struct clk *clk, struct clk *top)
> 
> Why do you need to change the signature of __clk_prepare and
> __clk_unprepare functions ?
> I mean i did not understand the use of passing struct clk *top? As i
> understand, it tells when you reach at the last
> clk struct in the tree which needs to be prepared/unprepared. Do we
> have extra benefit of this or if i am missing something?
> 

This series breaks compatibility with the internal clk functions.  So if
you were using __clk_prepare in your code somewhere then this will no
longer work.  It is likely you could just call clk_prepare in the same
place since there is some reentrancy introduced in this series.

Your understanding of top is correct: I want to avoid walking to the
root of the clock tree every time.  We determine the top based on
finding a positive clk->enable_count value.  There is no "extra
benefit", but locking to the root of the tree would destroy the goal of
reentrancy since there would be locking collisions at the top of the
tree.

<snip>
> > +               if (IS_ERR(top)) {
> > +                       pr_debug("%s: %s failed with %ld on attempt %d\n",
> > +                                       __func__, clk->name, PTR_ERR(top),
> > +                                       tries);
> > +                       wait_for_completion(&clk_completion);
> > +                       if (WAIT_TRIES == ++tries)
> > +                               break;
> > +               } else
> > +                       break;
> 
> Braces around else part please.
> 

OK.

> > +       }
> > +
> > +       if (WAIT_TRIES == tries) {
> > +               pr_warning("%s: failed to lock clocks; cyclical dependency?\n",
> > +                               __func__);
> > +               return;
> > +       }
> > +
> > +       /* unprepare the list of clocks from clk to top */
> > +       __clk_unprepare(clk, top);
> > +
> 
> > +       /* unprepare the list of clocks from clk to top */
> > +       __clk_prepare(clk, top);
> 
> You mean prepare right ? :)
> 

Right.  Will fix in next version of RFC.

Thanks much for the review,
Mike

> 
> 
> Regards,
> Pankaj Kumar
