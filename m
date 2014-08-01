From: julien.grall@linaro.org (Julien Grall)
Date: Fri, 01 Aug 2014 17:53:39 +0100
Subject: [Xen-devel] [PATCH v3 1/3] xen/arm: introduce
 XENFEAT_grant_map_identity
In-Reply-To: <1406904984-16068-1-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1408011552460.2293@kaball.uk.xensource.com>
 <1406904984-16068-1-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <53DBC613.4070506@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefano,

On 01/08/14 15:56, Stefano Stabellini wrote:
> The flag tells us that the hypervisor maps a grant page to guest
> physical address == machine address of the page in addition to the
> normal grant mapping address. It is needed to properly issue cache
> maintenance operation at the completion of a DMA operation involving a
> foreign grant.
>
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> Tested-by: Denis Schneider <v1ne2go@gmail.com>
>
> ---
> Changes in v3:
> - rename XENFEAT_grant_map_11 to XENFEAT_grant_map_identity.
> ---
>   arch/arm/xen/enlighten.c         |    6 ++++++
>   include/xen/interface/features.h |    3 +++
>   2 files changed, 9 insertions(+)
>
> diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
> index b96723e..eef324f 100644
> --- a/arch/arm/xen/enlighten.c
> +++ b/arch/arm/xen/enlighten.c
> @@ -262,6 +262,12 @@ static int __init xen_guest_init(void)
>   	xen_domain_type = XEN_HVM_DOMAIN;
>
>   	xen_setup_features();
> +
> +	if (!xen_feature(XENFEAT_grant_map_identity)) {
> +		pr_warn("Please upgrade your Xen.\n"
> +				"If your platform has any non-coherent DMA devices, they won't work properly.\n");
> +	}

I know we talked about this on a previous thread but I can't find it in 
my mail :/

Does a Linux with this series will work on Xen 4.4? If not what's the plan?

I think we have to keep any OS working on top on Xen 4.4 as people may 
want to retrieve the latest kernel for drivers bug fixes...

For running a previous kernel on Xen 4.5, then it will still be buggy. 
It might be worse to backport thise series on LTS kernel (i.e at least 
3.14).

Regards,

-- 
Julien Grall
