From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Nov 2011 15:31:02 +0000
Subject: [PATCH 2/5] ARM: vexpress: Remove platform SMP functions from
 ct_desc
In-Reply-To: <1321036026-23411-3-git-send-email-pawel.moll@arm.com>
References: <1321036026-23411-1-git-send-email-pawel.moll@arm.com>
 <1321036026-23411-3-git-send-email-pawel.moll@arm.com>
Message-ID: <20111117153102.GQ9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 11, 2011 at 06:27:03PM +0000, Pawel Moll wrote:
> This patch removes platform SMP callbacks from ct_desc struct
> and replaces them with global symbols in preparation for
> DT-based support code.

Will and myself discussed how to do this, and we came up with the
ct_desc solution.  Now you're doing something different.  It seems to
me like there's a disconnect between various different parts of ARM Ltd
between people who have different ideas about how problems are to be
solved.

So, what's the technical reason for this change?

I can't see how this improves anything.  In fact, this patch reintroduces
a bug which have been previously fixed:

> +static void ct_ca9x4_init_cpu_map(void)
> +{
> +	int i, ncores;
> +	ncores = scu_get_core_count(V2T_PERIPH_P2V(A9_MPCORE_SCU));
> +
> +	for (i = 0; i < ncores; ++i)
> +		set_cpu_possible(i, true);
> +
> +	set_smp_cross_call(gic_raise_softirq);
> +}
vs
> -static void ct_ca9x4_init_cpu_map(void)
> -{
> -	int i, ncores = scu_get_core_count(V2TILE_PERIPH_P2V(A9_MPCORE_SCU));
> -
> -	if (ncores > nr_cpu_ids) {
> -		pr_warn("SMP: %u cores greater than maximum (%u), clipping\n",
> -			ncores, nr_cpu_ids);
> -		ncores = nr_cpu_ids;
> -	}
> -
> -	for (i = 0; i < ncores; ++i)
> -		set_cpu_possible(i, true);
> -
> -	set_smp_cross_call(gic_raise_softirq);
> -}

When you rebase, please pay better attention to the conflicts.
