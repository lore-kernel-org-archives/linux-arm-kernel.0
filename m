From: aisheng.dong@nxp.com (A.s. Dong)
Date: Wed, 11 Jul 2018 11:27:01 +0000
Subject: [PATCH V4 5/5] soc: imx: add SC firmware IPC and APIs
In-Reply-To: <20180711103159.jxmgksxawjmiukaf@pengutronix.de>
References: <1531061817-1980-1-git-send-email-aisheng.dong@nxp.com>
 <1531061817-1980-6-git-send-email-aisheng.dong@nxp.com>
 <20180710144454.lmz62g76xu7ieohr@pengutronix.de>
 <AM0PR04MB421186AD7C08E94CADFDD394805A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20180711103159.jxmgksxawjmiukaf@pengutronix.de>
Message-ID: <AM0PR04MB421185C501B3B910A194232F805A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> Sent: Wednesday, July 11, 2018 6:32 PM
> To: A.s. Dong <aisheng.dong@nxp.com>
> Cc: linux-arm-kernel at lists.infradead.org; dongas86 at gmail.com; dl-linux-imx
> <linux-imx@nxp.com>; kernel at pengutronix.de; Fabio Estevam
> <fabio.estevam@nxp.com>; shawnguo at kernel.org
> Subject: Re: [PATCH V4 5/5] soc: imx: add SC firmware IPC and APIs
> 
> On Wed, Jul 11, 2018 at 09:18:06AM +0000, A.s. Dong wrote:
> > > -----Original Message-----
> > > From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> > > Sent: Tuesday, July 10, 2018 10:45 PM
> > > To: A.s. Dong <aisheng.dong@nxp.com>
> > > Cc: linux-arm-kernel at lists.infradead.org; dongas86 at gmail.com;
> > > dl-linux-imx <linux-imx@nxp.com>; kernel at pengutronix.de; Fabio
> > > Estevam <fabio.estevam@nxp.com>; shawnguo at kernel.org
> > > Subject: Re: [PATCH V4 5/5] soc: imx: add SC firmware IPC and APIs
> > >
> > > Hi,
> > >
> > > Thank you for removing the majority of this patch. It really helps
> readability.
> > >
> > > On Sun, Jul 08, 2018 at 10:56:57PM +0800, Dong Aisheng wrote:
> > > > +/* Initialization of the MU code. */ static int
> > > > +imx_sc_probe(struct platform_device *pdev) {
> > > > +	struct device *dev = &pdev->dev;
> > > > +	int ret;
> > > > +
> > > > +	ret = sc_ipc_open(&scu_ipc_handle, dev);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	pr_info("NXP i.MX SCU Initialized\n");
> > > > +
> > > > +	return devm_of_platform_populate(dev); }
> > >
> > > I see that you have turned the SCU code into a driver and I really
> > > welcome that. Now when you have a driver a global scu_ipc_handle is
> > > no longer necessary. You can call platform_set_drvdata(pdev,
> > > sc_ipc); and can get that from the child devices using
> > > dev_get_drvdata(pdev->dev.parent) like for example most mfd devices
> do.
> > >
> >
> > It looks like a good idea.
> > One question: That means that the SCU users much have a node under
> SCU
> > node and have struct device point, it seems ok for all normal devices like clk,
> pinctrl, pd.
> > But I found some special device like soc device which does not have
> > node and struct device, but also use SCU. How to treat for those devices?
> Possible anymore of them?
> 
> Not sure. What kind of device is it? I'm sure we'll find a solution so maybe ask
> again once we are there?
> 

See:
include/linux/sys_soc.h
arch/arm/mach-imx/cpu.c: imx_soc_device_init().
struct soc_device_attribute {
        const char *machine;
        const char *family;
        const char *revision;   
        const char *soc_id;
        const void *data;
};

And I found there's also SC services used by other normal devices
Which is not under SCU node. So I wonder dev_get_drvdata(parent)
may not work for them quite well.

> > > This can be embedded into structs that the consumers (like clock driver)
> use.
> > >
> >
> > Did you mean something like below (similar as TI does):
> >
> > struct sc_rpc_msg {
> >         uint8_t ver;
> >         uint8_t size;
> >         uint8_t svc;
> >         uint8_t func;
> > };
> >
> > // we need have two structures for each type SCU request and response
> > struct imx_sc_msg_req_get_clock_rate {
> >         struct sc_rpc_msg hdr;
> >         u16 resource;
> >         u8 clk;
> > } __packed;
> >
> > struct imx_sc_msg_resp_get_clock_rate {
> >         struct sc_rpc_msg hdr;
> >         u32 rate;
> > } __packed;
> >
> > sc_err_t sc_pm_get_clock_rate(sc_ipc_t ipc, sc_rsrc_t resource,
> >                               sc_pm_clk_t clk, sc_pm_clock_rate_t
> > *rate) {
> >         struct imx_sc_msg_req_get_clock_rate *msg;
> >         struct imx_sc_msg_resp_get_clock_rate *resp;
> >         struct sc_rpc_msg *hdr = &msg->hdr;
> >         uint8_t result;
> >         int ret;
> >
> >         hdr->ver = SC_RPC_VERSION;
> >         hdr->svc = (uint8_t)SC_RPC_SVC_PM;
> >         hdr->func = (uint8_t)PM_FUNC_GET_CLOCK_RATE;
> >         hdr->size = 2;
> >
> >         msg->resource = resource;
> >         msg->clk = clk;
> >
> >         ret = sc_call_rpc(ipc, &msg, false);
> >         if (ret)
> >                 return SC_ERR_FAIL;
> >
> >         resp = (struct imx_sc_msg_resp_get_clock_rate *)msg;
> >         if (rate != NULL)
> >                 *rate = resp->rate;
> >
> >         result = resp->hdr.func;
> >         return (sc_err_t)result;
> > }
> >
> > Are you okay with this?
> 
> Yes, that's what I meant. Put this function into the clock driver directly rather
> than in the SCU code and we are done.
> 

It seems those are procotol services,  both arm scpi and ti sci
Implemented them in scu driver.
drivers/firmware/ti_sci.c
drivers/firmware/arm_scpi.c
You do want to implement in each induvial client drivers?

Regards
Dong Aisheng

> Sascha
> 
> 
> --
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 |
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fww
> w.pengutronix.de%2F&amp;data=02%7C01%7Caisheng.dong%40nxp.com%7
> C4d1cdc88f66c4c6e8b2c08d5e7198a09%7C686ea1d3bc2b4c6fa92cd99c5c3016
> 35%7C0%7C0%7C636669019236875606&amp;sdata=lpP6lpObOOKajQFz9mTai
> BbqLklnoLbWGrMzPxhrjpU%3D&amp;reserved=0  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
