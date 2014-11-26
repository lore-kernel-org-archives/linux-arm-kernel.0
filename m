From: bjorn@kryo.se (Bjorn Andersson)
Date: Wed, 26 Nov 2014 09:41:17 -0800
Subject: [PATCH v2 1/3] pinctrl: Add Qualcomm TLMM driver
In-Reply-To: <CAOZdJXW_udiy6zYEUqJGqvdd5r4OuSzHk=u1f+tgZhRgoHNLCg@mail.gmail.com>
References: <1386295805-13708-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1386295805-13708-2-git-send-email-bjorn.andersson@sonymobile.com>
 <CAOZdJXW_udiy6zYEUqJGqvdd5r4OuSzHk=u1f+tgZhRgoHNLCg@mail.gmail.com>
Message-ID: <CAJAp7OjFmDU+5jAewkRFHZHHv8d=7n_peHWopvnQ-8bgPSzDYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 25, 2014 at 11:55 AM, Timur Tabi <timur@codeaurora.org> wrote:
> On Thu, Dec 5, 2013 at 8:10 PM, Bjorn Andersson
> <bjorn.andersson@sonymobile.com> wrote:
>>
>> +static int msm_gpio_init(struct msm_pinctrl *pctrl)
>> +{
>> +       struct gpio_chip *chip;
>> +       int irq;
>> +       int ret;
>> +       int i;
>> +       int r;
>> +
>> +       chip = &pctrl->chip;
>> +       chip->base = 0;
>> +       chip->ngpio = pctrl->soc->ngpios;
>
> I know this patch is a year old, but I'm wondering if this line is correct.
>

Hi Timur,

It's always good to review old code, so don't worry about its age of
the patch or code.

> The original version of your patch from 11/23/13 said this:
>
> +       chip->ngpio = pctrl->soc->gpio_range->npins;
>

If you look in patchset 2 (the addition of 8974) you can see that I
passed a pinctrl_gpio_range from the 8974 driver to the common driver;
but I only use this to pass the number of gpios (NUM_GPIO_PINGROUPS).

> and today, the line is this:
>
>     unsigned ngpio = pctrl->soc->ngpios;
>

Most likely based on some review comments this was replaced with just
an unsigned 'ngpios'.

> I'm wondering if this line should be instead:
>
>     unsigned ngpio = pctrl->soc->npins;
>
> I'm confused about the difference between msm_pinctrl_soc_data.npins
> and msm_pinctrl_soc_data.ngpios.  Variable "ngpio" is used by
> gpiochip_add(), so I think it's not concerned with pin control.
> msm_pinctrl_soc_data.npins appears to be the number of GPIOs, whereas
> msm_pinctrl_soc_data.ngpios appears to be the number of pin groups.
>

The 'ngpio' specifies how many gpio pins/groups (they are 1:1 in the
qcom case) the tlmm block sports, while 'npins' specifies how many
pingroups can be controlled by pinctrl/pinconf/pinmux.

So 'npins' will be 'ngpio' plus the other things that can be
controlled, e.g. sdcc.


The original patch assigns ngpio to be "the number of pinctrl pins in
the gpio range", i.e. a subset of all pins.

Regards,
Bjorn
