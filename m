From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 22 Nov 2010 10:47:40 +0000
Subject: [PATCH] Add call to non-crashing cores through IPI
In-Reply-To: <AANLkTikJiXFG_kGV4=wTKOzViy-h9VtGRHKVBuh76fE2@mail.gmail.com>
References: <1290161310-22808-1-git-send-email-per.xx.fransson@stericsson.com>
	<20101122072420.GC14080@gw.healthdatacare.com>
	<AANLkTikJiXFG_kGV4=wTKOzViy-h9VtGRHKVBuh76fE2@mail.gmail.com>
Message-ID: <20101122104740.GA30744@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 22, 2010 at 10:53:00AM +0100, Per Fransson wrote:
> >
> > I wonder whether it is good idea to enable interrupts here? What
> > if we came here from an interrupt handler with interrupts already
> > disabled?
> >
> > I guess you did this because smp_call_function() needs to have
> > interrupts enabled, right?
> >
> 
> Yup, that's why I did it.
> 
> > As we still need to make sure that all the secondary CPUs are
> > stopped, should we do just something like:
> >
> > ? ? ? ?smp_send_stop();
> >
> > and then in ipi_cpu_stop() we check whether oops_in_progress is set
> > and save the cpu state before entering that never-ending loop?
> 
> But we still need to wait for it to complete, right? Will smp_send_stop()
> handle the requirements of the underlying ipi regardless of the initial state?

In a crashing state, any kind of IPIs are not guaranteed.  The other
CPUs may be in an IRQ-protected region waiting for a lock which the
crashing CPU already holds, and so the IPI won't be received.

However, we do need smp_send_stop() to wait for a limited time for the
other CPUs to respond to the request.  We should also do something more
intelligent than spinning in a while(1) loop.
