From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 1 Oct 2013 09:58:00 -0400
Subject: [PATCH 3/4] clk: kirkwood: Add CLK_IGNORE_UNUSED to ethernet
 ge0 and ge1 clocks
In-Reply-To: <20131001134213.GC2448@localhost>
References: <1380575010-8573-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1380575010-8573-4-git-send-email-ezequiel.garcia@free-electrons.com>
 <20131001004009.GK31178@titan.lakedaemon.net>
 <20131001134213.GC2448@localhost>
Message-ID: <20131001135800.GS31178@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 01, 2013 at 10:42:14AM -0300, Ezequiel Garcia wrote:
> On Mon, Sep 30, 2013 at 08:40:09PM -0400, Jason Cooper wrote:
> > On Mon, Sep 30, 2013 at 06:03:29PM -0300, Ezequiel Garcia wrote:
> > > These clocks should never be gated, since the ethernet interfaces forget
> > > the assigned MAC address assigned if their clock source is turned off.
> > > 
> > > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > > ---
> > > Cc: Mike Turquette <mturquette@linaro.org>
> > > 
> > >  drivers/clk/mvebu/kirkwood.c | 9 +++++++--
> > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > I'm inclined to leave this as a hack in board-dt.c...  At some point we
> > are going to move kirkwood over to mach-mvebu/, and there will be eyes
> > on the code.  There's less chance of 're-discovering' this for cleanup
> > if it's in the clock driver, looking all proper and such.  Even with the
> > clear comment.
> > 
> 
> Hm.. Really? I honestly think this change is a far cleaner way of
> dealing with the problem.

That depends on your definition of 'problem' ;-)  It sounds like right
now you consider the problem to be kirkwood going multiplatform.  In
that case, this is a solution.

However, I think the problem is that the IP block loses it's mac address
when gated.  That hasn't been solved, all you're doing is moving the
hack/workaround from one place to another less visible place.

> The motivation for these 4 patches, came from an attempt of booting a
> multiplatform kernel Kirkwood, which _almost_ booted fine :P
> 
> So, I see this as preparation work for the move to mach-mvebu.

Fair enough.

> Does anybody have any insights on how a proper fix would be done
> in the net driver?

A reliable way to make sure the mac address is passed to the kernel from
existing bootloaders via DT.  I _really_ need to add fdt
parsing/modification to the impedance matcher.  Then we can safely say
"wrap the kernel and dtb with the impedance matcher".

/or/, we could save it in some fashion in mv643xx_eth's suspend/resume
code.  Unfortunately, it has to survive module unload/load, and there's
still the issue of loading the module after kernel boot.  Clocks would
be gated, so the mac address has to be retrieved from somewhere.

Since modifying the dt in the kernel is frowned upon, we're left with
inserting what the bootloader tells us and handing it off to the kernel
at boot time.

thx,

Jason.
