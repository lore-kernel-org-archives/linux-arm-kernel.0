From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 25 Apr 2013 21:36:22 +0200
Subject: gpio-pxa initcall level change and machine init breakage
References: <5172B398.7060706@newsguy.com>
 <CAD6h2NSRA9w7GZLQGgK-+TvEAsxwOHow5_26JyVUA6YQyj3OQg@mail.gmail.com>
 <517466F6.3000003@newsguy.com>
 <CAD6h2NSy0=3P-PHdCiJJQG_jvGaFnr7uex+Uxs=0F-VsUxtPWg@mail.gmail.com>
 <CACRpkdbk24kR75fanvXVAocnuozNq_=jWDSPHPCWhbZCOrN5_Q@mail.gmail.com>
 <5176E438.80800@newsguy.com>
 <CACRpkdYLCKKZZFi6Y-viPUvrwupJGzfxr3f20a1emp-9qE0YBg@mail.gmail.com>
Message-ID: <87ppxiz9l5.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij <linus.walleij@linaro.org> writes:

> On Tue, Apr 23, 2013 at 9:42 PM, Mike Dunn <mikedunn@newsguy.com> wrote:
>
>> On a more general note... I'm surprised that gpiolib can not run earlier, for
>> something so low-level.
>
> Well I think the patch we're discussing is making it run less early, and it
> can actually run as arch_initcall() or similar if you wish (it's up to the
> driver).
>
> However that is beside the point, Haojian is still doing the right thing
> trying to push this to driver init (==module_init) level. The reason is
> that basically all hardware drivers should be initialized at this level
> because the other init levels are basically for other things and driver
> deps are just shoehorned into them.
>
> Instead of relying on things to be set up early one shall rely on
> deferred probe.
Hi Linus,

Even if that is the long term goal, and I agree with that goal, let me quote
Documentation/gpio.txt : "However, for spinlock-safe GPIOs it's OK to use them
before tasking is enabled, as part of early board setup.".

When gpio abstraction was written, it was assumed GPIO usage was usable in early
platform setup code. As this was granted, we (board maintainers) coded
accordingly.

Now this patch breaks boards. I disagree in having my board code broken without
notice. What I would find less intrusive would be to :
 (a) revert the patch
 (b) inform board maintainers that they must fix their board code (for example
 give them 1 window)
 (c) put back the patch. Board maintainers who did not amend their board
 code cannot say anymore they didn't know it. Board maintainers will also have
 time to rise objections if they think they cannot change their board code
 (which I do not believe is possible, but who knows ...)

Ah and change the Documentation too I think, if you want GPIO to be only usable
from device initcall level.

> Alas, it is not an easy change, and not expected to happen quickly
> or painlessly.
Sure, so let's do it in right order, shall we ?

Cheers.

-- 
Robert

PS: When I say "broken code", in the mioa701 case, my phone doesn't wakeup on
phone calls. Disturbing, isn't it ?
