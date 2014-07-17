From: will.deacon@arm.com (Will Deacon)
Date: Thu, 17 Jul 2014 11:54:15 +0100
Subject: [PATCHv4 5/5] arm64: cpuinfo: print info for all CPUs
In-Reply-To: <53C7A980.8050601@arm.com>
References: <1405524767-30220-1-git-send-email-mark.rutland@arm.com>
 <1405524767-30220-6-git-send-email-mark.rutland@arm.com>
 <20140716155747.GR29414@arm.com>
 <CAFEAcA-_GawEimGS4q8=C7BK6gLzSA+xVSUtLFkUS5=Mf8syBw@mail.gmail.com>
 <53C7A980.8050601@arm.com>
Message-ID: <20140717105415.GI21153@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 17, 2014 at 11:46:24AM +0100, Marcus Shawcroft wrote:
> On 17/07/14 11:39, Peter Maydell wrote:
> > On 16 July 2014 16:57, Will Deacon <will.deacon@arm.com> wrote:
> >> I don't have hugely strong opinions about this, but I don't see why it's
> >> useful to print exactly the same line out `n' times; once for each CPU. We
> >> only pass one set of hwcaps to ELF executables via auxv, so why do we need
> >> to duplicate things here?
> >
> > I think there are a couple of lines of argument here:
> >
> > (1) Precedent from other architectures. Both 32-bit ARM and
> > x86 have the feature-info be per-core; we should do the same
> > for 64-bit ARM unless there's a really strong reason not to.
> 
> Agreed.

I don't really see the benefits of pretending that /proc/cpuinfo is remotely
portable between architectures.

> > (2) Making this be not-per-CPU backs us into a corner. If we
> > have the feature flags per-core, and it turns out that they're
> > never ever different between cores even on heterogenous
> > CPUs, there's no problem. If we have the feature flags be
> > listed only once, and then in future we do want to support
> > some minor form of heterogeny between cores, then we're
> > stuck with a compatibility break because the format doesn't
> > let us express that. (Perhaps there might be a big.LITTLE
> > system where only the big cores had the crypto extensions,
> > to pick a random possibility where the kernel doesn't need to
> > care but userspace could take advantage by restricting itself
> > to running on only the big cores). I think this makes the
> > choice pretty straightforward, since there's basically no
> > benefit to having only a single features line.
> 
> Agreed.

So the real question is: do we want to allow Linux to support features that
exist only on a subset of cores in the system? The current thinking is that
we truncate the advertised features to the common system subset, which means
it will be the same on all cores, by definition. That allows hardware guys
to build crazy systems that we can at least use, without imparting a world
of pain onto software that needs to run on them.

I also think that we're backed into a corner regardless. We've seen how
people ignore hwcaps (e.g. SWP), so they're likely to parse the caps for
CPU0 and use that as an indication of the system capabilities.

Note that the features list *isn't* just the features supported by the CPU.
It also takes into account the set of features supported by the kernel (e.g.
we don't advertise VFP on ARMv7 if VFP context switching isn't enabled).

Will
