From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 21 Apr 2017 10:25:26 +0100
Subject: [PATCH 2/3] bus: fsl-mc: dpio: enable qbman CENA portal memory
 access
In-Reply-To: <1492716858-24509-3-git-send-email-Haiying.Wang@nxp.com>
References: <1492716858-24509-1-git-send-email-Haiying.Wang@nxp.com>
 <1492716858-24509-3-git-send-email-Haiying.Wang@nxp.com>
Message-ID: <20170421092525.GB6406@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Apr 20, 2017 at 03:34:17PM -0400, Haiying Wang wrote:
> Once we enable the cacheable portal memory, we need to do
> cache flush for enqueue, vdq, buffer release, and management
> commands, as well as invalidate and prefetch for the valid bit
> of management command response and next index of dqrr.
> 
> Signed-off-by: Haiying Wang <Haiying.Wang@nxp.com>
> ---
>  drivers/staging/fsl-mc/bus/dpio/qbman-portal.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/fsl-mc/bus/dpio/qbman-portal.c b/drivers/staging/fsl-mc/bus/dpio/qbman-portal.c
> index 2a3ea29..e16121c 100644
> --- a/drivers/staging/fsl-mc/bus/dpio/qbman-portal.c
> +++ b/drivers/staging/fsl-mc/bus/dpio/qbman-portal.c
> @@ -99,6 +99,14 @@ enum qbman_sdqcr_fc {
>  	qbman_sdqcr_fc_up_to_3 = 1
>  };
>  
> +#define dccvac(p) { asm volatile("dc cvac, %0;" : : "r" (p) : "memory"); }
> +#define dcivac(p) { asm volatile("dc ivac, %0" : : "r"(p) : "memory"); }

Please don't place arm64-specific assembly in drivers, and use the APIs
the architecture provides. We have a suite of cache maintenance APIs,
and abstractions atop of those that make them easier to deal with.

This patch pushes the code further from being acceptable outside of
staging.


> +static inline void qbman_inval_prefetch(struct qbman_swp *p, uint32_t offset)
> +{
> +	dcivac(p->addr_cena + offset);
> +	prefetch(p->addr_cena + offset);
> +}

It doesn't make sense to me to clean+invalidate an arbitrary amount of
data, then prefetch an arbitrary amount. What exactly is this code
trying to do?

If this is intended to make data visible to a non-coherent observer, a
clean would be sufficient.

If this is intended to make data from a non-coherent master visible to
the CPUs, then an invalidate would be sufficient.

In either case, we *must* take the cache line size, and the size of the
data into account. If the same cache line is being modified by multiple
observers, this will corrupt the data in some cases.

Architecturally cache maintenance requires particular memory barriers,
which are missing here and/or in callers. At best, this works by chance.

The existing cache maintenance APIs handle this, and all you need to do
here is to ensure suitable alignment and padding. Please don't write
your own cache maintenance like this.

Thanks,
Mark.

> +
>  /* Portal Access */
>  
>  static inline u32 qbman_read_register(struct qbman_swp *p, u32 offset)
> @@ -189,7 +197,7 @@ struct qbman_swp *qbman_swp_init(const struct qbman_swp_desc *d)
>  	p->addr_cinh = d->cinh_bar;
>  
>  	reg = qbman_set_swp_cfg(p->dqrr.dqrr_size,
> -				1, /* Writes Non-cacheable */
> +				0, /* Writes cacheable */
>  				0, /* EQCR_CI stashing threshold */
>  				3, /* RPM: Valid bit mode, RCR in array mode */
>  				2, /* DCM: Discrete consumption ack mode */
> @@ -315,6 +323,7 @@ void qbman_swp_mc_submit(struct qbman_swp *p, void *cmd, u8 cmd_verb)
>  
>  	dma_wmb();
>  	*v = cmd_verb | p->mc.valid_bit;
> +	dccvac(cmd);
>  }
>  
>  /*
> @@ -325,6 +334,7 @@ void *qbman_swp_mc_result(struct qbman_swp *p)
>  {
>  	u32 *ret, verb;
>  
> +	qbman_inval_prefetch(p, QBMAN_CENA_SWP_RR(p->mc.valid_bit));
>  	ret = qbman_get_cmd(p, QBMAN_CENA_SWP_RR(p->mc.valid_bit));
>  
>  	/* Remove the valid-bit - command completed if the rest is non-zero */
> @@ -435,6 +445,7 @@ int qbman_swp_enqueue(struct qbman_swp *s, const struct qbman_eq_desc *d,
>  	/* Set the verb byte, have to substitute in the valid-bit */
>  	dma_wmb();
>  	p->verb = d->verb | EQAR_VB(eqar);
> +	dccvac(p);
>  
>  	return 0;
>  }
> @@ -627,6 +638,7 @@ int qbman_swp_pull(struct qbman_swp *s, struct qbman_pull_desc *d)
>  	/* Set the verb byte, have to substitute in the valid-bit */
>  	p->verb = d->verb | s->vdq.valid_bit;
>  	s->vdq.valid_bit ^= QB_VALID_BIT;
> +	dccvac(p);
>  
>  	return 0;
>  }
> @@ -680,8 +692,7 @@ const struct dpaa2_dq *qbman_swp_dqrr_next(struct qbman_swp *s)
>  				 s->dqrr.next_idx, pi);
>  			s->dqrr.reset_bug = 0;
>  		}
> -		prefetch(qbman_get_cmd(s,
> -				       QBMAN_CENA_SWP_DQRR(s->dqrr.next_idx)));
> +		qbman_inval_prefetch(s,	QBMAN_CENA_SWP_DQRR(s->dqrr.next_idx));
>  	}
>  
>  	p = qbman_get_cmd(s, QBMAN_CENA_SWP_DQRR(s->dqrr.next_idx));
> @@ -696,8 +707,7 @@ const struct dpaa2_dq *qbman_swp_dqrr_next(struct qbman_swp *s)
>  	 * knew from reading PI.
>  	 */
>  	if ((verb & QB_VALID_BIT) != s->dqrr.valid_bit) {
> -		prefetch(qbman_get_cmd(s,
> -				       QBMAN_CENA_SWP_DQRR(s->dqrr.next_idx)));
> +		qbman_inval_prefetch(s, QBMAN_CENA_SWP_DQRR(s->dqrr.next_idx));
>  		return NULL;
>  	}
>  	/*
> @@ -720,7 +730,7 @@ const struct dpaa2_dq *qbman_swp_dqrr_next(struct qbman_swp *s)
>  	    (flags & DPAA2_DQ_STAT_EXPIRED))
>  		atomic_inc(&s->vdq.available);
>  
> -	prefetch(qbman_get_cmd(s, QBMAN_CENA_SWP_DQRR(s->dqrr.next_idx)));
> +	qbman_inval_prefetch(s, QBMAN_CENA_SWP_DQRR(s->dqrr.next_idx));
>  
>  	return p;
>  }
> @@ -848,6 +858,7 @@ int qbman_swp_release(struct qbman_swp *s, const struct qbman_release_desc *d,
>  	 */
>  	dma_wmb();
>  	p->verb = d->verb | RAR_VB(rar) | num_buffers;
> +	dccvac(p);
>  
>  	return 0;
>  }
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
