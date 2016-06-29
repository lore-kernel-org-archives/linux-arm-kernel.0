From: drake@endlessm.com (Daniel Drake)
Date: Wed, 29 Jun 2016 08:41:34 -0600
Subject: [PATCH 0/2] pinctrl: Enable support for external GPIO interrupts
In-Reply-To: <CACRpkdZivUN8HKZ7oTDW6C35vSMv6+9G6-8M7=-kJM3B9vmH-A@mail.gmail.com>
References: <5772301F.3030904@baylibre.com>
 <CACRpkdZivUN8HKZ7oTDW6C35vSMv6+9G6-8M7=-kJM3B9vmH-A@mail.gmail.com>
Message-ID: <CAD8Lp44SGNwYmeMPKMxbho8EXv9xZFtgHVGh5PKT7_4svYmiFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 29, 2016 at 2:53 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> I think the dynamic solution is always more elegant, computers should resolve
> complex problems, doing it in DT makes a human do a machine's work which
> is as a rule of thumb not a good idea. But there is also the question
> of maintenance
> cost and what makes sense at a human level so I'm not totally
> inflexible on this.

On this hardware we only have 8 GPIO IRQs available, for 100+ GPIOs.
If you want to monitor for both rising and falling edge of a GPIO then
you have to use 2 GPIO IRQs. 2 are used for the common case of SD card
detect. You can quickly lose several more (2 for audio jack detection,
power button, etc). So these are a very limited resource.

If the allocation is done dynamically I see 2 slight advantages:

 1. If the number of GPIO-IRQ users is greater than the number
available, the distributor can exclude drivers that are not of
interest to him and the corresponding GPIO-IRQs will automatically and
dynamically become available for the drivers that are of interest.

 2. If the device tree encodes these assignments then the management
could be a bit complex, because some will be defined in the SoC dtsi
files and others will be defined in the board dts files (e.g.
Endless's CVBS mode selection switch), we'll have to make sure that
there are not conflicting assignments. Similarly if we end up sharing
dtsi files over different SoC versions then things could get tricky
especially in such a small namespace of 8 GPIO-IRQs. In the dynamic
case this is not an issue.

Daniel
