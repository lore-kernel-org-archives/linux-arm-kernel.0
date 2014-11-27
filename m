From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Nov 2014 10:35:08 +0000
Subject: [PATCH v4] arm: Support for the PXN CPU feature on ARMv7
In-Reply-To: <1417077724-15885-1-git-send-email-js07.lee@gmail.com>
References: <1417077724-15885-1-git-send-email-js07.lee@gmail.com>
Message-ID: <20141127103508.GN3836@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 27, 2014 at 05:42:04PM +0900, Jungseung Lee wrote:
> Modern ARMv7-A/R cores optionally implement below new
> hardware feature:
> 
> - PXN:
> Privileged execute-never(PXN) is a security feature. PXN bit
> determines whether the processor can execute software from
> the region. This is effective solution against ret2usr attack.
> On an implementation that does not include the LPAE, PXN is
> optionally supported.
> 
> This patch set PXN bit on user page table for preventing
> user code execution with privilege mode.

This looks fine to me, only one niggle:

> +	/*
> +	 * Check is it with support for the PXN bit
> +	 * in the Short-descriptor translation table format descriptors.
> +	 */
> +	if (cpu_arch == CPU_ARCH_ARMv7 &&
> +		(read_cpuid_ext(CPUID_EXT_MMFR0) & 0xF) == 4) {
> +		user_pmd_table |= PMD_PXNTABLE;
> +	}

Use spaces to indent the second line of the if() statement so that the
open paren aligns with the 'c' character of cpu_arch.

Using tabs within an if() expression is wrong from the readability point
of view as it makes it harder to see where the first statement if the
condition starts, and indenting to the appropriate point also helps
readability when there's multiple lines to the if() expression.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
