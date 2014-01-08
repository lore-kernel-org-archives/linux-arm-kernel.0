From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 8 Jan 2014 10:24:10 +0000
Subject: [PATCH 0/4] arm64 topology support
In-Reply-To: <20140107182355.GL31886@sirena.org.uk>
References: <1387483575-11430-1-git-send-email-broonie@kernel.org>
 <20140107180545.GB14603@e102568-lin.cambridge.arm.com>
 <20140107182355.GL31886@sirena.org.uk>
Message-ID: <20140108102410.GC2927@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 07, 2014 at 06:23:55PM +0000, Mark Brown wrote:
> On Tue, Jan 07, 2014 at 06:05:45PM +0000, Lorenzo Pieralisi wrote:
> > On Thu, Dec 19, 2013 at 08:06:11PM +0000, Mark Brown wrote:
> 
> > >  - Should we update the binding to allow cores in the root cpu_map node
> > >    (since it's less effort in code and not a meaningful difference
> > >    semantically), warn if we find cores in the cpu_map node or actively
> > >    reject such DTs?
> 
> > I think cpu-map must only contain cluster nodes as descendant children. This
> > to prevent creative DTs with cluster and core nodes at top topology level.
> > Overall it makes sense, cores can only exist in a cluster container, might
> > seem churn but at least that's strict.
> 
> That still leaves the question of what you want to happen with such
> maps.
> 
> > > In both cases I don't much mind but I think what's there is reasonable
> > > so I've left the code as-is pending further feedback.  I also didn't
> > > update the code to get more reuse of the iteration code, like I said I
> > > did look at that when writing the code but couldn't find anything that
> > > actually made things more pleasant but if someone has some ideas...
> 
> > I still think that most of the DT parsing code can and should be reused
> > also for other purposes (eg IRQ affinity). Comments on the patches
> > concerned.
> 
> I'm not seeing any mails there...  Note that most of the code is there
> because the binding took the decision to build the numbering for the
> subnodes into the names which is very unusual for DT and hence not very
> something the tooling works well with.  Do these other bindings have the
> same problem?  

Reviewing the parsing code now. I know the numbering is unusual and the
decision was not a simple one to make, it has been discussed and the reason
is simple: I do not want reg property in topology nodes, because they are
meaningless (we defined the topology to remove the dependency on the MPIDR,
so if we added back reg properties to eg cluster nodes, they might be thought
as cluster identifiers and that's wrong. Only cpu nodes reflect HW MPIDR
values).

No, as far as I can tell at present, IRQ affinity and C-state affinity
will work with phandles to cpu-map nodes, so the parsing you need for
the topology should not be reused for that purpose, but it is hard to
tell by just reviewing the code, I have to apply the patches and see how they
can be adapted for other purposes.

Nothing prevents us from merging code as it is and consolidate it when
needed, provided we will do that.

> get_cpu_for_node() could probably be shifted into a header, perhaps when
> there's other users though.

Right.

Thanks,
Lorenzo
