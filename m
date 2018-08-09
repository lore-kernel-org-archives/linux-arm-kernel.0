From: aisheng.dong@nxp.com (A.s. Dong)
Date: Thu, 9 Aug 2018 06:45:21 +0000
Subject: [PATCH v7 3/6] dt-bindings: mailbox: imx-mu: add generic MU
 channel support
In-Reply-To: <CABb+yY1wGv8XHcTy7WPeD_GGx0J4QF8bcgowJYOoTgTD1R6wPA@mail.gmail.com>
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
 <AM0PR04MB42110FCA0F68A73BA7416EA480250@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <CABb+yY1wGv8XHcTy7WPeD_GGx0J4QF8bcgowJYOoTgTD1R6wPA@mail.gmail.com>
Message-ID: <AM0PR04MB42117A7564C6E1AA4D1232F780250@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Jassi Brar [mailto:jassisinghbrar at gmail.com]
> Sent: Thursday, August 9, 2018 10:56 AM
[...]
> On Thu, Aug 9, 2018 at 7:52 AM, A.s. Dong <aisheng.dong@nxp.com> wrote:
> > Hi Jassi,
> >
> > Do you have any comments about this reply?
> >
> I did read your post. And my opinion isn't changed. If mailbox is new to you,
> please try to see how other subsystems works, especially SPI, I2C and DMA.
> 

Okay.
What's your comments about the known issues if doing that way?
1) Many unnecessary and meaningless interrupts handling of Tx and RX
2) Performance downgrading
    A 4 word SCU MSG may need 8 interrupts to handle which terribly slow
    down the speed. (Interrupt latency will be terrible if many). SCU msg
    are mostly handled within 10 us.
3) Complex RX flow in order to align with framework design

Are you referring to them as not a real issue?
Or even they're issues/limitations, you would still prefer multi channels way
In order to be consistent with mailbox subsystem by sacrificing the
performance drop?

And to be clear, the working flow you want is exactly as follows, right?
Sending Word 0 ->
Chan 0 interrupt -> (meaningless)
Sending Word 1 ->
Chan1 interrupt -> (meaningless)
Sending Word 2 ->
Chan2 interrupt -> (meaningless)
Sending Word 3 ->
Chan3 interrupt-> (meaningless)

Sending Word 4 on Chan 0 again ->
Wait for Chan 0 interrupt (meaningless) -> ...

Then waiting for Rx:

Chan 0 Rx interrupt ->
Read Word 0   ->
(Then we know response size here)

Chan 1 Rx interrupt ->
Read Word 1 ->
Chan 2 Rx interrupt ->
Read Word 2 ->
Chan 3 Rx interrupt ->
Read Word 3 ->

(If msg size > 4 words)
Chan 0 Rx interrupt ->
Read Word 4

Regards
Dong Aisheng

> Thanks.
