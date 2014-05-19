From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 19 May 2014 15:13:24 +0100
Subject: [PATCH 4/6] arm64: topology: add MPIDR-based detection
In-Reply-To: <20140519123314.GU12304@sirena.org.uk>
References: <1399063112-16917-1-git-send-email-broonie@kernel.org>
 <1399063112-16917-5-git-send-email-broonie@kernel.org>
 <53763DFC.8070309@arm.com> <20140516183915.GP22111@sirena.org.uk>
 <5379D594.2000200@arm.com>
 <20140519105405.GC5935@e102568-lin.cambridge.arm.com>
 <20140519123314.GU12304@sirena.org.uk>
Message-ID: <20140519141323.GA2917@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 19, 2014 at 01:33:14PM +0100, Mark Brown wrote:
> On Mon, May 19, 2014 at 11:54:05AM +0100, Lorenzo Pieralisi wrote:
> 
> > As to what should we use as cluster id, honestly I do not know.
> 
> > I am quite tempted to use just three affinity levels for the moment
> > and fix it when need arises, after all on ARM we have aff2 completely
> > unused at the moment for the non-SMT systems (ie all ARM SMP systems in
> > the mainline) and we are not coalescing affinity 2 into affinity 1 in
> > any way.
> 
> > So either you ignore aff3, or can do something like that (non-SMT):
> 
> > cluster_id = MPIDR_EL1[39:32] << 16 | MPIDR_EL1[23:16] << 8 | MPIDR_EL1[15:8]
> 
> Which is roughly what the original code that you were worried about did
> IIRC?  It seems silly to ignore the higher affinity levels since it's
> trivial to look at them and means the kernel will at least split
> everything into clusters if it does encounter some hardware that uses
> them as opposed to merging those distinguished only by the higher
> affinity levels.

No, it is not, at all, you do not remember correctly I am afraid.

Using the pseudo code above is as useful as using the hashing algorithm,
they both provide you with a unique id and that's all we need for the
topology.

The original code was using the hash shifts the wrong way, which could
lead to incorrect behaviour.

If ignoring affinity levels is silly, then we have to fix ARM 32 bit
code too, since there on ALL SMP ARM systems in the mainline, affinity
level 2 *is* ignored (since they are not SMT systems).

Having said that, I really think that for the time being we should use three
affinity levels (for topology purposes) as ARM 32 does and be done with this
stuff.

To be 100% precise, I think the best way to do it is to add another
topology level (ie "book" in the kernel or whatever you want to call it for
ARM, which I think is unused) and update the parsing code and data structure
accordingly so that if two clusters have the same id but belong to different
"books" (aff2 or aff3 - depending on SMT) the sibling masks are still correct.

Documentation/cputopology.txt

We will cross that bridge when we come to it instead of lumping affinity
levels together, that's my opinion.

> > Also please remove the warning on the missing topology information, if
> > we fall back to MPIDR_EL1 we will always have a topology of sorts, as
> > borked as it might be, so that warning becomes useless, ie it is never
> > triggered.
> 
> I'll add something to this patch - the warning is needed if the DT code
> gets merged without this and it seems this one still going round the
> loop.  :/

Yes but *this* patch is bumping the log level not the other ones and what I
am saying is that when this code patch gets merged that warning is useless (ie
never triggered - cluster id can't be == -1) unless I am missing something
here.

Do not bother, use three affinity levels and be done with that, we will
deal with aff3 (and aff2) when time comes.

Thanks,
Lorenzo
