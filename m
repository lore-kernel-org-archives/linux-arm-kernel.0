From: robherring2@gmail.com (Rob Herring)
Date: Mon, 18 Mar 2013 21:28:59 -0500
Subject: [PATCH v3 6/6] irqchip: s3c24xx: add s3c2450 interrupt definitions
In-Reply-To: <201303190034.49875.heiko@sntech.de>
References: <201303171404.06146.heiko@sntech.de>
 <201303181753.16547.heiko@sntech.de> <514791DC.9070600@gmail.com>
 <201303190034.49875.heiko@sntech.de>
Message-ID: <5147CD6B.80107@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/18/2013 06:34 PM, Heiko St?bner wrote:
> Am Montag, 18. M?rz 2013, 23:14:52 schrieb Rob Herring:
>> On 03/18/2013 11:53 AM, Heiko St?bner wrote:
>>> Hi Rob,
>>>
>>> Am Montag, 18. M?rz 2013, 16:54:03 schrieb Rob Herring:
>>>> On 03/17/2013 08:09 AM, Heiko St?bner wrote:
>>>>> The s3c2450 is special in that it shares the cpu identification with
>>>>> the s3c2416 but provides more interrupts for its additional
>>>>> components.
>>>>>
>>>>> It also shares the layout of the main interrupt register with the
>>>>> s3c2443 and therefore reuses this definition.
>>>>>
>>>>> As no non-dt boards are present, the s3c2450 irqs will only be
>>>>> accessible thru devicetree.
>>
>> [snip]
>>
>>>>> +	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 17 }, /* DMA4 */
>>>>> +	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 17 }, /* DMA5 */
>>>>> +	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 18 }, /* UART3-RX */
>>>>> +	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 18 }, /* UART3-TX */
>>>>> +	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 18 }, /* UART3-ERR */
>>>>> +	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 9 }, /* WDT */
>>>>> +	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 9 }, /* AC97 */
>>>>> +	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 17 }, /* DMA6 */
>>>>> +	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 17 }, /* DMA7 */
>>>>
>>>> This all seems like information that should come from DT.
>>>
>>> In the first iterations [0] of theis series it was done this way, but was
>>> suggested that these informations _might_ be implementation specific and
>>> not describing the hardware.
>>>
>>> As I didn't get any "final" feedback on the matter, I tried it this way
>>> this time. Personally I also did like the previous variant better, as
>>> the driver could loose all the declaration stuff when platforms move to
>>> dt.
>>>
>>> I would be glad for a hint if the first approach was the correct one.
>>>
>>>
>>> [0] "irqchip: irq-s3c24xx: add devicetree support" from 2013-02-18, also
>>> with you in the recipient list
>>
>> I'm inclined to say the prior way is more in the right direction.
>> However, I'm not really clear what you are trying to describe.
>>
>>> +		s3c24xx,irqlist = <2 0 /* 2D */
>>> +				   2 0 /* IIC1 */
>>> +				   0 0 /* reserved */
>>> +				   0 0 /* reserved */
>>> +				   2 0 /* PCM0 */
>>> +				   2 0 /* PCM1 */
>>> +				   2 0 /* I2S0 */
>>> +				   2 0>; /* I2S1 */
> 
> The s3c24xx SoCs contain one (or two) main interrupt controllers. That are the 
> nodes that gets checked by handle_irq. Additionally they contain something 
> called a sub-register which provides more specific irq for some of them.
> 
> The list you quoted, is meant to describe which bits of the interrupt register 
> contain a valid interrupt at all (!= 0), which handler should be used (2 for 
> the edge handler, 3 for level handler). The second argument contains the bit 
> in the parent interrupt register that contains the parent interrupt, that gets 
> checked in the irq_entry function.
> 
> The original code (which I reworked into this more declarative form) 
> distinguished very much between using the edge handler for some and the level 
> handler for other interrupts.
> 
> This list is essentially the same representation of the list you quoted above 
> and which also can be found in [0]
> 
> Going this way makes it easy to map datasheet values to interrupt number. When 
> I read the ac97 interrupt is in bit 28 of the sub-register I can simply 
> reference it as
> 		interrupt-parent = <&subintc>;
> 		interrupts = <28>;
> 
> 
> So these lists only desribe the internal structure of the interrupt controller 
> registers, which vary for each s3c24xx variant.
> 
> 
>> My first thought here is this information should not be centralized in
>> the controller node, but placed with each source node (2D, I2C1, etc).
> 
> I'm not sure I can follow currently :-)
> 
> I'll try an example:
> 
> The s3c serial driver expects the interrupts for uart tx and rx and the dt 
> entry would look like:
> 
> 	serial at 50000000 {
> 		compatible = "samsung,s3c2410-uart";
> 		reg = <0x50000000 0x4000>;
> 		interrupt-parent = <&subintc>;
> 		interrupts = <0>, <1>;

So what does 0 and 1 correspond to? These are the bits in the subintc?

> 	};
> 
> the map for these in the subintc looks like
>                s3c24xx,irqlist = <3 28 /* UART0-RX */
>                                   3 28 /* UART0-TX */
>                                   3 28 /* UART0-ERR */
> 
> marking them as using the level-handler and being children of the interrupt in 
> bit 28 of the intc handler.
> 
> So the irq_entry would check the intc, see the waiting interrupt in bit 28, 
> jump to the demux function which would then handle which ever of rx,tx or err 
> would be waiting, which then get sent to the serial driver.
> 
> These mappings between sub- and parent irqs also vary very much between the 
> different s3c24xx variants, as can be seen by the multitude of lists in [0] 
> and the parent interrupts are only used for demuxing purposes.
> 
> -----
> A notable speciality are the AC97 (sound) and watchdog interrupts (bits 27 and 
> 28 of the subregister), as they share a common parent interrupt (bit 9 of the 
> main interrupt register).
> 
> So irq_entry checks the main register, sees bit 9 (ac97/watchdog), demuxes it 
> to either coming from the ac97 or watchdog and sends it to the relevant 
> driver.
> 
> I don't think this should be exposed to the drivers at all :-) .
> -------
> 
> So I'm not sure, how this would be able to go in the driver nodes.

The information in an interrupts property is transparent to the driver,
but can contain extra cells with whatever information you need. The GIC
binding has SPI or PPI interrupt type information for example.

> The only thing I could think of, would be to make the handler adjustable via 
> the regular interrupts properties (i.e. as two_cell) which would bring the 
> list down to only list the parent relationships.
> 
> Hmm ... and this parent list might be doable via the regular interrupts 
> property, so the subintc would look like:
> 
> subintc: subintc = {
> 	interrupt-parent = <&intc>;
> 	interrupts = <28 0>, <28 0>, <28 0>, <23 0>, <23 0>, .....
> 	/*		     bit0    bit1    bit2    bit3    bit4   ..... */
> }
> 
> i.e. naming the parent interrupt for each of the interrupt bits of the sub-
> controller. Would this be the right direction?

I think you may want to use an interrupt-map property. That should allow
you to do arbitrary mappings from one interrupt controller's numbering
to another's numbering. The VExpress and several PPC platforms have
examples.

Rob
