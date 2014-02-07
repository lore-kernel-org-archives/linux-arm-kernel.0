From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 7 Feb 2014 18:24:40 +0100 (CET)
Subject: [linux-sunxi] Re: [PATCH] irq: Add new flag to ack level-triggered
 interrupts before unmasking
In-Reply-To: <CAOQ7t2b5qVTUXOB4iWAOoTehm=u6zxP0-zQmirSF0DvEk8KddQ@mail.gmail.com>
References: <1391721117-27446-1-git-send-email-carlo@caione.org>
 <alpine.DEB.2.02.1402062213590.21991@ionos.tec.linutronix.de>
 <CAOQ7t2Z0agZdDZ_OQZPtXWXoi5NMTcOOZz04q6wEVNy0rxn4AA@mail.gmail.com>
 <alpine.DEB.2.02.1402062229000.21991@ionos.tec.linutronix.de>
 <CAOQ7t2bzz9vKh_5h2nF=m+JpeYVa=Ttd4XQgrAa6Lhdzjg_Qxw@mail.gmail.com>
 <alpine.DEB.2.02.1402071121310.21991@ionos.tec.linutronix.de>
 <CAOQ7t2b5qVTUXOB4iWAOoTehm=u6zxP0-zQmirSF0DvEk8KddQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1402071721350.21991@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 7 Feb 2014, Carlo Caione wrote:
> Yeah, no really difference between threaded and non threaded.
> For the record, from a mail exchange with Allwinner's engineers: "the
> NMI module is a signal conversion module. It catches the NMI pin's
> state and generates irq to GIC", so GIC does not really ACK anything.
> BTW being a dummy "signal conversion module" this is probably why I
> still need to clear the pending status even though my IRQ line has
> already been cleared.

A pretty useless signal conversion module it seems creating a big mess
for a single interrupt line :)

> > I'm not against having a flag, but this should be done less convoluted
> > and have proper names which make the use case clear along with a good
> > technical explanation of the flag in the comment.
> 
> Ok, at this point do you think that a patch in the core could be
> useful or is it better to stick with modifying the unmask callback?

Not sure, really, but I tend to a core patch. Though we really want to
know whether the issue is threaded only or not. If it's a general
issue then this wants to go into unmask_irq() itself and not into an
extra unmask_threaded_irq() function.

Thanks,

	tglx
