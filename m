From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 19 Sep 2018 22:21:24 +0200
Subject: [PATCH V6 3/3] firmware: imx: add misc svc support
In-Reply-To: <1537326246-28558-4-git-send-email-aisheng.dong@nxp.com>
References: <1537326246-28558-1-git-send-email-aisheng.dong@nxp.com>
 <1537326246-28558-4-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20180919202124.GR4097@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 19, 2018 at 11:04:06AM +0800, Dong Aisheng wrote:
> +enum misc_func_e {
> +	MISC_FUNC_UNKNOWN = 0,
> +	MISC_FUNC_SET_CONTROL = 1,
> +	MISC_FUNC_GET_CONTROL = 2,
> +	MISC_FUNC_SET_MAX_DMA_GROUP = 4,
> +	MISC_FUNC_SET_DMA_GROUP = 5,
> +	MISC_FUNC_SECO_IMAGE_LOAD = 8,
> +	MISC_FUNC_SECO_AUTHENTICATE = 9,
> +	MISC_FUNC_DEBUG_OUT = 10,
> +	MISC_FUNC_WAVEFORM_CAPTURE = 6,
> +	MISC_FUNC_BUILD_INFO = 15,
> +	MISC_FUNC_UNIQUE_ID = 19,
> +	MISC_FUNC_SET_ARI = 3,
> +	MISC_FUNC_BOOT_STATUS = 7,
> +	MISC_FUNC_BOOT_DONE = 14,
> +	MISC_FUNC_OTP_FUSE_READ = 11,
> +	MISC_FUNC_OTP_FUSE_WRITE = 17,
> +	MISC_FUNC_SET_TEMP = 12,
> +	MISC_FUNC_GET_TEMP = 13,
> +	MISC_FUNC_GET_BOOT_DEV = 16,
> +	MISC_FUNC_GET_BUTTON_STATUS = 18,
> +};

Shouldn't that be in some header file? Some types seem to be used by
other drivers, MISC_FUNC_OTP_FUSE_READ for example.

> +sc_err_t sc_misc_set_control(struct sc_ipc *ipc, sc_rsrc_t resource,
> +			     sc_ctrl_t ctrl, uint32_t val)
> +{
> +	struct imx_sc_msg_req_misc_set_ctrl msg;
> +	struct sc_rpc_msg *hdr = &msg.hdr;
> +	int ret;
> +
> +	hdr->ver = SC_RPC_VERSION;
> +	hdr->svc = (uint8_t)SC_RPC_SVC_MISC;
> +	hdr->func = (uint8_t)MISC_FUNC_SET_CONTROL;
> +	hdr->size = 4;
> +
> +	msg.ctrl = ctrl;
> +	msg.val = val;
> +	msg.resource = resource;
> +
> +	ret = sc_call_rpc(ipc, (void *)&msg, false);

No need to cast to void *.

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

The function description should be over the function definition, not
above the declaration.

Also I think kerneldoc is preferred here.

Not sure how useful the description of the returned errors is. For once
SC_ERR_FAIL is missing and then the names are quite self explanatory.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
