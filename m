From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 11 Aug 2017 11:16:20 +0200
Subject: [PATCH] serio: PS2 gpio bit banging driver for the serio bus
In-Reply-To: <8e5e73575b3a70e0e60931698687471d@dk-develop.de>
References: <20170731222452.22887-1-danilokrummrich@dk-develop.de>
 <CACRpkdYz_+soss4Rb9zMiP4eZZtXqjW_Xy7hH=wm1x2m_R9R3A@mail.gmail.com>
 <20170807182207.348762301bf3d7f8509b1bf7@dk-develop.de>
 <8e5e73575b3a70e0e60931698687471d@dk-develop.de>
Message-ID: <CACRpkda=bYacXmv8SoQu3wPoZW9v+j8myZnme=QpofD=Y-gYTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 10, 2017 at 4:38 PM, Danilo Krummrich
<danilokrummrich@dk-develop.de> wrote:
> On 2017-08-07 18:22, Danilo Krummrich wrote:
>>>
>>> > +static int ps2_gpio_write(struct serio *serio, unsigned char val)
>>> > +{
>>> > +       struct ps2_gpio_data *drvdata = serio->port_data;
>>> > +
>>> > +       drvdata->mode = PS2_MODE_TX;
>>> > +       drvdata->tx_byte = val;
>>> > +       /* Make sure ISR running on other CPU notice changes. */
>>> > +       barrier();
>>>
>>> This seems overengineered, is this really needed?
>>>
>>> If we have races like this, the error is likely elsewhere, and should be
>>> fixed in the GPIO driver MMIO access or so.
>>>
>> Yes, seems it can be removed. I didn't saw any explicit barriers in the
>> GPIO
>> driver (I'm testing on bcm2835), but it seems MMIO operations on SMP archs
>> does contain barriers. Not sure if all do. If some do not this barrier
>> might
>> be needed to ensure ISR on other CPU notice the correct mode and byte to
>> send.
>>
> I couldn't find any guarantee that the mode and tx_byte change is implicitly
> covered by a barrier in this case. E.g. the bcm2835 driver does not make
> sure stores are completed before the particular interrupt is enabled, except by
> the fact that writel on ARM contains a wmb(). But this is nothing to rely on.
> (Please tell me if I miss something.)

writel() should be guaranteeing that the values hit the hardware, wmb() is
spelled out "write memory barrier" I don't see what you're after here.

If you think writel() doesn't do its job on some platform, then fix writel()
on that platform.

We can't randomly sprinkle things like this all over the kernel it makes
no sense.

> Therefore I would like to keep this barrier and replace it with smp_wmb() if
> you are fine with that.

I do not think this is proper.

Yours,
Linus Walleij
