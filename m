From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 20 Mar 2014 17:19:32 +0000
Subject: [PATCH 1/3] arm64: topology: Add support for topology DT bindings
In-Reply-To: <20140320134357.GE11706@sirena.org.uk>
References: <1395252139-16239-1-git-send-email-broonie@kernel.org>
 <20140320112650.GA1408@red-moon>
 <20140320134357.GE11706@sirena.org.uk>
Message-ID: <20140320171930.GA28238@arm.com>
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

I recall I mentioned the unneeded CONFIG_OF in the past but I can't
really tell whether it was for this set of patches or not.

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

CONFIG_OF will always be enabled in the kernel even when we get ACPI. We
still use the chosen DT node to tell the kernel about ACPI.

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

Do you mean the physical MPIDR_EL1 or the DT representation of
MPIDR_EL1?

-- 
Catalin
