From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 31 Oct 2014 10:57:44 +0100
Subject: [PATCH 1/3] genirq: Allow the irqchip state of an IRQ to be
 save/restored
In-Reply-To: <5450CCE7.7010803@arm.com>
References: <1414232097-4328-1-git-send-email-marc.zyngier@arm.com>
 <1414232097-4328-2-git-send-email-marc.zyngier@arm.com>
 <CACRpkdZjUPV1eWcJjT587kxJm2zyC+OEYD0Deid4wYPh8A-Z4w@mail.gmail.com>
 <5450CCE7.7010803@arm.com>
Message-ID: <CACRpkdadiT3QGnCp+1h-R1rLhfgYSor3KLfd0MUR=cBe0haU-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 29, 2014 at 12:17 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 29/10/14 10:12, Linus Walleij wrote:
>> On Sat, Oct 25, 2014 at 12:14 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>
>>> There is a number of cases where a kernel subsystem may want to
>>> introspect the state of an interrupt at the irqchip level:
>>>
>>> - When a peripheral is shared between virtual machines, its interrupt
>>>   state becomes part of the guest's state, and must be switched accordingly.
>>>   KVM on arm/arm64 requires this for its guest-visible timer
>>> - Some GPIO controllers seem to require peeking into the interrupt controller
>>>   they are connected to to report their internal state
>>
>> I'd like to know exactly what this means, for GPIO. As mentioned in
>> conversation with Arnd, there is since before the case where a GPIO
>> irqchip gets its irqs "stolen" by some other hardware that is in the
>> always-on domain, and I call these "latent irqs".
>
> It looks like a slightly different issue:
> http://patchwork.ozlabs.org/patch/397657/
>
> Basically, the GPIO chip cannot report its own state, and has to
> introspect the parent irqchip to find out.

That's incidentally the same problem as in the Integrator/CP,
wowsers. What goes around comes around.

>> This just goes in and peeks around in the Integrator SIC, this
>> patch would solve also this I think. Or are the added calls good
>> for clearing the latched IRQ too?
>
> Pretty funky. You could also use this to clear the pending bit (assuming
> there is one on the CP). I'm amazed at the number of similar hacks that
> are coming out of the wood now...

Yeah we should have fixed this with the Integrator in 2001 or so.
Not too late anyways, let's clean it out now :)

Yours,
Linus Walleij
