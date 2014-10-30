From: julien.grall@linaro.org (Julien Grall)
Date: Thu, 30 Oct 2014 23:09:16 +0000
Subject: [PATCH] ARM: decompressor: ensure I-side picks up relocated code
In-Reply-To: <1414688066-11043-1-git-send-email-will.deacon@arm.com>
References: <1414688066-11043-1-git-send-email-will.deacon@arm.com>
Message-ID: <5452C51C.1090205@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 30/10/2014 16:54, Will Deacon wrote:
> To speed up decompression, the decompressor sets up a flat, cacheable
> mapping of memory. However, when there is insufficient space to hold
> the page tables for this mapping, we don't bother to enable the caches
> and subsequently skip all the cache maintenance hooks.
>
> Skipping the cache maintenance before jumping to the relocated code
> allows the processor to predict the branch and populate the I-cache
> with stale data before the relocation loop has completed (since a
> bootloader may have SCTLR.I set, which permits normal, cacheable
> instruction fetches regardless of SCTLR.M).
>
> This patch moves the cache maintenance check into the maintenance
> routines themselves, allowing the v6/v7 versions to invalidate the
> I-cache regardless of the MMU state.
>
> Cc: Julien Grall <julien.grall@linaro.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>
> This fixes boot on my TC2 w/ multi_v7_defconfig. Julien was also
> reporting decompressor failures with a Xen payload, so hopefully this
> helps him too. If so, this is probably a candidate for stable.

With this patch, I'm able to boot a multi_v7_defconfig guest on Xen.
It might also fix some issue that Christoffer Dall saw on KVM.

Tested-by: Julien Grall <julien.grall@linaro.org>

Regards,

-- 
Julien Grall
