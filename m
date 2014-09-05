From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 05 Sep 2014 15:58:41 +0400
Subject: [PATCH 1/2] arm64: psci: respect MIGRATE_INFO_TYPE
In-Reply-To: <1409916139-20127-2-git-send-email-mark.rutland@arm.com>
References: <1409916139-20127-1-git-send-email-mark.rutland@arm.com>
 <1409916139-20127-2-git-send-email-mark.rutland@arm.com>
Message-ID: <5409A571.8060502@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 9/5/2014 3:22 PM, Mark Rutland wrote:

> Commit e71246a23acb (PSCI: Add initial support for PSCIv0.2 functions)
> added hooks for MIGRATE_INFO_TYPE, but didn't call it anywhere. This
> means that currently a UP Trusted OS can reject CPU_OFF calls, which
> will cause things to blow up.

> This patch ensures we test MIGRATE_INFO_TYPE before calling CPU_OFF. If
> there's a UP trusted OS hotplug is rejected. Full support for PSCI in
> the presence of a UP trusted OS will require the use of MIGRATE and will
> have to come as a later patch.

> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> Cc: Ian Campbell <ian.campbell@citrix.com>
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> ---
>   arch/arm64/kernel/psci.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)

> diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
> index 5539547..a5407af 100644
> --- a/arch/arm64/kernel/psci.c
> +++ b/arch/arm64/kernel/psci.c
> @@ -386,6 +386,20 @@ static int cpu_psci_cpu_disable(unsigned int cpu)
>   	/* Fail early if we don't have CPU_OFF support */
>   	if (!psci_ops.cpu_off)
>   		return -EOPNOTSUPP;
> +
> +	/*
> +	 * In the presence of a UP trusted OS, it might not be possible to
> +	 * hotplug certain CPUs, and CPU_OFF may return (which would be bad).
> +	 * Supporting a UP trusted OS requires careful use of
> +	 * MIGRATE_INFO_UP_CPU and MIGRATE, so for now fail in the presence of
> +	 * a UP Trusted OS.
> +	 */
> +	if (psci_ops.migrate_info_type &&
> +		psci_ops.migrate_info_type() != PSCI_0_2_TOS_MP) {
> +			pr_warn("Unable to handle UP trusted OS\n");
> +			return -EPERM;

    The above 2 lines are indented too much to the right.

> +	}
> +

WNR, Sergei
