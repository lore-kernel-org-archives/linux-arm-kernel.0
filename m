From: konrad.wilk@oracle.com (Konrad Rzeszutek Wilk)
Date: Tue, 22 Jan 2013 15:33:52 -0500
Subject: Compilation problem with drivers/staging/zsmalloc when !SMP on ARM
In-Reply-To: <20130121152440.GJ23505@n2100.arm.linux.org.uk>
References: <CAKGA1b=ACTQHo9=B7EAG5nrFCO9u-J+sy7dXtYk3Rk6OUcW3cQ@mail.gmail.com>
 <20130118210859.GH23505@n2100.arm.linux.org.uk>
 <20130118214527.GA913@kroah.com>
 <20130119043725.GB5391@phenom.dumpdata.com>
 <20130121152440.GJ23505@n2100.arm.linux.org.uk>
Message-ID: <20130122203352.GC12371@phenom.dumpdata.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 21, 2013 at 03:24:40PM +0000, Russell King - ARM Linux wrote:
> On Fri, Jan 18, 2013 at 11:37:25PM -0500, Konrad Rzeszutek Wilk wrote:
> > On Fri, Jan 18, 2013 at 01:45:27PM -0800, Greg Kroah-Hartman wrote:
> > > On Fri, Jan 18, 2013 at 09:08:59PM +0000, Russell King - ARM Linux wrote:
> > > > On Fri, Jan 18, 2013 at 02:24:15PM -0600, Matt Sealey wrote:
> > > > > Hello all,
> > > > > 
> > > > > I wonder if anyone can shed some light on this linking problem I have
> > > > > right now. If I configure my kernel without SMP support (it is a very
> > > > > lean config for i.MX51 with device tree support only) I hit this error
> > > > > on linking:
> > > > 
> > > > Yes, I looked at this, and I've decided that I will _not_ fix this export,
> > > > neither will I accept a patch to add an export.
> > > > 
> > > > As far as I can see, this code is buggy in a SMP environment.  There's
> > > > apparantly no guarantee that:
> > > > 
> > > > 1. the mapping will be created on a particular CPU.
> > > > 2. the mapping will then be used only on this specific CPU.
> > > > 3. no guarantee that another CPU won't speculatively prefetch from this
> > > >    region.
> > 
> > I thought the code had per_cpu for it - so that you wouldn't do that unless
> > you really went out the way to do it.
> 
> Actually, yes, you're right - that negates point (4) and possibly (2),
> but (3) is still a concern.  (3) shouldn't be that much of an issue
> _provided_ that the virtual addresses aren't explicitly made use of by
> other CPUs.  Is that guaranteed by the zsmalloc code?  (IOW, does it
> own the virtual region it places these mappings in?)

It does own them but it does also hand them off. So the users of it
might be put on a different CPU. I think, I need to trace the call-chain.
> 
> What is the performance difference between having and not having this
> optimization?  Can you provide some measurements please?

Oh boy, there were somewhere.
> 
> Lastly, as you hold per_cpu stuff across this, that means preemption
> is disabled - and any kind of scheduling is also a bug.  Is there
> any reason the kmap stuff can't be used?  Has this been tried?  How
> does it compare numerically with the existing solutions?

It was really dependent on the architecture. On x86 the copying
was superior, but on ARM it was sllow.
