From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 12 Mar 2012 11:48:36 +0100
Subject: [PATCH] serial: PL011: clear pending interrupts
In-Reply-To: <20120312101100.GA8649@n2100.arm.linux.org.uk>
References: <1331540750-25697-1-git-send-email-linus.walleij@stericsson.com>
 <20120312083221.GW17370@n2100.arm.linux.org.uk>
 <20120312101100.GA8649@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdbsa6HW63vN7CeKNpgLZokB+S6GEaU27CiaVsbvo5qA-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 12, 2012 at 11:11 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

>> > + ? /* RXIS but RXFE? Just clear the interrupt */
>> > + ? if(unlikely(fifotaken == 0))
>> > + ? ? ? ? ? writew(UART011_RTIS | UART011_RXIS,
>> > + ? ? ? ? ? ? ? ? ?uap->port.membase + UART011_ICR);
>
> BTW, I don't see why we need any of this stuff.
>
> The problem as described is that the interrupt handler is called with one
> of the receive flags set (UART011_RTIS or UART011_RXIS) but with
> UART01x_FR_RXFE clear.
>
> The problem report indicates that this is caused when we switch from FIFO
> mode to non-FIFO mode, and the FIFO contained some unread characters.
>
> That can only happen once we've enabled interrupts in the IMSC register,
> which doesn't happen until later in the startup function.
>
> So:
>
> ? ? ? ?spin_lock_irq(&uap->port.lock);
> ? ? ? ?uap->im = UART011_RTIM;
> ? ? ? ?if (!pl011_dma_rx_running(uap))
> ? ? ? ? ? ? ? ?uap->im |= UART011_RXIM;
> ? ? ? ?writew(uap->im, uap->port.membase + UART011_IMSC);
> ? ? ? ?spin_unlock_irq(&uap->port.lock);
>
> clearing the transmit/receive interrupts here _before_ we unmask them
> should be sufficient.

Right! OK I'll cook a v2 patch according to this suggestion and
request Chanho to test it.

Yours,
Linus Walleij
