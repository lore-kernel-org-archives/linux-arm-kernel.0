From: sboyd@kernel.org (Stephen Boyd)
Date: Sun, 08 Jul 2018 22:31:33 -0700
Subject: [PATCH v9 05/10] firmware: xilinx: Add clock APIs
In-Reply-To: <1529516435-7315-6-git-send-email-jollys@xilinx.com>
References: <1529516435-7315-1-git-send-email-jollys@xilinx.com>
 <1529516435-7315-6-git-send-email-jollys@xilinx.com>
Message-ID: <153111429376.143105.16639313603352498865@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Jolly Shah (2018-06-20 10:40:30)
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index 86d9bb8..c764d6e 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -269,14 +269,196 @@ static int zynqmp_pm_ioctl(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2,
>   */
>  static int zynqmp_pm_query_data(struct zynqmp_pm_query_data qdata, u32 *out)
>  {
> -       return zynqmp_pm_invoke_fn(PM_QUERY_DATA, qdata.qid, qdata.arg1,
> -                                  qdata.arg2, qdata.arg3, out);
> +       int ret;
> +
> +       ret = zynqmp_pm_invoke_fn(PM_QUERY_DATA, qdata.qid, qdata.arg1,
> +                                 qdata.arg2, qdata.arg3, out);
> +
> +       /*
> +        * For clock name query, all bytes in SMC response are clock name
> +        * characters and return code is always success. For invalid clocks,
> +        * clock name bytes would be 0s.

write the word 'zeroes' or 'zeros' please.

> +        */
> +       return qdata.qid == PM_QID_CLOCK_GET_NAME ? 0 : ret;
> +}
> +
[...]
> +
> +/**
> + * zynqmp_pm_clock_setrate() - Set the clock rate for given id
> + * @clock_id:  ID of the clock
> + * @rate:      rate value in hz
> + *
> + * This function is used by master to set rate for any clock.
> + *
> + * Return: Returns status, either success or error+reason
> + */
> +static int zynqmp_pm_clock_setrate(u32 clock_id, u64 rate)
> +{
> +       return zynqmp_pm_invoke_fn(PM_CLOCK_SETRATE, clock_id,
> +                                  rate & 0xFFFFFFFF,
> +                                  (rate >> 32) & 0xFFFFFFFF,

Use upper_32_bits() and lower_32_bits().

> +                                  0, NULL);
> +}
> +
