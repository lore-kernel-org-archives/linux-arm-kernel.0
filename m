From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 10 Sep 2018 09:03:49 +0200
Subject: [PATCH V5 0/5] soc: imx: add scu firmware api support
In-Reply-To: <AM0PR04MB4211EB20F182FD13C8070CA880010@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20180827083310.omqa3kpmj542fu3b@pengutronix.de>
 <AM0PR04MB4211E5D66FD8502278765EC8800B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <AM0PR04MB42113BB0FA9E54629339F872800B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20180828062113.khmkvsj3ofc7muu6@pengutronix.de>
 <AM0PR04MB4211A6BC038A141BA25B638A800A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20180829065346.zi6v6me7ufft7ntt@pengutronix.de>
 <AM0PR04MB42110CB29DC190C9163B2FB580090@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <AM0PR04MB4211680A90724E089F5A1468800C0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20180903114439.7y4zl63bpy26od23@pengutronix.de>
 <AM0PR04MB4211EB20F182FD13C8070CA880010@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <20180910070348.gempczezq36ansgm@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 06, 2018 at 03:21:39AM +0000, A.s. Dong wrote:
> Hi Sasha,
> 
> > -----Original Message-----
> > From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> > Sent: Monday, September 3, 2018 7:45 PM
> >
> > On Mon, Sep 03, 2018 at 08:57:36AM +0000, A.s. Dong wrote:
> > > Hi Sascha,
> > >
> > > > -----Original Message-----
> > > > From: A.s. Dong
> > > > Sent: Wednesday, August 29, 2018 4:35 PM
> > > > To: Sascha Hauer <s.hauer@pengutronix.de>
> > >
> > > [...]
> > >
> > > > > > The original point is to separate the SCU service API
> > > > > > implementation from the client drivers. Client drivers don't
> > > > > > have to know the internal details of the API implementation,
> > > > > > they just use the service API provided by SCU firmware. API
> > > > > > implementation and client users will be
> > > > > maintained independently.
> > > > >
> > > > > I would buy this argument if the 'API implementation' was more
> > > > > than a shim layer that directly translates between function
> > > > > arguments and a
> > > > message struct.
> > > > > With this you effectively can't change the API implementation
> > > > > without changing the API you provide to the client drivers.
> > > > >
> > > >
> > > > In reality, the API implementation could change without changing the
> > > > API prototype.
> > > > The API is defined in a more generic way and less possible to change.
> > > > But the internal implementation is allowed to change if the firmware
> > updates.
> > > > e.g. protocol params layout and size and etc.
> > > >
> > > > This way give us a clear separation between API internals and client
> > > > users which are more like to be maintained independently.
> > > > And it may also help if we want to support old firmware due to API
> > > > internal implementation changes. (And note that SCU firmware
> > > > supports many functions, distribute them into various drivers may
> > > > cause a bit mess. Some of them may get troubles on finding a proper
> > > > place to put.)
> > 
> > Examples?
> > 
> 
> Take sc_misc_set_control as example which is widely used by various client drivers.
> Encoding message in driver may cause many duplicated code. 
> Cscope tag: sc_misc_set_control
>    #   line  filename / context / line
>    1    206  drivers/clk/imx/clk-divider-scu.c <<clk_divider3_scu_set_rate>>
>              sci_err = sc_misc_set_control(ccm_ipc_handle, clk->rsrc_id,

You can still create a helper function for these calls. I was mainly
aiming for the oneshot usages of several other functions.

> > > >
> > > > So aren't those more valuable comparing to move SCU APIs into client
> > drivers?
> > > > And current kernel users (arm scpi/scmi, ti sci) already do like
> > > > this... why not i.MX?
> > > >
> > > > Sorry if I still not get your point.
> > > > Please help clarify a bit more if I missed something..
> > >
> > > Please let me know if you still believe moving SCU API implementation
> > > into each client driver is a more reasonable way to go, then i will do
> > > it as I trust your professionality.
> > 
> > Yes, I still think that. I still think the 1:1 mapping between messages and
> > function calls is an unnecessary overhead.
> > 
> 
> Okay, let's do that way first if you still think it's proper.
> BTW, do you have any comment about the MU usage in Patch 2/5 ?
> [V5,2/5] soc: imx: add SC firmware IPC and APIs
> https://patchwork.kernel.org/patch/10570551/

The MU usage looks fine from a first glance.

The way you share a global scu handle with your clients still looks
ridiculous though.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
