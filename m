From: ynorov@caviumnetworks.com (Yury Norov)
Date: Tue, 26 Sep 2017 21:45:42 +0300
Subject: [PATCH] arm64: fix documentation on kernel pages mappings to HYP
 VA
In-Reply-To: <20170913180830.8608-1-ynorov@caviumnetworks.com>
References: <20170913180830.8608-1-ynorov@caviumnetworks.com>
Message-ID: <20170926184542.t56zpdx2s5et77gy@yury-thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ping?

On Wed, Sep 13, 2017 at 09:08:30PM +0300, Yury Norov wrote:
> The Documentation/arm64/memory.txt says:
> When using KVM, the hypervisor maps kernel pages in EL2, at a fixed
> offset from the kernel VA (top 24bits of the kernel VA set to zero):
> 
> In fact, kernel addresses are transleted to HYP with kern_hyp_va macro,
> which has more options, and none of them assumes clearing of top 24bits
> of the kernel VA.
> 
> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> ---
>  Documentation/arm64/memory.txt | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/arm64/memory.txt b/Documentation/arm64/memory.txt
> index d7273a5f6456..c39895d7e3a2 100644
> --- a/Documentation/arm64/memory.txt
> +++ b/Documentation/arm64/memory.txt
> @@ -86,9 +86,12 @@ Translation table lookup with 64KB pages:
>   +-------------------------------------------------> [63] TTBR0/1
>  
>  
> -When using KVM, the hypervisor maps kernel pages in EL2, at a fixed
> -offset from the kernel VA (top 24bits of the kernel VA set to zero):
> -
> -Start			End			Size		Use
> ------------------------------------------------------------------------
> -0000004000000000	0000007fffffffff	 256GB		kernel objects mapped in HYP
> +When using KVM without Virtualization Host Extensions, the hypervisor maps
> +kernel pages in EL2, at a fixed offset from the kernel VA. Namely, top 16
> +or 25 bits of the kernel VA set to zero depending on ARM64_VA_BITS_48 or
> +ARM64_VA_BITS_39 config option selected; or top 17 or 26 bits of the kernel
> +VA set to zero if CPU has Reduced HYP mapping offset capability. See
> +kern_hyp_va macro.
> +
> +When using KVM with Virtualization Host Extensions, no additional mappings
> +created as host kernel already operates in EL2.
> -- 
> 2.11.0
