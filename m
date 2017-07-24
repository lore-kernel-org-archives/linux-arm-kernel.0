From: jack@suse.cz (Jan Kara)
Date: Mon, 24 Jul 2017 13:25:30 +0200
Subject: [PATCH v4 1/5] mm: add mkwrite param to vm_insert_mixed()
In-Reply-To: <20170721223956.29485-2-ross.zwisler@linux.intel.com>
References: <20170721223956.29485-1-ross.zwisler@linux.intel.com>
 <20170721223956.29485-2-ross.zwisler@linux.intel.com>
Message-ID: <20170724112530.GI652@quack2.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> @@ -1658,14 +1658,28 @@ static int insert_pfn(struct vm_area_struct *vma, unsigned long addr,
>  	if (!pte)
>  		goto out;
>  	retval = -EBUSY;
> -	if (!pte_none(*pte))
> -		goto out_unlock;
> +	if (!pte_none(*pte)) {
> +		if (mkwrite) {
> +			if (WARN_ON_ONCE(pte_pfn(*pte) != pfn_t_to_pfn(pfn)))

Is the WARN_ON_ONCE() really appropriate here? Your testcase with private
mappings has triggered this situation if I'm right...

Otherwise the patch looks good to me.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
