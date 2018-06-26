From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 26 Jun 2018 14:13:56 +0200
Subject: [PATCH V3 5/5] soc: imx: add SC firmware IPC and APIs
In-Reply-To: <AM0PR04MB421174A242740584D74B990480490@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1529676720-7533-1-git-send-email-aisheng.dong@nxp.com>
 <1529676720-7533-6-git-send-email-aisheng.dong@nxp.com>
 <20180625105807.in4oreq7s4zyjyci@pengutronix.de>
 <AM0PR04MB42112587EC89573D5E428695804A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20180625194418.skmn4fbkzhzn3msg@pengutronix.de>
 <AM0PR04MB421174A242740584D74B990480490@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <20180626121356.hqzhjamwrfkm6xz3@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 26, 2018 at 09:54:10AM +0000, A.s. Dong wrote:
> > -----Original Message-----
> > From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> > Sent: Tuesday, June 26, 2018 3:44 AM
> > To: A.s. Dong <aisheng.dong@nxp.com>
> > Cc: linux-arm-kernel at lists.infradead.org; dongas86 at gmail.com; dl-linux-imx
> > <linux-imx@nxp.com>; kernel at pengutronix.de; Fabio Estevam
> > <fabio.estevam@nxp.com>; shawnguo at kernel.org
> > Subject: Re: [PATCH V3 5/5] soc: imx: add SC firmware IPC and APIs
> > 
> > On Mon, Jun 25, 2018 at 01:04:38PM +0000, A.s. Dong wrote:
> > > > -----Original Message-----
> > > > From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> > > > Sent: Monday, June 25, 2018 6:58 PM
> > > > To: A.s. Dong <aisheng.dong@nxp.com>
> > > > Cc: linux-arm-kernel at lists.infradead.org; dongas86 at gmail.com;
> > > > dl-linux-imx <linux-imx@nxp.com>; kernel at pengutronix.de; Fabio
> > > > Estevam <fabio.estevam@nxp.com>; shawnguo at kernel.org
> > > > Subject: Re: [PATCH V3 5/5] soc: imx: add SC firmware IPC and APIs
> > > >
> > > > On Fri, Jun 22, 2018 at 10:12:00PM +0800, Dong Aisheng wrote:
> > > > > The System Controller Firmware (SCFW) is a low-level system
> > > > > function which runs on a dedicated Cortex-M core to provide power,
> > > > > clock, and resource management. It exists on some i.MX8
> > > > > processors. e.g. i.MX8QM (QM, QP), and i.MX8QX (QXP, DX).
> > > > >
> > > > > This patch adds the SC firmware service APIs used by the system.
> > > > > It mainly consists of two parts:
> > > > > 1) Implementation of the IPC functions using MUs (client side).
> > > > > 2) SCU firmware services APIs implemented based on RPC calls
> > > > >
> > > > > Cc: Shawn Guo <shawnguo@kernel.org>
> > > > > Cc: Sascha Hauer <kernel@pengutronix.de>
> > > > > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > > > > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > > > > ---
> > > > > v2->v3:
> > > > >  * add the ipc read/write error check
> > > > > v1->v2:
> > > > >  * change the type of sc_ipc_t from uint32_t to unsigned long.
> > > > >    This can make it be capable of storing 64 bit pointer in ARMv8 system.
> > > > >  * Update to use the new MU library implemenation (handle iomem
> > > > > privately)
> > > > >  * remove unused delcarations e.g. sc_rpc_dispatch and sc_rpc_xlate.
> > > > >  * remove unneeded pad ctl functions
> > > > > ---
> > > > > +static sc_ipc_t scu_ipc_handle;
> > > > > +static DEFINE_SPINLOCK(ipc_list_lock); static struct list_head
> > > > > +ipc_list = LIST_HEAD_INIT(ipc_list);
> > > > > +
> > > > > +/*
> > > > > + * This function reads a message from an IPC channel.
> > > > > + *
> > > > > + * @param[in]     sc_ipc      IPC channel handle
> > > > > + * @param[out]    data        pointer to message buffer to read
> > > > > + *
> > > > > + * This function will block if no message is available to be read.
> > > > > + */
> > > > > +static void sc_ipc_read(struct sc_ipc *sc_ipc, void *data) {
> > > > > +	sc_rpc_msg_t *msg = (sc_rpc_msg_t *)data;
> > > > > +	uint8_t count = 0;
> > > > > +	int ret;
> > > > > +
> > > > > +	/* Read first word */
> > > > > +	ret = mu_receive_msg(sc_ipc->mu, 0, (uint32_t *)msg);
> > > > > +	if (ret)
> > > > > +		pr_warn("%s: RPC(MU %pOF) read failed\n", __func__,
> > > > > +mu_node(sc_ipc->mu));
> > > >
> > > > So mu_receive_msg() can now timeout. This of course does not help
> > > > when all you do is to printk the error. You should forward it.
> > > >
> > >
> > > The reason is this timeout case is very low possibility (we've never
> > > seen it up till now),
> > 
> > That's no reason to not handle this case.
> > 
> 
> Okay, I will handle it.
> 
> > > so i just WARN it here to let user know something wrong happened in case
> > it really happens.
> > > Just like many other code in kernel do like a WARN() without return error.
> > >
> > > You will see in current SC service API designs, it replies on SC
> > > firmware to return error code, timeout case is not considered.
> > > e.g.
> > > sc_err_t sc_irq_enable(sc_ipc_t ipc, sc_rsrc_t resource,
> > >                        sc_irq_group_t group, uint32_t mask, bool
> > > enable) {
> > >         sc_rpc_msg_t msg;
> > >         uint8_t result;
> > >
> > >         RPC_VER(&msg) = SC_RPC_VERSION;
> > >         RPC_SVC(&msg) = (uint8_t)SC_RPC_SVC_IRQ; ....................
> > >
> > >         sc_call_rpc(ipc, &msg, false);
> > >
> > >         result = RPC_R8(&msg);
> > >         return (sc_err_t)result;
> > > }
> > >
> > > If we want an extra check for timeout case, we need change the whole
> > > SC services APIs in all C code files. If you think it's still
> > > necessary to do that instead of a warn, please let me know. I can do it.
> > 
> > Speaking of which, if you had documented the message format rather than a
> > C API then we wouldn't be confronted with a ton of function declarations not
> > being in a non Linux conform state. I'm inclined to say that you should throw
> > all the header files away and put the message format into your consumers.
> > With the example of the clock_set_parent call the clock driver could look like:
> > 
> 
> Yes, the message format has not been documented. They're hide to
> consumers. Consumers only call the APIs provided by SCU.
> 
> > struct sc_set_clock_parent {
> > 	struct sc_msg_common sc;
> > 	uint16_t resource;
> > 	uint8_t clk;
> > 	uint8_t parent;
> > };
> > 
> > int foo_clk_set_parent()
> > {
> > 	struct sc_set_clock_parent sc = {
> > 		.sc = {
> > 			.version = SC_RPC_VERSION,
> > 			.size = sizeof(struct sc_set_clock_parent),
> > 			.svc = SC_RPC_SVC_PM,
> > 			.func = PM_FUNC_SET_CLOCK_PARENT,
> > 		},
> > 		.resource = resource,
> > 		.clk = clk,
> > 		.parent = parent,
> > 	};
> > 
> > 	sc_call_rpc(sc_ipc_t ipc, &sc, ...);
> > }
> > 
> > (with struct sc_msg_common defined at some common place)
> > 
> > > >
> > > > That's an error. It shouldn't be silently ignored. By that I do not
> > > > mean that you should print a message. Go and error out, let your
> > > > callers know there an error.
> > >
> > > The msg->size are auto generated by SCU firmware script.
> > > But Okay to me if we decide to return an error for
> > 
> > It may be generated by a script, but you probably cannot reject cleanup
> > patches to the kernel with the argument that the code is autogenerated.
> > 
> > > > > +	spin_lock(&ipc_list_lock);
> > > > > +	list_for_each_entry(sc_ipc, &ipc_list, node) {
> > > > > +		if (mu_node(sc_ipc->mu) == mu_np) {
> > > > > +			spin_unlock(&ipc_list_lock);
> > > > > +			return sc_ipc;
> > > > > +		}
> > > > > +	}
> > > > > +	spin_unlock(&ipc_list_lock);
> > > > > +
> > > > > +	return NULL;
> > > > > +}
> > > > > +
> > > > > +/*
> > > > > + * Open an IPC channel
> > > > > + */
> > > > > +sc_err_t sc_ipc_open(sc_ipc_t *ipc, sc_ipc_id_t id) {
> > > > > +	struct device_node *mu_np = (struct device_node *)id;
> > > >
> > > > Why is the id argument of type sc_ipc_id_t? It is casted from a
> > > > struct device_node * by the caller and casted back to a struct
> > device_node * here.
> > > > Doesn't this suggest the argument should be a struct device_node * ?
> > > >
> > >
> > > That's more to align with original SC firmware API design to hide the
> > > real data type of sc_ipc_t and sc_ipc_id_t to users which can easy the
> > > future update in case a type change.
> > 
> > This API is completely inside the kernel. We can change both sides at the
> > same time.
> > 
> 
> Okay, I can change them.
> 
> > > > > +	if (sc_ipc) {
> > > > > +		sc_ipc->users++;
> > > > > +		*ipc = (sc_ipc_t)sc_ipc;
> > > > > +		return SC_ERR_NONE;
> > > > > +	}
> > > >
> > > > Which sense does this pseudo resource management do? sc_ipc_open()
> > > > is called exactly once during an initcall, and the resulting
> > > > sc_ipc_t * is put into a global variable which is then passed to all
> > > > consumers calling sc_ipc_get_handle().
> > > >
> > >
> > > This is designed to support multi channels simultaneously.
> > > For other users, they do similar thing like default SC IPC to open another
> > IPC channel:
> > > e.g.
> > >         mu_np = of_parse_phandle(np, "fsl,mu", 0);
> > >        ....
> > >         sciErr = sc_ipc_open(&client_ipc_handle, (sc_ipc_id_t)mu_np);
> > > Then operate on client_ipc_handle.
> > 
> > Yes, they can then operate on the very same handle they would also get if
> > they called sc_ipc_get_handle().
> > 
> > You could say that the device node argument could be a different one, but
> > then again you would only use one call to sc_ipc_open() and share the same
> > handle across the users.
> > 
> > That makes no sense, please just throw it away.
> > 
> 
> Sorry, I'm not quite understand your point. What did you suggest to throw away?
> They're used to support multi channels for different consumers at the same time
> to reduce contention time.
> e.g.
> SCU CLK: MU1 
> SCU PD: MU2

You already have multiple users on the same MU and still call
sc_ipc_open() only once. With your current code there is no need
to call sc_ipc_open() for the same MU twice, because you share
the very same instance to your users using sc_ipc_get_handle().

If you get more consumers on a different MU, then why should you
suddenly have to call sc_ipc_open() multiple times on the same MU
then?

> ...
> 
> > > They can also free it after using by calling sc_ipc_close().
> > >
> > > > What's interesting about this is that in sc_ipc_get_handle() you
> > > > pass the handle to your consumers and this place really could use
> > > > resource manangement. So resource management is implemented and
> > > > shortcircuited afterwards :(
> > >
> > > The API sc_ipc_open design does not have device pointer. So we don't
> > > use the resource management.
> > 
> > If you don't use it then throw it away. Maybe later when you really have the
> > need for it then you have the arguments at hand why you need it and then
> > we can see how to implement it. Until then this is only ballast.
> > 
> 
> Would you be more specific what to throw way?

sc_err_t sc_ipc_open(sc_ipc_t *ipc, sc_ipc_id_t id)
{
       struct device_node *mu_np = (struct device_node *)id;
       struct sc_ipc *sc_ipc;

       sc_ipc = sc_ipc_find(id);
       if (sc_ipc) {
               sc_ipc->users++;
               *ipc = (sc_ipc_t)sc_ipc;
               return SC_ERR_NONE;
       }

       ^^^^^^^^^^^^^^^^^^^

This. You only need one user per sc_ipc_t() since even multiple
users do not call sc_ipc_open() again but instead use
sc_ipc_get_handle() to get the instance already allocated.

> > > Your earlier reply is only changing head files if needed.
> > > This requires change all over the code.
> > > As I said before, that's part of code is auto generated by SCU firmware.
> > > (Only drivers/soc/imx/sc/main/ipc.c and drivers/soc/imx/sc/main/rpc.h
> > > Is newly implemented for Linux). Changing it will result in maintain
> > > troubles (we then need to change them all the time in the future in
> > > case a update for new features and etc).
> > > So the original purpose is we'd like to preserve it unless it's a big issue.
> > > What's your opinion?
> > 
> > > > > +/*
> > > > > + * This is an internal function to send an RPC message over an
> > > > > +IPC
> > > > > + * channel. It is called by client-side SCFW API function shims.
> > > > > + *
> > > > > + * @param[in]     ipc         IPC handle
> > > > > + * @param[in,out] msg         handle to a message
> > > > > + * @param[in]     no_resp     response flag
> > > > > + *
> > > > > + * If no_resp is false then this function waits for a response
> > > > > + * and returns the result in msg.
> > > > > + */
> > > > > +void sc_call_rpc(sc_ipc_t ipc, sc_rpc_msg_t *msg, bool no_resp);
> > > >
> > > > Positive logic is usually easier to read. Instead of a 'no_resp'
> > > > flag you should have a 'resp' flag.
> > >
> > > Same explain as above one.
> > >
> > > > > +	sc_call_rpc(ipc, &msg, false);
> > > >
> > > > This call can fail...
> > > >
> > >
> > > See the similar reply above.
> > 
> > My opinion to this is that the "we want to stay in sync with our internal code"
> > argument is not valid. With that argument you could sell anything and I think I
> > repeat myself when I say that Linux would look different when we would
> > merge everything a vendor throws over the fence.
> > 
> 
> I'm not meaning 'we must stay in sync with our internal code.'
> We definitely can change everything which violates Linux rule a lot.
> My original meaning is if it's not big issue and is acceptable by Linux,
> then we may prefer to not change as the sync helps a lot for the
> future maintain.

Ok, understood.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
