From: aisheng.dong@nxp.com (A.s. Dong)
Date: Wed, 11 Jul 2018 16:41:08 +0000
Subject: [PATCH V4 3/5] mailbox: imx: add imx mu support
In-Reply-To: <CABb+yY0SqUFfS0ts9QHnKbqH0YW5-dLw7PxcjVa3eK_c3zrNpA@mail.gmail.com>
References: <1531061817-1980-1-git-send-email-aisheng.dong@nxp.com>
 <1531061817-1980-4-git-send-email-aisheng.dong@nxp.com>
 <20180710141940.oed3kwhbplnykl36@pengutronix.de>
 <AM0PR04MB42113391A6EA741E2767C74B805A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20180711075456.npwfpm6mtpkx7k76@pengutronix.de>
 <AM0PR04MB42119DAE987CDF871CA8CFC6805A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <CABb+yY1kH8mr3=nazsLXrLaNWT0x6j9MizVaE+bZaHmrsKn-Wg@mail.gmail.com>
 <AM0PR04MB4211AD523CFB8DA99AB05EFC805A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <CABb+yY0SqUFfS0ts9QHnKbqH0YW5-dLw7PxcjVa3eK_c3zrNpA@mail.gmail.com>
Message-ID: <AM0PR04MB4211F30775A0C806F44626C8805A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jassi,

