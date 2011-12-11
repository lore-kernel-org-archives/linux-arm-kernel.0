From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 11 Dec 2011 10:23:46 +0000
Subject: [PATCH 1/2] ARM: only look for TCM on ARM926 and later
In-Reply-To: <1323297616-22865-1-git-send-email-linus.walleij@linaro.org>
References: <1323297616-22865-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20111211102346.GS14542@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 07, 2011 at 11:40:16PM +0100, Linus Walleij wrote:
> +	u32 cpuid = read_cpuid_id();
...
> +	/*
> +	 * Prior to ARM926 there is no TCM, and trying to read the status
> +	 * register will hang the processor.
> +	 */
> +	if (((cpuid & 0x0008f000) == 0x00000000) &&
> +	    ((cpuid >> 4) < 0x926))
> +		return;

This doesn't look correct.  The CPU ID register for an ARM920T is
0x41X2920X, which will fail both the first and second tests.  The first
fails because of the 0x????9???, and the second fails because of the
non-zero vendor, revision and architecture IDs.

Also, what if the CPU is not an ARM CPU?  Part numbers are dependent
on the vendor field.

Maybe we want to change to a different approach - rule out all
architectures prior to ARMv5 (which will include ARM920T etc).  I think
it is a safe assumption to make that anything older than ARMv5 will not
have TCM.

	if (cpu_architecture() < CPU_ARCH_ARMv5)
		return;
