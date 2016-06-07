From: jon.mason@broadcom.com (Jon Mason)
Date: Tue, 7 Jun 2016 18:58:23 -0400
Subject: [RFC 0/1] ARM: print MHz in /proc/cpuinfo
In-Reply-To: <20160607221809.GP1041@n2100.armlinux.org.uk>
References: <1465333713-14339-1-git-send-email-jon.mason@broadcom.com>
 <20160607221809.GP1041@n2100.armlinux.org.uk>
Message-ID: <20160607225822.GA15007@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 07, 2016 at 11:18:10PM +0100, Russell King - ARM Linux wrote:
> On Tue, Jun 07, 2016 at 05:08:32PM -0400, Jon Mason wrote:
> > Many users (and some applications) are expecting the CPU clock speed to
> > be output in /proc/cpuinfo (as is done in x86, avr32, c6x, tile, parisc,
> > ia64, and xtensa).
> 
> Such as what applications?  This is just another meaningless number,

To be honest, I don't have any direct knowledge of this.  I saw it in
passing while googling to see if anyone had pushed a patch like this
before.  Lots of people complaining and asking for help on message
boards.  I think it has been mostly "fixed" by those apps now using
bogomips, but per your comment below, that is not optimal.

> which is just as meaningless as the bogomips number.  It tells you
> nothing really about the CPU which should remotely be used for
> anything other than user display.  It certainly can't be used for
> algorithmic selection.

As far as being something useful, it does have some benefits.  It can
tell you the speed the core is currently running at, which is
beneficial when trying to determine if the power management is
stepping up/down the core based on load, etc.  This could be queried
via the clk_summary in debugfs, but this is not always enabled.

Also, Linux developers/users and (more important to me) customers
coming to ARM from x86 are expecting this to be there.  While it is
completely fair to tell them "this is ARM, it is different, get used
to it", it will not stop them from asking.

> We have resisted publishing this information for years because not
> every ARM CPU is capable of providing this information - for many, we
> don't know what the CPU clock rate even is.  I believe it is a mistake
> to publish this information.  If userspace wants to select an algorithm,
> that needs to be done according to much more information than just the
> CPU speed - it needs knowledge of the instruction timings as well, cache
> behaviour, etc, and you might as well benchmark an implementation and
> select at run time, caching the result.
> 
> Since we've never exported this information, it's not a regression
> and it's not part of the kernels standard API.

I do not think it is a regression, and I'm sorry if I implied it.  

For many boards, the information is already there.  From a technical
perspective, it is no big feat to query and print it (and make people
happy).  For the boards that do not have it (or it is not relevant),
we can say "this is ARM, it is different, get used to it".

Thanks,
Jon

> 
> -- 
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.
