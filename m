From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 16 May 2013 13:49:20 -0600
Subject: GPIO sysfs : set a wake source
In-Reply-To: <87ip2ig1ez.fsf@free.fr>
References: <87fvxwia0s.fsf@free.fr>
 <CACRpkdYjQD9phVtWNh2QGkZWOdEJyZENnYatXt7bd23bgqXitw@mail.gmail.com>
 <51926177.1050600@wwwdotorg.org> <87ip2ig1ez.fsf@free.fr>
Message-ID: <51953840.9050106@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/16/2013 01:39 PM, Robert Jarzmik wrote:
> Stephen Warren <swarren@wwwdotorg.org> writes:
> 
>> On 05/14/2013 03:29 AM, Linus Walleij wrote:
>>> On Thu, May 9, 2013 at 2:59 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>>>
>>>> I was thinking on how to remove all "gpio_request()" from my board code
>>>> (arch/arm/mach-pxa/mioa701.c).
>>>>
>>>> I have a small difficulty with the functionality provided by gpiolib in
>>>> userspace. This is what I need :
>>>>  - define a gpio as an input
>>>>  - define this gpio to be an interrupt source
>>>>  - define this interrupt to be a wake-up source
>>>
>>> This sounds like trying to remove board code by moving it to userspace
>>> and basically starting to implement stuff that belongs in the kernel
>>> in userspace just because someone says we should get rid of board
>>> files :-)
> No, really, even it's true that it comes from someone asking me, now I have
> though it a bit more through.
> 
>>> Don't go down this path, let the kernel handle this kind of stuff.
> Oh really, where ?
> 
> Let me show you why it can't be a module.
> In my case, I have a 2G modem connected to the soc :
>  - the modem and 1 SoC UART are connected (TX, RX, CTS, ...)
>  - the modem and SoC are connected through several gpios
>    - one or two control to power up and reset the modem
>    - one connected to the modem "ring" signal (the one I want a wakeup for).
> 
> So I have no module to handle my modem :
>  - UART is handled by pxa-uart
>  - control/reset by gpiolib
>  - ring ... by nobody
> 
> So my point is that this ring *should* be handled by gpiolib, just as any casual
> input gpio. Moreover, the "wake-up" ability should be activable/deactivable on
> wish by userspace.
> 
>>> Instead figure out how to make the subsystems we have and the
>>> device trees express what you want to do.
>
> As I said above, I don't think it's the way to go. I have *no* subsystem to
> address.
> Devicetree can't help in the toggle to "activate" or "deactivate" the wakeup
> upon this GPIO, can it ?

This sounds very similar to WiFi rfkill, although it's a MODEM not WiFi.
