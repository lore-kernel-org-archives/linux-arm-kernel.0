From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 15 Jan 2018 18:00:24 +0000
Subject: [PATCH 2/3] KVM: arm/arm64: fix HYP ID map extension to 52 bits
In-Reply-To: <1516029830-12326-3-git-send-email-kristina.martsenko@arm.com>
References: <1516029830-12326-1-git-send-email-kristina.martsenko@arm.com>
 <1516029830-12326-3-git-send-email-kristina.martsenko@arm.com>
Message-ID: <f22d9c0a-a719-3226-8f6b-47f5d2f0499d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/01/18 15:23, Kristina Martsenko wrote:
> Commit fa2a8445b1d3 incorrectly masks the index of the HYP ID map pgd
> entry, causing a non-VHE kernel to hang during boot. This happens when
> VA_BITS=48 and the ID map text is in 52-bit physical memory. In this
> case we don't need an extra table level but need more entries in the
> top-level table, so we need to map into hyp_pgd and need to use
> __kvm_idmap_ptrs_per_pgd to mask in the extra bits. However,
> __create_hyp_mappings currently masks by PTRS_PER_PGD instead.
> 
> Fix it so that we always use __kvm_idmap_ptrs_per_pgd for the HYP ID
> map. This ensures that we use the larger mask for the top-level ID map
> table when it has more entries. In all other cases, PTRS_PER_PGD is used
> as normal.
> 
> Fixes: fa2a8445b1d3 ("arm64: allow ID map to be extended to 52 bits")
> Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
