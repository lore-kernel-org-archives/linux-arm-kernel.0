From: grant.likely@linaro.org (Grant Likely)
Date: Wed, 20 Aug 2014 10:14:37 -0500
Subject: [PATCH 07/19] ARM64 / ACPI: Parse MADT to map logical cpu to
 MPIDR and get cpu_possible/present_map
In-Reply-To: <1406206825-15590-8-git-send-email-hanjun.guo@linaro.org>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
 <1406206825-15590-8-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20140820151437.91964C41290@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 24 Jul 2014 21:00:13 +0800, Hanjun Guo <hanjun.guo@linaro.org> wrote:
> MADT contains the information for MPIDR which is essential for
> SMP initialization, parse the GIC cpu interface structures to
> get the MPIDR value and map it to cpu_logical_map(), and add
> enabled cpu with valid MPIDR into cpu_possible_map and
> cpu_present_map.
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> ---
> +	/* If it is the first CPU, no need to check duplicate MPIDRs */
> +	if (!enabled_cpus)
> +		goto skip_mpidr_check;
> +
> +	/*
> +	 * Duplicate MPIDRs are a recipe for disaster. Scan
> +	 * all initialized entries and check for
> +	 * duplicates. If any is found just ignore the CPU.
> +	 */
> +	for_each_present_cpu(cpu) {
> +		if (cpu_logical_map(cpu) == mpidr) {
> +			pr_err("Firmware bug, duplicate CPU MPIDR: 0x%llx in MADT\n",
> +			       mpidr);
> +			return -EINVAL;
> +		}
> +	}
> +
> +skip_mpidr_check:
> +	enabled_cpus++;

So, this hunk is embarrasing. The goto is completely unnecessary and the
whole for_each_present_cpu() block can be inside an
"if (enabled_cpus) { ... }" block. A goto is just nasty.

That said, is the if even necessary? Will for_each_present_cpu() iterate
over anything if it is processing the first cpu? (I don't actually know
the answer here, I did a quick look but not enough to get an
authoritative answer).

g.
