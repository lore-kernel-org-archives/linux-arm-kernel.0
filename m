From: aneesh.kumar@linux.vnet.ibm.com (Aneesh Kumar K.V)
Date: Tue, 15 Nov 2016 11:31:06 +0530
Subject: [PATCH v2 4/6] mm: mempolicy: intruduce a helper huge_nodemask()
In-Reply-To: <1479107259-2011-5-git-send-email-shijie.huang@arm.com>
References: <1479107259-2011-1-git-send-email-shijie.huang@arm.com>
 <1479107259-2011-5-git-send-email-shijie.huang@arm.com>
Message-ID: <87oa1hb7tp.fsf@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Huang Shijie <shijie.huang@arm.com> writes:

> This patch intruduces a new helper huge_nodemask(),
> we can use it to get the node mask.
>
> This idea of the function is from the huge_zonelist().
>
> Signed-off-by: Huang Shijie <shijie.huang@arm.com>
> ---
>  include/linux/mempolicy.h |  8 ++++++++
>  mm/mempolicy.c            | 20 ++++++++++++++++++++
>  2 files changed, 28 insertions(+)
>
> diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
> index 5e5b296..01173c6 100644
> --- a/include/linux/mempolicy.h
> +++ b/include/linux/mempolicy.h
> @@ -145,6 +145,8 @@ extern void mpol_rebind_task(struct task_struct *tsk, const nodemask_t *new,
>  				enum mpol_rebind_step step);
>  extern void mpol_rebind_mm(struct mm_struct *mm, nodemask_t *new);
>
> +extern nodemask_t *huge_nodemask(struct vm_area_struct *vma,
> +				unsigned long addr);
>  extern struct zonelist *huge_zonelist(struct vm_area_struct *vma,
>  				unsigned long addr, gfp_t gfp_flags,
>  				struct mempolicy **mpol, nodemask_t **nodemask);
> @@ -261,6 +263,12 @@ static inline void mpol_rebind_mm(struct mm_struct *mm, nodemask_t *new)
>  {
>  }
>
> +static inline nodemask_t *huge_nodemask(struct vm_area_struct *vma,
> +				unsigned long addr)
> +{
> +	return NULL;
> +}
> +
>  static inline struct zonelist *huge_zonelist(struct vm_area_struct *vma,
>  				unsigned long addr, gfp_t gfp_flags,
>  				struct mempolicy **mpol, nodemask_t **nodemask)
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 6d3639e..4830dd6 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1800,6 +1800,26 @@ static inline unsigned interleave_nid(struct mempolicy *pol,
>
>  #ifdef CONFIG_HUGETLBFS
>  /*
> + * huge_nodemask(@vma, @addr)
> + * @vma: virtual memory area whose policy is sought
> + * @addr: address in @vma for shared policy lookup and interleave policy
> + *
> + * If the effective policy is BIND, returns a pointer to the mempolicy's
> + * @nodemask.
> + */
> +nodemask_t *huge_nodemask(struct vm_area_struct *vma, unsigned long addr)
> +{
> +	nodemask_t *nodes_mask = NULL;
> +	struct mempolicy *mpol = get_vma_policy(vma, addr);
> +
> +	if (mpol->mode == MPOL_BIND)
> +		nodes_mask = &mpol->v.nodes;
> +	mpol_cond_put(mpol);

What if it is MPOL_PREFERED or MPOL_INTERLEAVE ? we don't honor node
mask in that case ?


> +
> +	return nodes_mask;
> +}
> +
> +/*
>   * huge_zonelist(@vma, @addr, @gfp_flags, @mpol)
>   * @vma: virtual memory area whose policy is sought
>   * @addr: address in @vma for shared policy lookup and interleave policy
> -- 
> 2.5.5
