From: peng.fan@nxp.com (Peng Fan)
Date: Wed, 11 Jul 2018 13:30:04 +0000
Subject: [PATCH V4 3/5] mailbox: imx: add imx mu support
In-Reply-To: <AM0PR04MB42113391A6EA741E2767C74B805A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1531061817-1980-1-git-send-email-aisheng.dong@nxp.com>
 <1531061817-1980-4-git-send-email-aisheng.dong@nxp.com>
 <20180710141940.oed3kwhbplnykl36@pengutronix.de>
 <AM0PR04MB42113391A6EA741E2767C74B805A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <HE1PR04MB3004A524FF80D8BCA79E9DE0885A0@HE1PR04MB3004.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi A.S

> -----Original Message-----
> From: A.s. Dong
> Sent: 2018?7?11? 15:30
> To: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: linux-arm-kernel at lists.infradead.org; dongas86 at gmail.com; Jassi Brar
> <jassisinghbrar@gmail.com>; linux-kernel at vger.kernel.org; Oleksij Rempel
> <o.rempel@pengutronix.de>; dl-linux-imx <linux-imx@nxp.com>;
> kernel at pengutronix.de; Fabio Estevam <fabio.estevam@nxp.com>;
> shawnguo at kernel.org
> Subject: RE: [PATCH V4 3/5] mailbox: imx: add imx mu support
> 
> Hi Sascha,
> 
> > -----Original Message-----
> > From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> > Sent: Tuesday, July 10, 2018 10:20 PM
> > To: A.s. Dong <aisheng.dong@nxp.com>
> > Cc: linux-arm-kernel at lists.infradead.org; dongas86 at gmail.com; Jassi
> > Brar <jassisinghbrar@gmail.com>; linux-kernel at vger.kernel.org; Oleksij
> > Rempel <o.rempel@pengutronix.de>; dl-linux-imx <linux-imx@nxp.com>;
> > kernel at pengutronix.de; Fabio Estevam <fabio.estevam@nxp.com>;
> > shawnguo at kernel.org
> > Subject: Re: [PATCH V4 3/5] mailbox: imx: add imx mu support
> >
> > Hi,
> >
> > On Sun, Jul 08, 2018 at 10:56:55PM +0800, Dong Aisheng wrote:
> > > This is used for i.MX multi core communication.
> > > e.g. A core to SCU firmware(M core) on MX8.
> > >
> > > Tx is using polling mode while Rx is interrupt driven and schedule a
> > > hrtimer to receive remain words if have more than
> > > 4 words.
> >
> > You told us that using interrupts is not possible due to miserable
> > performance, we then provided you a way with which you could poll.
> > Why are you using interrupts now?
> >
> 
> Because mailbox framework does not support sync rx now, I think we do not
> need to wait for that feature done first as it's independent and  separate
> features of framework.
> 
> So for now, we're just using the common way in kernel as arm scpi and ti sci.
> When framework supports it, we can easily switch to it.
> 
> I optimized the performance a bit by removing the unnecessary memcopy
> between tx/tx messages. The test result of booting time shows there's no
> obvious regressions. I'm not sure whether it's due to we're booting a minimum
> system or the extra cost is very minor to be noticed due to not too much cmds
> sent during booting.
> (Copy Peng to comments more as he tried and reported that performance drop
> with vendor tree)

The txpoll_period is set 1, the minimum is 1ms. So it introduces latency in the initial mailbox
for SCU communication.

Regards,
Peng

> 
> From the time measurement of sc_call_rpc, we can see that most rpc command
> In polling mode can finish within 10us and very rare ones over 20us.
> If switched to irq mode, those 10us cmds will change to about 20us.
> 
> But the overall booting time did not increase much. Maybe the irq mode also
> saves some CPU MIPS to execute other works in parallel?
> 
> > We also suggested a way how the SCU mode could be integrated into the
> > generic MU support driver Oleksij posted and now you send a driver
> > which uses the same name as Oleksijs driver, but it only and
> > exclusively works in SCU mode. This doesn't bring us forward.
> >
> 
> Can Oleksij's patch be implemented against this one?
> As I remember you said we've still not determined whether Oleksij's approach is
> the most suitable way and it's still under discussion.
> (Actually TI's approach looks better which is more simiar as SCU way?)
> 
> Furthermore, from this patch, you will notice that Oleksij's patch almost did not
> work for SCU at all. I have to totally rewrite one for SCU.
> So I did not write against his patch as it does not help.
> And Oleksij's patch is quite simple while the SCU one is much complicated than
> his one. So we probably better get SCU done first.
> 
> > We suggested a binding that allows coexisting of the SCU mode and the
> > generic mode of the MU by putting the mode information into the second
> > mbox-cell. Why don't you use this?
> >
> 
> You mean this?
> +#define IMX_MU_CHANNEL0		0
> +#define IMX_MU_CHANNEL1		1
> +#define IMX_MU_CHANNEL2		2
> +#define IMX_MU_CHANNEL3		3
> +#define IMX_MU_CHANNEL_IMX8_SCU 4
> 
> It's hard for me to believe it's correct and it's over abstract to HW.
> So I thought using mbox-cells to distinguish seems to be better.
> 
> > I don't think it's necessary to rewrite Oleksijs driver, instead it
> > should rather be extended with the code I already provided as an
> > example. With that we could make both of us happy since we can both
> > have a suitable driver and even share most of the MU code.
> 
> As I said above, I even can't reuse 90%+ code of Oleksijs driver. So I can't see the
> meaning to demo the code on top of this driver. We can review the SCU
> implementation directly with this driver which is more easy.
> Then we can decide how to merge them together.
> 
> Regards
> Dong Aisheng
> 
> >
> > Regards,
> > Sascha
> >
> > --
> > Pengutronix e.K.                           |
> |
> > Industrial Linux Solutions                 |
> > https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fww
> > w.pengutronix.de%2F&amp;data=02%7C01%7Caisheng.dong%40nxp.com%7
> >
> Cb359a3eddee54bf1b40a08d5e6702f22%7C686ea1d3bc2b4c6fa92cd99c5c301
> >
> 635%7C0%7C0%7C636668291863846639&amp;sdata=hSucaLRfCB1j1McwlfO%
> > 2FL0921QXiHg68sl%2B23CvEp4Q%3D&amp;reserved=0  |
> > Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0
> |
> > Amtsgericht Hildesheim, HRA 2686           | Fax:
> +49-5121-206917-5555 |
