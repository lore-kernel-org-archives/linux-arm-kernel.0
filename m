From: bp@alien8.de (Borislav Petkov)
Date: Sun, 13 Aug 2017 15:08:36 +0200
Subject: [PATCH v2 5/6] edac: synopsys: Update ECC error message info
In-Reply-To: <b0fa5fc740ccbe8c13cec9886c6836df2e3042cd.1502091561.git.michal.simek@xilinx.com>
References: <91fd6532076e4c905b5a228d852bba4941c54a28.1502091561.git.michal.simek@xilinx.com>
 <b0fa5fc740ccbe8c13cec9886c6836df2e3042cd.1502091561.git.michal.simek@xilinx.com>
Message-ID: <20170813130836.GB24994@nazgul.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 07, 2017 at 09:39:27AM +0200, Michal Simek wrote:
> From: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
> 
> This patch updates the ECC error message info
> for zynqmp ddrc. added Block number and Bankgroup
> in the message info.
> 
> Signed-off-by: Naga Sureshkumar Relli <nagasure@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> Changes in v2:
> - s/ecc/ECC/ in commit message
> 
>  drivers/edac/synopsys_edac.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
> index 4cd9e3d8161c..24490334a4f2 100644
> --- a/drivers/edac/synopsys_edac.c
> +++ b/drivers/edac/synopsys_edac.c
> @@ -418,9 +418,17 @@ static void synps_edac_handle_error(struct mem_ctl_info *mci,
>  
>  	if (p->ce_cnt) {
>  		pinf = &p->ceinfo;
> -		snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
> -			 "DDR ECC error type :%s Row %d Bank %d Col %d ",
> -			 "CE", pinf->row, pinf->bank, pinf->col);
> +		if (priv->p_data->quirks == 0)

		if (!priv->...)

> +			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
> +				 "DDR ECC error type :%s Row %d Bank %d Col %d ",
> +				 "CE", pinf->row, pinf->bank, pinf->col);
> +		else
> +			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
> +				 "DDR ECC error type :%s Row %d Bank %d Col %d "
> +				 "BankGroup Number %d Block Number %d",
> +				 "CE", pinf->row, pinf->bank, pinf->col,
> +				 pinf->bankgrpnr, pinf->blknr);

> +
>  		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci,
>  				     p->ce_cnt, 0, 0, 0, 0, 0, -1,
>  				     priv->message, "");
> @@ -428,9 +436,16 @@ static void synps_edac_handle_error(struct mem_ctl_info *mci,
>  
>  	if (p->ue_cnt) {
>  		pinf = &p->ueinfo;
> -		snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
> -			 "DDR ECC error type :%s Row %d Bank %d Col %d ",
> -			 "UE", pinf->row, pinf->bank, pinf->col);
> +		if (priv->p_data->quirks == 0)

Ditto.

> +			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
> +				 "DDR ECC error type :%s Row %d Bank %d Col %d ",
> +				"UE", pinf->row, pinf->bank, pinf->col);
> +		else
> +			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
> +				 "DDR ECC error type :%s Row %d Bank %d Col %d "
> +				 "BankGroup Number %d Block Number %d",
> +				 "UE", pinf->row, pinf->bank, pinf->col,

WARNING: quoted string split across lines
#51: FILE: drivers/edac/synopsys_edac.c:428:
+                                "DDR ECC error type :%s Row %d Bank %d Col %d "
+                                "BankGroup Number %d Block Number %d",

WARNING: quoted string split across lines
#72: FILE: drivers/edac/synopsys_edac.c:446:
+                                "DDR ECC error type :%s Row %d Bank %d Col %d "
+                                "BankGroup Number %d Block Number %d",

And above too. Put strings on a single line for easier grepping.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
