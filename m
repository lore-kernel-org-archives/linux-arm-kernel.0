From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 28 Sep 2009 12:34:12 +0100
Subject: [PATCH] ARM: add warning for invalid kernel page faults
In-Reply-To: <20090928113327.GH30271@localhost>
References: <20090928092919.GA30271@localhost>
	<1254131304-32057-1-git-send-email-imre.deak@nokia.com>
	<20090928095516.GB6715@n2100.arm.linux.org.uk>
	<20090928100048.GC30271@localhost>
	<20090928100442.GD6715@n2100.arm.linux.org.uk>
	<20090928101625.GE30271@localhost>
	<20090928102710.GG6715@n2100.arm.linux.org.uk>
	<20090928110158.GG30271@localhost>
	<20090928112624.GA10671@n2100.arm.linux.org.uk>
	<20090928113327.GH30271@localhost>
Message-ID: <20090928113412.GD10671@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 28, 2009 at 02:33:27PM +0300, Imre Deak wrote:
> On Mon, Sep 28, 2009 at 01:26:24PM +0200, ext Russell King - ARM Linux wrote:
> > On Mon, Sep 28, 2009 at 02:01:58PM +0300, Imre Deak wrote:
> > > On Mon, Sep 28, 2009 at 12:27:10PM +0200, ext Russell King - ARM Linux wrote:
> > > > [...]
> > > >
> > > > Now you're talking about different code - the bit I quoted was what was
> > > > in your submitted patch, without deletion of intervening lines.  There
> > > > was no else clause in your patch.
> > > > 
> > > > Please, go back and look at your original patch.
> > > 
> > > Ah, sorry. Missed that line when rebasing. I'll send an updated one.
> > 
> > Now I see what you're getting at.  Yes, we can make this a debugging
> > option, but I believe it should exhibit the right behaviour.
> > 
> > In other words (and as I already covered) it should invoke the standard
> > no_context thing if there isn't a fixup handler in place rather than
> > continuing blindly on to try to handle the fault.  So, it should be:
> > 
> > 	if (!down_read_trylock(&mm->mmap_sem)) {
> > 		if (!user_mode(regs) && !search_exception_tables(regs->ARM_pc))
> > 			goto no_context;
> > 		down_read(&mm->mmap_sem);
> > 	} else {
> > +#ifdef CONFIG_DEBUG_VM
> > +		if (!user_mode(regs) && !search_exception_tables(regs->ARM_pc))
> > +			goto no_context;
> > +#endif
> 
> Ok, agreed. Do you need an updated patch?

Yes, I would like a patch, and preferably tested please.  We've had a
number of not-tested patches hitting the kernel recently and I'd like
to cut down on those.
