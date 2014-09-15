From: lznuaa@gmail.com (Zhi Li)
Date: Mon, 15 Sep 2014 08:21:28 -0500
Subject: [Patch v4 net-next 04/12] net: fec: parser max queue number from
 dt file
In-Reply-To: <20140915093926.11bdbc32@ipc1.ka-ro>
References: <1410555657-10744-1-git-send-email-Frank.Li@freescale.com>
 <1410555657-10744-5-git-send-email-Frank.Li@freescale.com>
 <20140915093926.11bdbc32@ipc1.ka-ro>
Message-ID: <CAHrpEqS3aVoWxi_E_dvCkfZJaFwC_HUvjn5u1x=zLSd-vcYyuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 15, 2014 at 2:39 AM, Lothar Wa?mann <LW@karo-electronics.de> wrote:
> Hi,
>
> Frank.Li at freescale.com wrote:
>> From: Fugang Duan <B38611@freescale.com>
>>
>> By default, the tx/rx queue number is 1, user can config the queue number
>> at DTS file like this:
>>       fsl,num-tx-queues=<3>;
>>       fsl,num-rx-queues=<3>
>>
>> Since i.MX6SX enet-AVB IP support multi queues, so use multi queues
>> interface to allocate and set up an Ethernet device.
>>
>> Signed-off-by: Fugang Duan <B38611@freescale.com>
>> Signed-off-by: Frank Li <Frank.Li@freescale.com>
>> ---
>>  drivers/net/ethernet/freescale/fec.h      |  2 ++
>>  drivers/net/ethernet/freescale/fec_main.c | 46 ++++++++++++++++++++++++++++++-
>>  2 files changed, 47 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
>> index b2b91f8..72fb90f 100644
>> --- a/drivers/net/ethernet/freescale/fec.h
>> +++ b/drivers/net/ethernet/freescale/fec.h
>> @@ -356,6 +356,8 @@ struct fec_enet_private {
>>
>>       bool ptp_clk_on;
>>       struct mutex ptp_clk_mutex;
>> +     unsigned int num_tx_queues;
>> +     unsigned int num_rx_queues;
>>
>>       /* The saved address of a sent-in-place packet/buffer, for skfree(). */
>>       struct fec_enet_priv_tx_q *tx_queue[FEC_ENET_MAX_TX_QS];
>> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
>> index 4c0d2ee..2240df0 100644
>> --- a/drivers/net/ethernet/freescale/fec_main.c
>> +++ b/drivers/net/ethernet/freescale/fec_main.c
>> @@ -2709,6 +2709,42 @@ static void fec_reset_phy(struct platform_device *pdev)
>>  }
>>  #endif /* CONFIG_OF */
>>
>> +static void
>> +fec_enet_get_queue_num(struct platform_device *pdev, int *num_tx, int *num_rx)
>> +{
>> +     struct device_node *np = pdev->dev.of_node;
>> +     int err;
>> +
>> +     *num_tx = *num_rx = 1;
>> +
>> +     if (!np || !of_device_is_available(np))
>> +             return;
>> +
>> +     /* parse the num of tx and rx queues */
>> +     err = of_property_read_u32(np, "fsl,num-tx-queues", num_tx);
>> +     err |= of_property_read_u32(np, "fsl,num-rx-queues", num_rx);
>> +     if (err) {
>> +             *num_tx = 1;
>> +             *num_rx = 1;
> Shouldn't these be handled seperately? So that if only one of those
> properties is given in DT the specified value for that property should
> be used?
>
>> +             return;
>> +     }
>> +
>> +     if (*num_tx < 1 || *num_tx > FEC_ENET_MAX_TX_QS) {
>> +             dev_err(&pdev->dev, "Invalidate num_tx(=%d), fail back to 1\n",
>>
> s/Invalidate/Invalid/
> s/fail/fall/
> If the problem is fixed up by the driver rather than leading to an
> error exit it should be dev_warn() rather than dev_err().
>
>> +                     *num_tx);
>> +             *num_tx = 1;
>> +             return;
>> +     }
>> +
>> +     if (*num_rx < 1 || *num_rx > FEC_ENET_MAX_RX_QS) {
>> +             dev_err(&pdev->dev, "Invalidate num_rx(=%d), fail back to 1\n",
> dto.
>
>> +                     *num_rx);
>> +             *num_rx = 1;
>> +             return;
>> +     }
>> +
>> +}
>> +
>>  static int
>>  fec_probe(struct platform_device *pdev)
>>  {
>> @@ -2720,13 +2756,18 @@ fec_probe(struct platform_device *pdev)
>>       const struct of_device_id *of_id;
>>       static int dev_id;
>>       struct device_node *np = pdev->dev.of_node, *phy_node;
>> +     int num_tx_qs = 1;
>> +     int num_rx_qs = 1;
>>
> useless initialization. These variables are initialized in
> fec_enet_get_queue_num() anyway.


David have applied the whole patch serials.
How to handle it? use new patch?

best regards
Frank Li

>
>>       of_id = of_match_device(fec_dt_ids, &pdev->dev);
>>       if (of_id)
>>               pdev->id_entry = of_id->data;
>>
>> +     fec_enet_get_queue_num(pdev, &num_tx_qs, &num_rx_qs);
>> +
>
>
> Lothar Wa?mann
> --
> ___________________________________________________________
>
> Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
> Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
> Gesch?ftsf?hrer: Matthias Kaussen
> Handelsregistereintrag: Amtsgericht Aachen, HRB 4996
>
> www.karo-electronics.de | info at karo-electronics.de
> ___________________________________________________________
