From: morten.rasmussen@arm.com (Morten Rasmussen)
Date: Thu, 12 Dec 2013 11:56:40 +0000
Subject: [PATCH 5/6] arm64: topology: Tell the scheduler about the
 relative power of cores
In-Reply-To: <alpine.LFD.2.10.1312111414500.15948@knanqh.ubzr>
References: <1386767606-6391-1-git-send-email-broonie@kernel.org>
 <1386767606-6391-5-git-send-email-broonie@kernel.org>
 <20131211144755.GF596@darko.cambridge.arm.com>
 <20131211173142.GD11468@sirena.org.uk>
 <alpine.LFD.2.10.1312111414500.15948@knanqh.ubzr>
Message-ID: <20131212115639.GD28621@e103034-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 11, 2013 at 07:27:09PM +0000, Nicolas Pitre wrote:
> On Wed, 11 Dec 2013, Mark Brown wrote:
> 
> > On Wed, Dec 11, 2013 at 02:47:55PM +0000, Catalin Marinas wrote:
> > > On Wed, Dec 11, 2013 at 01:13:25PM +0000, Mark Brown wrote:
> > 
> > > > The power numbers are the same as for ARMv7 since it seems that the
> > > > expected differential between the big and little cores is very similar on
> > > > both ARMv7 and ARMv8.
> > 
> > > I have no idea ;). We don't have real silicon yet, so that's just a wild
> > > guess.
> > 
> > I was going on some typical DMIPS/MHz numbers that I'd found so
> > hopefully it's not a complete guess, though it will vary and that's just
> > one benchmark with all the realism problems that entails.  The ratio
> > seemed to be about the same as the equivalent for the ARMv7 cores so
> > given that it's a finger in the air thing it didn't seem worth drilling
> > down much further.
> > 
> > > > +static const struct cpu_efficiency table_efficiency[] = {
> > > > +	{ "arm,cortex-a57", 3891 },
> > > > +	{ "arm,cortex-a53", 2048 },
> > > > +	{ NULL, },
> > > > +};
> > 
> > > I also don't think we can just have absolute numbers here. I'm pretty
> > > sure these were generated on TC2 but other platforms may have different
> > > max CPU frequencies, memory subsystem, level and size of caches. The
> > > "average" efficiency and difference will be different.
> > 
> > The CPU frequencies at least are taken care of already, these numbers
> > get scaled for each core.  Once we're talking about things like the
> > memory I'd also start worrying about application specific effects.
> > There's also going to be stuff like thermal management which get fed in
> > here and which varies during runtime.
> > 
> > I don't know where the numbers came from for v7.

I'm fairly sure that they are guestimates based on TC2. Vincent should
know. I wouldn't consider them accurate in any way as the relative
performance varies wildly depending on the workload. However, they are
better than having no information at all.

> > 
> > > Can we define this via DT? It's a bit strange since that's a constant
> > > used by the Linux scheduler but highly related to hardware.
> > 
> > I really don't think that's a good idea at this point, it seems better
> > for the DT to stick to factual descriptions of what's present rather
> > than putting tuning numbers in there.  If the wild guesses are in the
> > kernel source it's fairly easy to improve them, if they're baked into
> > system DTs that becomes harder.
> 
> I really think putting such things into DT is wrong.
> 
> If those numbers were derived from benchmark results, then it is most 
> probably best to try to come up with some kind of equivalent benchmark 
> in the kernel to qualify CPUs at run time.  After all this is what 
> actually matters i.e. how CPUs perform relative to each other, and that 
> may vary with many factors that people will forget to update when 
> copying a DT content to enable a new board.
> 
> And that wouldn't be the first time some benchmark is used at boot time.  
> Different crypto/RAID algorithms are tested to determine the best one to 
> use, etc.
> 
> > I'm also worried about putting numbers into the DT now with all the
> > scheduler work going on, this time next year we may well have a
> > completely different idea of what we want to tell the scheduler.  It may
> > be that we end up being able to explicitly tell the scheduler about
> > things like the memory architecture, or that the scheduler just gets
> > smarter and can estimate all this stuff at runtime.  

I agree. We need to sort the scheduler side out first before we commit
to anything. If we are worried about including code into v8 that we are
going to change later, then it is probably better to leave this part
out. See my response to Mark's patch subset with the same patch for
details (I didn't see this thread until afterwardsi - sorry).

> 
> Exactly.  Which is why the kernel better be self-sufficient to determine 
> such params.  Dt should be used only for things that may not be probed 
> at run time.  The relative performance of a CPU certainly can be probed 
> at run time.
> 
> Obviously the specifics of the actual benchmark might be debated, but 
> the same can be said about static numbers.

Indeed.

Morten
