From: xiaoguangrong@linux.vnet.ibm.com (Xiao Guangrong)
Date: Thu, 05 Jun 2014 14:55:43 +0800
Subject: [RESEND PATCH v7 3/4] arm: dirty log write protect management
 support
In-Reply-To: <1401916278-24835-1-git-send-email-m.smarduch@samsung.com>
References: <1401916278-24835-1-git-send-email-m.smarduch@samsung.com>
Message-ID: <5390146F.8020407@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/05/2014 05:11 AM, Mario Smarduch wrote:

> +	spin_lock(&kvm->mmu_lock);
> +
> +	for (i = 0; i < n / sizeof(long); i++) {
> +		unsigned long mask;
> +		gfn_t offset;
> +
> +		if (!dirty_bitmap[i])
> +			continue;
> +
> +		is_dirty = true;
> +
> +		mask = xchg(&dirty_bitmap[i], 0);
> +		dirty_bitmap_buffer[i] = mask;
> +
> +		offset = i * BITS_PER_LONG;
> +		kvm_mmu_write_protect_pt_masked(kvm, memslot, offset, mask);
> +	}
> +	if (is_dirty)
> +		kvm_flush_remote_tlbs(kvm);

You moved the flush into mmu-lock. Please do not :).

See commit 198c74f43f0f5473f99967aead30ddc622804bc1
