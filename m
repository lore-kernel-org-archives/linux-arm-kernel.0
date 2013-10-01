From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 1 Oct 2013 11:17:18 -0300
Subject: [PATCH 3/4] clk: kirkwood: Add CLK_IGNORE_UNUSED to ethernet ge0
 and ge1 clocks
In-Reply-To: <20131001135800.GS31178@titan.lakedaemon.net>
References: <1380575010-8573-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1380575010-8573-4-git-send-email-ezequiel.garcia@free-electrons.com>
 <20131001004009.GK31178@titan.lakedaemon.net>
 <20131001134213.GC2448@localhost>
 <20131001135800.GS31178@titan.lakedaemon.net>
Message-ID: <20131001141716.GE2448@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 01, 2013 at 09:58:00AM -0400, Jason Cooper wrote:
> On Tue, Oct 01, 2013 at 10:42:14AM -0300, Ezequiel Garcia wrote:
> > On Mon, Sep 30, 2013 at 08:40:09PM -0400, Jason Cooper wrote:
> > > On Mon, Sep 30, 2013 at 06:03:29PM -0300, Ezequiel Garcia wrote:
> > > > These clocks should never be gated, since the ethernet interfaces forget
> > > > the assigned MAC address assigned if their clock source is turned off.
> > > > 
> > > > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > > > ---
> > > > Cc: Mike Turquette <mturquette@linaro.org>
> > > > 
> > > >  drivers/clk/mvebu/kirkwood.c | 9 +++++++--
> > > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > > 
> > > I'm inclined to leave this as a hack in board-dt.c...  At some point we
> > > are going to move kirkwood over to mach-mvebu/, and there will be eyes
> > > on the code.  There's less chance of 're-discovering' this for cleanup
> > > if it's in the clock driver, looking all proper and such.  Even with the
> > > clear comment.
> > > 
> > 
> > Hm.. Really? I honestly think this change is a far cleaner way of
> > dealing with the problem.
> 
> That depends on your definition of 'problem' ;-)  It sounds like right
> now you consider the problem to be kirkwood going multiplatform.  In
> that case, this is a solution.
> 

Our 'problem' definition is certainly the same.

> However, I think the problem is that the IP block loses it's mac address
> when gated.  That hasn't been solved, all you're doing is moving the
> hack/workaround from one place to another less visible place.
> 

Of course, my opinion doesn't count this time, but I still think the fix
is cleaner.

There's an already existing and clock-framework-specific way of preventing
a clock from being ever gated -which seems to match exactly this case-
so I have a hard time seeing why we wouldn't use it.

Also: I'm wondering why you think this change would 'hide' the clock gating.
It seems whenever a (future?) developer finds these clocks are not gated,
one of the first places he will look for is precisely on those flags.

Just my two cents, the hack doesn't really worth a fight.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
