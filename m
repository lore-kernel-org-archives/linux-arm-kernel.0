From: joelf@ti.com (Joel Fernandes)
Date: Fri, 6 Sep 2013 14:51:14 -0500
Subject: [PATCH v2] ARM: EDMA: Fix clearing of unused list for DT DMA
 resources
In-Reply-To: <522A29CF.2090001@newflow.co.uk>
References: <1377287613-16491-1-git-send-email-joelf@ti.com>
 <522A2943.4060502@newflow.co.uk> <522A29CF.2090001@newflow.co.uk>
Message-ID: <522A3232.2090103@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/06/2013 02:15 PM, Mark Jackson wrote:
> On 06/09/13 20:13, Mark Jackson wrote:
>> On 23/08/13 20:53, Joel Fernandes wrote:
>>> HWMOD removal for MMC and Crypto is breaking edma_start as the events are
>>> being manually triggered due to unused channel list not being clear. Atleast
>>> breakage has been seen on these peripherals, but it is expected Audio (McASP)
>>> maybe breaking too.
>>>
>>> This patch fixes the issue, by reading the "dmas" property from the DT node if
>>> it exists and clearing the bits in the unused channel list so that these channels
>>> are not manually triggered.
>>>
>>> v2 changes:
>>> Reduced indendation by returning from if block.
>>>
>>> Reviewed-by: Sekhar Nori <nsekhar@ti.com>
>>> Reported-by: Balaji T K <balajitk@ti.com>
>>> Cc: Pantel Antoniou <panto@antoniou-consulting.com>
>>> Signed-off-by: Joel Fernandes <joelf@ti.com>
>>> ---
>>> Note:
>>> Patch should go in for -rc cycle as it fixes existing crypto drivers.
>>>
>>>  arch/arm/common/edma.c | 22 +++++++++++++++++++---
>>>  1 file changed, 19 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
>>> index 39ad030..3867e7e 100644
>>> --- a/arch/arm/common/edma.c
>>> +++ b/arch/arm/common/edma.c
>>> @@ -560,14 +560,30 @@ static int reserve_contiguous_slots(int ctlr, unsigned int id,
>>>  static int prepare_unused_channel_list(struct device *dev, void *data)
>>>  {
>>>  	struct platform_device *pdev = to_platform_device(dev);
>>> -	int i, ctlr;
>>> +	int i = 0, ctlr;
>>> +	u32 dma_chan;
>>> +	const __be32 *dma_chan_p;
>>> +	struct property *prop;
>>> +
>>> +	if (dev->of_node) {
>>> +		of_property_for_each_u32(dev->of_node, "dmas", prop,
>>> +					 dma_chan_p, dma_chan) {
>>> +			if (i++ & 1) {
>>> +				ctlr = EDMA_CTLR(dma_chan);
>>> +				clear_bit(EDMA_CHAN_SLOT(dma_chan),
>>> +					  edma_cc[ctlr]->edma_unused);
>>> +			}
>>> +		}
>>> +		return;
>>
>> This should return something here, otherwise we get:-
>>
>> arch/arm/common/edma.c: In function 'prepare_unused_channel_list':
>> arch/arm/common/edma.c:577:3: warning: 'return' with no value, in function returning non-void [-Wreturn-type]
> 
> Other than that I can confirm it fixes the issue for me ...

Thanks for pointing that out. Will fix it in the next revision.


Regards,

-Joel
