From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 28 Jan 2013 11:27:30 +0100
Subject: [PATCH 01/10] gpio: pxa: set initcall level to module init
In-Reply-To: <CAD6h2NSZoTaG1vN4gCRV5WdR07ZKepYP5z3JujuRs8Pn2pwdVQ@mail.gmail.com>
References: <1358929554-32265-1-git-send-email-haojian.zhuang@linaro.org>
 <1358929554-32265-2-git-send-email-haojian.zhuang@linaro.org>
 <87ham5nfi7.fsf@free.fr>
 <CAD6h2NSZoTaG1vN4gCRV5WdR07ZKepYP5z3JujuRs8Pn2pwdVQ@mail.gmail.com>
Message-ID: <CACRpkdYcCQrciwzzHpjRdxEF-H=h9hAG0XaUoSqeA2+qh6RLzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 28, 2013 at 5:26 AM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:
> On 26 January 2013 05:01, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>> Haojian Zhuang <haojian.zhuang@linaro.org> writes:
>>
>>> gpio & pinctrl driver are used together. The pinctrl driver is already
>>> launched before gpio driver in Makefile. So set gpio driver to module
>>> init level. Otherwise, the sequence will be inverted.
>> Hi Haojian,
>>
>> If you switch gpio to module level, and as some modules use gpios in their init
>> path, isn't it possible that some modules will fail their init, as GPIO API
>> won't provide the gpio_*_value() functions ?
>
> gpio_request() should return EPROBE_DEFER, then the driver is using gpio API
> fails and it should be retried after a while. At that time, gpio
> driver should be launched
> properly.

Correct. However it is not uncommon for modules to have untested
errorpaths, such as:

ret = gpio_request(12);
if (ret)
   return -ENODEV;

So you will not know before you test.

Then it is often common to have memory leaks in the errorpath...

So Tested-by: tags are appreciated.

Yours,
Linus Walleij
