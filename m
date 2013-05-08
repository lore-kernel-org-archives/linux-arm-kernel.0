From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Wed, 8 May 2013 13:17:01 +0100
Subject: [PATCH 2/3] xen/arm: do not handle VCPUOP_register_vcpu_info
 failures
In-Reply-To: <1368015080-5182-2-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1305081303310.18865@kaball.uk.xensource.com>
 <1368015080-5182-2-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <1368015421.26321.263.camel@zakaz.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-05-08 at 13:11 +0100, Stefano Stabellini wrote:
> We expect VCPUOP_register_vcpu_info to succeed, do not try to handle
> failures.
> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> ---
>  arch/arm/xen/enlighten.c |   11 ++++-------
>  1 files changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
> index 83d13b0..519acf9 100644
> --- a/arch/arm/xen/enlighten.c
> +++ b/arch/arm/xen/enlighten.c
> @@ -165,13 +165,10 @@ static int __init xen_secondary_init(unsigned int cpu)
>  	info.offset = offset_in_page(vcpup);
>  
>  	err = HYPERVISOR_vcpu_op(VCPUOP_register_vcpu_info, cpu, &info);
> -	if (err) {
> -		pr_debug("register_vcpu_info failed: err=%d\n", err);
> -	} else {
> -		/* This cpu is using the registered vcpu info, even if
> -		   later ones fail to. */
> -		per_cpu(xen_vcpu, cpu) = vcpup;
> -	}
> +	if (err)
> +		BUG();

AKA BUG_ON(err);

Acked-by: Ian Campbell <ian.campbell@citrix.com>

> +	per_cpu(xen_vcpu, cpu) = vcpup;
> +
>  	return 0;
>  }
>  
