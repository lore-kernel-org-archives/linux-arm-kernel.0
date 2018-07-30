From: aisheng.dong@nxp.com (A.s. Dong)
Date: Mon, 30 Jul 2018 14:27:30 +0000
Subject: [PATCH v7 3/6] dt-bindings: mailbox: imx-mu: add generic MU
 channel support
In-Reply-To: <AM0PR04MB4211EF3D479D6B8A093ACCB2802F0@AM0PR04MB4211.eurprd04.prod.outlook.com>
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
 <AM0PR04MB4211EF3D479D6B8A093ACCB2802F0@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <AM0PR04MB42115DC21B8B4F3CC78C6BAA802F0@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]
> > It will also help if you could share the user code of "scu-mode". If
> > there is no such code (and we know the driver doesn't respect the
> > "scu-mode" property) why do we even have that binding? Maybe drop it.
> 
> You can refer to this patch for the user code of "scu-mode".
> [RFC PATCH v6 2/2] mailbox: imx-mailbox: add scu protocol support
> https://www.spinics.net/lists/arm-kernel/msg665135.html
> 
> And I do admit that there're two protocol specific bits in the driver.
> 1. Unlike TI message header, SCU size is in the second u8.
> Ti message header:
> struct ti_msgmgr_message {
>         size_t len;
>         u8 *buf;
> };
> Controller get the size from the first u32.
> 
> SCU message header:
> struct sc_rpc_msg {
>         uint8_t ver;
>         uint8_t size;
>         uint8_t svc;
>         uint8_t func;
> };
> Controller get the size from the second u8.
> 
> And a full SCU message is like:
> struct imx_sc_msg_req_set_clock_rate {
>         struct sc_rpc_msg hdr;
>         u32 rate;
>         u16 resource;
>         u8 clk;
> } __packed;
> 
> 2. There's no synchronous read function in mailbox framework, So we use
> mbox_client_peek_data to read data which can't return the read data. In
> order to save a mem copy from read data to the data buffer, the controller
> driver saves the tx data buffer in itself.
> (Anyway to improve? Maybe we should implement a synchronous
> mbox_client_read_data()?)
> 
> And for SCU IPC client, it's something like:
> int sc_call_rpc(sc_ipc_t ipc, void *msg, bool no_resp) {
>         ...
>         mbox_send_message(sc_ipc->chan, msg);
> 
>         if (!no_resp)
>                 ret = mbox_client_peek_data(sc_ipc->chan);
> 
>         mbox_client_txdone(sc_ipc->chan, ret);
>         ...
> }
> 
> int sc_ipc_open(sc_ipc_t *ipc, struct device *dev) {
>         sc_ipc->cl.dev = dev;
>         sc_ipc->cl.tx_block = false;
>         sc_ipc->cl.knows_txdone = true;
> 
>         sc_ipc->chan = mbox_request_channel(&sc_ipc->cl, 0);
>         ...
> }
> 
> Any better ideas?
> 

And this the original implementation used by NXP internally without mailbox.
As it's quite simple and suppose more easy to help you understand the using of SCU.

void mu_send_msg(struct mu_priv *priv, uint32_t index, uint32_t msg)
{
        ...
        /* Wait TX register to be empty. */ 
        while (!(readl_relaxed(priv->base + MU_ASR) & mask))
                ;
        writel_relaxed(msg, priv->base + MU_ATR0  + (index * 4));
}

/*
 * Wait to receive message from the other core.
 */
void mu_receive_msg(struct mu_priv *priv, uint32_t index, uint32_t *msg)
{
        ...
        /* Wait RX register to be full. */
        while (!(readl_relaxed(priv->base + MU_ASR) & mask))
                ;
        *msg = readl_relaxed(priv->base + MU_ARR0 + (index * 4));
}

static void sc_ipc_read(struct sc_ipc *sc_ipc, void *data)
{
        sc_rpc_msg_t *msg = (sc_rpc_msg_t *)data;
 
        /* Read first word */
        mu_receive_msg(sc_ipc->mu, 0, (uint32_t *)msg);
        count++;
 
        /* Read remaining words */
        while (count < msg->size) {
                mu_receive_msg(sc_ipc->mu, count % MU_RR_COUNT,
                               &(msg->DATA.u32[count - 1]));
                count++;
        }
}

static void sc_ipc_write(struct sc_ipc *sc_ipc, void *data)
{
        sc_rpc_msg_t *msg = (sc_rpc_msg_t *)data;
        uint8_t count = 0;

        /* Write first word */
        mu_send_msg(sc_ipc->mu, 0, *((uint32_t *)msg));
        count++;

        while (count < msg->size) {
                mu_send_msg(sc_ipc->mu, count % MU_TR_COUNT,
                            msg->DATA.u32[count - 1]);
                count++;
        }
}

void sc_call_rpc(sc_ipc_t ipc, sc_rpc_msg_t *msg, bool no_resp)
{
        sc_ipc_write(sc_ipc, msg);
        if (!no_resp)
                sc_ipc_read(sc_ipc, msg);
}

For details, see:
https://www.spinics.net/lists/arm-kernel/msg659138.html

Regards
Dong Aisheng

> Regards
> Dong Aisheng
> 
> >
> > thnx.
