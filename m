From: peter.maydell@linaro.org (Peter Maydell)
Date: Thu, 17 Jul 2014 11:39:10 +0100
Subject: [PATCHv4 5/5] arm64: cpuinfo: print info for all CPUs
In-Reply-To: <20140716155747.GR29414@arm.com>
References: <1405524767-30220-1-git-send-email-mark.rutland@arm.com>
 <1405524767-30220-6-git-send-email-mark.rutland@arm.com>
 <20140716155747.GR29414@arm.com>
Message-ID: <CAFEAcA-_GawEimGS4q8=C7BK6gLzSA+xVSUtLFkUS5=Mf8syBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 July 2014 16:57, Will Deacon <will.deacon@arm.com> wrote:
> I don't have hugely strong opinions about this, but I don't see why it's
> useful to print exactly the same line out `n' times; once for each CPU. We
> only pass one set of hwcaps to ELF executables via auxv, so why do we need
> to duplicate things here?

I think there are a couple of lines of argument here:

(1) Precedent from other architectures. Both 32-bit ARM and
x86 have the feature-info be per-core; we should do the same
for 64-bit ARM unless there's a really strong reason not to.

(2) Making this be not-per-CPU backs us into a corner. If we
have the feature flags per-core, and it turns out that they're
never ever different between cores even on heterogenous
CPUs, there's no problem. If we have the feature flags be
listed only once, and then in future we do want to support
some minor form of heterogeny between cores, then we're
stuck with a compatibility break because the format doesn't
let us express that. (Perhaps there might be a big.LITTLE
system where only the big cores had the crypto extensions,
to pick a random possibility where the kernel doesn't need to
care but userspace could take advantage by restricting itself
to running on only the big cores). I think this makes the
choice pretty straightforward, since there's basically no
benefit to having only a single features line.

(3) CPU features really are per-core, so collapsing them
down into a single line is not consistent with the line this
series otherwise takes of "we just report the information
the hardware provides without interpretation" (in particular
the refusal to provide nice human readable CPU names).

> Put another way, we're really treating the hwcaps as a system property
> rather than a per-cpu property, so I think we should handle them as such.

This is an implementation detail of the kernel, so you shouldn't
be gratuitously exposing it to userspace if you can easily
avoid doing so, as here. (The ELF HWCAP ABI obviously
does assume homogeny and would need fixing in a future
more heterogenous world.)

If you wanted you could print a single "lowest common
denominator features" line in addition to the per-CPU
features information.

thanks
-- PMM
