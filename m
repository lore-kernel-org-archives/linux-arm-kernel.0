From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 7 Nov 2012 17:43:15 +0000
Subject: [RFC PATCH 1/4] ARM: kernel: add device tree init map function
In-Reply-To: <20121107153529.GT23305@mudshark.cambridge.arm.com>
References: <1350393709-23546-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1350393709-23546-2-git-send-email-lorenzo.pieralisi@arm.com>
 <20121106215044.GB21764@mudshark.cambridge.arm.com>
 <20121107102349.GC17831@e102568-lin.cambridge.arm.com>
 <20121107110542.GH23305@mudshark.cambridge.arm.com>
 <20121107120052.GD17831@e102568-lin.cambridge.arm.com>
 <20121107153529.GT23305@mudshark.cambridge.arm.com>
Message-ID: <20121107174315.GF17831@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 07, 2012 at 03:35:30PM +0000, Will Deacon wrote:
> On Wed, Nov 07, 2012 at 12:00:52PM +0000, Lorenzo Pieralisi wrote:
> > On Wed, Nov 07, 2012 at 11:05:42AM +0000, Will Deacon wrote:
> > > No, I was thinking about what happens if the devicetree doesn't contain an
> > > mpidr property that matches the boot cpu. In this case, we will fail to
> > > assign logical ID 0, right? If this happens, we should complain about an
> > > invalid devicetree and try to fall back on the logical_map that was
> > > generated earlier on.
> > 
> > Good point. What I could do, I can assign the MPIDR of the boot CPU to
> > the logical index 0 before even starting to parse the DT (that's what it
> > is done in smp_setup_processor_id(), with a couple of twists). Then, if I
> > find a node that matches the boot CPU mpidr I just skip over it. This
> > way the boot CPU MPIDR will always be correct the only difference with
> > the current approach will be that instead of generating the secondaries
> > MPIDRs we will read them from DT.
> 
> That should work, although I'm not sure why you can't just give up
> altogether and use the initial mapping from smp_setup_processor_id?

Since I need to either stash the values to avoid reparsing the tree or
at first I just parse to check for correctness, second pass I update the map.

I will stash the reg values, and if the boot CPU MPIDR is correct I will
copy the stashed map to the cpu_logical_map. If that's unacceptable we
will change it.

> > The problem with this approach is that if we need a pointer (phandle) to the
> > boot CPU DT node through the MPIDR and the boot CPU node is botched or missing
> > we still behave as if the DT CPU nodes were ok.
> 
> Does any code do this? Wouldn't it be much better to lookup logical CPU 0 if
> you want to find anything out about the boot CPU?

Formulated my point in a horrible way sorry.

In order to retrieve the logical id of a CPU (eg IRQ affinity list) we need
its MPIDR for the reverse look-up and for that to work the reg property in the
/cpu nodes must be correct. Let's gloss over this for now.

> > I think I'd better stick a warning condition in there if the boot CPU
> > node is not present or botched (from a MPIDR perspective at least).

Done, IMHO I wrote some code that is too convoluted, I will post it anyway for
review to get further feeback.

Thanks !!
Lorenzo
