From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 28 Sep 2018 08:11:09 +0200
Subject: [PATCH V7 3/3] firmware: imx: add misc svc support
In-Reply-To: <1537892878-30933-4-git-send-email-aisheng.dong@nxp.com>
References: <1537892878-30933-1-git-send-email-aisheng.dong@nxp.com>
 <1537892878-30933-4-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20180928061109.xxbrxsjpgizurhfl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 26, 2018 at 12:27:58AM +0800, Dong Aisheng wrote:
> Add SCU MISC SVC support which provides misc control get/set functions.
> 
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
> v6->v7:
>  * move MISC_FUNC enums into headfile
>  * delete void * cast
>  * move function description over the function definition
> v5->v6:
>  * move into drivers/firmware/imx
>  * using structure sc_ipc as handle instread of sc_ipc_t
>  * patch title changed
> v4->v5:
>  * new patch
> ---
>  drivers/firmware/imx/Makefile  |   2 +-
>  drivers/firmware/imx/misc.c    | 110 +++++++++++++++++++++++++++++++++++++++++
>  include/soc/imx/scu/sci.h      |   1 +
>  include/soc/imx/scu/svc/misc.h |  55 +++++++++++++++++++++
>  4 files changed, 167 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/firmware/imx/misc.c
>  create mode 100644 include/soc/imx/scu/svc/misc.h
> 
> diff --git a/drivers/firmware/imx/Makefile b/drivers/firmware/imx/Makefile
> index 9b1e2fe..0ac04df 100644
> --- a/drivers/firmware/imx/Makefile
> +++ b/drivers/firmware/imx/Makefile
> @@ -1,2 +1,2 @@
>  # SPDX-License-Identifier: GPL-2.0
> -obj-$(CONFIG_IMX_SCU)	+= imx-scu.o
> +obj-$(CONFIG_IMX_SCU)	+= imx-scu.o misc.o
> diff --git a/drivers/firmware/imx/misc.c b/drivers/firmware/imx/misc.c
> new file mode 100644
> index 0000000..88b8f7f
> --- /dev/null
> +++ b/drivers/firmware/imx/misc.c
> @@ -0,0 +1,110 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2016 Freescale Semiconductor, Inc.
> + * Copyright 2017~2018 NXP
> + *  Author: Dong Aisheng <aisheng.dong@nxp.com>
> + *
> + * File containing client-side RPC functions for the MISC service. These
> + * function are ported to clients that communicate to the SC.
> + *
> + */
> +
> +#include <soc/imx/scu/svc/misc.h>
> +
> +struct imx_sc_msg_req_misc_set_ctrl {
> +	struct sc_rpc_msg hdr;
> +	u32 ctrl;
> +	u32 val;
> +	u16 resource;
> +} __packed;
> +
> +struct imx_sc_msg_req_misc_get_ctrl {
> +	struct sc_rpc_msg hdr;
> +	u32 ctrl;
> +	u16 resource;
> +} __packed;
> +
> +struct imx_sc_msg_resp_misc_get_ctrl {
> +	struct sc_rpc_msg hdr;
> +	u32 val;
> +} __packed;
> +
> +/*
> + * This function sets a miscellaneous control value.
> + *
> + * @param[in]     ipc         IPC handle
> + * @param[in]     resource    resource the control is associated with
> + * @param[in]     ctrl        control to change
> + * @param[in]     val         value to apply to the control
> + *
> + * @return Returns an error code (SC_ERR_NONE = success).
> + *
> + * Return errors:
> + * - SC_PARM if arguments out of range or invalid,
> + * - SC_ERR_NOACCESS if caller's partition is not the resource owner or parent
> + *   of the owner
> + */
> +sc_err_t sc_misc_set_control(struct sc_ipc *ipc, sc_rsrc_t resource,
> +			     sc_ctrl_t ctrl, uint32_t val)

> +sc_err_t sc_misc_get_control(struct sc_ipc *ipc, sc_rsrc_t resource,
> +			     sc_ctrl_t ctrl, uint32_t *val)
> + */
> +enum misc_func_e {
> +	MISC_FUNC_UNKNOWN = 0,

The exported functions enums and structs should have a proper prefix.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
