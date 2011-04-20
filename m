From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 20 Apr 2011 22:11:30 +0200
Subject: [PATCH] mmci: sync DATAEND irq with dma transfer done
In-Reply-To: <BANLkTi=u95J5vMrSGQN45=eiQEWGNffv_g@mail.gmail.com>
References: <1303203754-1731-1-git-send-email-linus.walleij@stericsson.com>
	<20110419092049.GC22799@n2100.arm.linux.org.uk>
	<BANLkTik4mmJzYsOit-5vNzchtHVUyEL+jg@mail.gmail.com>
	<20110419120344.GG22799@n2100.arm.linux.org.uk>
	<BANLkTimrsn1MxY+L7_yt0b1LXmaXxpMHPg@mail.gmail.com>
	<BANLkTikr5B5YH+is18gYceCM1thjHgT-yQ@mail.gmail.com>
	<BANLkTik05ERLa83Lah5Fx2HO+91bb9Q7Xg@mail.gmail.com>
	<BANLkTi=u95J5vMrSGQN45=eiQEWGNffv_g@mail.gmail.com>
Message-ID: <BANLkTi=4V8DuDyuWeHGPXy_h+aH7YUdXMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 20, 2011 at 7:58 PM, Vitaly Wool <vitalywool@gmail.com> wrote:

> Okay, but can't we have something like this then in the unmap function:
>
> ? ? ? for (i = 0; i < 100; i++) {
> ? ? ? ? ? ? ? status = readl(host->base + MMCISTATUS);
> ? ? ? ? ? ? ? if (host->unreliable_rxflags) {
> ? ? ? ? ? ? ? ? ? ? ? if (host->dataend)
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?break;
> ? ? ? ? ? ? ? } else if (!(status & MCI_RXDATAAVLBLMASK))
> ? ? ? ? ? ? ? ? ? ? ? break;
> ? ? ? ? ? ? ? udelay(10);
> ? ? ? }
>
> to minimize the changes and apparently address Russell's concern as well?

Yes that was exactly my suggestion in my first reply to Russell,
sorry if that wasn't clear. I called it bool sync_dma_job

The problem is that this HW bug is very likely present also in
unmodified ARM IP blocks, the only reason noone is seing it
is that they don't clock them very high and DMA is not really
working on them for other reasons anyway.

I.e. all versions of MMCI are likely as unreliable...

Yours,
Linus Walleij
