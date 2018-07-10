From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 10 Jul 2018 16:44:54 +0200
Subject: [PATCH V4 5/5] soc: imx: add SC firmware IPC and APIs
In-Reply-To: <1531061817-1980-6-git-send-email-aisheng.dong@nxp.com>
References: <1531061817-1980-1-git-send-email-aisheng.dong@nxp.com>
 <1531061817-1980-6-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20180710144454.lmz62g76xu7ieohr@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Thank you for removing the majority of this patch. It really helps
readability.

On Sun, Jul 08, 2018 at 10:56:57PM +0800, Dong Aisheng wrote:
> +/* Initialization of the MU code. */
> +static int imx_sc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	ret = sc_ipc_open(&scu_ipc_handle, dev);
> +	if (ret)
> +		return ret;
> +
> +	pr_info("NXP i.MX SCU Initialized\n");
> +
> +	return devm_of_platform_populate(dev);
> +}

I see that you have turned the SCU code into a driver and I really
welcome that. Now when you have a driver a global scu_ipc_handle is no
longer necessary. You can call platform_set_drvdata(pdev, sc_ipc); and
can get that from the child devices using
dev_get_drvdata(pdev->dev.parent) like for example most mfd devices do.


> +	{ /* Sentinel */ }
> +};
> +
> +static struct platform_driver imx_sc_driver = {
> +	.driver = {
> +		.name = "imx-scu",
> +		.of_match_table = imx_sc_match,
> +	},
> +	.probe = imx_sc_probe,
> +};
> +
> +static int __init imx_sc_init(void)
> +{
> +	return platform_driver_register(&imx_sc_driver);
> +}
> +core_initcall(imx_sc_init);

...

> +
> +#define RPC_VER(MSG)            ((MSG)->version)
> +#define RPC_SIZE(MSG)           ((MSG)->size)
> +#define RPC_SVC(MSG)            ((MSG)->svc)
> +#define RPC_FUNC(MSG)           ((MSG)->func)
> +#define RPC_R8(MSG)             ((MSG)->func)
> +#define RPC_I32(MSG, IDX)       ((MSG)->DATA.i32[(IDX) / 4])
> +#define RPC_I16(MSG, IDX)       ((MSG)->DATA.i16[(IDX) / 2])
> +#define RPC_I8(MSG, IDX)        ((MSG)->DATA.i8[(IDX)])
> +#define RPC_U32(MSG, IDX)       ((MSG)->DATA.u32[(IDX) / 4])
> +#define RPC_U16(MSG, IDX)       ((MSG)->DATA.u16[(IDX) / 2])
> +#define RPC_U8(MSG, IDX)        ((MSG)->DATA.u8[(IDX)])

Same as I said more than once: These macros only reduce readability of
the code. Please drop them.

> +typedef struct sc_rpc_msg_s {
> +	uint8_t version;
> +	uint8_t size;
> +	uint8_t svc;
> +	uint8_t func;
> +	union {
> +		int32_t i32[(SC_RPC_MAX_MSG - 1)];
> +		int16_t i16[(SC_RPC_MAX_MSG - 1) * 2];
> +		int8_t i8[(SC_RPC_MAX_MSG - 1) * 4];
> +		uint32_t u32[(SC_RPC_MAX_MSG - 1)];
> +		uint16_t u16[(SC_RPC_MAX_MSG - 1) * 2];
> +		uint8_t u8[(SC_RPC_MAX_MSG - 1) * 4];
> +	} DATA;
> +} sc_rpc_msg_t;

I am pretty sure now that you should only define a common header struct,
like:

struct sc_rpc_msg {
	uint8_t version;
	uint8_t size;
	uint8_t svc;
	uint8_t func;
};

This can be embedded into structs that the consumers (like clock driver)
use.

> +
> +/*
> + * @name Defines for common frequencies
> + */
> +#define SC_32KHZ            32768	/* 32KHz */
> +#define SC_10MHZ         10000000	/* 10MHz */
> +#define SC_20MHZ         20000000	/* 20MHz */
> +#define SC_25MHZ         25000000	/* 25MHz */

What is the usecase for these defines? Can we add them along with the
users of the defines so that we can decide then if we really want to
have them?

Regards
 Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
