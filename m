From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 4 Oct 2018 10:19:54 -0700
Subject: [PATCH] ARM: KVM: Correctly order SGI register entries in the
 cp15 array
In-Reply-To: <20181004092946.59836-1-marc.zyngier@arm.com>
References: <20181004092946.59836-1-marc.zyngier@arm.com>
Message-ID: <1334e22d-a64b-9116-e8a5-448eacbecf45@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/04/2018 02:29 AM, Marc Zyngier wrote:
> The ICC_ASGI1R and ICC_SGI0R register entries in the cp15 array
> are not correctly ordered, leading to a BUG() at boot time.
> 
> Move them to their natural location.
> 
> Fixes: 3e8a8a50c7ef ("KVM: arm: vgic-v3: Add support for ICC_SGI0R and ICC_ASGI1R accesses")
> Reported-by: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
> Paolo, Radim,
> 
> Could you please send this patch directly to Greg so that it makes it
> into 4.19? I thought I had it fixed long before the merge window, and
> obviously didn't...

Thanks for the quick fix! I probably won't be able to test this until 8h
from now but this looks obviously correct.

> 
> Thanks,
> 
> 	M.
> 
>  arch/arm/kvm/coproc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/kvm/coproc.c b/arch/arm/kvm/coproc.c
> index 450c7a4fbc8a..cb094e55dc5f 100644
> --- a/arch/arm/kvm/coproc.c
> +++ b/arch/arm/kvm/coproc.c
> @@ -478,15 +478,15 @@ static const struct coproc_reg cp15_regs[] = {
>  
>  	/* ICC_SGI1R */
>  	{ CRm64(12), Op1( 0), is64, access_gic_sgi},
> -	/* ICC_ASGI1R */
> -	{ CRm64(12), Op1( 1), is64, access_gic_sgi},
> -	/* ICC_SGI0R */
> -	{ CRm64(12), Op1( 2), is64, access_gic_sgi},
>  
>  	/* VBAR: swapped by interrupt.S. */
>  	{ CRn(12), CRm( 0), Op1( 0), Op2( 0), is32,
>  			NULL, reset_val, c12_VBAR, 0x00000000 },
>  
> +	/* ICC_ASGI1R */
> +	{ CRm64(12), Op1( 1), is64, access_gic_sgi},
> +	/* ICC_SGI0R */
> +	{ CRm64(12), Op1( 2), is64, access_gic_sgi},
>  	/* ICC_SRE */
>  	{ CRn(12), CRm(12), Op1( 0), Op2(5), is32, access_gic_sre },
>  
> 


-- 
Florian
