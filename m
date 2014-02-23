From: broonie@kernel.org (Mark Brown)
Date: Sun, 23 Feb 2014 11:09:22 +0900
Subject: [PATCH 1/4] arm64: topology: Implement basic CPU topology support
In-Reply-To: <20140222122647.GC9012@e102568-lin.cambridge.arm.com>
References: <1392037324-5069-1-git-send-email-broonie@kernel.org>
 <20140221150140.GB495@e102568-lin.cambridge.arm.com>
 <20140222020602.GG25940@sirena.org.uk>
 <20140222122647.GC9012@e102568-lin.cambridge.arm.com>
Message-ID: <20140223020922.GC25940@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 22, 2014 at 12:26:48PM +0000, Lorenzo Pieralisi wrote:
> On Sat, Feb 22, 2014 at 02:06:02AM +0000, Mark Brown wrote:
> > On Fri, Feb 21, 2014 at 03:01:40PM +0000, Lorenzo Pieralisi wrote:

> > > If the DT does not contain a proper topology the scheduler seem to go for a
> > > toss. I tried to track it down and it seems it expects topology cpumasks to be
> > > initialized regardless (eg to possible mask), they cannot be left empty.

> > Could you be more specific please?  I didn't notice anything particular
> > in my testing but then the fact that it's a model does obscure a lot of
> > things.

> I will send you a backtrace, config file, commit.

> Problem is hit when CONFIG_SCHED_SMT is on and there is no cpu-map in
> the dts.

Interesting...  I did test this incrementally during development but
didn't see any issues, though as there have been many stylistic updates
so I have to confess it's probably been a while since I ran that test,
I'll take a look when I have a stable enough network connection to run
the models (I'm on a Shinkansen at the minute so my connection keeps
dropping out).

> What's a model ? And if you mean the processor model, what can it possibly
> obscure as long as this patch is concerned ?

A fast or foundation model.  Your only description was "went for a toss"
so I had no idea what the problem was, I was guessing that this was some
sort of issue with performance like only using one core or something.
If it's a crash then using the models won't make a difference but for
performance issues the emulation means it's not always apparent when
using the system if the kernel is performing poorly or if the emulation
is just slow.

> > > On top of that, the pr_info message is quite annoying and should be
> > > probably downgraded or removed altogether.

> > This was deliberate - since we are not willing to use the MPIDR
> > information to discover the topology we need to get the information into
> > the DT bindings in order to discover it.  Even in a SMP system there is
> > a difference in how closely attached the cores are so it seems like we
> > should be expecting a description of the topology.

> We have to make a decision. Either we rely on MPIDR_EL1 as a fallback or
> we barf on missing topology nodes (or we just set-up a flat topology if
> the cpu-map is missing and do not log anything).

Indeed.  My personal preference would be that we fall back to MPIDR if
we don't have topology information from the firmware (since it's always
possible that the silicon does the right thing) or failing that we
insist on topology information from the firmware.  Once systems are out
in the wild it's potentially painful to get the data added to DTs so
pushing for information in case we need it in the future seems like the
safest approach in cases like this where it's not going to be too much
work to provide.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140223/6988707f/attachment-0001.sig>
