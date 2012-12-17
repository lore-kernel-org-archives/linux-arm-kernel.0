From: wg@grandegger.com (Wolfgang Grandegger)
Date: Mon, 17 Dec 2012 17:28:40 +0100
Subject: [PATCH RESEND 0/6 v10] gpio: Add block GPIO
In-Reply-To: <50CF237E.5020409@antcom.de>
References: <1355495185-24220-1-git-send-email-stigge@antcom.de>
 <50CB68AB.5070806@grandegger.com> <50CBBB25.20002@antcom.de>
 <50CF03FB.2030100@grandegger.com> <50CF0744.7040404@grandegger.com>
 <50CF1EF1.2070601@antcom.de> <50CF237E.5020409@antcom.de>
Message-ID: <50CF4838.9000401@grandegger.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/17/2012 02:51 PM, Roland Stigge wrote:
> Hi Wolfgang,
> 
> On 12/17/2012 02:32 PM, Roland Stigge wrote:
>> And I guess Russell is right: If possible, we should write outputs
>> simultaneously via ODSR (plus OWER/OWDR/OWSR) instead of separate set/clear.
>>
>> I wonder if we need to save/restore the state of OWSR at every write
>> operation or if we need/can cache it. Assuming that block GPIO are the
>> only code in the kernel that manipulates ODSR.
> 
> Can you please test the following:
> 
> +static void at91_gpiolib_set_block(struct gpio_chip *chip, unsigned long mask, unsigned long val)
> +{
> +       struct at91_gpio_chip *at91_gpio = to_at91_gpio_chip(chip);
> +       void __iomem *pio = at91_gpio->regbase;
> +
> +       __raw_writel(~mask, pio + PIO_OWDR);

This would also disable normal GPIOs configured for output! From the
manual I understand that if the pin is configured for output, we could
either use PIO_SODR/PIO_CODR to set/clear the bits individually or
PIO_ODSR for synchronous data output. But than we need to care about the
non-block GPIO outputs as well... requiring a read-modify-write cycle :(.

Wolfgang.
