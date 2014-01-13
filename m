From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 13 Jan 2014 09:44:41 -0500
Subject: [PATCH] ARM: Kirkwood: Add support for Excito Bubba B3
In-Reply-To: <20140111155900.GL15937@n2100.arm.linux.org.uk>
References: <1388247131-19301-1-git-send-email-andrew@lunn.ch>
 <20131228170114.GH19878@titan.lakedaemon.net>
 <20140102194924.GA3321@obsidianresearch.com>
 <1388702192.16958.54.camel@hastur.hellion.org.uk>
 <20140102230832.GB9339@obsidianresearch.com>
 <20140110192032.GQ19878@titan.lakedaemon.net>
 <20140111155900.GL15937@n2100.arm.linux.org.uk>
Message-ID: <20140113144441.GE19878@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 11, 2014 at 03:59:00PM +0000, Russell King - ARM Linux wrote:
> On Fri, Jan 10, 2014 at 02:20:32PM -0500, Jason Cooper wrote:
> > I'm of the opinion that the kernel shouldn't assume the state of the
> > system when it begins execution.
> 
> Rubbish.  The kernel's requirements are well documented, and have been for
> years.  The reason we've documented it is because it _matters_, and it's
> hard to sort out this crap before the kernel starts.
> 
> Think about it - think about how many different L2 caches there are out
> there.
> 
> Think about how difficult it is to locate the L2 cache controller when
> you don't know what platform you're running on.
> 
> Think about how difficult it is to disable the L2 cache.
> 
> Think about how difficult it is to flush the L2 cache, when you don't
> know what sort it is, where it's located, or what instructions to use
> to do that.
> 
> The kernel cares about its boot environment beacuse of these issues.

Agreed.  My failure was applying the thought process for drivers (eg
mv643xx_eth) to the core kernel code.  With a network driver we are
often in a situation where sometimes the clocks are gated, sometimes
they aren't.

For example, doing tftp boot during development, and nandboot in
production.  In that case, sometimes the bootloader sets things up and
sometimes it doesn't depending on the bootloader environment.  The
mv643xx_eth driver can't assume the state that's handed to it.

But as you and JasonG have clearly explained, that doesn't carry weight
so early in the boot process for all the reasons you mentioned.

thx,

Jason.
