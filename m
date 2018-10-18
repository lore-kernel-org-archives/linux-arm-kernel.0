From: aisheng.dong@nxp.com (A.s. Dong)
Date: Thu, 18 Oct 2018 02:35:34 +0000
Subject: [PATCH V4 03/11] clk: imx: scu: add scu clock divider
In-Reply-To: <153979235107.5275.17099119584473464472@swboyd.mtv.corp.google.com>
References: <1539504194-28289-1-git-send-email-aisheng.dong@nxp.com>
 <1539504194-28289-4-git-send-email-aisheng.dong@nxp.com>
 <153972518358.5275.8551722631185725008@swboyd.mtv.corp.google.com>
 <AM0PR04MB42111D180BE6D7557F71D15380FF0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <153978942538.5275.15892434593141965554@swboyd.mtv.corp.google.com>
 <AM0PR04MB42114436952826801D15BA3E80FF0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <153979235107.5275.17099119584473464472@swboyd.mtv.corp.google.com>
Message-ID: <AM0PR04MB4211A124CF43AF4291BA688780F80@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Stephen Boyd [mailto:sboyd at kernel.org]
> Sent: Thursday, October 18, 2018 12:06 AM
> Quoting A.s. Dong (2018-10-17 08:45:05)
> > > -----Original Message-----
> > > From: Stephen Boyd [mailto:sboyd at kernel.org]
> > > Sent: Wednesday, October 17, 2018 11:17 PM Quoting A.s. Dong
> > > (2018-10-17 01:56:35)
> > > > > From: Stephen Boyd [mailto:sboyd at kernel.org]
> > > > > Sent: Wednesday, October 17, 2018 5:26 AM Quoting A.s. Dong
> > > > > (2018-10-14 01:07:49)
> > > >
> > > > How about do something like below?
> > > > struct req_get_clock_rate {
> > > >         u16 resource;
> > > >         u8 clk;
> > > > } __packed;
> > > >
> > > > struct resp_get_clock_rate {
> > > >         u32 rate;
> > > > } __packed;
> > >
> > > This doesn't need __packed because it's a single u32.
> > >
> >
> > It's a safe writing, but yes, can be removed.
> >
> > > >
> > > > struct imx_sc_msg_get_clock_rate {
> > > >         struct imx_sc_rpc_msg hdr;
> > > >         union {
> > > >                 struct req_get_clock_rate req;
> > > >                 struct resp_get_clock_rate resp;
> > > >         } data;
> > > > } __packed;
> > > >
> > >
> > > Yes something like this would be best. And now I wonder if
> > > imx_scu_call_rpc() is doing endianness swapping? Or does it copy
> > > data into these response structures? I'm saying that the u32/16/8
> > > may need to be
> > > __le32/16/8 and then have the proper accessors.
> > >
> >
> > No endianness swapping. It's fixed little endian.
> > SCU protocol isn't aware of these structures. The structures are
> > defined according to SCU protocol definition to make sure each field
> > position and size are correct. Then SCU IPC driver just send and receive them
> sequentially.
> > Client driver uses the structures to retrieve the responding filed values.
> >
> > We do this like drivers/firmware/ti_sci.h Do you think we still need
> > specify __le32/16/8 for this case?
> 
> Probably, because the CPU in linux could be big endian or little endian.
> It doesn't hurt to do it right to begin with and then you get the support for free
> if it's ever used later on.
> 

All right for me. Thanks for the suggestion.

Regards
Dong Aisheng
