From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 8 Oct 2015 16:54:04 +0100
Subject: [PATCH 2/5] irqchip/gic-v3: Make gic_enable_sre an inline function
In-Reply-To: <1443803874-9566-3-git-send-email-marc.zyngier@arm.com>
References: <1443803874-9566-1-git-send-email-marc.zyngier@arm.com>
 <1443803874-9566-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <20151008155404.GN17192@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 02, 2015 at 05:37:51PM +0100, Marc Zyngier wrote:
> +static inline bool gic_enable_sre(void)
> +{
> +	u64 val;
> +
> +	asm volatile("mrs_s %0, " __stringify(ICC_SRE_EL1) : "=r" (val));
> +	if (val & ICC_SRE_EL1_SRE)
> +		return true;
> +
> +	val |= ICC_SRE_EL1_SRE;
> +	asm volatile("msr_s " __stringify(ICC_SRE_EL1) ", %0" : : "r" (val));
> +	isb();
> +	asm volatile("mrs_s %0, " __stringify(ICC_SRE_EL1) : "=r" (val));
> +
> +	return !!(val & ICC_SRE_EL1_SRE);
> +}

I don't think !! is needed ;). Apparently, from ISO C99: "When any
scalar value is converted to _Bool, the result is 0 if the value
compares equal to 0; otherwise, the result is 1."

-- 
Catalin
