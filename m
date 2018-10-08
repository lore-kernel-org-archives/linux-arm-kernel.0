From: MNARANI@xilinx.com (Manish Narani)
Date: Mon, 8 Oct 2018 13:45:28 +0000
Subject: [PATCH v8 02/10] edac: synopsys: Rename the static functions to a
 shorter name
In-Reply-To: <20181004203540.GD5149@zn.tnic>
References: <1538667328-9465-1-git-send-email-manish.narani@xilinx.com>
 <1538667328-9465-3-git-send-email-manish.narani@xilinx.com>
 <20181004203540.GD5149@zn.tnic>
Message-ID: <DM6PR02MB52274CC51BE196CF18C97834C1E60@DM6PR02MB5227.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

Thanks a lot for the review.

> -----Original Message-----
> From: Borislav Petkov [mailto:bp at alien8.de]
> Sent: Friday, October 5, 2018 2:06 AM
> Subject: Re: [PATCH v8 02/10] edac: synopsys: Rename the static functions to a
> shorter name
> 
> On Thu, Oct 04, 2018 at 09:05:20PM +0530, Manish Narani wrote:
> > Rename the static functions to a shorter name. Since this is Synopsys
> > EDAC driver, better to remove unnecessary 'synps_' prefix in function
> > names.
> >
> > Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> > ---
> >  drivers/edac/synopsys_edac.c | 56 ++++++++++++++++++++++-------------------
> ---
> >  1 file changed, 28 insertions(+), 28 deletions(-)
> 
> Ok, let's flip the roles - now you get to review what I've committed:

Okay. Few minor nits below. :)

> 
> ---
> From: Manish Narani <manish.narani@xilinx.com>
> Date: Thu, 4 Oct 2018 21:05:20 +0530
> Subject: [PATCH 1/2] EDAC, synopsys: Shorten static function names
> 
> Shorten static function names, remove the unnecessary 'synps_' prefix in
> function names.
> 
>  [ bp: Drop the "edac_" prefix too as that prefix is reserved for
>    EDAC core functions. ]
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> CC: Mauro Carvalho Chehab <mchehab@kernel.org>
> CC: Michal Simek <michal.simek@xilinx.com>
> CC: amit.kucheria at linaro.org
> CC: devicetree at vger.kernel.org
> CC: leoyang.li at nxp.com
> CC: linux-arm-kernel at lists.infradead.org
> CC: linux-edac <linux-edac@vger.kernel.org>
> CC: mark.rutland at arm.com
> CC: robh+dt at kernel.org
> CC: sudeep.holla at arm.com
> Link: http://lkml.kernel.org/r/1538667328-9465-3-git-send-email-
> manish.narani at xilinx.com
> ---
>  drivers/edac/synopsys_edac.c | 79 +++++++++++++++++-------------------
>  1 file changed, 38 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
> index 1936c73f1d15..fbaf33540ce3 100644
> --- a/drivers/edac/synopsys_edac.c
> +++ b/drivers/edac/synopsys_edac.c
> @@ -142,7 +142,7 @@ struct synps_edac_priv {
>  };
> 
>  /**
> - * synps_edac_geterror_info - Get the current ecc error info
> + * get_error_info - Get the current ecc error info
>   * @base:	Pointer to the base address of the ddr memory controller
>   * @p:		Pointer to the synopsys ecc status structure
>   *
> @@ -150,8 +150,7 @@ struct synps_edac_priv {
>   *
>   * Return: one if there is no error otherwise returns zero
>   */
> -static int synps_edac_geterror_info(void __iomem *base,
> -				    struct synps_ecc_status *p)
> +static int get_error_info(void __iomem *base, struct synps_ecc_status *p)
>  {
>  	u32 regval, clearval = 0;
> 
> @@ -196,14 +195,13 @@ static int synps_edac_geterror_info(void __iomem
> *base,
>  }
> 
>  /**
> - * synps_edac_handle_error - Handle controller error types CE and UE
> + * handle_error - Handle controller error types CE and UE
>   * @mci:	Pointer to the edac memory controller instance
>   * @p:		Pointer to the synopsys ecc status structure
>   *
> - * Handles the controller ECC correctable and un correctable error.
> + * Handles the controller ECC correctable and uncorrectable error.

Nit: This can be moved to Comments Correction patch

>   */
> -static void synps_edac_handle_error(struct mem_ctl_info *mci,
> -				    struct synps_ecc_status *p)
> +static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status
> *p)
>  {
>  	struct synps_edac_priv *priv = mci->pvt_info;
>  	struct ecc_error_info *pinf;
> @@ -232,30 +230,30 @@ static void synps_edac_handle_error(struct
> mem_ctl_info *mci,
>  }
> 
>  /**
> - * synps_edac_check - Check controller for ECC errors
> + * check_errors - Check controller for ECC errors
>   * @mci:	Pointer to the edac memory controller instance
>   *
>   * Used to check and post ECC errors. Called by the polling thread
>   */
> -static void synps_edac_check(struct mem_ctl_info *mci)
> +static void check_errors(struct mem_ctl_info *mci)
>  {
>  	struct synps_edac_priv *priv = mci->pvt_info;
>  	int status;
> 
> -	status = synps_edac_geterror_info(priv->baseaddr, &priv->stat);
> +	status = get_error_info(priv->baseaddr, &priv->stat);
>  	if (status)
>  		return;
> 
>  	priv->ce_cnt += priv->stat.ce_cnt;
>  	priv->ue_cnt += priv->stat.ue_cnt;
> -	synps_edac_handle_error(mci, &priv->stat);
> +	handle_error(mci, &priv->stat);
> 
>  	edac_dbg(3, "Total error count CE %d UE %d\n",
>  		 priv->ce_cnt, priv->ue_cnt);
>  }
> 
>  /**
> - * synps_edac_get_dtype - Return the controller memory width
> + * get_dtype - Return the controller memory width
>   * @base:	Pointer to the ddr memory controller base address
>   *
>   * Get the EDAC device type width appropriate for the current controller
> @@ -263,7 +261,7 @@ static void synps_edac_check(struct mem_ctl_info
> *mci)
>   *
>   * Return: a device type width enumeration.
>   */
> -static enum dev_type synps_edac_get_dtype(const void __iomem *base)
> +static enum dev_type get_dtype(const void __iomem *base)
>  {
>  	enum dev_type dt;
>  	u32 width;
> @@ -286,20 +284,20 @@ static enum dev_type synps_edac_get_dtype(const
> void __iomem *base)
>  }
> 
>  /**
> - * synps_edac_get_eccstate - Return the controller ecc enable/disable status
> - * @base:	Pointer to the ddr memory controller base address
> + * get_ecc_state - Return the controller ECC enable/disable status

Nit: ecc --> ECC correction can be moved to Comments correction patch. Minor. Can keep it here too. 

> + * @base:	Pointer to the DDR memory controller base address

Nit: This should be moved to Comments correction patch.

>   *
> - * Get the ECC enable/disable status for the controller
> + * Get the ECC enable/disable status for the controller.

Nit: This should be moved to Comments correction patch.

>   *
> - * Return: a ecc status boolean i.e true/false - enabled/disabled.
> + * Return: a ECC status boolean i.e true/false - enabled/disabled.

Nit: Can move to Comments correction patch.

>   */


Thanks,
Manish
