From: dong.aisheng@linaro.org (Dong Aisheng)
Date: Tue, 26 Feb 2013 17:13:11 +0800
Subject: [PATCH v2 3/3] pinctrl: imx: move hard-coding data into device
 tree
In-Reply-To: <1361533888-18073-4-git-send-email-shawn.guo@linaro.org>
References: <1361533888-18073-1-git-send-email-shawn.guo@linaro.org>
 <1361533888-18073-4-git-send-email-shawn.guo@linaro.org>
Message-ID: <CAP1dx+zv3dkWTjQqL+YxK=Se64eojXCHkqs6FXodppXkaRNmXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 February 2013 19:51, Shawn Guo <shawn.guo@linaro.org> wrote:
> Currently, all imx pinctrl drivers maintain a big array of struct
> imx_pin_reg which hard-codes data like register offset and mux mode
> setting for each pin function.  Every time a new imx SoC support is
> added, we need to add such a big mount of data.  With moving to single
> kernel build, it's only matter of time to be blamed on memory consuming.
>
> With DTC pre-processor support in place, the patch moves all these data
> into device tree by redefining the PIN_FUNC_ID in imxXX-pinfunc.h and
> changing the PIN_FUNC_ID parsing code a little bit.
>
> The pin id gets re-numbered based on mux register offset, or config
> register offset if the pin has no mux register, so that kernel can
> identify the pin id from register offsets provided by device tree.

This looks ok to me.

> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
........
> + * The pin function ID is a tuple of
> + * <mux_reg conf_reg input_reg mux_mode input_val>
> + */
> +#define MX6Q_PAD_SD2_DAT1__USDHC2_DAT1                 0x04c 0x360 0x000 0x0 0x0
> +#define MX6Q_PAD_SD2_DAT1__ECSPI5_SS0                  0x04c 0x360 0x834 0x1 0x0
> +#define MX6Q_PAD_SD2_DAT1__WEIM_WEIM_CS_2              0x04c 0x360 0x000 0x2 0x0

Is there any special reason we change the register order comparing to iomux-v3?
How did you generate this new table?

>  static struct of_device_id imx53_pinctrl_of_match[] = {
> diff --git a/drivers/pinctrl/pinctrl-imx6q.c b/drivers/pinctrl/pinctrl-imx6q.c
> index 663346b..74ea946 100644
> --- a/drivers/pinctrl/pinctrl-imx6q.c
> +++ b/drivers/pinctrl/pinctrl-imx6q.c
> @@ -23,1935 +23,256 @@
>  #include "pinctrl-imx.h"
>
>  enum imx6q_pads {
....
> +       MX6Q_PAD_JTAG_TDI = 417,
> +       MX6Q_PAD_JTAG_TCK = 418,
> +       MX6Q_PAD_JTAG_TDO = 419,

Ideally even for this table, we may also do not need it.
Because the pin id defined here actually is dynamically calculated by
mux_reg/config_reg offset.
If that, why can't we also define the pinctrl_pin_desc dynamically and
register it into the core?
However, it may need the pinctrl core to provide register a single pin
function to driver.
Since it does not affect the binding itself, i'm ok it may be
discussed or done in the future
in a separate patch.

Besides above minor comments, this binding improvement patch is ok to me.
Acked-by: Dong Aisheng <dong.aisheng@linaro.org>

Regards
Dong Aisheng
