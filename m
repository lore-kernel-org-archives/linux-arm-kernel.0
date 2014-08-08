From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 8 Aug 2014 14:42:21 +0200
Subject: [PATCH 5/8] pinctrl: add driver for MB86S7x
In-Reply-To: <CAJe_Zhc2gz8DZjzo-4YAucAZ2P=UamZ2MtTP1fHmxC0vspZJDw@mail.gmail.com>
References: <1405233067-4725-1-git-send-email-mollie.wu@linaro.org>
 <CACRpkdb_NC7j=XkbMPv8YYLSeEd1AOpFqmD8x+ohC7ds3cPCfg@mail.gmail.com>
 <CAJe_Zhc2gz8DZjzo-4YAucAZ2P=UamZ2MtTP1fHmxC0vspZJDw@mail.gmail.com>
Message-ID: <CACRpkdb_8HBzLUKedZKwPxDZ8TQiNMs5QV_eFfkqD=-9TTK55w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 24, 2014 at 8:04 PM, Jassi Brar <jaswinder.singh@linaro.org> wrote:
> On 22 July 2014 21:41, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Sun, Jul 13, 2014 at 8:31 AM, Mollie Wu <mollie.wu@linaro.org> wrote:

>>> +               if (pchip->pin_busy[p + 3]) {
>>> +                       pr_err("%s:%d:%d %d busy\n",
>>> +                              __func__, __LINE__, pins[i], p+3);
>>> +                       goto busy_exit;
>>> +               }
>>
>> I don't understand this either.
>>
>> Why all this fuzz around the four pins from p ... p+3?
>>
> Pinctrl exposes each pin individually, but the controller clubs 4 pins
> together to work in same mode... so we have to reject any attempt to
> change mode of a pin if any other pin in the same group [p,.. p+3] is
> already taken by some user and is in a different mode i.e, busy. And
> no, we can't expose each group of 4 as a 'virtual' pin because some
> groups serve to 2 different IPs.

OK I get it now I think, seems valid.

>>> +               pr_debug(" %d", p);
>>> +               pchip->pin_busy[p] = true;
>>
>> So I'm questioning this....
>>
>>> +               if (p < PINS_VIRT) /* Not for virtual pins */
>>
>> We need an explanation somewhere about what "virtual pins"
>> means in this driver, I have never seen that before.
>>
> Now, these are really 'virtual' :)
> The registers for physically individual pins are uniformly spaced and
> we can compact the offsets with simple math.
> However for some peripherals like PCI, USB etc, the pins are all tied
> together as one 'virtual' pin. To reuse the same math to calculate
> offsets, we assign virtual numbers to these virtual pins, assuming
> 'holes' wherever necessary.

Aha. OK, well I guess readability is paramount, the scheme
you come up with is likely to stick so make sure that whatever
way it works is very clear and documented so others can follow
the example later on.

>>> +MODULE_DEVICE_TABLE(of, mb86s70_gpio_dt_ids);
>>
>> "fujitsu" does not seem to exist in
>> Documentation/devicetree/bindings/vendor-prefixes.txt
>> Do you want to add it?
>>
> Yup, in a later patch of this set :)

OK thanks. Dunno if there is already some v2 in my inbox, I've
got some stuff to process...

Yours,
Linus Walleij
