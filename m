From: eric.auger@linaro.org (Eric Auger)
Date: Mon, 01 Dec 2014 15:39:24 +0100
Subject: [PATCH v3 3/8] VFIO: platform: forwarded state tested when
 selecting IRQ handler
In-Reply-To: <20141130124730.GD82106@macair>
References: <1416767760-14487-1-git-send-email-eric.auger@linaro.org>
 <1416767760-14487-4-git-send-email-eric.auger@linaro.org>
 <20141130124730.GD82106@macair>
Message-ID: <547C7D9C.7030909@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,
On 11/30/2014 01:47 PM, Christoffer Dall wrote:
> The subject reads strangely, perhaps just:
> 
> VFIO: platform: test forward state when selecting IRQ handler
OK
> 
> On Sun, Nov 23, 2014 at 07:35:55PM +0100, Eric Auger wrote:
>> In case the IRQ is forwarded, the VFIO platform IRQ handler does not
>> need to disable the IRQ anymore.
>>
>> When setting the IRQ handler we now also test the forwarded state. In
>> case the IRQ is forwarded we select the edge handler (no automaske).
>>
>> Signed-off-by: Eric Auger <eric.auger@linaro.org>
>>
>> ---
>>
>> v2 -> v3:
>> - forwarded state was tested in the handler. Now the forwarded state
>>   is tested before setting the handler. This definitively limits
>>   the dynamics of forwarded state changes but I don't think there is
>>   a use case where we need to be able to change the state at any time.
> 
> user space can change this by calling the VFIO_IRQ_SET_ACTION_TRIGGER
> whenever it wants, right?
yes the user can set/unset the VFIO signaling (and request_irq/free_irq)
using VFIO_IRQ_SET_ACTION_TRIGGER. In this new version I do not allow
changing the forwarded state when the handler is attached (request_irq).

Does it answer your interrogation?

Best Regards

Eric

> 
>> ---
>>  drivers/vfio/platform/vfio_platform_irq.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/vfio/platform/vfio_platform_irq.c b/drivers/vfio/platform/vfio_platform_irq.c
>> index 08d400e..61a2920 100644
>> --- a/drivers/vfio/platform/vfio_platform_irq.c
>> +++ b/drivers/vfio/platform/vfio_platform_irq.c
>> @@ -230,8 +230,13 @@ static int vfio_platform_set_irq_trigger(struct vfio_platform_device *vdev,
>>  {
>>  	struct vfio_platform_irq *irq = &vdev->irqs[index];
>>  	irq_handler_t handler;
>> +	struct irq_data *d;
>> +	bool is_forwarded;
>>  
>> -	if (vdev->irqs[index].flags & VFIO_IRQ_INFO_MASKABLE)
>> +	d = irq_get_irq_data(irq->hwirq);
>> +	is_forwarded = irqd_irq_forwarded(d);
>> +
>> +	if ((vdev->irqs[index].flags & VFIO_IRQ_INFO_MASKABLE) && !is_forwarded)
>>  		handler = vfio_maskable_irq_handler;
>>  	else
>>  		handler = vfio_irq_handler;
>> -- 
>> 1.9.1
>>
