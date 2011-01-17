From: rabin@rab.in (Rabin Vincent)
Date: Mon, 17 Jan 2011 20:42:07 +0530
Subject: [PATCH] mmci: fixup broken_blockend variant patch v2
In-Reply-To: <1295275071-13146-1-git-send-email-linus.walleij@stericsson.com>
References: <1295275071-13146-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <AANLkTin67iTj34QBv3T-9+oMdo6q=EsYKf=5ca=6B69s@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 17, 2011 at 20:07, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> + ? ? ? ?* On the U300 and Ux500 a few to many MCI_DATABLOCKEND interrupts
> + ? ? ? ?* are usually missing, so the data counter is not properly increased.
> + ? ? ? ?* This is likely because new block arrive while the IRQ is being
> + ? ? ? ?* processed without the transfers being held back, and ACK:in the
> + ? ? ? ?* interrupt will only clear the very last block and intermediate
> + ? ? ? ?* blockend interrupts get lost. So we simply mask of the blockend
> + ? ? ? ?* interrupt on these and only use the dataend interrupt.

Have you observed this to be different on the ARM variants?  I asked a
related question about this earlier:

http://thread.gmane.org/gmane.linux.ports.arm.kernel/101118:
| In MMCI, on variants which use the DATABLOCKEND interrupt, if we cross
| more than one block boundary in the loop inside mmc_pio_read() or
| mmci_pio_write(), when the DATABLOCKEND irq is handled after interrupts
| are enabled in mmci_pio_irq(), won't the block count be incorrect
| because we would consider that only one block has been transferred, when
| in fact it has been two?  Or can this never happen for some reason?
