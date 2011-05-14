From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Sun, 15 May 2011 00:18:25 +0400
Subject: [PATCH] pxa/hx4700: Fix basic suspend/resume
In-Reply-To: <20399.31072.qm@web29013.mail.ird.yahoo.com>
References: <20110513103255.GB18716@rainbow>
	<20399.31072.qm@web29013.mail.ird.yahoo.com>
Message-ID: <20110514201824.GA16305@rainbow>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20:18 Fri 13 May     , Paul Parsons wrote:
> Hi Dmitry,
> 
> That patch found its way into 2.6.39-rc7 and earlier so I'm already using it.
> Thanks anyway.
Erm, do you have some special 2.6.39-rc7? :) I can't see in mine
any .suspend/.resume callbacks defined in asic3.c for tmio_mmc cell.
Or have you meant some other changes? BTW, I quickly looked at
tmio_mmc.c and it seems very suspicious that it calls cell->disable(dev)
on suspend, but cell->resume(dev) on resume. As I said earlier,
.resume isn't defined in asic3.c for tmio_mmc cell - so probably that's
the culprit.

> As for the tmio_mmc driver, it more or less works for me in 2.6.39-rc7,
> though it does produce a lot of "tmio_mmc: Spurious irq" messages. My SD
> card is detected OK and reading / writing it works fine. I'll try to look
> into both the spurious IRQ problem and the suspend / resume bug(s).

Ah, so mmc works for you in 2.6.39-rc7?  Nice to hear! Wonder why it
doesn't work for me. I suspect this may be connected to the fact that
I boot from WinCE using HaRET - probably Windows leaves controller in
some inconsistent state and driver doesn't reset hardware properly.

As for "Spurious irq, disabling!" messages, I'm seeing them for a long
time - since pr_debug was turned into pr_warning in commit 311f3ac768
("mmc: add DMA support to tmio_mmc driver, when used on SuperH")
So I suspect this issue (if it's issue at all) has always been there, just
unseen before that commit. Not sure what causes those spurious interrupts -
maybe it's some specific of TMIO hardware in ASIC3?

-- 
Best regards,
Dmitry "MAD" Artamonow
