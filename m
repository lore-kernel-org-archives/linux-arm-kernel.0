From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 20 Mar 2014 18:08:36 +0000
Subject: [PATCH 1/3] arm64: topology: Add support for topology DT bindings
In-Reply-To: <20140320134357.GE11706@sirena.org.uk>
References: <1395252139-16239-1-git-send-email-broonie@kernel.org>
 <20140320112650.GA1408@red-moon>
 <20140320134357.GE11706@sirena.org.uk>
Message-ID: <20140320180836.GA3307@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 20, 2014 at 01:43:57PM +0000, Mark Brown wrote:
> On Thu, Mar 20, 2014 at 11:26:50AM +0000, Lorenzo Pieralisi wrote:
> > On Wed, Mar 19, 2014 at 06:02:17PM +0000, Mark Brown wrote:
> > > +#ifdef CONFIG_OF
> 
> > This ifdef can be removed, CONFIG_OF is always selected for arm64 and
> > the !CONFIG_OF path
> 
> This has been present since the very first time these patches were
> posted but hasn't been mentioned as being a problem previously.

I am sorry, I missed it, doing my best to help you get it through.

> > > +#else
> > > +static inline int parse_dt_topology(void) { return 0; }
> > > +#endif
> 
> > is wrong, it should return failure. You should remove the CONFIG_OF
> > ifdeffery.
> 
> Yup.  It actually won't affect the behaviour at present though - since
> it won't do anything the result will be just the same as if we return an
> error and reset.
> 
> Given ACPI (which really looks like it's going to happen at some point
> and presumably make OF optional) I'm not sure removing the handling of
> OF is actually constructive but whatever, it's done now...

DT is there to stay, regardless of ACPI. However, given the function call
logic, returning 0 on !CONFIG_OF was correct since it meant "no cpu-map".
Anyway, CONFIG_OF ifdef should be removed.

> > > +			if (leaf) {
> > > +				ret = parse_core(c, cluster_id, core_id++);
> > > +				if (ret != 0) {
> > > +					return ret;
> > > +				}
> 
> > WARNING: braces {} are not necessary for single statement blocks
> > #139: FILE: arch/arm64/kernel/topology.c:132:
> 
> Like I say I don't think checkpatch is being helpful on this one, the
> code looks worse.  Again, whatever.

Worse or better, it has to be consistent. Either you leave them
everywhere (but there is a coding style, it is for a reason) or you
remove them everywhere (there are other nested paths where it is removed
in the patch). Do not take it as a nitpick please, I just want the code to
be consistent.

> > We still have a problem here. If the topology does not contain bindings
> > for some cpu nodes, parse_cluster() does not fail and we end up with an
> > incomplete topology. We have two choices: either we check the topology
> 
> Hrm, looking at the topology binding it doesn't specificially require
> that the topology be complete.  I can see why you would want that.
> 
> > I'd rather do it here, in preparation for MPIDR_EL1 fallback solution
> > (where there will always be topology information configured and the register
> > will always be there in all its glory).
> 
> To be honest at this point I think what I want to do is go back to the
> original approach of layering DT on top of MPIDR.  MPIDR is smaller and
> simpler code so seems more likely to make progress.  I really do expect
> that for a very large proportion of systems it'll be sufficient.

DT (cpu-map) takes precedence though. Yes, instead of resetting the
topology, falling back to MPIDR_EL1 is acceptable if either there are
broken bindings or cpus with missing topology information.

Honestly, it is not up to the kernel to validate DT, since this adds
complexity, but I think that a big fat WARN_ON on missing or broken
topology information would help fix firmware at early stages.

You should fall back to HW MPIDR_EL1.

I know, it is complex, there is little we can do about that and it is
code run just at cold boot and freed later so I deem that acceptable.

Thanks,
Lorenzo
