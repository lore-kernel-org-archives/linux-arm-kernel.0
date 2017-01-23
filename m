From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 23 Jan 2017 22:08:59 +0100
Subject: [PATCH 2/2] arm64: kvm: upgrade csselr and ccsidr to 64-bit values
In-Reply-To: <1484909410-11673-2-git-send-email-sudeep.holla@arm.com>
References: <1484909410-11673-1-git-send-email-sudeep.holla@arm.com>
 <1484909410-11673-2-git-send-email-sudeep.holla@arm.com>
Message-ID: <20170123210859.GJ15850@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2017 at 10:50:10AM +0000, Sudeep Holla wrote:
> csselr and ccsidr are treated as 64-bit values already elsewhere in the
> kernel. It also aligns well with the architecture extensions that allow
> 64-bit format for ccsidr.
> 
> This patch upgrades the existing accesses to csselr and ccsidr from
> 32-bit to 64-bit in preparation to add support to those extensions.
> 
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  arch/arm64/kvm/sys_regs.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 5dca1f10340f..a3559a8a2b0c 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -58,15 +58,15 @@
>   */
>  
>  /* 3 bits per cache level, as per CLIDR, but non-existent caches always 0 */
> -static u32 cache_levels;
> +static u64 cache_levels;
>  
>  /* CSSELR values; used to index KVM_REG_ARM_DEMUX_ID_CCSIDR */
>  #define CSSELR_MAX 	((MAX_CACHE_LEVEL - 1) >> 1)
>  
>  /* Which cache CCSIDR represents depends on CSSELR value. */
> -static u32 get_ccsidr(u32 csselr)
> +static u64 get_ccsidr(u64 csselr)
>  {
> -	u32 ccsidr;
> +	u64 ccsidr;
>  
>  	/* Make sure noone else changes CSSELR during this! */
>  	local_irq_disable();
> @@ -1952,9 +1952,9 @@ static int set_invariant_sys_reg(u64 id, void __user *uaddr)
>  	return 0;
>  }
>  
> -static bool is_valid_cache(u32 val)
> +static bool is_valid_cache(u64 val)
>  {
> -	u32 level, ctype;
> +	u64 level, ctype;
>  
>  	if (val >= CSSELR_MAX)
>  		return false;
> @@ -1979,8 +1979,8 @@ static bool is_valid_cache(u32 val)
>  
>  static int demux_c15_get(u64 id, void __user *uaddr)
>  {
> -	u32 val;
> -	u32 __user *uval = uaddr;
> +	u64 val;
> +	u64 __user *uval = uaddr;
>  
>  	/* Fail if we have unknown bits set. */
>  	if (id & ~(KVM_REG_ARCH_MASK|KVM_REG_SIZE_MASK|KVM_REG_ARM_COPROC_MASK
> @@ -2004,8 +2004,8 @@ static int demux_c15_get(u64 id, void __user *uaddr)
>  
>  static int demux_c15_set(u64 id, void __user *uaddr)
>  {
> -	u32 val, newval;
> -	u32 __user *uval = uaddr;
> +	u64 val, newval;
> +	u64 __user *uval = uaddr;

Doesn't converting these uval pointers to u64 cause us to break the ABI
as we'll now be reading/writing 64-bit values to userspace with the
get_user and put_user following the declarations?

>  
>  	/* Fail if we have unknown bits set. */
>  	if (id & ~(KVM_REG_ARCH_MASK|KVM_REG_SIZE_MASK|KVM_REG_ARM_COPROC_MASK
> -- 
> 2.7.4
> 

Thanks,
-Christoffer
