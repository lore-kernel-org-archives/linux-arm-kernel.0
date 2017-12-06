From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 6 Dec 2017 14:11:39 +0000
Subject: [PATCH v3 16/20] arm64: entry: Add fake CPU feature for
 unmapping the kernel at EL0
In-Reply-To: <1512563739-25239-17-git-send-email-will.deacon@arm.com>
References: <1512563739-25239-1-git-send-email-will.deacon@arm.com>
 <1512563739-25239-17-git-send-email-will.deacon@arm.com>
Message-ID: <20171206141138.33mw3tmhwfuh6x3y@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 06, 2017 at 12:35:35PM +0000, Will Deacon wrote:
> +static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
> +				int __unused)
> +{
> +	/* Forced on command line? */
> +	if (__kpti_forced) {
> +		pr_info("kernel page table isolation forced %s by command line option\n",
> +			__kpti_forced > 0 ? "ON" : "OFF");
> +		return __kpti_forced > 0;
> +	}

I think we want this to be a pr_info_once() so that we don't print this
for late-onlined secondaries due to verify_local_cpu_features().

With that changed:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
