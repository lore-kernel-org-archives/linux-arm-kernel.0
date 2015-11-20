From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 20 Nov 2015 16:19:42 +0000
Subject: [PATCH 03/13] arm/xen: Use xlated_setup_gnttab_pages to setup
 grant table
In-Reply-To: <1447754231-7772-4-git-send-email-shannon.zhao@linaro.org>
References: <1447754231-7772-1-git-send-email-shannon.zhao@linaro.org>
 <1447754231-7772-4-git-send-email-shannon.zhao@linaro.org>
Message-ID: <alpine.DEB.2.02.1511201618530.1107@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Nov 2015, shannon.zhao at linaro.org wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> Use xlated_setup_gnttab_pages to setup grant table. Then it doesn't rely
> on DT or ACPI to pass the start address and size of grant table.
> 
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>

It looks good. I'll wait for the final version of
xlated_setup_gnttab_pages before acking it, but it is fine in principle.


>  arch/arm/xen/enlighten.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
> index eeeab07..7cb82f7 100644
> --- a/arch/arm/xen/enlighten.c
> +++ b/arch/arm/xen/enlighten.c
> @@ -186,18 +186,10 @@ static int __init xen_guest_init(void)
>  {
>  	struct xen_add_to_physmap xatp;
>  	struct shared_info *shared_info_page = NULL;
> -	struct resource res;
> -	phys_addr_t grant_frames;
>  
>  	if (!xen_domain())
>  		return 0;
>  
> -	if (of_address_to_resource(xen_node, GRANT_TABLE_PHYSADDR, &res)) {
> -		pr_err("Xen grant table base address not found\n");
> -		return -ENODEV;
> -	}
> -	grant_frames = res.start;
> -
>  	xen_events_irq = irq_of_parse_and_map(xen_node, 0);
>  	if (!xen_events_irq) {
>  		pr_err("Xen event channel interrupt not found\n");
> @@ -232,7 +224,7 @@ static int __init xen_guest_init(void)
>  	if (xen_vcpu_info == NULL)
>  		return -ENOMEM;
>  
> -	if (gnttab_setup_auto_xlat_frames(grant_frames)) {
> +	if (xlated_setup_gnttab_pages()) {
>  		free_percpu(xen_vcpu_info);
>  		return -ENOMEM;
>  	}
> -- 
> 2.1.0
> 
