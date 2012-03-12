From: james.dutton@gmail.com (James Courtier-Dutton)
Date: Mon, 12 Mar 2012 09:27:28 +0000
Subject: [PATCH] serial: PL011: clear pending interrupts
In-Reply-To: <1331540750-25697-1-git-send-email-linus.walleij@stericsson.com>
References: <1331540750-25697-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <CAAMvbhF7-5FyzjgtK7EjFZSJg4KBxdMdd1jnTRTLA-LnsVhKyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 March 2012 08:25, Linus Walleij <linus.walleij@stericsson.com> wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
>
> Chanho Min reported that when the boot loader transfers
> control to the kernel, there may be pending interrupts
> causing the UART to lock up in an eternal loop trying to
> pick tokens from the FIFO (since the RX interrupt flag
> indicates there are tokens) while in practice there are
> no tokens - in fact there is only a pending IRQ flag.
>

I might be off base here, because I don't know this particular UART,
but if an IRQ routine is called because the RX interrupt flag is set,
shouldn't the IRQ routine be written in such a way that it can never
lock up.
If the IRQ routing has a loop that is used to read each byte from the
port, the loop should have a counter limit in it, so in case of some
unexpected situation, it can always make an exit, and not lock up.
So, in your case, if the loop counter limit is hit, it would mean that
although we had an RX interrupt flag set, there are no tokens, so act
according with a suitable error path.

I had to implement this in one Linux kernel driver due to an error
condition that happened on PCMCIA card insertion.
On the first insertion, there were unwanted IRQ calls, but after the
second false IRQ call, it calmed down. I used a counter limit in the
IRQ driver in order to handle the false IRQ calls situation.

Kind Regards

James
