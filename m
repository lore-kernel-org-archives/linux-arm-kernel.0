From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 14 Jan 2013 17:23:46 +0000
Subject: [PATCH] arm: kernel/perf_event_cpu.c: fix error null pointer
 dereference check
In-Reply-To: <1358183933-29160-1-git-send-email-dinggnu@gmail.com>
References: <1358183933-29160-1-git-send-email-dinggnu@gmail.com>
Message-ID: <20130114172346.GK23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 14, 2013 at 05:18:53PM +0000, Cong Ding wrote:
> the pointer cpu_pmu is used without null pointer dereference check, and is
> checked after the using of it, so we move the null pointer check to before the
> first use.

The NULL pointer check is not necessary.  cpu_pmu_init() is called
after cpu_pmu has already been dereferenced by its caller:

        cpu_pmu = pmu;
        cpu_pmu->plat_device = pdev;
        cpu_pmu_init(cpu_pmu);

So...

> -	/* Ensure the PMU has sane values out of reset. */
> -	if (cpu_pmu && cpu_pmu->reset)

Just replace this with:
	if (cpu_pmu->reset)
