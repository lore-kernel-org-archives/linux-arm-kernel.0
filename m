From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 14 Jun 2013 09:47:32 +0100
Subject: [PATCH] arm: pj4: check cpu id for pj4 cp0 access
In-Reply-To: <1371199336-28027-1-git-send-email-chao.xie@marvell.com>
References: <1371199336-28027-1-git-send-email-chao.xie@marvell.com>
Message-ID: <20130614084732.GL18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 14, 2013 at 04:42:16AM -0400, Chao Xie wrote:
> @@ -79,6 +82,15 @@ static void __init pj4_cp_access_write(u32 value)
>  static int __init pj4_cp0_init(void)
>  {
>  	u32 cp_access;
> +	u32 cpuid;
> +
> +	__asm__ __volatile__ (
> +		"mrc	p15, 0, %0, c0, c0\n\t"
> +		: "=r" (cpuid));
> +
> +	/* If it is not a pj4 core, skip it. */
> +	if ((cpuid & CORE_PJ4_MASK) != CORE_PJ4_ID)
> +		return 0;

We have a macro for reading the CPU ID, see asm/cputype.h
