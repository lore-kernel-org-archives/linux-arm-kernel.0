From: will.deacon@arm.com (Will Deacon)
Date: Wed, 18 Jun 2014 18:20:36 +0100
Subject: [PATCHv2 4/4] arm64: add runtime system sanity checks
In-Reply-To: <1403024674-25108-5-git-send-email-mark.rutland@arm.com>
References: <1403024674-25108-1-git-send-email-mark.rutland@arm.com>
 <1403024674-25108-5-git-send-email-mark.rutland@arm.com>
Message-ID: <20140618172036.GH17851@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 17, 2014 at 06:04:34PM +0100, Mark Rutland wrote:
> Unexpected variation in certain system register values across CPUs is an
> indicator of potential problems with a system. The kernel expects CPUs
> to be mostly identical in terms of supported features, even in systems
> with heterogeneous CPUs, with uniform instruction set support being
> critical for the correct operation of userspace.
> 
> To help detect issues early where hardware violates the expectations of
> the kernel, this patch adds simple runtime sanity checks on important ID
> registers in the bring up path of each CPU.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>

[...]

> +/*
> + * Verify that CPUs don't have unexpected differences that will cause problems.
> + */
> +void cpuinfo_sanity_check(struct cpuinfo_arm64 *cur)
> +{
> +	struct cpuinfo_arm64 *boot = &per_cpu(cpu_data, 0);
> +	int cpu = smp_processor_id();

You could just as easily pass in the cpu number here, like you do for
cpuinfo_detect_icache_policy.

Will
