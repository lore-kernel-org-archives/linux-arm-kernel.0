From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 19 Mar 2014 20:41:41 -0700
Subject: [PATCH 2/5] ARM64: KVM: set and get of sys registers in BE case
In-Reply-To: <1392184643-6108-3-git-send-email-victor.kamensky@linaro.org>
References: <1392184643-6108-1-git-send-email-victor.kamensky@linaro.org>
 <1392184643-6108-3-git-send-email-victor.kamensky@linaro.org>
Message-ID: <20140320034141.GR1297@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 11, 2014 at 09:57:20PM -0800, Victor Kamensky wrote:
> This patch fixes issue of reading and writing V8 sys registers in
> BE case. It is similar to V7 "ARM: kvm one_reg coproc set and get
> BE fixes" patch.
> 
> It changes reg_from_user and reg_to_user functions to have strong
> typed 'u64 *val' argument. And it uses endian angnostic way to
> pick up righ word from '*val' in case when register size is 4 bytes.
> 
> Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
> ---
>  arch/arm64/kvm/sys_regs.c | 39 +++++++++++++++++++++++++++++++++------
>  1 file changed, 33 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 02e9d09..e7c3e24 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -701,18 +701,45 @@ static struct sys_reg_desc invariant_sys_regs[] = {
>  	  NULL, get_ctr_el0 },
>  };
>  
> -static int reg_from_user(void *val, const void __user *uaddr, u64 id)
> +static int reg_from_user(u64 *val, const void __user *uaddr, u64 id)
>  {
> -	/* This Just Works because we are little endian. */
> -	if (copy_from_user(val, uaddr, KVM_REG_SIZE(id)) != 0)
> +	unsigned long regsize = KVM_REG_SIZE(id);
> +	union {
> +		u32	word;
> +		u64	dword;
> +	} tmp = {0};
> +
> +	if (copy_from_user(&tmp, uaddr, regsize) != 0)
>  		return -EFAULT;
> +	switch (regsize) {
> +	case 4:
> +		*val = tmp.word;
> +		break;

This should never happen for arm64, right?  IIRC, we expose all system
registers, even the aarch32 ones, as 64-bit versions with padded zeros,
just like in the ARM ARM...

> +	case 8:
> +		*val = tmp.dword;
> +		break;
> +	}
>  	return 0;
>  }
>  
> -static int reg_to_user(void __user *uaddr, const void *val, u64 id)
> +static int reg_to_user(void __user *uaddr, const u64 *val, u64 id)
>  {
> -	/* This Just Works because we are little endian. */
> -	if (copy_to_user(uaddr, val, KVM_REG_SIZE(id)) != 0)
> +	unsigned long regsize = KVM_REG_SIZE(id);
> +	union {
> +		u32	word;
> +		u64	dword;
> +	} tmp;
> +
> +	switch (regsize) {
> +	case 4:
> +		tmp.word = *val;
> +		break;

same

> +	case 8:
> +		tmp.dword = *val;
> +		break;
> +	}
> +
> +	if (copy_to_user(uaddr, &tmp, regsize) != 0)
>  		return -EFAULT;
>  	return 0;
>  }
> -- 
> 1.8.1.4
> 

-- 
Christoffer
