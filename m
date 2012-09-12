From: anton.vorontsov@linaro.org (Anton Vorontsov)
Date: Tue, 11 Sep 2012 21:06:57 -0700
Subject: [RFC] tty/serial/kgdboc: Add and wire up clear_irqs callback
In-Reply-To: <CAMbhsRTmZyxFE-vAa-UvNE8KJ2f0cfXP7mncXKcpUiNF6C9PUQ@mail.gmail.com>
References: <20120911093042.GA12471@lizard>
 <1347356106-25368-6-git-send-email-anton.vorontsov@linaro.org>
 <20120911151540.362001c6@pyramind.ukuu.org.uk>
 <20120912033209.GA32156@lizard>
 <CAMbhsRTmZyxFE-vAa-UvNE8KJ2f0cfXP7mncXKcpUiNF6C9PUQ@mail.gmail.com>
Message-ID: <20120912040657.GA3880@lizard>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 11, 2012 at 08:42:46PM -0700, Colin Cross wrote:
[...]
> > The "problem" is in the last step. If we exit NMI without making UART
> > know that we're done with the interrupt, we will reenter the NMI
> > immediately, even without any new characters from the UART.
> 
> The UART irq line should go low when you read the character out of the

Probably some controllers may lower the line by themselves, but not
all, and probably most of them need an explicit clear.

> receive buffer, or the polling rx function should clear the interrupt
> for you.

Yes, that's an option. But that way we add a new semantic for the
polling routines, and effecitvely we just merge the two callbacks.

Of course, if Alan is OK with this, I'm more than OK too. :-)

(But the polling routines would need to clear all interrupts, not
just rx/tx. For example, if the controller indicated some error, and
nobody clears it, then we'll start reentering infinitely.)

> If you use a clear_irqs callback, you can drop characters if
> one arrives between the last character buffer read and calling
> clear_irqs.

Only if we call clear_irqs() after reading the characters, but we do
it before. So if new characters are available, we will reenter NMI,
which is OK.

But if used incorrectly, it truly can cause dropping (or staling) of
characters, so I'd better add some comments about this.

Thanks!

Anton.
