From: jamie@shareable.org (Jamie Lokier)
Date: Fri, 18 Dec 2009 20:31:54 +0000
Subject: [PATCH] ARM: Add SWP/SWPB emulation for ARMv7 processors
In-Reply-To: <13B9B4C6EF24D648824FF11BE896716203A7FA6BF4@dlee02.ent.ti.com>
References: <20091217175416.9317.66257.stgit@e101986-lin>
	<13B9B4C6EF24D648824FF11BE896716203A7FA69CC@dlee02.ent.ti.com>
	<20091217191602.GC362@shareable.org>
	<13B9B4C6EF24D648824FF11BE896716203A7FA6BF4@dlee02.ent.ti.com>
Message-ID: <20091218203154.GE1205@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Woodruff, Richard wrote:
> 
> > From: Jamie Lokier [mailto:jamie at shareable.org]
> > Sent: Thursday, December 17, 2009 1:16 PM
> 
> > Woodruff, Richard wrote:
> > > Exclusive operations are more certainly more efficient than the full
> > > bus lock behavior of SWP.  Finding and killing SWP where possible
> > > seems positive.
> >
> > Are they really more efficient for cached accesses in L1?  In
> > principle, external bus lock is not needed when doing an
> > read-modify-write on words in MESI cache, just the ability to
> > internally block it's eviction during the sequence.
> 
> Performance point was mainly about coordination with non-coherent
> external masters (outside of cluster).  Blocking all external people
> for a small range is not optimal.

Sure, but doesn't your patch break any program which tries to do
that, due to the lack of LDREX/STREX global monitor reaching to
external masters, so that case isn't relevant?

So (correct me if I'm wrong) the interesting case is only about
accesses within the cluster.  Is that really slower with SWP/SWPB?

-- Jamie
