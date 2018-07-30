From: aisheng.dong@nxp.com (A.s. Dong)
Date: Mon, 30 Jul 2018 14:14:17 +0000
Subject: [PATCH v7 3/6] dt-bindings: mailbox: imx-mu: add generic MU
 channel support
In-Reply-To: <CABb+yY3PLcjduxm7uJ9xZpPP2zkcQ5Qngs4PjnhGAXp43QVzFA@mail.gmail.com>
References: <20180726065331.6186-1-o.rempel@pengutronix.de>
 <20180726065331.6186-4-o.rempel@pengutronix.de>
 <CABb+yY0kVFvQRBrU4j9t=_JcSUkcXMMSK5u=XSufM6XcmKiv-g@mail.gmail.com>
 <AM0PR04MB42116C756EC78AD12EB254D6802B0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <CABb+yY0yn9os6nqH8eUfAr3Q3ev4=TfpTp=5ZDBR7FN67eb-wg@mail.gmail.com>
 <VI1PR04MB4222672B8F7B6AF2B11A4442802A0@VI1PR04MB4222.eurprd04.prod.outlook.com>
 <CABb+yY1EkHk85H72xYoYA3JbQL03+-o3UcRVdA_Zub-Q+D=OHw@mail.gmail.com>
 <VI1PR04MB422216469EE5F3ED8E53A4F1802A0@VI1PR04MB4222.eurprd04.prod.outlook.com>
 <CABb+yY0SfdFr8TMOMosTVb5+LFWqB8nQkKj3ze8usi-s7Cko4g@mail.gmail.com>
 <VI1PR04MB4222B4877B341C0FA07A6A8D802A0@VI1PR04MB4222.eurprd04.prod.outlook.com>
 <CABb+yY1MSSQKZ6BOQXC-x=qy4VZ5HqDBjmh_BJTXSkAm3+P8mA@mail.gmail.com>
 <bf7aca98-7ec8-bcf3-b1a8-d86a7cf28d31@pengutronix.de>
 <CABb+yY3PLcjduxm7uJ9xZpPP2zkcQ5Qngs4PjnhGAXp43QVzFA@mail.gmail.com>
Message-ID: <AM0PR04MB4211EF3D479D6B8A093ACCB2802F0@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Jassi Brar [mailto:jassisinghbrar at gmail.com]
> Sent: Monday, July 30, 2018 9:05 PM
> To: Oleksij Rempel <o.rempel@pengutronix.de>
> Cc: A.s. Dong <aisheng.dong@nxp.com>; , Sascha Hauer
> <kernel@pengutronix.de>; Shawn Guo <shawnguo@kernel.org>; Fabio
> Estevam <fabio.estevam@nxp.com>; Rob Herring <robh+dt@kernel.org>;
> Mark Rutland <mark.rutland@arm.com>; Vladimir Zapolskiy
> <vladimir_zapolskiy@mentor.com>; ", linux-arm-
> kernel"@lists.infradead.org; , linux-arm-kernel at lists.infradead.org, linux-
> mediatek at lists.infradead.org, srv_heupstream <linux-
> mediatek at lists.infradead.org>; srv_heupstream <linux-arm-
> kernel at lists.infradead.org>; Devicetree List <devicetree@vger.kernel.org>;
> dl-linux-imx <linux-imx@nxp.com>
> Subject: Re: [PATCH v7 3/6] dt-bindings: mailbox: imx-mu: add generic MU
> channel support
> 
> On Mon, Jul 30, 2018 at 1:05 PM, Oleksij Rempel <o.rempel@pengutronix.de>
> wrote:
> > Hi Aishen, Jassie,
> >
> > i'm lost in this discussion. Please, as soon as I need to add some
> > changes to my patches, notify me. Preferably on top for email.
> >
> I am ok with however you choose to implement, 8 unidirectional or 4
> bidirectional channels or whatever.
> 
> We just can't have protocol specific s/w modes in the controller drivers.
> 

Do you think implement "Passing short messages" defined in reference
manual in controller driver is protocol specific?
That seems like our most argument before.

> The best solution is to fix the SCU firmware. If that is _really_ impossible, I
> provided a solution (3 cells work around). If you have a better idea please
> feel free to propose and implement that.
> 

That's out of our control.
SCU firmware is not using Linux and there's no mailbox framework.
It's simply follow "passing short messages" way to send multi words with 4 data
Registers.
 
> It will also help if you could share the user code of "scu-mode". If there is no
> such code (and we know the driver doesn't respect the "scu-mode" property)
> why do we even have that binding? Maybe drop it.

You can refer to this patch for the user code of "scu-mode".
[RFC PATCH v6 2/2] mailbox: imx-mailbox: add scu protocol support
https://www.spinics.net/lists/arm-kernel/msg665135.html

And I do admit that there're two protocol specific bits in the driver.
1. Unlike TI message header, SCU size is in the second u8.
Ti message header:
struct ti_msgmgr_message {
        size_t len;
        u8 *buf;
};
Controller get the size from the first u32.

SCU message header:
struct sc_rpc_msg {
        uint8_t ver;
        uint8_t size;
        uint8_t svc; 
        uint8_t func;
};
Controller get the size from the second u8.

And a full SCU message is like:
struct imx_sc_msg_req_set_clock_rate {
        struct sc_rpc_msg hdr;
        u32 rate;
        u16 resource;
        u8 clk;
} __packed;

2. There's no synchronous read function in mailbox framework,
So we use mbox_client_peek_data to read data which can't return
the read data. In order to save a mem copy from read data to the
data buffer, the controller driver saves the tx data buffer in itself. 
(Anyway to improve? Maybe we should implement a synchronous
mbox_client_read_data()?)

And for SCU IPC client, it's something like:
int sc_call_rpc(sc_ipc_t ipc, void *msg, bool no_resp)
{
        ...
        mbox_send_message(sc_ipc->chan, msg);

        if (!no_resp) 
                ret = mbox_client_peek_data(sc_ipc->chan);

        mbox_client_txdone(sc_ipc->chan, ret);
        ...
}

int sc_ipc_open(sc_ipc_t *ipc, struct device *dev)
{
        sc_ipc->cl.dev = dev; 
        sc_ipc->cl.tx_block = false;
        sc_ipc->cl.knows_txdone = true;

        sc_ipc->chan = mbox_request_channel(&sc_ipc->cl, 0);
        ...
}

Any better ideas?

Regards
Dong Aisheng

> 
> thnx.
