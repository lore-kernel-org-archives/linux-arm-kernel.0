From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Sat, 22 Feb 2014 12:26:48 +0000
Subject: [PATCH 1/4] arm64: topology: Implement basic CPU topology support
In-Reply-To: <20140222020602.GG25940@sirena.org.uk>
References: <1392037324-5069-1-git-send-email-broonie@kernel.org>
 <20140221150140.GB495@e102568-lin.cambridge.arm.com>
 <20140222020602.GG25940@sirena.org.uk>
Message-ID: <20140222122647.GC9012@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 22, 2014 at 02:06:02AM +0000, Mark Brown wrote:
> On Fri, Feb 21, 2014 at 03:01:40PM +0000, Lorenzo Pieralisi wrote:
> 
> > If the DT does not contain a proper topology the scheduler seem to go for a
> > toss. I tried to track it down and it seems it expects topology cpumasks to be
> > initialized regardless (eg to possible mask), they cannot be left empty.
> 
> Could you be more specific please?  I didn't notice anything particular
> in my testing but then the fact that it's a model does obscure a lot of
> things.

I will send you a backtrace, config file, commit.

Problem is hit when CONFIG_SCHED_SMT is on and there is no cpu-map in
the dts.

What's a model ? And if you mean the processor model, what can it possibly
obscure as long as this patch is concerned ?

> > On top of that, the pr_info message is quite annoying and should be
> > probably downgraded or removed altogether.
> 
> This was deliberate - since we are not willing to use the MPIDR
> information to discover the topology we need to get the information into
> the DT bindings in order to discover it.  Even in a SMP system there is
> a difference in how closely attached the cores are so it seems like we
> should be expecting a description of the topology.

We have to make a decision. Either we rely on MPIDR_EL1 as a fallback or
we barf on missing topology nodes (or we just set-up a flat topology if
the cpu-map is missing and do not log anything).

Thanks,
Lorenzo
