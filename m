From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Mon, 15 Sep 2014 17:08:04 +0200
Subject: [Patch v4 net-next 04/12] net: fec: parser max queue number
 from dt file
In-Reply-To: <CAHrpEqTCBMn-P2O7VZOOLUN=Zbc8h_Ow9MKrv5cV5gZPENRqUw@mail.gmail.com>
References: <1410555657-10744-1-git-send-email-Frank.Li@freescale.com>
 <1410555657-10744-5-git-send-email-Frank.Li@freescale.com>
 <20140915093926.11bdbc32@ipc1.ka-ro>
 <CAHrpEqTCBMn-P2O7VZOOLUN=Zbc8h_Ow9MKrv5cV5gZPENRqUw@mail.gmail.com>
Message-ID: <20140915170804.39061c0d@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Zhi Li wrote:
> On Mon, Sep 15, 2014 at 2:39 AM, Lothar Wa?mann <LW@karo-electronics.de> wrote:
> > Hi,
> >
> > Frank.Li at freescale.com wrote:
> >> From: Fugang Duan <B38611@freescale.com>
> >>
> >> By default, the tx/rx queue number is 1, user can config the queue number
> >> at DTS file like this:
> >>       fsl,num-tx-queues=<3>;
> >>       fsl,num-rx-queues=<3>
> >>
> >> Since i.MX6SX enet-AVB IP support multi queues, so use multi queues
> >> interface to allocate and set up an Ethernet device.
> >>
> >> Signed-off-by: Fugang Duan <B38611@freescale.com>
> >> Signed-off-by: Frank Li <Frank.Li@freescale.com>
> >> ---
> >>  drivers/net/ethernet/freescale/fec.h      |  2 ++
> >>  drivers/net/ethernet/freescale/fec_main.c | 46 ++++++++++++++++++++++++++++++-
> >>  2 files changed, 47 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
> >> index b2b91f8..72fb90f 100644
> >> --- a/drivers/net/ethernet/freescale/fec.h
> >> +++ b/drivers/net/ethernet/freescale/fec.h
> >> @@ -356,6 +356,8 @@ struct fec_enet_private {
> >>
> >>       bool ptp_clk_on;
> >>       struct mutex ptp_clk_mutex;
> >> +     unsigned int num_tx_queues;
> >> +     unsigned int num_rx_queues;
> >>
> >>       /* The saved address of a sent-in-place packet/buffer, for skfree(). */
> >>       struct fec_enet_priv_tx_q *tx_queue[FEC_ENET_MAX_TX_QS];
> >> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> >> index 4c0d2ee..2240df0 100644
> >> --- a/drivers/net/ethernet/freescale/fec_main.c
> >> +++ b/drivers/net/ethernet/freescale/fec_main.c
> >> @@ -2709,6 +2709,42 @@ static void fec_reset_phy(struct platform_device *pdev)
> >>  }
> >>  #endif /* CONFIG_OF */
> >>
> >> +static void
> >> +fec_enet_get_queue_num(struct platform_device *pdev, int *num_tx, int *num_rx)
> >> +{
> >> +     struct device_node *np = pdev->dev.of_node;
> >> +     int err;
> >> +
> >> +     *num_tx = *num_rx = 1;
> >> +
> >> +     if (!np || !of_device_is_available(np))
> >> +             return;
> >> +
> >> +     /* parse the num of tx and rx queues */
> >> +     err = of_property_read_u32(np, "fsl,num-tx-queues", num_tx);
> >> +     err |= of_property_read_u32(np, "fsl,num-rx-queues", num_rx);
> >> +     if (err) {
> >> +             *num_tx = 1;
> >> +             *num_rx = 1;
> > Shouldn't these be handled seperately? So that if only one of those
> > properties is given in DT the specified value for that property should
> > be used?
> 
> I worry about asymmetric design in future.
>
Then why do you use two distinct properties in the first place?

> And use two property is the easy debug two directory.
> 
I don't understand this sentence.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
