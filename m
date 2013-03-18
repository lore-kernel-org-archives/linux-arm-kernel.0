From: robherring2@gmail.com (Rob Herring)
Date: Mon, 18 Mar 2013 17:14:52 -0500
Subject: [PATCH v3 6/6] irqchip: s3c24xx: add s3c2450 interrupt definitions
In-Reply-To: <201303181753.16547.heiko@sntech.de>
References: <201303171404.06146.heiko@sntech.de>
 <201303171409.07774.heiko@sntech.de> <5147389B.5060105@gmail.com>
 <201303181753.16547.heiko@sntech.de>
Message-ID: <514791DC.9070600@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/18/2013 11:53 AM, Heiko St?bner wrote:
> Hi Rob,
> 
> Am Montag, 18. M?rz 2013, 16:54:03 schrieb Rob Herring:
>> On 03/17/2013 08:09 AM, Heiko St?bner wrote:
>>> The s3c2450 is special in that it shares the cpu identification with the
>>> s3c2416 but provides more interrupts for its additional components.
>>>
>>> It also shares the layout of the main interrupt register with the s3c2443
>>> and therefore reuses this definition.
>>>
>>> As no non-dt boards are present, the s3c2450 irqs will only be
>>> accessible thru devicetree.

[snip]

>>> +	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 17 }, /* DMA4 */
>>> +	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 17 }, /* DMA5 */
>>> +	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 18 }, /* UART3-RX */
>>> +	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 18 }, /* UART3-TX */
>>> +	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 18 }, /* UART3-ERR */
>>> +	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 9 }, /* WDT */
>>> +	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 9 }, /* AC97 */
>>> +	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 17 }, /* DMA6 */
>>> +	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 17 }, /* DMA7 */
>>
>> This all seems like information that should come from DT.
> 
> In the first iterations [0] of theis series it was done this way, but was 
> suggested that these informations _might_ be implementation specific and not 
> describing the hardware.
> 
> As I didn't get any "final" feedback on the matter, I tried it this way this 
> time. Personally I also did like the previous variant better, as the driver 
> could loose all the declaration stuff when platforms move to dt.
> 
> I would be glad for a hint if the first approach was the correct one.
> 
> 
> [0] "irqchip: irq-s3c24xx: add devicetree support" from 2013-02-18, also with 
> you in the recipient list

I'm inclined to say the prior way is more in the right direction.
However, I'm not really clear what you are trying to describe.

> +		s3c24xx,irqlist = <2 0 /* 2D */
> +				   2 0 /* IIC1 */
> +				   0 0 /* reserved */
> +				   0 0 /* reserved */
> +				   2 0 /* PCM0 */
> +				   2 0 /* PCM1 */
> +				   2 0 /* I2S0 */
> +				   2 0>; /* I2S1 */

My first thought here is this information should not be centralized in
the controller node, but placed with each source node (2D, I2C1, etc).

Rob
