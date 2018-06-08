From: aisheng.dong@nxp.com (A.s. Dong)
Date: Fri, 8 Jun 2018 05:52:48 +0000
Subject: [PATCH 4/4] soc: imx: add SC firmware IPC and APIs
In-Reply-To: <20180608041326.4jmk2et73o2clz25@pengutronix.de>
References: <20180502100401.qmik5goglbuiqcaa@pengutronix.de>
 <AM0PR04MB421166CCB06610FF8AF25C2980800@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20180503110611.wxwsjfszjdnovm2f@pengutronix.de>
 <AM0PR04MB42117041F226AD5E8501EC1080870@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20180503124030.jkc7oox2vyjblk2y@pengutronix.de>
 <AM0PR04MB421169E44830A17D8A52D3F4806A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20180606141501.6prypkkxgsk3e7ee@pengutronix.de>
 <AM0PR04MB4211E378DCBB769AB2C06BCF80640@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20180607070835.ebqsj7qurcdvcubz@pengutronix.de>
 <AM0PR04MB42119006042C993F410D6CB080640@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20180608041326.4jmk2et73o2clz25@pengutronix.de>
Message-ID: <VI1PR04MB4222C3338BB84DA54C70EBB0807B0@VI1PR04MB4222.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

> -----Original Message-----
> From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> Sent: Friday, June 8, 2018 12:13 PM
> To: A.s. Dong <aisheng.dong@nxp.com>
> Cc: dongas86 at gmail.com; dl-linux-imx <linux-imx@nxp.com>;
> kernel at pengutronix.de; Fabio Estevam <fabio.estevam@nxp.com>;
> shawnguo at kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 4/4] soc: imx: add SC firmware IPC and APIs
> 
> On Thu, Jun 07, 2018 at 01:59:26PM +0000, A.s. Dong wrote:
> > Hi Sascha,
> >
> > > -----Original Message-----
> > > From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> > > Sent: Thursday, June 7, 2018 3:09 PM
> > > To: A.s. Dong <aisheng.dong@nxp.com>
> > > Cc: dongas86 at gmail.com; dl-linux-imx <linux-imx@nxp.com>;
> > > kernel at pengutronix.de; Fabio Estevam <fabio.estevam@nxp.com>;
> > > shawnguo at kernel.org; linux-arm-kernel at lists.infradead.org
> > > Subject: Re: [PATCH 4/4] soc: imx: add SC firmware IPC and APIs
> > >
> > > On Thu, Jun 07, 2018 at 04:18:54AM +0000, A.s. Dong wrote:
> > > > Hi Sascha,
> > > >
> > > > > > One problem of the way you suggested may be that:
> > > > > > If we doing like below, we may lose flexibility to change the
> > > > > > MU used for SCU firmware communication.
> > > > > > 	scu at 5d1b0000 {
> > > > > > 		compatible = "fsl,imx8qxp-scu";
> > > > > > 		reg = <0x0 0x5d1b0000 0x0 0x10000>;
> > > > > > 	};
> > > > > >
> > > > > > And current design is that the system supports multiple MU
> > > > > > channels used by various users at the same time, e.g. SCU,
> > > > > > Power Domain, Clock and
> > > > > others.
> > > > > > User can flexibly change it under their nodes: And each MU
> > > > > > channel is protected by their private lock and not affect each others.
> > > > > >
> > > > > > e.g.
> > > > > >         scu {
> > > > > >                 compatible = "nxp,imx8qxp-scu", "simple-bus";
> > > > > >                 fsl,mu = <&lsio_mu0>;
> > > > > >
> > > > > >                 clk: clk {
> > > > > >                         compatible = "fsl,imx8qxp-clk";
> > > > > >                         #clock-cells = <1>;
> > > > > >                 };
> > > > > >
> > > > > >                 iomuxc: iomuxc {
> > > > > >                         compatible = "fsl,imx8qxp-iomuxc";
> > > > > >                         fsl,mu = <&lsio_mu3>;
> > > > > >                 };
> > > > > >
> > > > > >                 imx8qx-pm {
> > > > > >                         #address-cells = <1>;
> > > > > >                         #size-cells = <0>;
> > > > > >                         fsl,mu = <&lsio_mu4>;
> > > > > > 	.............
> > > > > >         }
> > > > > >
> > > > > > The default code only uses MU0 which is used by SCU.
> > > > > >
> > > > > > The change may affect this design. Any ideas?
> > > > >
> > > > > Sorry for the delay.
> > > > >
> > > > > You can add the child nodes to the mu nodes they should use:
> > > > >
> > > > > 	scu1 {
> > > > >         	compatible = "nxp,imx8qxp-scu";
> > > > > 		reg = <0x0 0x5d1b0000 0x0 0x10000>;
> > > > >
> > > > > 		clk: clk {
> > > > > 			compatible = "fsl,imx8qxp-clk";
> > > > > 			#clock-cells = <1>;
> > > > > 		};
> > > > >
> > > > > 		...
> > > > > 	};
> > > > >
> > > > > 	scu2 {
> > > > > 		compatible = "nxp,imx8qxp-scu";
> > > > > 		reg = <0x0 someothermu 0x0 0x10000>;
> > > > >
> > > > > 		iomuxc: iomuxc {
> > > > > 			compatible = "fsl,imx8qxp-iomuxc";
> > > > > 		};
> > > > >
> > > > > 		...
> > > > > 	};
> > > > >
> > > > > So instead of adding all possible children to a single mu and
> > > > > phandle to other mu's, just add the right children to each mu.
> > > > >
> > > >
> > > > I got your point now. But sorry i'm still a bit hestitate to it....
> > > >
> > > > This way increases complexity and looks more like a per-channel
> binding.
> > > > But we normally have only one (abstract) SCU firmware node in a
> > > > system which may use different channels to implement different
> > > > functions like clk,
> > > pd and etc.
> > > > Multiple faked SCU nodes make people a bit confusing.
> > >
> > > They are not faked, indeed that's the MU units that physically exist.
> > >
> > > > Furthermore, it's still lose the flexibility for user to changing a MU to use.
> > > >
> > > > Looking at all exist users in kernel, seems no one to use like this.
> > > > See:
> > > > Documentation/devicetree/bindings/arm/arm,scpi.txt
> > > > Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
> > > >
> > > > All are similar like:
> > > > xxx: protocol-node {
> > > >                 compatible = "xxx-protocal";
> > > > 	  channel = ...
> > > >                 ...
> > > >
> > > >                 clk_node: clk_node {
> > > >                         ...
> > > >                 };
> > > >
> > > >                 pd_node: pd_node {
> > > >                         ...
> > > >                 };
> > > > };
> > > > The protocol node work is selecting the correct channel, do
> > > > necessary initialization and populate the all child function device nodes.
> > > >
> > > > IMHO I'm still a bit like to this common way used in kernel if no
> > > > stronger
> > > objection.
> > > > Do you think we can choose this way to go step forward?
> > >
> > > I'm not convinced, but go ahead if you think this is the better way to
> proceed.
> > >
> > > I think my original point that led to this discussion is the muddled
> > > way the MUs are handled in the code.
> > >
> > > To start with in the system controller code you ioremap the physical
> > > address of the MU and later on pass this address as a reference to
> > > the MU library code. There's no way for the MU code to ever create a
> > > private data. It would be much better if you would pass mu_init a
> > > pointer to the device node it shall initialize, let mu_init allocate
> > > a private data struct, ioremap the base and put it in the private data struct,
> and return the private data struct.
> > >
> >
> > Actually I have tried that way initially, but ....
> >
> > > Then there is this sc_ipc_get_handle() thing that your consumers
> > > shall use to get a handle to the SCU. Instead of returning a struct
> > > sc_ipc * there you return a ida which you first have to search for
> > > each time a consumer wants to do something on the SCU. Please just
> > > return a pointer there (which can be a cookie, i.e. the struct
> > > definition is unknown to the consumer but privately to the SCU code).
> > >
> >
> > The problem is that sc_ipc_t is defined as uint32_t.
> > /*
> >  * This type is used to declare a handle for an IPC communication
> >  * channel. Its meaning is specific to the IPC implementation.
> >  */
> > typedef uint32_t sc_ipc_t;
> >
> > which is referenced by the standard rpc call:
> > void sc_call_rpc(sc_ipc_t ipc, sc_rpc_msg_t *msg, bool no_resp)
> >
> > I can't return a pointer which is 64bit on ARMv8 platform and used it
> > for sc_call_rpc directly.
> >
> > That why I need a way to convert struct sc_ipc_t to struct sc_ipc
> > (done by sc_ipc_get(ipc)).
> >
> > But you're right, that means we have to search for each time a
> > consumer wants to do something on the SCU.
> >
> > If we want to void it,  one possible way may be changing the prototype
> > of both ipc handle sc_ipc_t  and IPC channel ID sc_ipc_id_t to
> > unsigned long, then we can directly pass them the address pointer.
> >
> > Although I initially don't want to changing SCU API prototype, but if
> > we have to, I will do it.
> 
> Don't try to push crappy code just because you use the same crappy code
> internally elsewhere. Everything you post for the Kernel is subject for
> discussion, review and change. If we would follow the it's-in-sync-with-
> internal-company-code argument the Kernel would loook differently now
> and surely not better.
> 

Yes, I do agree with you. That's why I'd also like a change now.
Will do that way, If any issue pleases let me know.
Thanks for the suggestion.

Regards
Dong Aisheng

> Sascha
> 
> --
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 |
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fww
> w.pengutronix.de%2F&data=02%7C01%7Caisheng.dong%40nxp.com%7Cb2b
> c8844a75c4321cde908d5ccf62fa7%7C686ea1d3bc2b4c6fa92cd99c5c301635%7
> C0%7C0%7C636640280097302814&sdata=T3xyXepjdIsF11sCjn9Xe8A8qAlsAA3
> b%2BQfs%2FCzGNeo%3D&reserved=0  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