> -----Original Message-----
> From: Jassi Brar [mailto:jassisinghbrar at gmail.com]
> Sent: Thursday, July 12, 2018 12:32 AM
> To: A.s. Dong <aisheng.dong@nxp.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>; linux-arm-
> kernel at lists.infradead.org; dongas86 at gmail.com; linux-
> kernel at vger.kernel.org; Oleksij Rempel <o.rempel@pengutronix.de>; dl-
> linux-imx <linux-imx@nxp.com>; kernel at pengutronix.de; Fabio Estevam
> <fabio.estevam@nxp.com>; shawnguo at kernel.org
> Subject: Re: [PATCH V4 3/5] mailbox: imx: add imx mu support
> 
> On Wed, Jul 11, 2018 at 6:28 PM, A.s. Dong <aisheng.dong@nxp.com> wrote:
> > Hi Jassi,
> >
> >> -----Original Message-----
> >> From: Jassi Brar [mailto:jassisinghbrar at gmail.com]
> >> Sent: Wednesday, July 11, 2018 6:44 PM
> >> To: A.s. Dong <aisheng.dong@nxp.com>
> >> Cc: Sascha Hauer <s.hauer@pengutronix.de>; linux-arm-
> >> kernel at lists.infradead.org; dongas86 at gmail.com; linux-
> >> kernel at vger.kernel.org; Oleksij Rempel <o.rempel@pengutronix.de>; dl-
> >> linux-imx <linux-imx@nxp.com>; kernel at pengutronix.de; Fabio Estevam
> >> <fabio.estevam@nxp.com>; shawnguo at kernel.org
> >> Subject: Re: [PATCH V4 3/5] mailbox: imx: add imx mu support
> >>
> >> On Wed, Jul 11, 2018 at 4:07 PM, A.s. Dong <aisheng.dong@nxp.com>
> wrote:
> >> >
> >> > > -----Original Message-----
> >> > > From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> >> > > Sent: Wednesday, July 11, 2018 3:55 PM
> >> > > To: A.s. Dong <aisheng.dong@nxp.com>
> >> > > Cc: linux-arm-kernel at lists.infradead.org; dongas86 at gmail.com;
> >> > > Jassi Brar <jassisinghbrar@gmail.com>;
> >> > > linux-kernel at vger.kernel.org; Oleksij Rempel
> >> > > <o.rempel@pengutronix.de>; dl-linux-imx <linux-imx@nxp.com>;
> >> > > kernel at pengutronix.de; Fabio Estevam <fabio.estevam@nxp.com>;
> >> > > shawnguo at kernel.org
> >> > > Subject: Re: [PATCH V4 3/5] mailbox: imx: add imx mu support
> >> > >
> >> > > On Wed, Jul 11, 2018 at 07:29:38AM +0000, A.s. Dong wrote:
> >> > > > Hi Sascha,
> >> > > >
> >> > > > > -----Original Message-----
> >> > > > > From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> >> > > > > Sent: Tuesday, July 10, 2018 10:20 PM
> >> > > > > To: A.s. Dong <aisheng.dong@nxp.com>
> >> > > > > Cc: linux-arm-kernel at lists.infradead.org; dongas86 at gmail.com;
> >> > > > > Jassi Brar <jassisinghbrar@gmail.com>;
> >> > > > > linux-kernel at vger.kernel.org; Oleksij Rempel
> >> > > > > <o.rempel@pengutronix.de>; dl-linux-imx <linux-imx@nxp.com>;
> >> > > > > kernel at pengutronix.de; Fabio Estevam
> <fabio.estevam@nxp.com>;
> >> > > > > shawnguo at kernel.org
> >> > > > > Subject: Re: [PATCH V4 3/5] mailbox: imx: add imx mu support
> >> > > > >
> >> > > > > Hi,
> >> > > > >
> >> > > > > On Sun, Jul 08, 2018 at 10:56:55PM +0800, Dong Aisheng wrote:
> >> > > > > > This is used for i.MX multi core communication.
> >> > > > > > e.g. A core to SCU firmware(M core) on MX8.
> >> > > > > >
> >> > > > > > Tx is using polling mode while Rx is interrupt driven and
> >> > > > > > schedule a hrtimer to receive remain words if have more
> >> > > > > > than
> >> > > > > > 4 words.
> >> > > > >
> >> > > > > You told us that using interrupts is not possible due to
> >> > > > > miserable performance, we then provided you a way with which
> >> > > > > you
> >> could poll.
> >> > > > > Why are you using interrupts now?
> >> > > > >
> >> > > >
> >> > > > Because mailbox framework does not support sync rx now, I think
> >> > > > we do not need to wait for that feature done first as it's
> >> > > > independent and separate features of framework.
> >> > >
> >> > > You can wait forever for this feature, nobody will add it for you.
> >> > > It's up to you to add support for that feature. Who else should
> >> > > add this
> >> feature if not you?
> >> > > And when will you add that feature if not now when you actually need
> it?
> >> > > It is common practice that you adjust the frameworks to your
> >> > > needs rather than working around them.
> >> > >
> >> >
> >> > I'm willing to add it. Just because you said Jassi already had the
> >> > idea on how to Implement it and does not add much complexity. So I
> >> > just
> >> want to see his patches.
> >> > But if he did not work on it, I can also help on it.
> >> >
> >> I am not much aware of the history of this conversation... but it
> >> seems you need to make use of mbox_chan_ops.peek_data().
> >>
> >> If not that, please let me know the requirement.
> >>
> >
> > Thanks for the suggestion.
> > It looks to me may work.
> >
> > From the definition, it seems it's used to pull data from remote side.
> > /**
> >  * mbox_client_peek_data - A way for client driver to pull data
> >  *                      received from remote by the controller.
> >  * @chan: Mailbox channel assigned to this client.
> >  *
> >  * A poke to controller driver for any received data.
> >  * The data is actually passed onto client via the
> >  * mbox_chan_received_data()
> >  * The call can be made from atomic context, so the controller's
> >  * implementation of peek_data() must not sleep.
> >  *
> >  * Return: True, if controller has, and is going to push after this,
> >  *          some data.
> >  *         False, if controller doesn't have any data to be read.
> >  */
> > bool mbox_client_peek_data(struct mbox_chan *chan) {
> >         if (chan->mbox->ops->peek_data)
> >                 return chan->mbox->ops->peek_data(chan);
> >
> >         return false;
> > }
> > EXPORT_SYMBOL_GPL(mbox_client_peek_data);
> > But it seems most users in kernel simply implement it as a data
> > available Checking rather than receiving it.
> > See:
> > drivers/mailbox/ti-msgmgr.c
> > drivers/mailbox/mailbox-altera.c
> >
> > Only bcm uses it to receive data.
> > drivers/mailbox/bcm-flexrm-mailbox.c
> >
> > For our requirement, we want to implement sync receiving protocol like:
> > Sc_call_rpc()
> > {
> >         mbox_send_message(chan, msg)
> >         If (!no_resp)
> >                 // rx also stored in msg
> >                 mbox_receive_msg_in_polling(chan, msg);
> >         mbox_client_txdone();
> > }
> >
> > If using peek_data, it can be:
> > Sc_call_rpc()
> > {
> >         mbox_send_message(chan, msg)
> >         If (!no_resp)
> >                 // rx also stored in msg
> >                 Mbox_client_peek_data(chan);
> >
> Yes, and you may want to loop for a certain amount of time if peek keeps
> returning false.
> 
> >         mbox_client_txdone();
> > }
> >
> > And for mu controller driver .peek_data():
> > imx_mu_peek_data(chan)
> > {
> >         // get first word and parse data size
> >         imx_mu_receive_msg(&mu->chans, 0, mu->msg);
> >
> >         raw_data = (u8 *)mu->msg;
> >         size = raw_data[1];
> >
> >         // receive rest of them
> >         for (i = 1; i < size; i++) {
> >                 ret = imx_mu_receive_msg(&mu->chans, i % 4, mu->msg + i);
> >                 if (ret)
> >                         return false;
> >         }
> >
> >         mbox_chan_received_data(&mu->chans, (void *)mu->msg);
> >
> Not sure how your controller works. But the peek() callback only _checks_ if
> there is some data available to be read. Please note that
> peek() can not sleep.
> So if the data fetching doesn't sleep you can do that here, otherwise peek
> has to schedule the actual fetching of data from remote and providing to the
> client via mbox_chan_received_data.
> 

bcm seems is using peek to receive data, not only checking the data availability,
right?
drivers/mailbox/bcm-flexrm-mailbox.c

So I did the similar way for i.MX. I just sent out that new patch series.
Please help review if any problem of it.
BTW i.MX peek is using busy polling, so won't sleep.

Regards
Dong Aisheng

> -jassi
