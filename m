From: cov@codeaurora.org (Christopher Covington)
Date: Thu, 26 Jun 2014 16:29:10 -0400
Subject: [PATCHv3 5/5] arm64: add runtime system sanity checks
In-Reply-To: <1403795926-17139-6-git-send-email-mark.rutland@arm.com>
References: <1403795926-17139-1-git-send-email-mark.rutland@arm.com>
 <1403795926-17139-6-git-send-email-mark.rutland@arm.com>
Message-ID: <53AC8296.808@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 06/26/2014 11:18 AM, Mark Rutland wrote:
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
> Where CPUs are fundamentally mismatched, set TAINT_CPU_OUT_OF_SPEC.
> Given that the kernel assumes CPUs are identical feature wise, let's not
> pretend that we expect such configurations to work. Supporting such
> configurations would require massive rework, and hopefully they will
> never exist.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> ---
>  arch/arm64/kernel/cpuinfo.c | 92 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 92 insertions(+)
> 
> diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c

> +	/* If different, timekeeping will be broken (especially with KVM) */
> +	diff |= CHECK(cntfrq, boot, cur, cpu);

You're calling this a "CPU feature" but I thought this was purely a firmware
setting. Does the architecture even allow hardware to program this register?
Additionally, in arch_timer_detect_rate it appears that a device tree setting
takes precedence, but you're not checking that.

> +	/*
> +	 * Mismatched CPU features are a recipe for disaster. Don't even
> +	 * pretend to support them.
> +	 */
> +	WARN_TAINT_ONCE(diff, TAINT_CPU_OUT_OF_SPEC,
> +			"Unsupported CPU feature variation.");
> +}

Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
