From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 15 Jan 2016 17:21:18 +0000
Subject: [PATCH v2 04/16] arm/xen: Use xen_xlate_map_ballooned_pages to
 setup grant table
In-Reply-To: <1452840929-19612-5-git-send-email-zhaoshenglong@huawei.com>
References: <1452840929-19612-1-git-send-email-zhaoshenglong@huawei.com>
 <1452840929-19612-5-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <alpine.DEB.2.02.1601151717460.16178@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 15 Jan 2016, Shannon Zhao wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> Use xen_xlate_map_ballooned_pages to setup grant table. Then it doesn't
> rely on DT or ACPI to pass the start address and size of grant table.
> 
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>

Acked-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>


>  arch/arm/xen/enlighten.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
> index afe6175..6d90a62 100644
> --- a/arch/arm/xen/enlighten.c
> +++ b/arch/arm/xen/enlighten.c
> @@ -266,18 +266,10 @@ static int __init xen_guest_init(void)
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
> @@ -312,7 +304,10 @@ static int __init xen_guest_init(void)
>  	if (xen_vcpu_info == NULL)
>  		return -ENOMEM;
>  
> -	if (gnttab_setup_auto_xlat_frames(grant_frames)) {
> +	xen_auto_xlat_grant_frames.count = gnttab_max_grant_frames();
> +	if (xen_xlate_map_ballooned_pages(&xen_auto_xlat_grant_frames.pfn,
> +					  &xen_auto_xlat_grant_frames.vaddr,
> +					  xen_auto_xlat_grant_frames.count)) {
>  		free_percpu(xen_vcpu_info);
>  		return -ENOMEM;
>  	}
> -- 
> 2.0.4
> 
> 
