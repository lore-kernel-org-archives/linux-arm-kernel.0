From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Tue, 7 Feb 2012 11:01:06 +0100
Subject: [BUG] genirq: Race condition in ONESHOT IRQ handler disabling
 IRQ forever
In-Reply-To: <20120207090305.GB32736@zhy>
References: <20271.35831.227679.177366@ipc1.ka-ro> <20120207090305.GB32736@zhy>
Message-ID: <20272.63074.235023.783459@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> On Mon, Feb 06, 2012 at 09:14:47AM +0100, Lothar Wa?mann wrote:
> > Hi,
> > 
> > I already sent this to <linux-kernel@vger.kernel.org> on Feb. 1, 2012
> > but did not get any response there. So resending to a wider audience
> > with improved subject line:
> > 
> > there is a race condition in the threaded IRQ handler code for oneshot
> > interrupts that may lead to disabling an IRQ indefinitely. IRQs are
> > masked before calling the hard-irq handler and are unmasked only after
> > the soft-irq handler has been run. Thus if the hard-irq handler
> > returns IRQ_HANDLED instead of IRQ_WAKE_THREAD, meaning the soft-irq
> > will not be called, the interrupt will remain masked forever.
> > 
> > This can happen due to a short pulse on the interrupt line, that
> > triggers the interrupt logic, but goes undetected by the hard-irq
> > handler. The problem can be reproduced with the TSC2007 touch
> > controller driver that uses ONESHOT interrupts.
> 
> Isn't it the responsibility of the driver (say TSC2007)?
> 
> In this case, TSC2007 should return IRQ_WAKE_THREAD IMHO.
> 
That would mean it had to return IRQ_WAKE_THREAD unconditionally
making the return code useless.
And it would cause an extra useless loop through the softirq
handler.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
