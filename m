From: carlo.caione@gmail.com (Carlo Caione)
Date: Tue, 28 Jan 2014 20:41:57 +0100
Subject: [PATCH v3 1/3] ARM: sun7i/sun6i: irqchip: Add irqchip driver for
 NMI controller
In-Reply-To: <52E78E3F.6080902@redhat.com>
References: <1389453548-10665-1-git-send-email-carlo.caione@gmail.com>
 <1389453548-10665-2-git-send-email-carlo.caione@gmail.com>
 <20140116123940.GE31779@lukather>
 <CAOQ7t2ay6UM-YAUSypRzC=_oSY=0L5RhD6FziG96j4aoK6RHsQ@mail.gmail.com>
 <20140128104044.GC3867@lukather> <52E78E3F.6080902@redhat.com>
Message-ID: <CAOQ7t2bahx_ZEMMmhPm3g7-v6U3MkaXO6-JFGvjoKNWOCrG=ng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 28, 2014 at 12:02 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Hi,
>
> On 01/28/2014 11:40 AM, Maxime Ripard wrote:
>
> Jumping in here to try and clarify things, or so I hope at least :)

Thank you :) I'm sure you will explain this better than me.

> The PMIC irq line won't go low until an i2c write to its irq status
> registers write-clears all status bits for which the corresponding
> bit in the irq-mask register is set.
>
> And the only reason the NMI -> GIC also goes low is because the unmask
> operation writes a second ack to the NMI controller in the unmask
> callback of the NMI controller driver.

Exactly. PMIC -> NMI is cleared when the irq handler write-clears all
the IRQs on PMIC while NMI -> GIC is cleared by the ACK in the unmask
callback.

<snip>

> Hmm, I'm not going to say that using a raw irqchip here is a bad idea, it
> sounds like it would be better.
>
> But I don't think this will solve the need the mask / umask. The problem is
> we need to do an i2c write to clear the interrupt source, which needs to
> be done from a thread / workqueue. So when the interrupt handler finishes
> the source won't be cleared yet, and AFAIK then only way to deal with this
> is to mask the interrupt until we've cleared the interrupt source.

That's why the driver using the NMI controller has to use IRQF_ONESHOT
so that the interrupt is not unmasked after the hard interrupt context
handler but it is unmasked after the thread handler function has been
executed (calling the unmask callback)

Thank you for explaining this mess you couldn't be clearer than that.

-- 
Carlo Caione
