From: eric@anholt.net (Eric Anholt)
Date: Mon, 06 Jun 2016 10:15:05 -0700
Subject: [PATCH] dma: bcm2835: Fix compiler warning on arm64.
In-Reply-To: <20160606042337.GT16910@localhost>
References: <1465007013-5300-1-git-send-email-eric@anholt.net>
 <20160606042337.GT16910@localhost>
Message-ID: <87eg8a6xye.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vinod Koul <vinod.koul@intel.com> writes:

> On Fri, Jun 03, 2016 at 07:23:33PM -0700, Eric Anholt wrote:
>> The min() macro was complaining about mismatched types.  The max len
>> is at most SZ_1G, so we can just put it in an unsigned int.
>> 
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>> ---
>> 
>> Vinod, if you ack it, this one would be nice to be able to merge
>> through the -soc tree, so that when we enable of arm64 builds of this
>> driver we don't introduce a new compiler warning.
>> 
>>  drivers/dma/bcm2835-dma.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
>> index 6149b27c33ad..1fa11fc067c6 100644
>> --- a/drivers/dma/bcm2835-dma.c
>> +++ b/drivers/dma/bcm2835-dma.c
>> @@ -393,7 +393,7 @@ static void bcm2835_dma_fill_cb_chain_with_sg(
>>  	unsigned int sg_len)
>>  {
>>  	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
>> -	size_t max_len = bcm2835_dma_max_frame_length(c);
>> +	unsigned int max_len = bcm2835_dma_max_frame_length(c);
>
> bcm2835_dma_max_frame_length() returns size_t. so this should also add a
> complain about type mismatch as well!
>
> Also, wouldn't it be better to make both args of min()  as size_t then?

Assignments from different sizes don't produce warnings.  The other arg
of the min() is a u32, and this value is known to be < u32, so I don't
see the problem.  I could start promoting u32s to size_ts instead, but I
don't know where that would end.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160606/d65d5e79/attachment-0001.sig>
