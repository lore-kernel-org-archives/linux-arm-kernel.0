From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 16 May 2013 21:39:00 +0200
Subject: GPIO sysfs : set a wake source
In-Reply-To: <51926177.1050600@wwwdotorg.org> (Stephen Warren's message of
 "Tue, 14 May 2013 10:08:23 -0600")
References: <87fvxwia0s.fsf@free.fr>
 <CACRpkdYjQD9phVtWNh2QGkZWOdEJyZENnYatXt7bd23bgqXitw@mail.gmail.com>
 <51926177.1050600@wwwdotorg.org>
Message-ID: <87ip2ig1ez.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren <swarren@wwwdotorg.org> writes:

> On 05/14/2013 03:29 AM, Linus Walleij wrote:
>> On Thu, May 9, 2013 at 2:59 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>> 
>>> I was thinking on how to remove all "gpio_request()" from my board code
>>> (arch/arm/mach-pxa/mioa701.c).
>>>
>>> I have a small difficulty with the functionality provided by gpiolib in
>>> userspace. This is what I need :
>>>  - define a gpio as an input
>>>  - define this gpio to be an interrupt source
>>>  - define this interrupt to be a wake-up source
>> 
>> This sounds like trying to remove board code by moving it to userspace
>> and basically starting to implement stuff that belongs in the kernel
>> in userspace just because someone says we should get rid of board
>> files :-)
No, really, even it's true that it comes from someone asking me, now I have
though it a bit more through.

>> Don't go down this path, let the kernel handle this kind of stuff.
Oh really, where ?

Let me show you why it can't be a module.
In my case, I have a 2G modem connected to the soc :
 - the modem and 1 SoC UART are connected (TX, RX, CTS, ...)
 - the modem and SoC are connected through several gpios
   - one or two control to power up and reset the modem
   - one connected to the modem "ring" signal (the one I want a wakeup for).

So I have no module to handle my modem :
 - UART is handled by pxa-uart
 - control/reset by gpiolib
 - ring ... by nobody

So my point is that this ring *should* be handled by gpiolib, just as any casual
input gpio. Moreover, the "wake-up" ability should be activable/deactivable on
wish by userspace.

>> Instead figure out how to make the subsystems we have and the
>> device trees express what you want to do.
As I said above, I don't think it's the way to go. I have *no* subsystem to
address.
Devicetree can't help in the toggle to "activate" or "deactivate" the wakeup
upon this GPIO, can it ?

>> 
>> In another thread I suggested that we add a GPIO "hogging"
>> mechanism to gpiolib, so that the gpio subsystem can by itself
>> "hog" (get) some GPIOs and set them up in certain modes.
>> This closely matches what the pin control subsystem will do
>> with some such things.
>> 
>> What do you think about this idea?
I don't yet know. Let me think this more over. I'd like some literature if you
can provide (especially on LAKML).

> There's some merit to discussing the use of "GPIO hogging" for the
> purpose of solving interactions between the IRQ and GPIO subsystems
>
> However, the discussion above sounds like simply a list of GPIOs to
> initialize at boot for the sole purpose of GPIO initialization. I
> thought that had been discussed before and nak'd?
Now I have described a bit more the problem, I think this sentence would need to
be amended :)

Cheers.

-- 
Robert
