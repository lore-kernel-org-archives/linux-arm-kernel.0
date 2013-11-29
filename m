From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 29 Nov 2013 14:46:29 +0100
Subject: [PATCH V2] media: i2c: Add ADV761X support
In-Reply-To: <5298852F.6030303@cogentembedded.com>
References: <1384520071-16463-1-git-send-email-valentine.barshak@cogentembedded.com>
 <5295E231.9030200@cisco.com> <5295E641.6060603@cogentembedded.com>
 <2150651.hQNra4Rlob@avalon>
 <CACRpkdZQa626hNRFcGvk4t7Z8scTCoEcf7AqO-FsL=BGk6UfeA@mail.gmail.com>
 <52987058.80700@metafoo.de> <5298852F.6030303@cogentembedded.com>
Message-ID: <CACRpkdaKeuQk3y42XvCcjJuis0U5cpmJ8M7YG6=0Qo1Apc=HHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 29, 2013 at 1:14 PM, Valentine
<valentine.barshak@cogentembedded.com> wrote:
> On 11/29/2013 02:45 PM, Lars-Peter Clausen wrote:
>> On 11/29/2013 11:37 AM, Linus Walleij wrote:

>>> So I guess the answer to the question is something like, fix
>>> the GPIO driver to stop requiring the GPIO lines to be requested
>>> and configured before being used as IRQs, delete that code,
>>> and while you're at it add a call to gpiod_lock_as_irq()
>>> to your GPIO driver in the right spot: examples are on the
>>> mailing list and my mark-irqs branch in the GPIO tree.
>>
>> As far as I understand it this already works more or less with the driver.
>> The problem is that the IRQ numbers are dynamically allocated, while the
>> GPIO numbers apparently are not. So the board code knows the the GPIO
>> number
>> at compile time and can pass this to the diver which then does a
>> gpio_to_irq
>> to lookup the IRQ number.
(...)
>> This of course isn't really a problem with
>> devicetree, but only with platform board code.
>
> I'm not sure what's the difference here and why it is not a problem with
> devicetree?

It's no problem when using devicetree because you can obtain
the GPIOs directly from the node with of_get_gpio()
and of_get_named_gpio() in the special DT probe path.

But don't do that! Instead switch the whole driver, and preferably
the whole platform, to use descriptors.

Yours,
Linus Walleij
