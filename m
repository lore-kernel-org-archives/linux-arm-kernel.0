From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 11 Jan 2013 12:19:19 +0000
Subject: [PATCH 01/16] ARM: b.L: secondary kernel entry code
In-Reply-To: <20130111114552.GB12560@localhost.cambridge.arm.com>
References: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
 <1357777251-13541-2-git-send-email-nicolas.pitre@linaro.org>
 <CAHkRjk65PEVDS6vi=07g_hef8yXOR+mTYV_Nchu1fAuLnOJLOw@mail.gmail.com>
 <alpine.LFD.2.02.1301101132080.6300@xanadu.home>
 <20130111114552.GB12560@localhost.cambridge.arm.com>
Message-ID: <20130111121919.GG1966@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 11, 2013 at 11:45:53AM +0000, Catalin Marinas wrote:
> On Thu, Jan 10, 2013 at 04:47:09PM +0000, Nicolas Pitre wrote:
> > On Thu, 10 Jan 2013, Catalin Marinas wrote:
> > > On 10 January 2013 00:20, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > > > --- /dev/null
> > > > +++ b/arch/arm/common/bL_entry.c
> > > ...
> > > > +extern volatile unsigned long bL_entry_vectors[BL_NR_CLUSTERS][BL_CPUS_PER_CLUSTER];
> > > 
> > > IMHO, we should keep this array linear and ignore the cluster grouping
> > > at this stage. This information could be added to latter patches that
> > > actually need to know about the b.L topology.
> > 
> > That's virtually all of them.  Everything b.L related is always 
> > expressed in terms of a cpu,cluster tuple at the low level.
> > 
> > > This would also imply that we treat the MPIDR just as an ID without 
> > > digging into its bit layout.
> > 
> > That makes for too large an index space.  We always end up needing to 
> > break the MPIDR into a cpu,cluster thing as the MPIDR bits are too 
> > sparse.
> 
> You could find a way to compress this with some mask and shifts. We can
> look at this later if we are to generalise this to non-b.L systems.

The b.L cluster handling code has multiple instances of this issue.
We should either try to fix them all, or defer them all as being
overkill for the foreseeable future.

For current platforms, the space saved in unlikely to be larger than
the amount of code required to implement the optimisation.

I do think we need a good, generic way to map sparesely-populated,
multidimensional topological node IDs to/from a linear space, but
we should avoid reinventing that too many times.

I think Lorenzo was already potentially looking at this issue in
relation to managing cpu_logical_map.

Cheers
---Dave
