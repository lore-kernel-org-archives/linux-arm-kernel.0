From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 29 Oct 2012 09:55:48 +0800
Subject: [PATCH v2 2/9] pinctrl: single: support gpio request and free
In-Reply-To: <20121022213709.GL4730@atomide.com>
References: <1350922139-3693-1-git-send-email-haojian.zhuang@gmail.com>
 <1350922139-3693-3-git-send-email-haojian.zhuang@gmail.com>
 <20121022202805.GG4730@atomide.com>
 <20121022213709.GL4730@atomide.com>
Message-ID: <CAN1soZzb-un9MqVGVy8iEzT_8ag8zQyFO=deB7=VQG2K73oouw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 23, 2012 at 5:37 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Tony Lindgren <tony@atomide.com> [121022 13:29]:
>> * Haojian Zhuang <haojian.zhuang@gmail.com> [121022 09:11]:
>> > --- a/drivers/pinctrl/pinctrl-single.c
>> > +++ b/drivers/pinctrl/pinctrl-single.c
>> > @@ -28,8 +28,10 @@
>> >  #define DRIVER_NAME                        "pinctrl-single"
>> >  #define PCS_MUX_PINS_NAME          "pinctrl-single,pins"
>> >  #define PCS_MUX_BITS_NAME          "pinctrl-single,bits"
>> > +#define PCS_GPIO_FUNC_NAME         "pinctrl-single,gpio-func"
>>
>> I think we can now get rid of these defines, I initially added
>> them as we had a bit hard time finding a suitable name for the
>> driver. These are only used in one location, so let's not add
>> new ones here.
>>
>> >  static int pcs_request_gpio(struct pinctrl_dev *pctldev,
>> > -                   struct pinctrl_gpio_range *range, unsigned offset)
>> > +                       struct pinctrl_gpio_range *range, unsigned pin)
>> >  {
>> > -   return -ENOTSUPP;
>> > +   struct pcs_device *pcs = pinctrl_dev_get_drvdata(pctldev);
>> > +   struct pcs_gpio_range *gpio = NULL;
>> > +   int end, mux_bytes;
>> > +   unsigned data;
>> > +
>> > +   gpio = container_of(range, struct pcs_gpio_range, range);
>> > +   if (!gpio->func_en)
>> > +           return 0;
>> > +   end = range->pin_base + range->npins - 1;
>> > +   if (pin < range->pin_base || pin > end) {
>> > +           dev_err(pctldev->dev, "pin %d isn't in the range of "
>> > +                   "%d to %d\n", pin, range->pin_base, end);
>> > +           return -EINVAL;
>> > +   }
>> > +   mux_bytes = pcs->width / BITS_PER_BYTE;
>> > +   data = pcs_readl(pcs->base + pin * mux_bytes) & ~pcs->fmask;
>> > +   data |= gpio->gpio_func;
>> > +   pcs_writel(data, pcs->base + pin * mux_bytes);
>> > +   return 0;
>> >  }
>>
>> I think I already commented on this one.. Is this safe if you don't
>> have GPIOs configured? Or should you return -ENODEV in that case?
>
> Oops also you should not use pcs_readl/pcs_writel in the driver
> directly but use pcs_read instead as you can have register width other
> than 32-bits.
>

I think you're meaning pcs->read(). I'll use this interface.
