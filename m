From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 30 Sep 2013 15:59:10 +0200
Subject: [PATCH v2 1/3] dma: mxs-dma: Cleanup interrupt handler
In-Reply-To: <21065.33455.71463.188271@ipc1.ka-ro>
References: <1380546822-14034-1-git-send-email-mpa@pengutronix.de>
 <1380546822-14034-2-git-send-email-mpa@pengutronix.de>
 <21065.33455.71463.188271@ipc1.ka-ro>
Message-ID: <524983AE.8020706@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/30/2013 03:54 PM, Lothar Wa?mann wrote:
> Hi,
> 
> Markus Pargmann writes:
>> The DMA interrupt handler uses its controll registers to handle all
>> available channel interrupts it can find.
>>
>> This patch changes it to handle only one interrupt by directly mapping
>> irq number to channel. It also includes a cleanup of the ctrl-register
>> usage.
>>
>> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
>> ---
>>  drivers/dma/mxs-dma.c | 95 ++++++++++++++++++++++++++++++++-------------------
>>  1 file changed, 59 insertions(+), 36 deletions(-)
>>
>> diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
>> index ccd13df..bfca8dc 100644
>> --- a/drivers/dma/mxs-dma.c
>> +++ b/drivers/dma/mxs-dma.c
>> @@ -272,58 +272,81 @@ static void mxs_dma_tasklet(unsigned long data)
>>  		mxs_chan->desc.callback(mxs_chan->desc.callback_param);
>>  }
>>  
>> +static int mxs_dma_irq_to_chan(struct mxs_dma_engine *mxs_dma, int irq)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i != mxs_dma->nr_channels; ++i)
>> +		if (mxs_dma->mxs_chans[i].chan_irq == irq)
>> +			return i;
>>
> You might use a linked list for all active channels so that you don't
> have to check all unused channels when trying to find the channel
> number for an irq.

Or an array of mxs_dma->nr_channels length for direct mapping.

Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 259 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130930/33c1b90f/attachment.sig>
