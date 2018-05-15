From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 15 May 2018 15:16:58 +0100
Subject: [PATCH v2 16/40] arm64: mm: Pin down ASIDs for sharing mm with
 devices
In-Reply-To: <20180511190641.23008-17-jean-philippe.brucker@arm.com>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
 <20180511190641.23008-17-jean-philippe.brucker@arm.com>
Message-ID: <20180515141658.vivrgcyww2pxumye@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean-Philippe,

On Fri, May 11, 2018 at 08:06:17PM +0100, Jean-Philippe Brucker wrote:
> +unsigned long mm_context_get(struct mm_struct *mm)
> +{
> +	unsigned long flags;
> +	u64 asid;
> +
> +	raw_spin_lock_irqsave(&cpu_asid_lock, flags);
> +
> +	asid = atomic64_read(&mm->context.id);
> +
> +	if (mm->context.pinned) {
> +		mm->context.pinned++;
> +		asid &= ~ASID_MASK;
> +		goto out_unlock;
> +	}
> +
> +	if (nr_pinned_asids >= max_pinned_asids) {
> +		asid = 0;
> +		goto out_unlock;
> +	}
> +
> +	if (!asid_gen_match(asid)) {
> +		/*
> +		 * We went through one or more rollover since that ASID was
> +		 * used. Ensure that it is still valid, or generate a new one.
> +		 * The cpu argument isn't used by new_context.
> +		 */
> +		asid = new_context(mm, 0);
> +		atomic64_set(&mm->context.id, asid);
> +	}
> +
> +	asid &= ~ASID_MASK;
> +
> +	nr_pinned_asids++;
> +	__set_bit(asid2idx(asid), pinned_asid_map);
> +	mm->context.pinned++;
> +
> +out_unlock:
> +	raw_spin_unlock_irqrestore(&cpu_asid_lock, flags);
> +
> +	return asid;
> +}

With CONFIG_UNMAP_KERNEL_AT_EL0 (a.k.a. KPTI), the hardware ASID has bit
0 set automatically when entering user space (and cleared when getting
back to the kernel). If the returned asid value here is going to be used
as is in the calling code, you should probably set bit 0 when KPTI is
enabled.

-- 
Catalin
