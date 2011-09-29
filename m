From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 29 Sep 2011 10:24:06 +0100
Subject: [PATCH v2] ARM: cache-l2x0: add resume entry for l2 in secure mode
In-Reply-To: <20110929092828.GE19318@S2100-06.ap.freescale.net>
References: <1317007569-31213-1-git-send-email-Baohua.Song@csr.com>
	<20110929092828.GE19318@S2100-06.ap.freescale.net>
Message-ID: <20110929092406.GD23944@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 29, 2011 at 05:28:29PM +0800, Shawn Guo wrote:
> On Sun, Sep 25, 2011 at 08:26:09PM -0700, Barry Song wrote:
> > we save the l2x0 registers at the first initialization, and platform codes
> > can get them to restore l2x0 status after wakeup.
> > 
> > Cc: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Signed-off-by: Barry Song <Baohua.Song@csr.com>
> > ---
> >  -v2:
> >  define the structure l2x0_regs to hold all saved registers;
> >  make saved copy of registers non-static so that platform codes can access them;
> >  add asm_offset for l2x0 saved regs(l2x0_regs struct) so that asm codes can use
> > 
> 
> I'm trying to migrate imx6q to this infrastructure, but seeing some
> facts that might stop me from the effort.  Please help me understand
> these facts are correct.
> 
> It seems to me that the only benefit that imx6q gains from the
> infrastructure is the register saving, and I fail to see any benefit
> on the restoring.

That's correct - because I believe that's the only part which is worth
doing in common code.  The restoring tends to be platform dependent so
I don't see the point of having a bunch of code in common files to do
that which almost no one uses.

>  * I still have to save physical base of l2x0 for register restoring.

That could be added to the structure.

>  * I do not have the physical address of l2x0_saved_regs, and I have
>    to manage to get it somehow.

That's true no matter what - we could store the physical address of
the struct somewhere, but then in order for you to obtain that, you'd
somehow need to know the physical address of _that_ location too - so
there's no benefit there.

It can be obtained simply by: __pa(l2x0_saved_regs) in C code, and
saving that in a location known to the platform prior to suspend.
