From: m.smarduch@samsung.com (Mario Smarduch)
Date: Sun, 21 Jun 2015 20:17:22 -0700
Subject: [RESEND PATCH v2 2/2] arm: KVM: keep arm vfp/simd exit handling
 consistent with arm64
In-Reply-To: <1434739306-23417-1-git-send-email-m.smarduch@samsung.com>
References: <1434739306-23417-1-git-send-email-m.smarduch@samsung.com>
Message-ID: <55877E42.5070205@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/19/2015 11:41 AM, Mario Smarduch wrote:
[...]

>
>  
> -host_switch_to_hyp:
> +	/* Guest is calling a hyp function, save minimum context branch to it */ 

Hi Marc,
    please correct Guest to Host (or word this to your preference).
Somehow wondered off on Friday :)

Thanks,
- Mario

>  	pop	{r0, r1, r2}
>  
>  	/* Check for __hyp_get_vectors */
> @@ -411,6 +407,10 @@ guest_trap:
>  
>  	@ Check if we need the fault information
>  	lsr	r1, r1, #HSR_EC_SHIFT
> +#ifdef CONFIG_VFPv3
> +	cmp	r1, #HSR_EC_CP_0_13
> +	beq	switch_to_guest_vfp
> +#endif
>  	cmp	r1, #HSR_EC_IABT
>  	mrceq	p15, 4, r2, c6, c0, 2	@ HIFAR
>  	beq	2f
> 
