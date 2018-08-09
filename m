From: aisheng.dong@nxp.com (A.s. Dong)
Date: Thu, 9 Aug 2018 02:22:41 +0000
Subject: [PATCH v7 3/6] dt-bindings: mailbox: imx-mu: add generic MU
 channel support
In-Reply-To: <AM0PR04MB42112E77338240832E2E5077802C0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <AM0PR04MB42116C756EC78AD12EB254D6802B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <CABb+yY0yn9os6nqH8eUfAr3Q3ev4=TfpTp=5ZDBR7FN67eb-wg@mail.gmail.com>
 <VI1PR04MB4222672B8F7B6AF2B11A4442802A0@VI1PR04MB4222.eurprd04.prod.outlook.com>
 <CABb+yY1EkHk85H72xYoYA3JbQL03+-o3UcRVdA_Zub-Q+D=OHw@mail.gmail.com>
 <VI1PR04MB422216469EE5F3ED8E53A4F1802A0@VI1PR04MB4222.eurprd04.prod.outlook.com>
 <CABb+yY0SfdFr8TMOMosTVb5+LFWqB8nQkKj3ze8usi-s7Cko4g@mail.gmail.com>
 <VI1PR04MB4222B4877B341C0FA07A6A8D802A0@VI1PR04MB4222.eurprd04.prod.outlook.com>
 <CABb+yY1MSSQKZ6BOQXC-x=qy4VZ5HqDBjmh_BJTXSkAm3+P8mA@mail.gmail.com>
 <bf7aca98-7ec8-bcf3-b1a8-d86a7cf28d31@pengutronix.de>
 <CABb+yY3PLcjduxm7uJ9xZpPP2zkcQ5Qngs4PjnhGAXp43QVzFA@mail.gmail.com>
 <20180730144435.srxgohwgdhrmw2rz@pengutronix.de>
 <CABb+yY0sUxGatozwdQVM55z7ACtpK8HCepnfvQNunQ=r5y_kVw@mail.gmail.com>
 <CABb+yY04dm_N1Ud2Mhi-g-eFdNVkxJKE8ONOqntZjN_QKwgLcg@mail.gmail.com>
 <AM0PR04MB42118617A7F29C1D7BE59242802E0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <CABb+yY2HaTK9tq539+m1fyMMPr1eyygJZ7QvzWNp9E7aYxpoVQ@mail.gmail.com>
 <CABb+yY0KB7RLK1DyPNNPaXoXkx5WoJhkoKX5XVa+4Q94vC7p4A@mail.gmail.com>
 <AM0PR04MB42112E77338240832E2E5077802C0@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <AM0PR04MB42110FCA0F68A73BA7416EA480250@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jassi,

Do you have any comments about this reply?

Sascha,
What's your option?

Regards
Dong Aisheng

