From: kernel@martin.sperl.org (Martin Sperl)
Date: Mon, 29 Feb 2016 19:14:19 +0100
Subject: [PATCH V2 6/8] dmaengine: bcm2835: move controlblock chain
 generation into separate method
In-Reply-To: <874md6ya2m.fsf@eliezer.anholt.net>
References: <1452187987-2605-1-git-send-email-kernel@martin.sperl.org>
 <1452187987-2605-7-git-send-email-kernel@martin.sperl.org>
 <874md6ya2m.fsf@eliezer.anholt.net>
Message-ID: <BBA893B4-C93B-4817-89C3-2A2B4CB268AA@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 18.02.2016, at 04:24, Eric Anholt <eric@anholt.net> wrote:
> 
> kernel at martin.sperl.org writes:
> 
>> From: Martin Sperl <kernel@martin.sperl.org>
>> 
>> In preparation of adding slave_sg functionality this patch moves the
>> generation/allocation of bcm2835_desc and the building of
>> the corresponding DMA-control-block chain from bcm2835_dma_prep_dma_cyclic
>> into the newly created method bcm2835_dma_create_cb_chain.
>> 
>> This new code also takes the limits of LITE channels into account
>> and splits the control-block transfers at the correct location.
>> 
>> Tested Audio output with a Hifiberry I2S card.
>> 
>> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
>> ---
>> drivers/dma/bcm2835-dma.c |  288 ++++++++++++++++++++++++++++++---------------
>> 1 file changed, 191 insertions(+), 97 deletions(-)
>> 
>> diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
>> index 43758ba..41a4f0b 100644
>> --- a/drivers/dma/bcm2835-dma.c
>> +++ b/drivers/dma/bcm2835-dma.c
>> @@ -90,12 +90,12 @@ struct bcm2835_desc {
>> 	struct virt_dma_desc vd;
>> 	enum dma_transfer_direction dir;
>> 
>> -	struct bcm2835_cb_entry *cb_list;
>> -
>> 	unsigned int frames;
>> 	size_t size;
>> 
>> 	bool cyclic;
>> +
>> +	struct bcm2835_cb_entry cb_list[];
>> };
>> 
>> #define BCM2835_DMA_CS		0x00
>> @@ -181,6 +181,22 @@ struct bcm2835_desc {
>> #define BCM2835_DMA_IRQ_SHARED		11
>> #define BCM2835_DMA_IRQ_ALL		12
>> 
>> +/* the max dma length for different channels */
>> +#define MAX_DMA_LEN SZ_1G
>> +#define MAX_LITE_DMA_LEN (SZ_64K - 4)
>> +
>> +static inline bool bcm2835_dma_is_lite(struct bcm2835_chan *c)
>> +{
>> +	/* dma channels >= 7 are LITE channels */
>> +	return (c->ch >= 7);
>> +}
> 
> You can ask a channel if it's a LITE engine by checking if the DEBUG reg
> has bit 28 set.  Then you don't need to have the software/DT guessing
> about it.
I will implement that - it is simple.

> However, I'm disappointed to see these changes for adding LITE support
> included in the same commit as refactoring chain generation into a
> separate function.
I will separate this ?LITE-channel handling? out into a separate patch.

Martin
