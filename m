From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 16 Sep 2014 17:52:56 -0300
Subject: [Patch net-next v2 4/4] net: fec: Workaround for imx6sx enet tx
 hang when enable three queues
In-Reply-To: <1410890290-11248-5-git-send-email-Frank.Li@freescale.com>
References: <1410890290-11248-1-git-send-email-Frank.Li@freescale.com>
 <1410890290-11248-5-git-send-email-Frank.Li@freescale.com>
Message-ID: <CAOMZO5DnmHBaDr7RzozJoBsuEY=bzmusKcfJQ4NjCyD4+13=Tg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 16, 2014 at 2:58 PM,  <Frank.Li@freescale.com> wrote:
> From: Fugang Duan <B38611@freescale.com>
>
> When enable three queues on imx6sx enet, and then do tx performance
> test with iperf tool, after some time running, tx hang.
>
> Found that:
>         If uDMA is running, software set TDAR may cause tx hang.
>         If uDMA is in idle, software set TDAR don't cause tx hang.
>
> There is a TDAR race condition for mutliQ when the software sets TDAR
> and the UDMA clears TDAR simultaneously or in a small window (2-4 cycles).
> This will cause the udma_tx and udma_tx_arbiter state machines to hang.
> The issue exist at i.MX6SX enet IP.
>
> So, the Workaround is checking TDAR status four time, if TDAR cleared by
> hardware and then write TDAR, otherwise don't set TDAR.
>
> The patch is only one Workaround for the issue TKT210582.

As Shawn pointed out, it is better to use the ERR007885 instead of an
internal bug numbering.
