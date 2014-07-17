From: peter.maydell@linaro.org (Peter Maydell)
Date: Thu, 17 Jul 2014 12:12:48 +0100
Subject: [PATCHv4 5/5] arm64: cpuinfo: print info for all CPUs
In-Reply-To: <20140717105415.GI21153@arm.com>
References: <1405524767-30220-1-git-send-email-mark.rutland@arm.com>
 <1405524767-30220-6-git-send-email-mark.rutland@arm.com>
 <20140716155747.GR29414@arm.com>
 <CAFEAcA-_GawEimGS4q8=C7BK6gLzSA+xVSUtLFkUS5=Mf8syBw@mail.gmail.com>
 <53C7A980.8050601@arm.com> <20140717105415.GI21153@arm.com>
Message-ID: <CAFEAcA8wZ9z8+0Q-2D_B3tkuQnksdWFeWEAadkHyB72oS6ae=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 July 2014 11:54, Will Deacon <will.deacon@arm.com> wrote:
> I don't really see the benefits of pretending that /proc/cpuinfo is remotely
> portable between architectures.

I'm not suggesting it's portable. I'm suggesting that you need
a good reason to push backwards against a design decision
made on other architectures. In particular, given that ARM is
in general *more* likely to be heterogenous than x86 (given
the existence of big.LITTLE), it seems baffling to try to move
in a direction that denies the possibility of further heterogeneity
in future.

> So the real question is: do we want to allow Linux to support features that
> exist only on a subset of cores in the system? The current thinking is that
> we truncate the advertised features to the common system subset, which means
> it will be the same on all cores, by definition. That allows hardware guys
> to build crazy systems that we can at least use, without imparting a world
> of pain onto software that needs to run on them.

I've already made one suggestion (non-pervasive crypto).
You could also envisage "feature bits" that effectively mean
"things will be faster on this core" even if they still work on
other cores too.

> I also think that we're backed into a corner regardless. We've seen how
> people ignore hwcaps (e.g. SWP), so they're likely to parse the caps for
> CPU0 and use that as an indication of the system capabilities.

Certainly userspace *can* do the wrong thing. That doesn't
necessarily mean that the kernel should only ever provide the
API equivalent of safety scissors...

> Note that the features list *isn't* just the features supported by the CPU.
> It also takes into account the set of features supported by the kernel (e.g.
> we don't advertise VFP on ARMv7 if VFP context switching isn't enabled).

This is an argument for also advertising the lowest-common-denominator
feature bits. (Do you want to argue for a single "features:" line
plus per-core "extra-features:" lines?)

thanks
-- PMM
