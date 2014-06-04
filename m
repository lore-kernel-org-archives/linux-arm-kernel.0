From: broonie@kernel.org (Mark Brown)
Date: Wed, 4 Jun 2014 12:57:51 +0100
Subject: [PATCH] arm64: topology: add MPIDR-based detection
In-Reply-To: <20140604093452.GA8057@e102568-lin.cambridge.arm.com>
References: <1401644249-23792-1-git-send-email-broonie@kernel.org>
 <20140603173103.GA18004@red-moon>
 <20140603210424.GJ31751@sirena.org.uk>
 <20140604093452.GA8057@e102568-lin.cambridge.arm.com>
Message-ID: <20140604115751.GH2520@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 04, 2014 at 10:34:53AM +0100, Lorenzo Pieralisi wrote:
> On Tue, Jun 03, 2014 at 10:04:24PM +0100, Mark Brown wrote:

> > I'm having a really hard time seeing this as anything other than a step
> > back.  Your change causes us to discard the higher affinity levels which
> > seems like something we actively know to be misleading and means that we
> > will be handing the scheduler two different identically numbered cores
> > (all the affinity levels we do pay attention to will be identical) if we
> > ever encounter such a system which is actively broken.

> If we ever encounter such systems we will deal with them when time
> comes, DT can handle them and patching this code is trivial.

> All I am saying is, let's wait and see, there is no compelling need to
> use aff3 (and aff2 on non-SMT systems) on current systems for the
> topology.

That's still a kernel patch or having to write DT to get things working
which for the sake of avoiding a couple of shift and or statements just
seems unhelpful.  If it was just going to give poor performance that'd
be one thing but it's actively broken.

> > > not think we should do it, that's the reason why we defined DT bindings
> > > to add a proper topology semantics and we should use them when the MPIDR
> > > values deviate from the "recommendations".

> > I'd agree with not going to great lengths unless someone defines
> > semantics for the higher affinity levels in the future however it does
> > seem like completely ignoring them when it's so easy to take some
> > account of them is insufficiently defensive - it's similar to things
> > like putting the of_node_put() calls in even though they don't do
> > anything at the minute.

> So why don't you remove of_node_put() all over the kernel then ?

Well, for code that might run on SPARC, PowerPC or (IIRC) x86 where
there are genuine OF implementations as opposed to just FDT and it does
in fact do something so in generic code it's useful.  For code that'll
only be run with FDT personally I'd not bother.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140604/72edf1ff/attachment.sig>
