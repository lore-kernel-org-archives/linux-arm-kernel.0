From: wg@grandegger.com (Wolfgang Grandegger)
Date: Mon, 17 Dec 2012 15:57:39 +0100
Subject: [PATCH RESEND 0/6 v10] gpio: Add block GPIO
In-Reply-To: <20121217121026.GR14363@n2100.arm.linux.org.uk>
References: <1355495185-24220-1-git-send-email-stigge@antcom.de>
 <50CB68AB.5070806@grandegger.com> <50CBBB25.20002@antcom.de>
 <50CF03FB.2030100@grandegger.com> <50CF0744.7040404@grandegger.com>
 <20121217121026.GR14363@n2100.arm.linux.org.uk>
Message-ID: <50CF32E3.90305@grandegger.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/17/2012 01:10 PM, Russell King - ARM Linux wrote:
> On Mon, Dec 17, 2012 at 12:51:32PM +0100, Wolfgang Grandegger wrote:
>> +static void at91_gpiolib_set_block(struct gpio_chip *chip, unsigned long mask, unsigned long val)
>> +{
>> +	struct at91_gpio_chip *at91_gpio = to_at91_gpio_chip(chip);
>> +	void __iomem *pio = at91_gpio->regbase;
>> +	u32 set_bits = val & mask;
>> +	u32 clr_bits = ~val & mask;
>> +
>> +	/* GPIO outputs can only be set at once or cleared at once */
>> +	if (set_bits)
>> +		__raw_writel(set_bits, pio + PIO_SODR);
>> +	if (clr_bits)
>> +		__raw_writel(clr_bits, pio + PIO_CODR);
>> +}
> 
> You obviously didn't see my email...

Well, I did read you mail but it was not obvious to me how to maintain
compatibility with the existing "set" method... at a first glance.
But the synchronous data output is important and it's even simpler than
I thought. The block-set callback can directly write to ODSR because
"at91_set_gpio_output()" already has set OWER. Will give that a try
later today.

Wolfgang.
