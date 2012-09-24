From: will.deacon@arm.com (Will Deacon)
Date: Mon, 24 Sep 2012 18:19:35 +0100
Subject: [PATCH] ARM: hw_breakpoint: Clear breakpoints before enabling
 monitor mode
In-Reply-To: <20120920173556.GQ4654@mudshark.cambridge.arm.com>
References: <1348160260-19486-1-git-send-email-sboyd@codeaurora.org>
 <20120920173556.GQ4654@mudshark.cambridge.arm.com>
Message-ID: <20120924171934.GE5522@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2012 at 06:35:56PM +0100, Will Deacon wrote:
> On Thu, Sep 20, 2012 at 05:57:40PM +0100, Stephen Boyd wrote:
> > +/* Determine if halting mode is enabled */
> > +static int halting_mode_enabled(void)
> > +{
> > +	u32 dscr;
> > +
> > +	ARM_DBG_READ(c1, 0, dscr);
> > +
> > +	if (WARN_ONCE(dscr & ARM_DSCR_HDBGEN,
> > +		"halting debug mode enabled. Unable to access hardware resources.\n")) {
> > +		return -EPERM;
> > +	}
> > +	return 0;
> > +}
> 
> ...it looks like debug arch 7.1 defines this bit as UNKNOWN when the OS lock
> is clear, so we probably shouldn't be reading it at all. I'll pour myself a
> stiff drink and start reading the debug arch docs to work out what on Earth
> we should do.
> 
> Stay tuned.

Ok, I've pushed a bunch of patches to my hw-breakpoint branch (head commit
55cb726797c7). I'll post them to the list after the merge window, but please
do take them for a spin if you get a chance.

Will
