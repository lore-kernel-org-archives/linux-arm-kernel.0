From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Wed, 24 Feb 2016 13:38:32 -0700
Subject: [PATCH net-next V2 7/8] net: fec: don't transfer ownership until
 descriptor write is complete
In-Reply-To: <20160205170347.45a91314@jclayton-pc>
References: <1454709170-19527-1-git-send-email-troy.kisky@boundarydevices.com>
 <1454709170-19527-8-git-send-email-troy.kisky@boundarydevices.com>
 <20160205170347.45a91314@jclayton-pc>
Message-ID: <56CE14C8.70708@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/5/2016 6:03 PM, Joshua Clayton wrote:
> On Fri,  5 Feb 2016 14:52:49 -0700
> Troy Kisky <troy.kisky@boundarydevices.com> wrote:
> 
>> If you don't own it, you shouldn't write to it.
>>
>> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
>> ---
>>  drivers/net/ethernet/freescale/fec_main.c | 14 +++++++++++++-
>>  1 file changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/freescale/fec_main.c
>> b/drivers/net/ethernet/freescale/fec_main.c index ca2708d..97ca72a
>> 100644 --- a/drivers/net/ethernet/freescale/fec_main.c
>> +++ b/drivers/net/ethernet/freescale/fec_main.c
>> @@ -390,6 +390,10 @@ fec_enet_txq_submit_frag_skb(struct
>> fec_enet_priv_tx_q *txq, 
>>  		bdp->cbd_bufaddr = cpu_to_fec32(addr);
>>  		bdp->cbd_datlen = cpu_to_fec16(frag_len);
>> +		/* Make sure the updates to rest of the descriptor
>> are
>> +		 * performed before transferring ownership.
>> +		 */
>> +		wmb();
>>  		bdp->cbd_sc = cpu_to_fec16(status);
> You use almost exactly the same code in each place.
> I'd prefer to have wmb(); bdp->cbd_sc = cpu_to_fec16(status) wrapped in
> a function or function like macro, and put the comment in one place.
> 

Thanks for the review. I added a patch to the end of the series to create a common
"trigger_tx" subroutine which should address this.
