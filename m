From: olof@lixom.net (Olof Johansson)
Date: Wed, 26 Sep 2018 13:48:41 -0700
Subject: [PATCH v3 2/4] firmware: xilinx: Add zynqmp IOCTL API for device
 control
In-Reply-To: <1537985581-32164-3-git-send-email-jollys@xilinx.com>
References: <1537985581-32164-1-git-send-email-jollys@xilinx.com>
 <1537985581-32164-3-git-send-email-jollys@xilinx.com>
Message-ID: <CAOesGMhEcMB4caAPtCSq-m5zQBDc-8Z4f_xAkomnEwVaHyX2Mw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Just nits on code readability below. Approach looks OK to me.

On Wed, Sep 26, 2018 at 11:13 AM Jolly Shah <jolly.shah@xilinx.com> wrote:
>
> From: Rajan Vaja <rajan.vaja@xilinx.com>
>
> Add ZynqMP firmware IOCTL API to control and configure
> devices like PLLs, SD, Gem, etc.
>
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> Signed-off-by: Jolly Shah <jollys@xilinx.com>
> ---
>  drivers/firmware/xilinx/zynqmp.c     | 43 ++++++++++++++++++++++++++++++++++++
>  include/linux/firmware/xlnx-zynqmp.h |  4 +++-
>  2 files changed, 46 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index 84b3fd2..671a37a 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -428,6 +428,48 @@ static int zynqmp_pm_clock_getparent(u32 clock_id, u32 *parent_id)
>         return ret;
>  }
>
> +/**
> + * zynqmp_is_valid_ioctl() - Check whether IOCTL ID is valid or not
> + * @ioctl_id:  IOCTL ID
> + *
> + * Return: 0 if IOCTL is valid, else -EINVAL
> + */
> +static inline int zynqmp_is_valid_ioctl(u32 ioctl_id)

I think most who come across the use of this would expect an
.*is_valid() to return true (non-0) when valid, and 0 otherwise.

> +{
> +       if (ioctl_id == IOCTL_SET_PLL_FRAC_MODE ||
> +           ioctl_id == IOCTL_GET_PLL_FRAC_MODE ||
> +           ioctl_id == IOCTL_SET_PLL_FRAC_DATA ||
> +           ioctl_id == IOCTL_GET_PLL_FRAC_DATA)
> +               return 0;

This is purely a matter of taste, and no requirement to change, but I
find a switch slightly easier to read for this kind of usage:

        switch(ioctl_id) {
        case IOCTL_SET_PLL_FRAC_MODE:
        case IOCTL_GET_PLL_FRAC_MODE:
        case IOCTL_SET_PLL_FRAC_DATA:
        case IOCTL_GET_PLL_FRAC_DATA:
                return 1;
        default:
                return 0;
        }

> +
> +       return -EINVAL;
> +}
> +
> +/**
> + * zynqmp_pm_ioctl() - PM IOCTL API for device control and configs
> + * @node_id:   Node ID of the device
> + * @ioctl_id:  ID of the requested IOCTL
> + * @arg1:      Argument 1 to requested IOCTL call
> + * @arg2:      Argument 2 to requested IOCTL call
> + * @out:       Returned output value
> + *
> + * This function calls IOCTL to firmware for device control and configuration.
> + *
> + * Return: Returns status, either success or error+reason
> + */
> +static int zynqmp_pm_ioctl(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2,
> +                          u32 *out)
> +{
> +       int ret;
> +
> +       ret = zynqmp_is_valid_ioctl(ioctl_id);
> +       if (ret)
> +               return ret;

So with changed return values, this would turn into:

        if (!zynqmp_is_valid_ioctl(ioctl_id))
                return -EINVAL;

> +
> +       return zynqmp_pm_invoke_fn(PM_IOCTL, node_id, ioctl_id,
> +                                  arg1, arg2, out);
> +}
> +
>  static const struct zynqmp_eemi_ops eemi_ops = {
>         .get_api_version = zynqmp_pm_get_api_version,
>         .query_data = zynqmp_pm_query_data,
> @@ -440,6 +482,7 @@ static const struct zynqmp_eemi_ops eemi_ops = {
>         .clock_getrate = zynqmp_pm_clock_getrate,
>         .clock_setparent = zynqmp_pm_clock_setparent,
>         .clock_getparent = zynqmp_pm_clock_getparent,
> +       .ioctl = zynqmp_pm_ioctl,
>  };
>
>  /**
> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
> index 015e130..7a9db08 100644
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@ -34,7 +34,8 @@
>
>  enum pm_api_id {
>         PM_GET_API_VERSION = 1,
> -       PM_QUERY_DATA = 35,
> +       PM_IOCTL = 34,
> +       PM_QUERY_DATA,
>         PM_CLOCK_ENABLE,
>         PM_CLOCK_DISABLE,
>         PM_CLOCK_GETSTATE,
> @@ -99,6 +100,7 @@ struct zynqmp_eemi_ops {
>         int (*clock_getrate)(u32 clock_id, u64 *rate);
>         int (*clock_setparent)(u32 clock_id, u32 parent_id);
>         int (*clock_getparent)(u32 clock_id, u32 *parent_id);
> +       int (*ioctl)(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2, u32 *out);
>  };
>
>  #if IS_REACHABLE(CONFIG_ARCH_ZYNQMP)
> --
> 2.7.4
>
