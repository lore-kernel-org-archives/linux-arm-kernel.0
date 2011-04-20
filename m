From: vitalywool@gmail.com (Vitaly Wool)
Date: Wed, 20 Apr 2011 19:58:40 +0200
Subject: [PATCH] mmci: sync DATAEND irq with dma transfer done
In-Reply-To: <BANLkTik05ERLa83Lah5Fx2HO+91bb9Q7Xg@mail.gmail.com>
References: <1303203754-1731-1-git-send-email-linus.walleij@stericsson.com>
	<20110419092049.GC22799@n2100.arm.linux.org.uk>
	<BANLkTik4mmJzYsOit-5vNzchtHVUyEL+jg@mail.gmail.com>
	<20110419120344.GG22799@n2100.arm.linux.org.uk>
	<BANLkTimrsn1MxY+L7_yt0b1LXmaXxpMHPg@mail.gmail.com>
	<BANLkTikr5B5YH+is18gYceCM1thjHgT-yQ@mail.gmail.com>
	<BANLkTik05ERLa83Lah5Fx2HO+91bb9Q7Xg@mail.gmail.com>
Message-ID: <BANLkTi=u95J5vMrSGQN45=eiQEWGNffv_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 20, 2011 at 7:17 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> What we need is a DMAXFERCOMPLETE flag so we know that
> the DMA state machine is really finished. Sadly the hardware lacks
> such a status flag, so there is no way to know that the DMA state
> machine is finished by looking at any status registers in the
> MMCI block.
>
> We are thus reliant on the other end of the bitpipe telling us
> it's finished.

Okay, but can't we have something like this then in the unmap function:

       for (i = 0; i < 100; i++) {
               status = readl(host->base + MMCISTATUS);
               if (host->unreliable_rxflags) {
                       if (host->dataend)
                              break;
               } else if (!(status & MCI_RXDATAAVLBLMASK))
                       break;
               udelay(10);
       }

to minimize the changes and apparently address Russell's concern as well?

Thanks,
   Vitaly
