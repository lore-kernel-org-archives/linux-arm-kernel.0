From: ijc@hellion.org.uk (Ian Campbell)
Date: Thu, 02 Jan 2014 22:36:32 +0000
Subject: [PATCH] ARM: Kirkwood: Add support for Excito Bubba B3
In-Reply-To: <20140102194924.GA3321@obsidianresearch.com>
References: <1388247131-19301-1-git-send-email-andrew@lunn.ch>
 <20131228170114.GH19878@titan.lakedaemon.net>
 <20140102194924.GA3321@obsidianresearch.com>
Message-ID: <1388702192.16958.54.camel@hastur.hellion.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-01-02 at 12:49 -0700, Jason Gunthorpe wrote:
> On Sat, Dec 28, 2013 at 12:01:14PM -0500, Jason Cooper wrote:
> 
> > > + * Note: This requires a new'ish version of u-boot, which disables the
> > > + * L2 cache. If your B3 silently fails to boot, u-boot is probably too
> > > + * old. Either upgrade, or consider the following email:
> > > + *
> > > + * http://lists.debian.org/debian-arm/2012/08/msg00128.html
> > 
> > Nice, thanks for adding this.
> 
> Nifty.. But what is the root cause for the above?
> 
> I'm guessing that at some point the the L1 icache has been enabled,
> the L1 dcache disabled, and the L2 cache enabled?
> 
> If the pv_fixup runs with both L1 caches off and an empty L2 then it
> shouldn't cause a problem.

I'm not 100% sure but I think the issue is that the kernel expects to be
running with all of the caches off, but u-boot incorrectly left the l2
on. The L2 is probably not empty (because u-boot was using it).

There is some code modifications done at startup (relating to setting
paddr offset?) and since the kernel expects caches to be off it doesn't
do any cache maintenance. Which means that things don't work as
expected, because stuff is cached in L2 dcache and therefore not seen in
the instruction stream (Either icached or uncached).

Anyway, regardless of the specifics running with caches on when the
kernel thinks they are off is going to cause all sorts of oddness...

Ian.
