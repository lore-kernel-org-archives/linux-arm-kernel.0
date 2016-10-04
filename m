From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 4 Oct 2016 18:07:41 +0100
Subject: [PATCH v2] arm: Added support for getcpu() vDSO using TPIDRURW
In-Reply-To: <1475595363-4272-1-git-send-email-fredrik.markstrom@gmail.com>
References: <1475589000-29315-1-git-send-email-fredrik.markstrom@gmail.com>
 <1475595363-4272-1-git-send-email-fredrik.markstrom@gmail.com>
Message-ID: <20161004170741.GC29008@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 04, 2016 at 05:35:33PM +0200, Fredrik Markstrom wrote:
> This makes getcpu() ~1000 times faster, this is very useful when
> implementing per-cpu buffers in userspace (to avoid cache line
> bouncing). As an example lttng ust becomes ~30% faster.
> 
> The patch will break applications using TPIDRURW (which is context switched
> since commit 4780adeefd042482f624f5e0d577bf9cdcbb760 ("ARM: 7735/2:

It looks like you dropped the leading 'a' from the commit ID. For
everyone else's benefit, the full ID is:

  a4780adeefd042482f624f5e0d577bf9cdcbb760

Please note that arm64 has done similar for compat tasks since commit:

  d00a3810c16207d2 ("arm64: context-switch user tls register tpidr_el0 for
  compat tasks")

> Preserve the user r/w register TPIDRURW on context switch and fork")) and
> is therefore made configurable.

As you note above, this is an ABI break and *will* break some existing
applications. That's generally a no-go.

This also leaves arm64's compat with the existing behaviour, differing
from arm.

I was under the impression that other mechanisms were being considered
for fast userspace access to per-cpu data structures, e.g. restartable
sequences. What is the state of those? Why is this better?

If getcpu() specifically is necessary, is there no other way to
implement it?

> +notrace int __vdso_getcpu(unsigned int *cpup, unsigned int *nodep,
> +			  struct getcpu_cache *tcache)
> +{
> +	unsigned long node_and_cpu;
> +
> +	asm("mrc p15, 0, %0, c13, c0, 2\n" : "=r"(node_and_cpu));
> +
> +	if (nodep)
> +		*nodep = cpu_to_node(node_and_cpu >> 16);
> +	if (cpup)
> +		*cpup  = node_and_cpu & 0xffffUL;

Given this is directly user-accessible, this format is a de-facto ABI,
even if it's not documented as such. Is this definitely the format you
want long-term?

Thanks,
Mark.
