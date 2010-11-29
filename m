From: olof@lixom.net (Olof Johansson)
Date: Mon, 29 Nov 2010 11:47:05 -0600
Subject: [PATCH v2] Add call to non-crashing cores through IPI
In-Reply-To: <AANLkTinF0Ndb9-3z1ZeMBjPRH5jXWNA+BL6QpS+--0A4@mail.gmail.com>
References: <1290587308-22038-1-git-send-email-per.xx.fransson@stericsson.com>
	<20101126040612.GA6598@lixom.net>
	<AANLkTinF0Ndb9-3z1ZeMBjPRH5jXWNA+BL6QpS+--0A4@mail.gmail.com>
Message-ID: <20101129174705.GA25168@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 29, 2010 at 01:46:26PM +0100, Per Fransson wrote:
> >> ?void machine_crash_shutdown(struct pt_regs *regs)
> >> ?{
> >> + ? ? unsigned long msecs;
> >
> > Int should be enough here? Not that it makes a difference on ARM, but
> > anyway. :)
> >
> >> +
> >> ? ? ? local_irq_disable();
> >> +
> >> + ? ? atomic_set(&waiting_for_crash_ipi, num_online_cpus() - 1);
> >> + ? ? smp_call_function(machine_crash_nonpanic_core, NULL, false);
> >> + ? ? msecs = 1000; /* Wait at most a second for the other cpus to stop */
> >> + ? ? while ((atomic_read(&waiting_for_crash_ipi) > 0) && msecs) {
> >> + ? ? ? ? ? ? mdelay(1);
> >> + ? ? ? ? ? ? msecs--;
> >> + ? ? }
> 
> The choice of type comes from the corresponding x86 code in
> 
>     arch/x86/kernel/reboot.c:nmi_shootdown_cpus()
> 
> Should we deviate?

We've already spent more time discussing this than it's worth. :-)
Leave it if you prefer.


-Olof
