From: aisheng.dong@nxp.com (A.s. Dong)
Date: Wed, 11 Jul 2018 09:18:06 +0000
Subject: [PATCH V4 5/5] soc: imx: add SC firmware IPC and APIs
In-Reply-To: <20180710144454.lmz62g76xu7ieohr@pengutronix.de>
References: <1531061817-1980-1-git-send-email-aisheng.dong@nxp.com>
 <1531061817-1980-6-git-send-email-aisheng.dong@nxp.com>
 <20180710144454.lmz62g76xu7ieohr@pengutronix.de>
Message-ID: <AM0PR04MB421186AD7C08E94CADFDD394805A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> Sent: Tuesday, July 10, 2018 10:45 PM
> To: A.s. Dong <aisheng.dong@nxp.com>
> Cc: linux-arm-kernel at lists.infradead.org; dongas86 at gmail.com; dl-linux-imx
> <linux-imx@nxp.com>; kernel at pengutronix.de; Fabio Estevam
> <fabio.estevam@nxp.com>; shawnguo at kernel.org
> Subject: Re: [PATCH V4 5/5] soc: imx: add SC firmware IPC and APIs
> 
> Hi,
> 
> Thank you for removing the majority of this patch. It really helps readability.
> 
> On Sun, Jul 08, 2018 at 10:56:57PM +0800, Dong Aisheng wrote:
> > +/* Initialization of the MU code. */
> > +static int imx_sc_probe(struct platform_device *pdev) {
> > +	struct device *dev = &pdev->dev;
> > +	int ret;
> > +
> > +	ret = sc_ipc_open(&scu_ipc_handle, dev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	pr_info("NXP i.MX SCU Initialized\n");
> > +
> > +	return devm_of_platform_populate(dev); }
> 
> I see that you have turned the SCU code into a driver and I really welcome
> that. Now when you have a driver a global scu_ipc_handle is no longer
> necessary. You can call platform_set_drvdata(pdev, sc_ipc); and can get that
> from the child devices using
> dev_get_drvdata(pdev->dev.parent) like for example most mfd devices do.
> 

It looks like a good idea.
One question: That means that the SCU users much have a node under SCU node
and have struct device point, it seems ok for all normal devices like clk, pinctrl, pd.
But I found some special device like soc device which does not have node and struct
device, but also use SCU. How to treat for those devices? Possible anymore of them?

> 
> > +	{ /* Sentinel */ }
> > +};
> > +
> > +static struct platform_driver imx_sc_driver = {
> > +	.driver = {
> > +		.name = "imx-scu",
> > +		.of_match_table = imx_sc_match,
> > +	},
> > +	.probe = imx_sc_probe,
> > +};
> > +
> > +static int __init imx_sc_init(void)
> > +{
> > +	return platform_driver_register(&imx_sc_driver);
> > +}
> > +core_initcall(imx_sc_init);
> 
> ...
> 
> > +
> > +#define RPC_VER(MSG)            ((MSG)->version)
> > +#define RPC_SIZE(MSG)           ((MSG)->size)
> > +#define RPC_SVC(MSG)            ((MSG)->svc)
> > +#define RPC_FUNC(MSG)           ((MSG)->func)
> > +#define RPC_R8(MSG)             ((MSG)->func)
> > +#define RPC_I32(MSG, IDX)       ((MSG)->DATA.i32[(IDX) / 4])
> > +#define RPC_I16(MSG, IDX)       ((MSG)->DATA.i16[(IDX) / 2])
> > +#define RPC_I8(MSG, IDX)        ((MSG)->DATA.i8[(IDX)])
> > +#define RPC_U32(MSG, IDX)       ((MSG)->DATA.u32[(IDX) / 4])
> > +#define RPC_U16(MSG, IDX)       ((MSG)->DATA.u16[(IDX) / 2])
> > +#define RPC_U8(MSG, IDX)        ((MSG)->DATA.u8[(IDX)])
> 
> Same as I said more than once: These macros only reduce readability of the
> code. Please drop them.
> 
> > +typedef struct sc_rpc_msg_s {
> > +	uint8_t version;
> > +	uint8_t size;
> > +	uint8_t svc;
> > +	uint8_t func;
> > +	union {
> > +		int32_t i32[(SC_RPC_MAX_MSG - 1)];
> > +		int16_t i16[(SC_RPC_MAX_MSG - 1) * 2];
> > +		int8_t i8[(SC_RPC_MAX_MSG - 1) * 4];
> > +		uint32_t u32[(SC_RPC_MAX_MSG - 1)];
> > +		uint16_t u16[(SC_RPC_MAX_MSG - 1) * 2];
> > +		uint8_t u8[(SC_RPC_MAX_MSG - 1) * 4];
> > +	} DATA;
> > +} sc_rpc_msg_t;
> 
> I am pretty sure now that you should only define a common header struct,
> like:
> 
> struct sc_rpc_msg {
> 	uint8_t version;
> 	uint8_t size;
> 	uint8_t svc;
> 	uint8_t func;
> };
> 
> This can be embedded into structs that the consumers (like clock driver) use.
> 

