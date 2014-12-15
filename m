From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Mon, 15 Dec 2014 23:48:14 +0100
Subject: [PATCH 0/5] ARM: at91: fix irq_pm_install_action WARNING
In-Reply-To: <2662748.NJbkr6jW7r@vostro.rjw.lan>
References: <1418660152-17185-1-git-send-email-boris.brezillon@free-electrons.com>
 <2662748.NJbkr6jW7r@vostro.rjw.lan>
Message-ID: <3542278.8lcJeXLMFm@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, December 15, 2014 11:20:17 PM Rafael J. Wysocki wrote:
> On Monday, December 15, 2014 05:15:47 PM Boris Brezillon wrote:
> > Commit cab303be91dc47942bc25de33dc1140123540800 [1] introduced a WARN_ON
> > test which triggers a WARNING backtrace on at91 platforms.
> 
> Pretty much as intended.
> 
> > While this WARN_ON is absolutely necessary to warn users that they should
> > not mix request with and without IRQF_NO_SUSPEND flags on shared IRQs,
> > there is no easy way to solve this issue on at91 platforms.
> > 
> > The main reason is that the init timer is often using a shared irq line
> > and thus request this irq with IRQF_NO_SUSPEND flag set, while other
> > peripherals request the same irq line without this flag.
> > 
> > We could deal with that by identifying whether a given peripheral is
> > connected to the init timer shared irq line and add the IRQF_NO_SUSPEND
> > in this case, but this implies adding the logic in all peripheral drivers
> > that could be connected to this shared irq.
> > 
> > This series takes the reverse approach: force IRQ users to specify that
> > they take care of disabling peripheral interrupts and that IRQ core can
> > safely leave the handler in a suspended state without having to bother
> > about spurious interrupts.
> > This is done by mean of a new IRQF_SUSPEND_NOACTION flag which tells the
> > core to move the action handler to a suspended list, thus preventing its
> > execution when we are in suspend mode.
> > Of course, specifying the IRQF_SUSPEND_NOACTION flag implies taking care
> > of masking/unmasking the peripheral interrupts in the suspend/resume
> > implementation.
> 
> Well, I'm not sure how much value is in all that to be honest.  The only
> thing it helps with is to make the WARN_ON go away in some cases, while
> the drivers in question need to make sure that they disable their interrupts
> properly anyway, so what exactly is the purpose of the new irqaction
> shuffling?
> 
> It might just be simpler to add a flag to suppress the WARN_ON that would be
> set by the user of IRQF_NO_SUSPEND that is broken enough to have to share the
> interrupt with others ...

Or even set IRFQ_NO_SUSPEND for all of the users of this interrupt and add
comments to them explaining why it is set.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
