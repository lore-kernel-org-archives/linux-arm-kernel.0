From: kgunda@codeaurora.org (kgunda at codeaurora.org)
Date: Wed, 28 Jun 2017 12:28:50 +0530
Subject: [PATCH] spmi: pmic-arb: Always allocate ppid_to_apid table
In-Reply-To: <20170627021746.22445-1-sboyd@codeaurora.org>
References: <20170627021746.22445-1-sboyd@codeaurora.org>
Message-ID: <50b43f2e54cb0b2260a249ed07fe21ce@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-06-27 07:47, Stephen Boyd wrote:
> After commit 7f1d4e58dabb ("spmi: pmic-arb: optimize table
> lookups") we always need the ppid_to_apid table regardless of the
> version of pmic arbiter we have. Otherwise, we will try to deref
> the array when we don't allocate it on v2 hardware like the
> msm8974 SoCs.
> 
> Cc: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
> Cc: Kiran Gunda <kgunda@codeaurora.org>
> Fixes: 7f1d4e58dabb ("spmi: pmic-arb: optimize table lookups")
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Reviewed-by: Kiran Gunda <kgunda@codeaurora.org>
> ---
>  drivers/spmi/spmi-pmic-arb.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/spmi/spmi-pmic-arb.c 
> b/drivers/spmi/spmi-pmic-arb.c
> index 2afe3597982e..f4b7a98a7913 100644
> --- a/drivers/spmi/spmi-pmic-arb.c
> +++ b/drivers/spmi/spmi-pmic-arb.c
> @@ -134,7 +134,6 @@ struct apid_data {
>   * @spmic:		SPMI controller object
>   * @ver_ops:		version dependent operations.
>   * @ppid_to_apid	in-memory copy of PPID -> channel (APID) mapping 
> table.
> - *			v2 only.
>   */
>  struct spmi_pmic_arb {
>  	void __iomem		*rd_base;
> @@ -1016,6 +1015,13 @@ static int spmi_pmic_arb_probe(struct
> platform_device *pdev)
>  		goto err_put_ctrl;
>  	}
> 
> +	pa->ppid_to_apid = devm_kcalloc(&ctrl->dev, PMIC_ARB_MAX_PPID,
> +					sizeof(*pa->ppid_to_apid), GFP_KERNEL);
> +	if (!pa->ppid_to_apid) {
> +		err = -ENOMEM;
> +		goto err_put_ctrl;
> +	}
> +
>  	hw_ver = readl_relaxed(core + PMIC_ARB_VERSION);
> 
>  	if (hw_ver < PMIC_ARB_VERSION_V2_MIN) {
> @@ -1048,15 +1054,6 @@ static int spmi_pmic_arb_probe(struct
> platform_device *pdev)
>  			err = PTR_ERR(pa->wr_base);
>  			goto err_put_ctrl;
>  		}
> -
> -		pa->ppid_to_apid = devm_kcalloc(&ctrl->dev,
> -						PMIC_ARB_MAX_PPID,
> -						sizeof(*pa->ppid_to_apid),
> -						GFP_KERNEL);
> -		if (!pa->ppid_to_apid) {
> -			err = -ENOMEM;
> -			goto err_put_ctrl;
> -		}
>  	}
> 
>  	dev_info(&ctrl->dev, "PMIC arbiter version %s (0x%x)\n",
Thanks for the fix !
