From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 8 Sep 2015 10:00:23 +0100
Subject: [PATCH v4 2/5] irqchip, gicv3: Workaround for Cavium ThunderX
 erratum 23154
In-Reply-To: <55EDCC5E.9080203@arm.com>
References: <1439576885-15621-1-git-send-email-rric@kernel.org>
 <1439576885-15621-3-git-send-email-rric@kernel.org>
 <55EDC12E.8000408@arm.com>
 <20150907171501.GD10645@e104818-lin.cambridge.arm.com>
 <55EDCC5E.9080203@arm.com>
Message-ID: <20150908090023.GB14550@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 07, 2015 at 06:41:50PM +0100, Suzuki K. Poulose wrote:
> On 07/09/15 18:15, Catalin Marinas wrote:
> >On Mon, Sep 07, 2015 at 05:54:06PM +0100, Suzuki K. Poulose wrote:
> >>On 14/08/15 19:28, Robert Richter wrote:
> >>>+static void gicv3_enable_quirks(void)
> >>>+{
> >>>+	if (cpus_have_cap(ARM64_WORKAROUND_CAVIUM_23154))
> >>>+		static_key_slow_inc(&is_cavium_thunderx);
> >>
> >>May be you could use the enable() method added to struct arm64_cpu_capability
> >>here to perform the above operation, added by James :
> >>
> >>commit 1c0763037f1e1caef739e36e09c6d41ed7b61b2d
> >>Author: James Morse <james.morse@arm.com>
> >>Date:   Tue Jul 21 13:23:28 2015 +0100
> >>
> >>     arm64: kernel: Add cpufeature 'enable' callback
> >
> >I thought about this as well when looking at the patch but decided it's
> >better as it is. The "enable" method is meant to enable per-CPU features
> >(or workarounds) but here it is about GICv3, so we don't want to enable
> >for every CPU.
> 
> Right. I have been playing with a series where the checks are delayed until
> all CPUs are brought up.

Unrelated to the GIC workaround, delaying the enable feature until the
CPUs are brought up is not always be feasible. At some point we may
implement support to defer the CPU on to user space (I already have a
patch that does this when no DT enable-method is specified, but I won't
publish it before Qualcomm fixes its firmware ;)). But we may have other
reasons to start with CPUs hot-unplugged by default and turn them on
later.

-- 
Catalin
