From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 18 May 2013 11:18:40 +0200
Subject: GPIO sysfs : set a wake source
References: <87fvxwia0s.fsf@free.fr>
 <CACRpkdYjQD9phVtWNh2QGkZWOdEJyZENnYatXt7bd23bgqXitw@mail.gmail.com>
 <51926177.1050600@wwwdotorg.org> <87ip2ig1ez.fsf@free.fr>
 <CACRpkdbiZFutP_+u=ciuC6r-8N5FpkEnGVLH9LGDQ7pvdo3_-Q@mail.gmail.com>
Message-ID: <87k3mwv6ru.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij <linus.walleij@linaro.org> writes:

> On Thu, May 16, 2013 at 9:39 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>
>>>> Don't go down this path, let the kernel handle this kind of stuff.
>
>> Oh really, where ?
>>
>> Let me show you why it can't be a module.
>
> I'm not following. I haven't been talking about modules ...
> (I think?)
> Do you mean you want to show why it can't be in the kernel?
My bad. Bad wording, I should have said "why it shouldn't be in kernel".

>
>> In my case, I have a 2G modem connected to the soc :
>>  - the modem and 1 SoC UART are connected (TX, RX, CTS, ...)
>>  - the modem and SoC are connected through several gpios
>>    - one or two control to power up and reset the modem
>>    - one connected to the modem "ring" signal (the one I want a wakeup for).
>>
>> So I have no module to handle my modem :
>>  - UART is handled by pxa-uart
>>  - control/reset by gpiolib
>
> Do you mean control/reset is handled by the userspace sysfs
> interface to GPIOlib? This is not necessarily a good idea
> in that case.
Exactly, all controlled through userspace sysfs.

Well, it's the agreed method for far, see [1].
Search [1] for the string "These are really lengthy and time consuming sequences".

>> Devicetree can't help in the toggle to "activate" or "deactivate" the wakeup
>> upon this GPIO, can it ?
>
> No, I'm just saying the connection between the device and the
> GPIO tree shall be modeled in the device tree, especially since
> this is obviously deeply embedded, soldered-on stuff and the
> hardware set-up should be encoded in the device tree.
OK, expressed in DT, why not.

> I am starting so suspect that the real issue here, which has
> not been expressed so far, is that you think of this embedded
> modem as a US Robotics 28K8 modem connected to a serial
> port, and as something that should be handled by userspace.
Yes, that's what I and others think for modem startup control ([1]) but not for
modem data path.

> Is there a silent assumption that "modem drivers must be in
> userspace"?
No, certainly not. The assumption is one though that this particular modem,
which is that old and simple, doesn't require a driver other than the uart SoC
driver.

> This assumption is not necessarily true when the modem start
> to connect wires like GPIO to work. There are modems using
> other things than UART, such as HSI, for datapath. And modems
> using in-kernel protocols like CAIF or Phonet for control.
These are far more modern modems than the one I'm talking of.
Mine is a Sagem X200 (I think, from board disassembly).

> I think you need to think about how we join this modem closer
> with the kernel instead of trying to paper it over using userspace
> GPIO.
Why ? I has only one UART and several GPIOs. What good would it be to add it in
kernel ?

>> I don't yet know. Let me think this more over. I'd like some literature if you
>> can provide (especially on LAKML).
> It doesn't toggle any pins so it's not what you want anyway.
> I think you want part of your driver in the kernel.
Which driver ? The Sagem X200 ?

> I think the dilemma faced by embedded modems need to
> be considered thoroughly here.
As I said, it's an "old" modem. And if by embedded you mean "embedded in the
SoC", it's not, it's a separate chip. The interconnect are the UART lines and
the GPIO lines (solder lines as you pointed out).


Cheers.

-- 
Robert

[1] http://archive.arm.linux.org.uk/lurker/message/20080612.101303.80e8bb8b.fr.html
