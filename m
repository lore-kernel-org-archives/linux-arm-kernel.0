From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 Sep 2013 16:55:37 +0100
Subject: Unhandled prefetch abort on mirabox with 3.11-rc7
In-Reply-To: <20130903104817.GE19598@titan.lakedaemon.net>
References: <52253229.2050103@leahnim.org>
 <20130903104817.GE19598@titan.lakedaemon.net>
Message-ID: <20130903155537.GI6617@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 03, 2013 at 06:48:17AM -0400, Jason Cooper wrote:
> Adding the relevant folks to the Cc: ...

I don't think this is a kernel problem either.

> On Mon, Sep 02, 2013 at 08:49:45PM -0400, Jochen De Smet wrote:
> > [Not subscribed, so keep me on CC please]
> > 
> > This one happened on my second mirabox, with the same kernel as my
> > last problem
> > (see "Undefined instruction (ldrshtgt?) on mirabox with 3.11-rc7"
> > thread); I'm hoping
> > there's not some general (overheating?) hw problem with these boxes.
> > 
> > [56215.930555] Unhandled prefetch abort: section domain fault
> > (0x009) at 0xc014aae8

A "prefetch abort" means that the CPU was unable to fetch the instruction
for some reason.  The address of the instruction is 0xc014aae8, and the
reason is "section domain fault" - this means that the CPU thinks the
section mapping specified a domain number which denied it access to this
mapping (in other words, the domain associated with this mapping was set
to "no access").

There's two strong arguments against that being the case though:

1. The oops code can read the data located there; domains have no separation
   of read vs execute permission, and the CPU was in the same mode as it is
   when it dumped this oops.  So the domain is accessible, even though the
   abort indicated it was not.

2. The CPU executed the two preceding instructions from this code before
   spitting out this error.  Again, this indicates that the domain was
   accessible immediately before this abort was raised.

This is also inside __memzero, which will have been used many times before
this point, so its highly unlikely that the kernel would have been booted
if there was a problem here.

so, i'm afraid again, I don't think this is a kernel bug but pointing
towards a hardware weakness.  The argument against that is you say that
it's a different (your second) mirabox...  unless it's a generic design
weakness.

Keep on posting the oopses though, there may be a pattern to them.