> -----Original Message-----
> From: A.s. Dong
> Sent: Thursday, August 2, 2018 5:24 PM
> To: 'Jassi Brar' <jassisinghbrar@gmail.com>
> Cc: Oleksij Rempel <o.rempel@pengutronix.de>; , Sascha Hauer
> <kernel@pengutronix.de>; Shawn Guo <shawnguo@kernel.org>; Fabio
> Estevam <fabio.estevam@nxp.com>; Rob Herring <robh+dt@kernel.org>;
> Mark Rutland <mark.rutland@arm.com>; Vladimir Zapolskiy
> <vladimir_zapolskiy@mentor.com>; , linux-arm-kernel at lists.infradead.org,
> linux-mediatek at lists.infradead.org, srv_heupstream <linux-arm-
> kernel at lists.infradead.org>; , linux-arm-kernel at lists.infradead.org, linux-
> mediatek at lists.infradead.org, srv_heupstream <linux-
> mediatek at lists.infradead.org>; Devicetree List
> <devicetree@vger.kernel.org>; dl-linux-imx <linux-imx@nxp.com>
> Subject: RE: [PATCH v7 3/6] dt-bindings: mailbox: imx-mu: add generic MU
> channel support
> 
> Hi Jassi,
> 
> > -----Original Message-----
> > From: Jassi Brar [mailto:jassisinghbrar at gmail.com]
> > Sent: Tuesday, July 31, 2018 8:42 PM
> > To: A.s. Dong <aisheng.dong@nxp.com>
> 
> [...]
> 
> > >> Do you need me to send the full scu client driver patch for the reference?
> > >> If yes, please feel free to let me know.
> > >>
> > > Yes, that'll make it clearer.
> > >
> > Thanks for sharing the patch offline.
> >
> > I don't see why it can't be adapted to work with the simple 2-cell
> > implementation. Instead of one virtual, ask for 4 physical channels
> > and send data in u32 chunks sequentially over them.
> > In fact, that should make it even better by removing the tight-loop
> > (zero
> > delay!!) polling in send_data() -- MU does support interrupts, why not
> > use them to avoid polling?  If you find it hard, I can make a patch on
> > top of your client patchset, once Oleksij is done with the MU driver.
> >
> 
> As you insist, I will try to implement multi channels mode, then we can do a
> clear comparison to see which one is better for SCU mode rather than
> assumptions.
> 
> First of all,  using interrupt for each chan will likely to terribly slow down the
> SCU Message handling speed. SCU Messages usually are handled by SCU
> firmware very quickly in a few microseconds. (< 10us). That's why we use
> polling mode for SCU message handling.
> 
> If we break down a SCU message into a few separate MU channel interrupts
> driven, There will be a lot of unnecessary and meaningless interrupt handling.
> And the whole flow may look like:
> 
> Sending Word 0 ->
> Chan 0 interrupt -> (meaningless)
> Sending Word 1 ->
> Chan1 interrupt -> (meaningless)
> Sending Word 2 ->
> Chan2 interrupt -> (meaningless)
> Sending Word 3 ->
> Chan3 interrupt-> (meaningless)
> 
> Sending Word 4 on Chan 0 again ->
> Wait for Chan 0 interrupt (meaningless) -> ...
> 
> Then waiting for Rx:
> 
> Chan 0 Rx interrupt ->
> Read Word 0   ->
> (Then we know response size here)
> 
> Chan 1 Rx interrupt ->
> Read Word 1 ->
> Chan 2 Rx interrupt ->
> Read Word 2 ->
> Chan 3 Rx interrupt ->
> Read Word 3 ->
> 
> (If msg size > 4 words)
> Chan 0 Rx interrupt ->
> Read Word 4
> 
> ...
> And we must use a complicated way to map the received data of each
> channel into one SCU msg buffer and need handle the sequence properly for
> size > 4 words case
> 
> Is this what you intended?
> 
> Per my understanding, there're several issues for this follow:
> 1) Many unnecessary and meaningless interrupts hanllding of Tx and RX
> 2) Performance downgrading
>     A 4 word SCU MSG may need 8 interrupts to handle which terribly slow
>     down the speed. (Interrupt latency will be terrible if many)
> 3) Complex RX flow in order to align with framework design
> 
> Any comments about these issues?
> 
> Generally, from what I see, the mailbox framework really is not designed for
> SCU type devices that handling msg sending or receiving via multiple
> channels.  Including the ring buffer supported for handling several msgs on
> the same channel and rich completion mechanism, none of them are suitable
> for SCU MU in multiple channel mode.
> 
> What we really actually needed is a quite simple way to handle MSG Tx and
> Tx synchronously.
> 
> int sc_call_rpc(sc_ipc_t ipc, void *msg, bool no_resp)
> {
>         ...
>         ret = mbox_send_message(sc_ipc->chan, msg);
>         if (!no_resp)
>                 ret = mbox_receive_message(sc_ipc->chan, msg);
>         ...
>         return ret;
> }
> 
> For me, I don't think the above way driven by interrupt is suitable for SCU.
> But I will still keep investigating if any better way to handle it in multi chan
> mode as you wish.
> 
> How would you suggest for such situation in order to support SCU properly?
> 
> > I have some more suggestions for the client driver. But since I don't
> > have to live with them (you do), I can't demand you make those
> > changes. If you like, please feel free to cc me on the next revision of the
> client driver.
> 
> I certainly appreciate any clear and valuable improvement suggestions.
> Just feel free to let me know if any better idea.
> 
> Regards
> Dong Aisheng
