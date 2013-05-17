From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 17 May 2013 08:24:35 +0200
Subject: GPIO sysfs : set a wake source
In-Reply-To: <87ip2ig1ez.fsf@free.fr>
References: <87fvxwia0s.fsf@free.fr>
 <CACRpkdYjQD9phVtWNh2QGkZWOdEJyZENnYatXt7bd23bgqXitw@mail.gmail.com>
 <51926177.1050600@wwwdotorg.org> <87ip2ig1ez.fsf@free.fr>
Message-ID: <CACRpkdbiZFutP_+u=ciuC6r-8N5FpkEnGVLH9LGDQ7pvdo3_-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 16, 2013 at 9:39 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:

>>> Don't go down this path, let the kernel handle this kind of stuff.

> Oh really, where ?
>
> Let me show you why it can't be a module.

I'm not following. I haven't been talking about modules ...
(I think?)

Do you mean you want to show why it can't be in the kernel?

> In my case, I have a 2G modem connected to the soc :
>  - the modem and 1 SoC UART are connected (TX, RX, CTS, ...)
>  - the modem and SoC are connected through several gpios
>    - one or two control to power up and reset the modem
>    - one connected to the modem "ring" signal (the one I want a wakeup for).
>
> So I have no module to handle my modem :
>  - UART is handled by pxa-uart
>  - control/reset by gpiolib

Do you mean control/reset is handled by the userspace sysfs
interface to GPIOlib? This is not necessarily a good idea
in that case.

>  - ring ... by nobody
>
> So my point is that this ring *should* be handled by gpiolib, just as any casual
> input gpio. Moreover, the "wake-up" ability should be activable/deactivable on
> wish by userspace.

(...)

>>> Instead figure out how to make the subsystems we have and the
>>> device trees express what you want to do.
> As I said above, I don't think it's the way to go. I have *no* subsystem to
> address.

We have several cases of out-of-tree code due to missing subsystems.

One such subsystem is the in-kernel modem subsystem which Arun
has been trying to get going:
http://marc.info/?l=linux-kernel&m=134881988212794&w=2

> Devicetree can't help in the toggle to "activate" or "deactivate" the wakeup
> upon this GPIO, can it ?

No, I'm just saying the connection between the device and the
GPIO tree shall be modeled in the device tree, especially since
this is obviously deeply embedded, soldered-on stuff and the
hardware set-up should be encoded in the device tree.

I am starting so suspect that the real issue here, which has
not been expressed so far, is that you think of this embedded
modem as a US Robotics 28K8 modem connected to a serial
port, and as something that should be handled by userspace.

Is there a silent assumption that "modem drivers must be in
userspace"?

This assumption is not necessarily true when the modem start
to connect wires like GPIO to work. There are modems using
other things than UART, such as HSI, for datapath. And modems
using in-kernel protocols like CAIF or Phonet for control.

I think you need to think about how we join this modem closer
with the kernel instead of trying to paper it over using userspace
GPIO.

>>> What do you think about this idea? [GPIO hogs]
> I don't yet know. Let me think this more over. I'd like some literature if you
> can provide (especially on LAKML).

It doesn't toggle any pins so it's not what you want anyway.

I think you want part of your driver in the kernel.

I think the dilemma faced by embedded modems need to
be considered thoroughly here.

Yours,
Linus Walleij
