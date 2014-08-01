From: david.vrabel@citrix.com (David Vrabel)
Date: Fri, 1 Aug 2014 16:17:49 +0100
Subject: [PATCH v3 1/3] xen/arm: introduce XENFEAT_grant_map_identity
In-Reply-To: <1406904984-16068-1-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1408011552460.2293@kaball.uk.xensource.com>
 <1406904984-16068-1-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <53DBAF9C.6080702@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
>  arch/arm/xen/enlighten.c         |    6 ++++++
>  include/xen/interface/features.h |    3 +++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
> index b96723e..eef324f 100644
> --- a/arch/arm/xen/enlighten.c
> +++ b/arch/arm/xen/enlighten.c
> @@ -262,6 +262,12 @@ static int __init xen_guest_init(void)
>  	xen_domain_type = XEN_HVM_DOMAIN;
>  
>  	xen_setup_features();
> +
> +	if (!xen_feature(XENFEAT_grant_map_identity)) {
> +		pr_warn("Please upgrade your Xen.\n"
> +				"If your platform has any non-coherent DMA devices, they won't work properly.\n");

I think:

"Non-coherent DMA devices require a hypervisor with
 XENFEAT_grant_map_identity"

Is a more helpful message.

David