Did you mean something like below (similar as TI does):

struct sc_rpc_msg {
        uint8_t ver;
        uint8_t size; 
        uint8_t svc;
        uint8_t func; 
};

// we need have two structures for each type SCU request and response       
struct imx_sc_msg_req_get_clock_rate {
        struct sc_rpc_msg hdr;
        u16 resource;
        u8 clk;
} __packed;

struct imx_sc_msg_resp_get_clock_rate {
        struct sc_rpc_msg hdr;
        u32 rate;
} __packed;

sc_err_t sc_pm_get_clock_rate(sc_ipc_t ipc, sc_rsrc_t resource,
                              sc_pm_clk_t clk, sc_pm_clock_rate_t *rate)
{
        struct imx_sc_msg_req_get_clock_rate *msg;
        struct imx_sc_msg_resp_get_clock_rate *resp;
        struct sc_rpc_msg *hdr = &msg->hdr;
        uint8_t result;
        int ret;

        hdr->ver = SC_RPC_VERSION;
        hdr->svc = (uint8_t)SC_RPC_SVC_PM;
        hdr->func = (uint8_t)PM_FUNC_GET_CLOCK_RATE;
        hdr->size = 2;

        msg->resource = resource;
        msg->clk = clk;

        ret = sc_call_rpc(ipc, &msg, false);
        if (ret)
                return SC_ERR_FAIL;

        resp = (struct imx_sc_msg_resp_get_clock_rate *)msg;
        if (rate != NULL)
                *rate = resp->rate;

        result = resp->hdr.func;
        return (sc_err_t)result;
}

Are you okay with this?

> > +
> > +/*
> > + * @name Defines for common frequencies  */
> > +#define SC_32KHZ            32768	/* 32KHz */
> > +#define SC_10MHZ         10000000	/* 10MHz */
> > +#define SC_20MHZ         20000000	/* 20MHz */
> > +#define SC_25MHZ         25000000	/* 25MHz */
> 
> What is the usecase for these defines? Can we add them along with the
> users of the defines so that we can decide then if we really want to have
> them?

Okay, I could remove them from this patch.

Regards
Dong Aisheng

> 
> Regards
>  Sascha
> 
> --
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 |
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fww
> w.pengutronix.de%2F&amp;data=02%7C01%7Caisheng.dong%40nxp.com%7
> C8f4321d863924a5d649b08d5e673b523%7C686ea1d3bc2b4c6fa92cd99c5c3016
> 35%7C0%7C0%7C636668306989011249&amp;sdata=pG94K1r%2F%2Feyng%2
> F1reGHfO0TEYLNJKtYTa5y%2FZqNfJjc%3D&amp;reserved=0  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
