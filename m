From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 19 Sep 2018 21:41:00 +0200
Subject: [PATCH V6 2/3] firmware: imx: add SCU firmware driver support
In-Reply-To: <1537326246-28558-3-git-send-email-aisheng.dong@nxp.com>
References: <1537326246-28558-1-git-send-email-aisheng.dong@nxp.com>
 <1537326246-28558-3-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20180919194100.GQ4097@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dong,

Looks mostly ok for me now. Some small things inside.

On Wed, Sep 19, 2018 at 11:04:05AM +0800, Dong Aisheng wrote:
> The System Controller Firmware (SCFW) is a low-level system function
> which runs on a dedicated Cortex-M core to provide power, clock, and
> resource management. It exists on some i.MX8 processors. e.g. i.MX8QM
> (QM, QP), and i.MX8QX (QXP, DX).
> 
> This patch implements the SCU firmware IPC function and the common
> message sending API sc_call_rpc.
> 
> +int sc_ipc_get_handle(struct sc_ipc *ipc)
> +{
> +	if (!scu_ipc_handle)
> +		return -EPROBE_DEFER;
> +
> +	ipc = scu_ipc_handle;

You are modifying a local pointer here instead of returning it.

> +	return 0;
> +}
> +EXPORT_SYMBOL(sc_ipc_get_handle);

Could you give the exported functions a better namespace like imx_scu_*?

> +int sc_ipc_write(struct sc_ipc *sc_ipc, void *msg)
> +{

Should be static.

> +
> +		dev_dbg(dev, "request mbox chan %s\n", chan_name);
> +		/* chan_name is not used anymore by framework */
> +		kfree(chan_name);
> +	}
> +
> +	sc_ipc->dev = dev;
> +	mutex_init(&sc_ipc->lock);
> +	init_completion(&sc_ipc->done);
> +
> +	scu_ipc_handle = sc_ipc;
> +
> +	pr_info("NXP i.MX SCU Initialized\n");

dev_info

> +/*
> + * This is an function to send an RPC message over an IPC channel.
> + * It is called by client-side SCFW API function shims.
> + *
> + * @param[in]     ipc         IPC handle
> + * @param[in,out] msg         handle to a message
> + * @param[in]     no_resp     response flag
> + *
> + * If no_resp is false then this function waits for a response
> + * and returns the result in msg.
> + */
> +int sc_call_rpc(struct sc_ipc *ipc, void *msg, bool no_resp);

better name it get_resp or something like that to avoid this double
negation.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
