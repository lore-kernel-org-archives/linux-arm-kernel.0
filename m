From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 3 May 2018 13:06:11 +0200
Subject: [PATCH 4/4] soc: imx: add SC firmware IPC and APIs
In-Reply-To: <AM0PR04MB421166CCB06610FF8AF25C2980800@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1524854776-14863-1-git-send-email-aisheng.dong@nxp.com>
 <1524854776-14863-5-git-send-email-aisheng.dong@nxp.com>
 <20180502100401.qmik5goglbuiqcaa@pengutronix.de>
 <AM0PR04MB421166CCB06610FF8AF25C2980800@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <20180503110611.wxwsjfszjdnovm2f@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 02, 2018 at 06:40:03PM +0000, A.s. Dong wrote:
> > -----Original Message-----
> > From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> > Sent: Wednesday, May 2, 2018 6:04 PM
> > To: A.s. Dong <aisheng.dong@nxp.com>
> > Cc: linux-arm-kernel at lists.infradead.org; dongas86 at gmail.com; dl-linux-imx
> > <linux-imx@nxp.com>; kernel at pengutronix.de; Fabio Estevam
> > <fabio.estevam@nxp.com>; shawnguo at kernel.org
> > Subject: Re: [PATCH 4/4] soc: imx: add SC firmware IPC and APIs
> > 
> > On Sat, Apr 28, 2018 at 02:46:16AM +0800, Dong Aisheng wrote:
> > > +/* Initialization of the MU code. */
> > > +int __init imx8_scu_init(void)
> > > +{
> > > +	struct device_node *np, *mu_np;
> > > +	struct resource mu_res;
> > > +	sc_err_t sci_err;
> > > +	int ret;
> > > +
> > > +	if (!of_machine_is_compatible("fsl,imx8qxp"))
> > > +		return 0;
> > > +
> > > +	np = of_find_compatible_node(NULL, NULL, "nxp,imx8qxp-scu");
> > > +	if (!np)
> > > +		return -ENODEV;
> > > +
> > > +	mu_np = of_parse_phandle(np, "fsl,mu", 0);
> > > +	if (WARN_ON(!mu_np))
> > > +		return -EINVAL;
> > > +
> > > +	ret = of_address_to_resource(mu_np, 0, &mu_res);
> > > +	if (WARN_ON(ret))
> > > +		return -EINVAL;
> > > +
> > > +	/* we use mu physical address as IPC communication channel ID */
> > > +	sci_err = sc_ipc_open(&scu_ipc_handle, (sc_ipc_id_t)(mu_res.start));
> > > +	if (sci_err != SC_ERR_NONE) {
> > > +		pr_err("Cannot open MU channel to SCU\n");
> > > +		return sci_err;
> > > +	};
> > 
> > Introducing private error codes always has the risk of just forwarding them as
> > errno codes as done here.
> > 
> 
> Yes, you're right.
> We probably could do the same as scpi_to_linux_errno in
> drivers/firmware/arm_scpi.c.
> However, may can't fix the issue permanently.
> 
> > > +
> > > +	of_node_put(mu_np);
> > > +
> > > +	pr_info("NXP i.MX SCU Initialized (scu_ipc %u)\n", scu_ipc_handle);
> > > +
> > > +	return 0;
> > > +}
> > > +early_initcall(imx8_scu_init);
> > 
> > This code shows that the separate 'scu' device node shouldn't exist. It is only
> > used as a stepping stone to find the 'mu' node. Instead of providing a proper
> > driver for the 'mu' node the scu code registers it with its physical address.
> > I don't think it makes sense to separate mu and scu code in this way.
> > 
> 
> I agree that may not look quite well. 
> It mainly because we want to use the MU physical address as a MU ID. 
> (can't use virtual address as sc_ipc_id_t is u32 defined by SCU firmware.
> 
> If you have any better suggestion please let me know.

What I'm suggesting is a single node:

	scu at 5d1b0000 {
		compatible = "fsl,imx8qxp-scu";
		reg = <0x0 0x5d1b0000 0x0 0x10000>;
	};

Attach your code to this one, without any further separation between mu and scu code.

We discussed this internally and came to the conclusion that the SCU is
not a generic user of a MU. The MU is designed to work together with a piece
of SRAM to form a mailbox system. Instead of working as designed the SCU
morses the messages through the doorbell (what the MU really is). For
anything that uses the MU in the way it is designed I would suggest
using the mailbox interface from drivers/mailbox/ along with the
binding from Documentation/devicetree/bindings/mailbox/mailbox.txt.

In the way I suggest there is no need for any MU ID.

> 
> > > +#define RPC_VER(MSG)            ((MSG)->version)
> > > +#define RPC_SIZE(MSG)           ((MSG)->size)
> > > +#define RPC_SVC(MSG)            ((MSG)->svc)
> > > +#define RPC_FUNC(MSG)           ((MSG)->func)
> > > +#define RPC_R8(MSG)             ((MSG)->func)
> > > +#define RPC_I32(MSG, IDX)       ((MSG)->DATA.i32[(IDX) / 4])
> > > +#define RPC_I16(MSG, IDX)       ((MSG)->DATA.i16[(IDX) / 2])
> > > +#define RPC_I8(MSG, IDX)        ((MSG)->DATA.i8[(IDX)])
> > > +#define RPC_U32(MSG, IDX)       ((MSG)->DATA.u32[(IDX) / 4])
> > > +#define RPC_U16(MSG, IDX)       ((MSG)->DATA.u16[(IDX) / 2])
> > > +#define RPC_U8(MSG, IDX)        ((MSG)->DATA.u8[(IDX)])
> > 
> > These macros only make the code less readable, please drop them. Plain
> > m->version is easier to read and forces the reader through less
> > indirections. IMO m->DATA.u32[0] = foo; m->DATA.u8[4] = bar is still better
> > readable than doing the division by size in macros.
> > 
> 
> I somehow agree with you.
> See below...
> 
> > > +typedef enum sc_rpc_async_state_e {
> > > +	SC_RPC_ASYNC_STATE_RD_START = 0,
> > > +	SC_RPC_ASYNC_STATE_RD_ACTIVE = 1,
> > > +	SC_RPC_ASYNC_STATE_RD_DONE = 2,
> > > +	SC_RPC_ASYNC_STATE_WR_START = 3,
> > > +	SC_RPC_ASYNC_STATE_WR_ACTIVE = 4,
> > > +	SC_RPC_ASYNC_STATE_WR_DONE = 5,
> > > +} sc_rpc_async_state_t;
> > > +
> > > +typedef struct sc_rpc_async_msg_s {
> > > +	sc_rpc_async_state_t state;
> > > +	uint8_t wordIdx;
> > > +	sc_rpc_msg_t msg;
> > > +	uint32_t timeStamp;
> > > +} sc_rpc_async_msg_t;
> > 
> > We normally do not typedef struct types. Any good reasons to do so here?
> > 
> 
> Yes, I did not some checkpatch warnings about this.
> 
> For this patch, I only implemented IPC function calls based on MU which is in
> drivers/soc/imx/sc/main/ipc.c. All other files actually are generated by SCU firmware
> script automatically for Linux OS. They're tightly couple with SCU firmware side
> implementation. In order to gain better maintainability (easy upgrade and sync with
> SCU firmware), we're trying to not change those APIs too much unless we have strong
> reasons. Does it make sense to you?

Hm, I'm not suggesting to change the API, only the header files. In
another mail you say that the SCU firmware is stable, so there shouldn't
be any strong need to sync the header files from your internal
repositories, right?
Besides, you could also update your internal repositories with the
suggestions I make ;)

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
