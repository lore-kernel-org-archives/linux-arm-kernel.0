From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 20 Mar 2017 14:58:03 +0000
Subject: [PATCH 15/17] arm64: arch_timer: Workaround for Cortex-A73
 erratum 858921
In-Reply-To: <20170306112622.13853-16-marc.zyngier@arm.com>
References: <20170306112622.13853-1-marc.zyngier@arm.com>
 <20170306112622.13853-16-marc.zyngier@arm.com>
Message-ID: <20170320145803.GI31213@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 06, 2017 at 11:26:20AM +0000, Marc Zyngier wrote:
> Cortex-A73 (all versions) counter read can return a wrong value
> when the counter crosses a 32bit boundary.
> 
> The workaround involves performing the read twice, and to return
> one or the other depending on whether a transition has taken place.
 
> +#ifdef CONFIG_ARM64_ERRATUM_858921
> +static u64 notrace arm64_858921_read_cntvct_el0(void)
> +{
> +	u64 _old, _new;
> +
> +	_old = read_sysreg(cntvct_el0);
> +	_new = read_sysreg(cntvct_el0);
> +	return (((_old ^ _new) >> 32) & 1) ? _old : _new;
> +}
> +#endif

Given this is a static inline, I think we can drop the underscores here.

Thanks,
Mark.
