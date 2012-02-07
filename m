From: yong.zhang0@gmail.com (Yong Zhang)
Date: Tue, 7 Feb 2012 20:34:55 +0800
Subject: [BUG] genirq: Race condition in ONESHOT IRQ handler disabling
 IRQ forever
In-Reply-To: <20272.63074.235023.783459@ipc1.ka-ro>
References: <20271.35831.227679.177366@ipc1.ka-ro> <20120207090305.GB32736@zhy>
 <20272.63074.235023.783459@ipc1.ka-ro>
Message-ID: <20120207123455.GA2452@zhy>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 07, 2012 at 11:01:06AM +0100, Lothar Wa?mann wrote:
> Hi,
> 
> > On Mon, Feb 06, 2012 at 09:14:47AM +0100, Lothar Wa?mann wrote:
> > > Hi,
> > > 
> > > I already sent this to <linux-kernel@vger.kernel.org> on Feb. 1, 2012
> > > but did not get any response there. So resending to a wider audience
> > > with improved subject line:
> > > 
> > > there is a race condition in the threaded IRQ handler code for oneshot
> > > interrupts that may lead to disabling an IRQ indefinitely. IRQs are
> > > masked before calling the hard-irq handler and are unmasked only after
> > > the soft-irq handler has been run. Thus if the hard-irq handler
> > > returns IRQ_HANDLED instead of IRQ_WAKE_THREAD, meaning the soft-irq
> > > will not be called, the interrupt will remain masked forever.
> > > 
> > > This can happen due to a short pulse on the interrupt line, that
> > > triggers the interrupt logic, but goes undetected by the hard-irq
> > > handler. The problem can be reproduced with the TSC2007 touch
> > > controller driver that uses ONESHOT interrupts.
> > 
> > Isn't it the responsibility of the driver (say TSC2007)?
> > 
> > In this case, TSC2007 should return IRQ_WAKE_THREAD IMHO.
> > 
> That would mean it had to return IRQ_WAKE_THREAD unconditionally
> making the return code useless.
> And it would cause an extra useless loop through the softirq
> handler.

Yeah, it's the default behavior when we introduce 'theadirqs',
and it's safe.

You know in your patch unmask_irq() is called locklessly and
it will introduce other race.

Thanks,
Yong
