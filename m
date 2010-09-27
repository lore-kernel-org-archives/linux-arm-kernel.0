From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 27 Sep 2010 15:07:47 +0100
Subject: [GIT PULL] omap2 sparse fixes
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E9402DB3F8D00@dbde02.ent.ti.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E9402785A390E@dbde02.ent.ti.com>
	<20100923225851.GR4211@atomide.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E9402DB3F859E@dbde02.ent.ti.com>
	<20100925001914.GO4211@atomide.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E9402DB3F8D00@dbde02.ent.ti.com>
Message-ID: <20100927140747.GA13143@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 27, 2010 at 07:11:37PM +0530, G, Manjunath Kondaiah wrote:
> > Can you please check that? Will not merge for now until we 
> > figure out what changes with these patches.
> > 
> > Then, I also noticed the following exports getting added:
> > 
> > +EXPORT_SYMBOL(omap2_gp_clockevent_set_gptimer);
> > +EXPORT_SYMBOL(omapfb_reserve_sram);
> > +EXPORT_SYMBOL(omap_sram_init);
> > 
> > These should not be exported, they are only intended to be 
> > called from the low-level platform init code. So exporting 
> > them is not the right fix for these.
> 
> I have declared these API's as extern functions in respective
> header files.

It's hard to tell whether you're justifying having the EXPORT_SYMBOLs
there or not from your reply.

Just because you add them as declarations to a header file does not mean
you have to add EXPORT_SYMBOLs for them.  The only thing that this macro
does is make them available to modules.

In any case, if functions are marked as __init (or similar, which some
are) then they must not be exported - they won't exist when modules are
available to be loaded.  Instead, their symbols will point to some
random data which has replaced the code.
