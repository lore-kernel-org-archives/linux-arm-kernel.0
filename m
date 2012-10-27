From: viresh.kumar@linaro.org (viresh kumar)
Date: Sat, 27 Oct 2012 15:03:46 +0530
Subject: [GIT PULL] SPEAr pinctrl updates for v-3.5
In-Reply-To: <CACRpkdZok471mc_XqogZo2orS7aCeMDSz0oxXfncm5HgMv37aw@mail.gmail.com>
References: <1336562136-24498-1-git-send-email-viresh.kumar@st.com>
 <CAOh2x=mGdV_wbJC64wvb9+UV_FBgnsat9=ojD8BJYVxT+HoWhQ@mail.gmail.com>
 <201205122142.02318.arnd@arndb.de>
 <CACRpkdZgSJGcM9cT3yMv1jhUrD9hKXv=VVb1mFSWrMzRPYu-=g@mail.gmail.com>
 <4FB47DE2.4070704@st.com>
 <CACRpkdYGuqg3xy+x+adREEzkPL9RFzDDBaEBttR-HarZ7jWuFA@mail.gmail.com>
 <CAOh2x=kOU=X2V5zBg4G_SWzNSfQyoeygwgW-vO-xxRkDXzZDJQ@mail.gmail.com>
 <CACRpkday9+zhMHWWjNNBfhhQ2NXPc+RoGkHvxodud5HY7hLm4g@mail.gmail.com>
 <CAPub14-CQCXf3pfZqXjHarfMfaYG3Me7aNffFJ3JMYhr8J4osg@mail.gmail.com>
 <CACRpkdZok471mc_XqogZo2orS7aCeMDSz0oxXfncm5HgMv37aw@mail.gmail.com>
Message-ID: <CAOh2x=kREo-gta292gmBfYxRX6YFFG-r++UnF7QPpKU=81UzfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Sorry for replying on very old thread. Actually i wanted to give
answer to some of
your review comments you already gave.

On Mon, Sep 3, 2012 at 5:18 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Sat, Sep 1, 2012 at 1:22 PM, shiraz hashim
> <shiraz.linux.kernel@gmail.com> wrote:

>> +2.1) gpio-controller and pinctrl subsystem
>> +------------------------------------------
>>

<...>

>> +   &pinctrl1 and &pinctrl2 is the phandle to the pinctrl DT node.
>> +
>> +   Next values specify the base pin and number of pins for the range
>> +   handled by 'qe_pio_e' gpio. In the given example from base pin 20 to
>> +   pin 29 under pinctrl1 and pin 50 to pin 69 under pinctrl2 is handled
>> +   by this gpio controller.

> Also, you should put a big "DEPRECATED" mark on the old gpio
> range concept, and refer to the new way of doing things.

I have added following on reply to this request:

diff --git a/Documentation/pinctrl.txt b/Documentation/pinctrl.txt
index a1cd2f9..da40efb 100644
--- a/Documentation/pinctrl.txt
+++ b/Documentation/pinctrl.txt
@@ -364,6 +364,9 @@ will get an pin number into its handled number
range. Further it is also passed
 the range ID value, so that the pin controller knows which range it should
 deal with.

+Calling pinctrl_add_gpio_range from pinctrl driver is DEPRECATED. Please see
+section 2.1 of Documentation/devicetree/bindings/gpio/gpio.txt on how to bind
+pinctrl and gpio drivers.


>> diff --git a/include/asm-generic/gpio.h b/include/asm-generic/gpio.h

>> +#ifdef CONFIG_PINCTRL
>
> There's no need to #ifdef this I think.

Actually there is, as definition of struct pinctrl_gpio_range is enclosed
in this config option.

>> +/**
>> + * struct gpio_pin_range - pin range controlled by a gpio chip
>> + * @head: list for maintaining set of pin ranges, used internally
>> + * @pctldev: pinctrl device which handles corresponding pins
>> + * @range: actual range of pins controlled by a gpio controller
>> + */
>> +
>> +struct gpio_pin_range {
>> +       struct list_head node;
>> +       struct pinctrl_dev *pctldev;
>> +       struct pinctrl_gpio_range range;
>> +};
>> +#endif

--
viresh
