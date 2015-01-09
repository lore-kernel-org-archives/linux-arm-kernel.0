From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 9 Jan 2015 09:34:46 +0100
Subject: [PATCH 0/9] ARM Versatile multi-platform support
In-Reply-To: <CAL_JsqKLNPVDCUELaZU8JW0roT3RcyqcxtJbvbYQrjzxjt3FeQ@mail.gmail.com>
References: <1419967718-26909-1-git-send-email-robherring2@gmail.com>
 <CACRpkda8T8CwghVYtTw41h_y+GdCA5xCEaSL1Jy4VZBo3MAy-Q@mail.gmail.com>
 <CAL_JsqKLNPVDCUELaZU8JW0roT3RcyqcxtJbvbYQrjzxjt3FeQ@mail.gmail.com>
Message-ID: <CACRpkdZpwoY4-9K9_Eh-UikmP5hqQhfu2eZRb-wkVntVn1g5wA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 8, 2015 at 10:38 PM, Rob Herring <robherring2@gmail.com> wrote:
> On Thu, Jan 8, 2015 at 1:47 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Tue, Dec 30, 2014 at 8:28 PM, Rob Herring <robherring2@gmail.com> wrote:
>>
>>> From: Rob Herring <robh@kernel.org>
>>>
>>> This series converts ARM Versatile platform to multi-platform. I started
>>> this some time ago and some pieces were already merged. The primary
>>> piece remaining is converting the PCI host to DT which I was waiting for
>>> the common PCI DT parsing to get settled. Now that that is in place as
>>> well as a few other pieces are in place like multi-platform fixes for
>>> CLCD, we can fully convert Versatile to DT and multi-platform.
>>>
>>> There's still a few things that need DT support which can be done
>>> later:
>>> - MMC card detect and write protect. Should be able to use VExpress
>>>   support
>>> - Reboot support. Should be able to re-use Realview reboot code.
>>> - flash phys-map support. Binding exists, but specifically Vpp control
>>>   is needed.
>>> - CLCD support. Not sure where this is at.
>>
>> I like it overall but would like to see some use of the syscon
>> pattern to access random registers in syscon, and specifically not
>> to refer to these registers as some "gpio" because they aren't.
>
> I'm not sure I follow. Creating GPIO lines for SD card detect and
> write protect is exactly how VExpress syscon was implemented.

Hm it all boils down to this mfd/vexpress-sysreg.c driver that
spawns some MFD devices.

>From there a LED, card detect and flash protection are modeled as
"basic-mmio-gpio" instantiating the drivers/gpio/gpio-generic.c
driver to drive/read various bits.

Specifically commit 974cc7b93441a0e78f030495436d1be7eb7c208d
that makes a layered MFD->gpio->gpio LED cake.
Needless to say neither the GPIO maintainers or the GPIO
mailing list was included in review of this patch and it was
merged on its MFD merits :(

It is sort of elegant in a way, but I don't like it when we describe
registers that are not general purpose as "general purpose input
output" it is simply ontologically wrong and a misleading hardware
description. These bits are not general purpose *at* *all* they are
special purpose.

It is Linux GPIO implementation details leaking into the hardware
description basically: it just happened to be very convenient to
describe these register bits as "gpios" as the drivers etc were
already in place.

I prefer syscon->syscon LED as a two layer cake
instead of a three layer cake involving GPIO and it's more to the point,
describing the hardware properly, so I say let's go for that instead.

For card detect and flash protection I suspect we can use
syscon as well, avoiding shoehorning a GPIO abstraction between
it.

Yours,
Linus Walleij
