From: will.deacon@arm.com (Will Deacon)
Date: Wed, 16 Jul 2014 16:57:47 +0100
Subject: [PATCHv4 5/5] arm64: cpuinfo: print info for all CPUs
In-Reply-To: <1405524767-30220-6-git-send-email-mark.rutland@arm.com>
References: <1405524767-30220-1-git-send-email-mark.rutland@arm.com>
 <1405524767-30220-6-git-send-email-mark.rutland@arm.com>
Message-ID: <20140716155747.GR29414@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 16, 2014 at 04:32:47PM +0100, Mark Rutland wrote:
> The features are printed per-cpu to match the format used by other
> architectures, and are derived from the (globally uniform) hwcaps. In
> cases where this may report incorrect information, rework is required
> elsewhere to function with varying instruction set support, and the
> sanity checks should provide us with some advance notice (warnings and
> TAINT_CPU_OUT_OF_SPEC). If we're lucky, such systems will never exist.

[...]

> -	for_each_online_cpu(i) {
>  		/*
>  		 * glibc reads /proc/cpuinfo to determine the number of
>  		 * online processors, looking for lines beginning with
>  		 * "processor".  Give glibc what it expects.
>  		 */
>  #ifdef CONFIG_SMP
> -		seq_printf(m, "processor\t: %d\n", i);
> +		seq_printf(m, "processor\t: %d\n", c);
>  #endif
> +		seq_printf(m, "implementer\t: 0x%02x\n",
> +			   MIDR_IMPLEMENTOR(midr));
> +		seq_printf(m, "variant\t\t: 0x%x\n", MIDR_VARIANT(midr));
> +		seq_printf(m, "partnum\t\t: 0x%03x\n", MIDR_PARTNUM(midr));
> +		seq_printf(m, "revision\t: 0x%x\n", MIDR_REVISION(midr));
> +
> +		/* dump out the processor features */
> +		seq_puts(m, "features\t: ");
> +		for (i = 0; hwcap_str[i]; i++)
> +			if (elf_hwcap & (1 << i))
> +				seq_printf(m, "%s ", hwcap_str[i]);

I don't have hugely strong opinions about this, but I don't see why it's
useful to print exactly the same line out `n' times; once for each CPU. We
only pass one set of hwcaps to ELF executables via auxv, so why do we need
to duplicate things here?

Put another way, we're really treating the hwcaps as a system property
rather than a per-cpu property, so I think we should handle them as such.

Will
