From: carlo.caione@gmail.com (Carlo Caione)
Date: Tue, 28 Jan 2014 22:02:46 +0100
Subject: [PATCH v3 1/3] ARM: sun7i/sun6i: irqchip: Add irqchip driver for
 NMI controller
In-Reply-To: <20140128164142.GL3867@lukather>
References: <1389453548-10665-1-git-send-email-carlo.caione@gmail.com>
 <1389453548-10665-2-git-send-email-carlo.caione@gmail.com>
 <20140116123940.GE31779@lukather>
 <CAOQ7t2ay6UM-YAUSypRzC=_oSY=0L5RhD6FziG96j4aoK6RHsQ@mail.gmail.com>
 <20140128104044.GC3867@lukather> <52E78E3F.6080902@redhat.com>
 <20140128164142.GL3867@lukather>
Message-ID: <CAOQ7t2YLv8dNF6i-X6Y1BgvvcBCNt6JhmpGuo23E057xez6+Tg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jan 28, 2014 at 5:41 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Tue, Jan 28, 2014 at 12:02:23PM +0100, Hans de Goede wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> Hi,
>>
>> On 01/28/2014 11:40 AM, Maxime Ripard wrote:
>>
>> Jumping in here to try and clarify things, or so I hope at least :)
>
> Sure :)
>
>> No, the IRQ from the PMIC is a level sensitive IRQ, so it would look
>> like this:
>
> Hmm, your mailer seems to have mangled your drawing :(
>
>> The PMIC irq line won't go low until an i2c write to its irq status
>> registers write-clears all status bits for which the corresponding
>> bit in the irq-mask register is set.
>
> Which makes sense too
>
>> And the only reason the NMI -> GIC also goes low is because the unmask
>> operation writes a second ack to the NMI controller in the unmask
>> callback of the NMI controller driver.
>
> Yes, and this is exactly what I don't understand. You shouldn't need
> that ack in first place, since it's been done already right after the
> unmask.

But the first ack is ignored since the IRQ line is still maintained
asserted by PMIC.

>> Note that we cannot use edge triggered interrupts here because the PMIC
>> has the typical setup with multiple irq status bits driving a single
>> irq line, so the irq handler does read irq-status, handle stuff,
>> write-clear irq-status. And if any other irq-status bits get set
>> between the read and write-clear the PMIC -> NMI line will stay
>> high, as it should since there are more interrupts to handle.
>
> Yep, the edge-thing was just the only case I could think of where it
> could lead to troubles.
>
> In what you're saying, which makes total sense, if we don't do the
> ack, as soon as the irq will be unmasked, since the level is high, the
> handler will be called again, treat the new interrupts, and so on. I
> don't see how this is an issue actually.

This is exactly why in unmask callback we first ACK and then unmask.
So, if the line is still maintained up by PMIC then a new interrupt is
raised otherwise nothing happens.

>> > But in this case, you would have two events coming from your
>> > device (the two rising edges), so you'd expect two interrupts. And
>> > in the case of a level triggered interrupt, the device would keep
>> > the interrupt line active until it's unmasked, so we wouldn't end
>> > up with this either.
>> >
>> >> sunxi_sc_nmi_ack_and_unmask is therefore called (by
>> >> irq_finalize_oneshot) after the IRQ thread has been
>> >> executed. After the IRQ thread has ACKed the IRQs on the
>> >> originating device we can finally ACK and unmask again the NMI.
>> >
>> > And what happens if you get a new interrupt right between the end
>> > of the handler and the unmask?
>>
>> The implicit ack done by the unmask will be ignored if the NMI line
>> is still high, just like the initial ack is ignored (which is why we
>> need the mask), and when the unmask completes the irq will
>> immediately retrigger, as it should.
>
> Yeah, but why do we need the ack in the first place? I can't think of
> a case where the ACK would be doing something useful. Either:
>   - there is no new interrupts between the mask/ack and the unmask, so
>     there's no interrupt to ack.
>   - There's a new interrupt between the mask/ack and the
>     unmask. There's two more cases here:
>     * The interrupt came before the device handler kicked in, and the
>       handler will treat it/ack it: No issue
>     * The interrupt comes right after the handler has been acking its
>       interrupt, the level stays high, your handler is called once
>       again, you can treat it: No issue

AFAIU the problem here is that the only ACK that is able to assert the
line NMI -> GIC is the ACK by the unmask callback. All the others ACKs
before that one are ignored by the NMI controller since the line PMIC
-> NMI is still asserted.

>> >>> I really wonder whether it makes sense to have a generic chip
>> >>> here. It seems to be much more complicated than it should. It's
>> >>> only about a single interrupt interrupt chip here.
>> >>
>> >> I agree but is there any other way to manage the NMI without the
>> >> driver of the device connected to NMI having to worry about
>> >> acking/masking/unmasking/ etc..?
>> >
>> > Yes, just declare a "raw" irqchip. Pretty much like we do on
>> > irq-sun4i for example.
>>
>> Hmm, I'm not going to say that using a raw irqchip here is a bad
>> idea, it sounds like it would be better.
>
> There's none. It was a separate comment :)
>
>> But I don't think this will solve the need the mask / umask. The
>> problem is we need to do an i2c write to clear the interrupt source,
>> which needs to be done from a thread / workqueue. So when the
>> interrupt handler finishes the source won't be cleared yet, and
>> AFAIK then only way to deal with this is to mask the interrupt until
>> we've cleared the interrupt source.
>
> Yes, but the interrupt is still masked during the time between the
> "hard" handler and the thread, so there's no way you can get an
> interrupt flood during that time.

agree.

BTW fortunately we can talk about this also during FOSDEM ;)

Thank you,

-- 
Carlo Caione
