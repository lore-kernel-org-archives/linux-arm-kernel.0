From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 13 Oct 2016 11:29:40 +0100
Subject: [PATCH] perf: xgene: Remove bogus IS_ERR() check
In-Reply-To: <1476290367-8092-1-git-send-email-ttnguyen@apm.com>
References: <1476290367-8092-1-git-send-email-ttnguyen@apm.com>
Message-ID: <20161013102939.GA22356@remoulade>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 12, 2016 at 09:39:27AM -0700, Tai Nguyen wrote:
> This patch fixes the warning issue with static checker.
> The bug is reported in [1]
> 
> [1] https://www.spinics.net/lists/arm-kernel/msg535957.html
> 
> Signed-off-by: Tai Nguyen <ttnguyen@apm.com>

Please put the problem description in the commit message:

  In acpi_get_pmu_hw_inf we pass the address of a local variable to IS_ERR(),
  which doesn't make sense, as the pointer must be a real, valid pointer. This
  doesn't cause a functional problem, as IS_ERR() will evaluate as false, but
  the check is bogus and causes static checkers to complain.

  Remove the bogus check.

Please also add a Reported-by for Dan.

The patch itself is fine, so with the above, you can add:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Please Cc Will Deacon when sending that, I expect that he will pick it up
(though perhaps not until rc1 given this is not a critical issue).

Thanks,
Mark.

> ---
>  drivers/perf/xgene_pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
> index c2ac764..a8ac4bc 100644
> --- a/drivers/perf/xgene_pmu.c
> +++ b/drivers/perf/xgene_pmu.c
> @@ -1011,7 +1011,7 @@ xgene_pmu_dev_ctx *acpi_get_pmu_hw_inf(struct xgene_pmu *xgene_pmu,
>  	rc = acpi_dev_get_resources(adev, &resource_list,
>  				    acpi_pmu_dev_add_resource, &res);
>  	acpi_dev_free_resource_list(&resource_list);
> -	if (rc < 0 || IS_ERR(&res)) {
> +	if (rc < 0) {
>  		dev_err(dev, "PMU type %d: No resource address found\n", type);
>  		goto err;
>  	}
> -- 
> 1.9.1
> 
