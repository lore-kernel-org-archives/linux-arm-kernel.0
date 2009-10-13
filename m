From: ryan@bluewatersys.com (Ryan Mallon)
Date: Wed, 14 Oct 2009 09:01:30 +1300
Subject: [RFC PATCH v1] EP93XX: Add ADC support
In-Reply-To: <4AD47DCD.5030004@techworks.ie>
References: <20091012142413.30881.62391.stgit@archeopterix.techworks.local>
	<4AD392AF.8050806@bluewatersys.com> <4AD47DCD.5030004@techworks.ie>
Message-ID: <4AD4DC9A.8090802@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Christian Gagneraud wrote:
> Ryan Mallon wrote:
>> Christian Gagneraud wrote:
>>> This patch add support for the ADC found in the EP93XX.
>>>
>>
>>> +};
>>> +
>>> +struct adc_device {
>>> +    struct platform_device *pdev;
>>> +    struct platform_device *owner;
>>> +    struct clk *clk;
>>> +    struct ep93xx_adc_client *cur;
>>> +    void __iomem *regs;
>>> +    int irq;
>>> +    unsigned int refm;              /* Reading when Vin = Vref- */
>>> +    unsigned int refp;              /* Reading when Vin = Vref+ */
>>> +};
>>> +
>>> +static struct adc_device *adc_dev;
>>> +
>>> +static LIST_HEAD(adc_pending);
>>> +
>>> +#define adc_dbg(_adc, msg...) dev_dbg(&(_adc)->pdev->dev, msg)
>>
>> Bit of a nitpick, but can you move the structure definitions and
>>  above the first functions in this file.
> 
> Bit of nitpick, but I will move the first functions _below_ the
> structure definitions and variable declarations. :)

Heh, fair enough :-).

> 
>>
>>> +
>>> +static inline void ep93xx_adc_convert(struct adc_device *adc)
>>> +{
>>> +    unsigned long prev_switch;
>>> +    unsigned long next_switch;
>>> +
>>> +    /* Configure the switches */
>>> +    prev_switch = __raw_readl(EP93XX_TS_DIRECT);
>>> +    next_switch = adc->cur->channel;
>>> +    if (next_switch != prev_switch) {
>>> +        ep93xx_adc_set_reg(EP93XX_TS_DIRECT, next_switch);
>>> +        /* Channel switch settling time */
>>> +        /* TODO: depends on clock speed (500us or 2ms) */
>>> +        /* FIXME: the caller has disabled interrupts and the
>>> +         * caller can even be the irq handler. Should we
>>> +         * better fire a timer? */
>>> +        mdelay(2);
>>
>> Perhaps make the mdelay value a platform data in the meantime then?
> 
> Actually I need to use clock_get_rate I think. But yes, why not putting
> the clock configuration in the platform data in the meantime.
> 
> Any particular comment about using mdelay within local_irq_save/restore
> context (used to protect the list), and within an interrupt handler
> (needed to fire the next operation).

udelay and mdelay are busy wait loops, and are okay to use inside
interrupt context.

> 
>>
>>> +    data -= adc->refm;
>>> +
>>> +    client->nr_samples--;
>>> +
>>> +    ep93xx_convert_done(client, data, &client->nr_samples);
>>> +
>>> +    /* If all samples are done, disable IRQ, and kick start the next
>>> +     * one if any. */
>>
>> This comment doesn't make sense. If all samples are done, kick start the
>> next one? Am I missing something?
> 
> I will clarify the comment, actually I meant:
> If all samples are done for this client (channel), disable IRQ, and kick
> start the next client (channel) if any.

Okay, that makes sense. Can you change the comment to reflect this.

>>
>>> +
>>> +    platform_set_drvdata(pdev, adc);
>>> +
>>> +    /* Defaults from datasheet (approximated values) */
>>> +    adc->refm = 0xFFFF - 25000;
>>
>> Erk, why two different bases? Can we just #define these values somewhere.
> 
> I think I still need to find the best way to cope with that, 0xFFFF is
> because we're manipulating 16bits data and 25000 is the value for Vref/2
> (from datasheet).

Okay, makes sense. Can we make a #define with a comment then?

>>
>>> +    adc->refp = 25000;
>>> +    adc_dev = adc;
>>> +
>>> +    return 0;
>>> +
>>> +      err_clk:
>>> +    clk_put(adc->clk);
>>
>> clk_disable?
> 
> Why? isn't clk_put() the reverse of clk_get()?

Sorry, I misread the code. I though you could error exit after the
clk_enable above. Your error path is okay.

>>> +
>>> +static struct platform_driver ep93xx_adc_driver = {
>>> +    .driver = {
>>> +           .name = "ep93xx-analog",
>>
>> Why not ep93xx-adc?
> 
> As I said in a previous email, there's ADC stuff and there's touchscreen
> stuff, both use the same ressource, so I chossed a "neutral" name for
> these shared ressource (it's not ADC, it's not TS, it's "analog").
> 
> I'm really thinking about to make everything ADC centric.

As Hartley mentioned, if this is the interface to the ADC, and the
touchscreen driver uses ep93xx_adc_register, then this driver is the
only one which needs the clock.

I have a touchscreen driver lying around which needs to be ported to the
mainline. I will add getting it work with this driver to my list of
things to do.

>>> +
>>> +#ifndef __ASM_ARCH_HWMON_H
>>> +#define __ASM_ARCH_HWMON_H __FILE__
>>
>> Stray __FILE__?
> 
> Yes, I saw that as well, but as I said in another email, I first tried
> not to do cosmetic changes, so i leaved this guy as it was.

It shouldn't be there, just remove it.

>>
>>> +static struct ep93xx_hwmon_data ts72xx_hwmon_info = {
>>> +    /* POWER_IN*10K/150K (4.5-20V) */
>>> +    .in[0] = &(struct ep93xx_hwmon_chcfg) {
>>
>> That cast looks really ugly, is there a better way?
>>
>>> +        .name        = "ts72xx-vin",
>>> +                .channel        = TS72XX_ADC0,
>>> +        .mult        = 33*(15+1),
>>> +        .div        = 500*1,
>>
>> Spaces around operators please. Also why the explict multiplies
>> (especially by 1)?
> 
> I didn't want to put any magic numbers here, so it means 3.3V multiplied
> by 150K resistor in serie with 10K resistor, divided by a 10K resistor
> multiplied by the full scale value.

Perhaps a comment explaining this then?

One last thing. It might be an idea to split this into a few patches. At
least into one for the adc driver and one for the hwmon part. As it
stands the patch is quite large.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
