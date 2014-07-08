From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 08 Jul 2014 12:50:59 +0200
Subject: [PATCH 4/6] pinctrl: exynos: Lock GPIOs as interrupts when used as
 EINTs
In-Reply-To: <CACRpkdYD=6iV0qFRQrAf2TJc7tg=m2ZEr6SvhruEwsGQLzskSA@mail.gmail.com>
References: <1404315664-3174-1-git-send-email-t.figa@samsung.com>
 <1404315664-3174-5-git-send-email-t.figa@samsung.com>
 <CACRpkdYD=6iV0qFRQrAf2TJc7tg=m2ZEr6SvhruEwsGQLzskSA@mail.gmail.com>
Message-ID: <53BBCD13.7020902@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On 08.07.2014 11:03, Linus Walleij wrote:
> On Wed, Jul 2, 2014 at 5:41 PM, Tomasz Figa <t.figa@samsung.com> wrote:
> 
>> Currently after configuring a GPIO pin as an interrupt related pinmux
>> registers are changed, but there is no protection from calling
>> gpio_direction_*() in a badly written driver, which would cause the same
>> pinmux register to be reconfigured for regular input/output and this
>> disabling interrupt capability of the pin.
>>
>> This patch addresses this issue by moving pinmux reconfiguration to
>> .irq_startup() callback of irq_chip and calling gpio_lock_as_irq()
>> helper to prevent reconfiguration of pin direction.
>>
>> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> (...)
>> +               .irq_startup = exynos_irq_startup,
>> +               .irq_shutdown = exynos_irq_shutdown,
> 
> I think you should be using the
> .irq_request_resources and .irq_release_resources callbacks instead.
> 
> The reason is that startup and shutdown cannot really fail (ret code
> is unsigned...), so using the other callbacks is safer.

Hmm, I used the at91 pinctrl driver as an example, but I agree that
request/release_resources would be better. I guess it should be changed
there as well. [Ccing Jean-Jacques and Jean-Christophe]

> 
> Can you have a quick look at this before I apply any more of the
> Samsung patches?

The two remaining patches are pretty much independent from this one and
rest of this series so please take a look at them while I prepare new
version of this patch.

Best regards,
Tomasz
