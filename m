From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 8 Mar 2013 11:48:04 -0500
Subject: [PATCH 04/10] bus: introduce an Marvell EBU MBus driver
In-Reply-To: <20130307063513.GA31330@obsidianresearch.com>
References: <1362577426-12804-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130306202710.15a6aa2c@skate>
 <20130306202447.GA4916@obsidianresearch.com>
 <201303070337.43288.arnd@arndb.de>
 <20130307063513.GA31330@obsidianresearch.com>
Message-ID: <20130308164804.GR23237@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 06, 2013 at 11:35:13PM -0700, Jason Gunthorpe wrote:
> On Thu, Mar 07, 2013 at 03:37:43AM +0000, Arnd Bergmann wrote:
> 
> > Yes. We can even use the index of the "ranges" property to refer directly
> > to the number of the window, so ranges replaces the kernel internal
> > struct mvebu_mbus_mapping.
> 
> I think we are thinking the same thing, but, s/index/bus address/ and
> s/number of the window/target id/ ?
> 
> > I would also suggest not making the mbus compatible with "simple_bus", but
> > instead probing /only/ the mbus device at bootup, which can then set
> > up the hardware based on the ranges property and then call
> > of_platform_populate on its children.
> 
> Yeah, something is needed to make startup ordering work. Things like
> the timer and main interrupt controller live behind the special
> internal regs window, so in a perfect world finding the timer would
> automatically setup the enclosing bus structures ...
> 
> > > I certainly agree with this. If it wasn't for the idea that the DT is
> > > a stable ABI and thus must be perfect from the start, I wouldn't have
> > > mentioned any of this right now, making fine tuning adjustments as a
> > > follow on seems better to me.
> > > 
> > > It is absolutely way too much work to try and fix everything in one
> > > go! I would be happy to see your patch go in as-is, but mildly unhappy
> > > to see us stuck with this DT layout forever...
> > > 
> > > Especially since I really want to see your PCI stuff go in ....
> > 
> > I basically agree with everything you write in this mail, Jason, and
> > I was about to make exactly the same comments myself.
> > 
> > Getting the binding right is certainly a priority here, but I also think
> > that we don't need to rush the code to use that binding (although having
> > the code work would make me more comfortable thinking that the binding
> > actually works).
> 
> Do you think Jason C's notion to take it as is and then be OK with
> altering the binding later pending agreement is acceptable for now? I
> agree with Thomas that this is too much to ask just to get
> the already huge Marvell PCI-E patchset into mainline.

Since these bindings are mvebu-specific, and since there are no DT
based boards on the market for mvebu, I think this is an acceptable
compromise.

Thanks to JasonG and Arnd for clearing up my misunderstandings.  The
only thing I would really like to see at this point is a clear,
thought-through migration path from Thomas' patches to JasonG's
proposal.  Obviously, it would be nice if the proposer took a crack at
this. ;-)

I'd really like to avoid a churn/spaghetti nightmare down the road if we
can avoid it with a simple tweak now.

thx,

Jason.
