From: marcus.shawcroft@arm.com (Marcus Shawcroft)
Date: Thu, 17 Jul 2014 11:46:24 +0100
Subject: [PATCHv4 5/5] arm64: cpuinfo: print info for all CPUs
In-Reply-To: <CAFEAcA-_GawEimGS4q8=C7BK6gLzSA+xVSUtLFkUS5=Mf8syBw@mail.gmail.com>
References: <1405524767-30220-1-git-send-email-mark.rutland@arm.com>
 <1405524767-30220-6-git-send-email-mark.rutland@arm.com>
 <20140716155747.GR29414@arm.com>
 <CAFEAcA-_GawEimGS4q8=C7BK6gLzSA+xVSUtLFkUS5=Mf8syBw@mail.gmail.com>
Message-ID: <53C7A980.8050601@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/07/14 11:39, Peter Maydell wrote:
> On 16 July 2014 16:57, Will Deacon <will.deacon@arm.com> wrote:
>> I don't have hugely strong opinions about this, but I don't see why it's
>> useful to print exactly the same line out `n' times; once for each CPU. We
>> only pass one set of hwcaps to ELF executables via auxv, so why do we need
>> to duplicate things here?
>
> I think there are a couple of lines of argument here:
>
> (1) Precedent from other architectures. Both 32-bit ARM and
> x86 have the feature-info be per-core; we should do the same
> for 64-bit ARM unless there's a really strong reason not to.

Agreed.

> (2) Making this be not-per-CPU backs us into a corner. If we
> have the feature flags per-core, and it turns out that they're
> never ever different between cores even on heterogenous
> CPUs, there's no problem. If we have the feature flags be
> listed only once, and then in future we do want to support
> some minor form of heterogeny between cores, then we're
> stuck with a compatibility break because the format doesn't
> let us express that. (Perhaps there might be a big.LITTLE
> system where only the big cores had the crypto extensions,
> to pick a random possibility where the kernel doesn't need to
> care but userspace could take advantage by restricting itself
> to running on only the big cores). I think this makes the
> choice pretty straightforward, since there's basically no
> benefit to having only a single features line.

Agreed.

This patch is in itself an ABI break for anyone consuming /proc/cpuinfo. 
  Making this be not-per-cpu just sets us up for another ABI break in 
the future, not ideal.

Cheers
/Marcus
