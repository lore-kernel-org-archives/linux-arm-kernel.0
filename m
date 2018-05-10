From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 10 May 2018 15:12:18 +0100
Subject: [PATCH v6 04/11] firmware: xilinx: Add query data API
In-Reply-To: <1523389127-14243-5-git-send-email-jollys@xilinx.com>
References: <1523389127-14243-1-git-send-email-jollys@xilinx.com>
 <1523389127-14243-5-git-send-email-jollys@xilinx.com>
Message-ID: <85f8f8c5-a177-dad8-e095-a9dd1c513e8d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/04/18 20:38, Jolly Shah wrote:
> From: Rajan Vaja <rajanv@xilinx.com>
> 
> Add ZynqMP firmware query data API to query platform
> specific information(clocks, pins) from firmware.
> 
> Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
> Signed-off-by: Jolly Shah <jollys@xilinx.com>
> ---
>  drivers/firmware/xilinx/zynqmp.c     | 14 ++++++++++++++
>  include/linux/firmware/xlnx-zynqmp.h | 20 ++++++++++++++++++++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index 44b43fa..ef09c44 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -258,9 +258,23 @@ static int zynqmp_pm_ioctl(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2,
>  				   arg1, arg2, out);
>  }
>  
> +/**
> + * zynqmp_pm_query_data() - Get query data from firmware
> + * @qdata:	Variable to the zynqmp_pm_query_data structure
> + * @out:	Returned output value
> + *
> + * Return: Returns status, either success or error+reason
> + */
> +static int zynqmp_pm_query_data(struct zynqmp_pm_query_data qdata, u32 *out)
> +{
> +	return zynqmp_pm_invoke_fn(PM_QUERY_DATA, qdata.qid, qdata.arg1,
> +				   qdata.arg2, qdata.arg3, out);
> +}
> +
>  static const struct zynqmp_eemi_ops eemi_ops = {
>  	.get_api_version = zynqmp_pm_get_api_version,
>  	.ioctl = zynqmp_pm_ioctl,
> +	.query_data = zynqmp_pm_query_data,

Can you give more insight into this ? How will be this used ?
How this aligns with data we get from DT ? I am just trying to
understand how is this information split between this API and DT for
example.

-- 
Regards,
Sudeep
