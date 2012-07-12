From: richard.zhao@freescale.com (Richard Zhao)
Date: Thu, 12 Jul 2012 17:31:04 +0800
Subject: [PATCH v2 1/2] pinctrl: pinctrl-imx: add support for set bits
 for general purpose registers
In-Reply-To: <1342084080-3145-1-git-send-email-b29396@freescale.com>
References: <1342084080-3145-1-git-send-email-b29396@freescale.com>
Message-ID: <20120712093103.GD21635@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 12, 2012 at 05:07:59PM +0800, Dong Aisheng wrote:
> From: Dong Aisheng <dong.aisheng@linaro.org>
> 
> The General Purpose Registers (GPR) is used to select operating modes for
> general features in the SoC, usually not related to the IOMUX itself,
> but it does belong to IOMUX controller.
> We simply provide an convient API for driver to call to write/read the general
> purpose register bits if needed.
> 
> Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
> ---
> ChangeLog v1->v2:
> * add gpr read api
> * change api name a bit to *_write and *_read
> * add -EPROBE_DEFER support
> * define macros for gpr registers for imx6q
> * change driver loadding priority to postcore_init at satisfy clients driver
>   to use imx_pinctrl_gpr_{read | write} APIs at best
> ---
>  drivers/pinctrl/pinctrl-imx.c   |   29 ++++
>  drivers/pinctrl/pinctrl-imx51.c |    2 +-
>  drivers/pinctrl/pinctrl-imx53.c |    2 +-
>  drivers/pinctrl/pinctrl-imx6q.c |    2 +-
>  include/linux/fsl/imx-pinctrl.h |  340 +++++++++++++++++++++++++++++++++++++++
>  5 files changed, 372 insertions(+), 3 deletions(-)
>  create mode 100644 include/linux/fsl/imx-pinctrl.h
> 
> diff --git a/drivers/pinctrl/pinctrl-imx.c b/drivers/pinctrl/pinctrl-imx.c
> index 44e9726..1725e07 100644
> --- a/drivers/pinctrl/pinctrl-imx.c
> +++ b/drivers/pinctrl/pinctrl-imx.c
> @@ -54,6 +54,34 @@ struct imx_pinctrl {
>  	const struct imx_pinctrl_soc_info *info;
>  };
>  
> +static struct imx_pinctrl *imx_pinctrl;
> +/*
> + * Set bits for general purpose registers
> + */
> +int imx_pinctrl_gpr_write(u8 gpr, u32 mask, u32 value)
> +{
> +	u32 reg;
> +
> +	if (!imx_pinctrl)
> +		return -EPROBE_DEFER;
	value &= mask;
And add a spinlock to protect it?
 
Thanks
Richard
