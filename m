From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 3 Jan 2017 14:08:39 +0000
Subject: [PATCH v6 01/14] ACPI: ARM64: IORT: minor cleanup for
 iort_match_node_callback()
In-Reply-To: <1483363905-2806-2-git-send-email-hanjun.guo@linaro.org>
References: <1483363905-2806-1-git-send-email-hanjun.guo@linaro.org>
 <1483363905-2806-2-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20170103140839.GC7478@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 02, 2017 at 09:31:32PM +0800, Hanjun Guo wrote:
> Cleanup iort_match_node_callback() a little bit to reduce
> some lines of code, aslo fix the indentation in iort_scan_node().

s/aslo/also

"Also" in a commit log is a sign a patch should be split and that's what
you should do even though I know it is tempting to merge all trivial
changes into one single patch.

Make it two patches please.

Thanks,
Lorenzo

> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Tested-by: Majun <majun258@huawei.com>
> Tested-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Tomasz Nowicki <tn@semihalf.com>
> ---
>  drivers/acpi/arm64/iort.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index e0d2e6e..46e2d82 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -225,7 +225,7 @@ static struct acpi_iort_node *iort_scan_node(enum acpi_iort_node_type type,
>  
>  		if (iort_node->type == type &&
>  		    ACPI_SUCCESS(callback(iort_node, context)))
> -				return iort_node;
> +			return iort_node;
>  
>  		iort_node = ACPI_ADD_PTR(struct acpi_iort_node, iort_node,
>  					 iort_node->length);
> @@ -253,17 +253,15 @@ static acpi_status iort_match_node_callback(struct acpi_iort_node *node,
>  					    void *context)
>  {
>  	struct device *dev = context;
> -	acpi_status status;
> +	acpi_status status = AE_NOT_FOUND;
>  
>  	if (node->type == ACPI_IORT_NODE_NAMED_COMPONENT) {
>  		struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER, NULL };
>  		struct acpi_device *adev = to_acpi_device_node(dev->fwnode);
>  		struct acpi_iort_named_component *ncomp;
>  
> -		if (!adev) {
> -			status = AE_NOT_FOUND;
> +		if (!adev)
>  			goto out;
> -		}
>  
>  		status = acpi_get_name(adev->handle, ACPI_FULL_PATHNAME, &buf);
>  		if (ACPI_FAILURE(status)) {
> @@ -289,8 +287,6 @@ static acpi_status iort_match_node_callback(struct acpi_iort_node *node,
>  		 */
>  		status = pci_rc->pci_segment_number == pci_domain_nr(bus) ?
>  							AE_OK : AE_NOT_FOUND;
> -	} else {
> -		status = AE_NOT_FOUND;
>  	}
>  out:
>  	return status;
> -- 
> 1.9.1
> 
