From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 18 May 2015 10:46:30 +0100
Subject: [PATCH 11/12] ARM: migrate to common PSCI client code
In-Reply-To: <CAJ5Y-eYYUr6xUTGRvr_K-Cj0dPXhickk01o9oWQVJC0EXEHLNA@mail.gmail.com>
References: <1431085004-32743-1-git-send-email-mark.rutland@arm.com>
 <1431085004-32743-12-git-send-email-mark.rutland@arm.com>
 <CAJ5Y-eb4m1X3DDBujGV+OkZM-6JzNdK6YrwaFTXEG3z_POBJig@mail.gmail.com>
 <CAJ5Y-eYYUr6xUTGRvr_K-Cj0dPXhickk01o9oWQVJC0EXEHLNA@mail.gmail.com>
Message-ID: <20150518094630.GB3551@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >> +int psci_cpu_disable(unsigned int cpu)
> >> +{
> >> +       /* Fail early if we don't have CPU_OFF support */
> >> +       if (!psci_ops.cpu_off)
> >> +               return 0;
> >> +
> >> +       /* Trusted OS will deny CPU_OFF */
> >> +       if (psci_tos_resident_on(cpu))
> >> +               return 0;
> >> +
> >
> > Same question here. Seems like if MIGRATE_INFO_TYPE = 2 ( TOS is
> > present or does not require migration), you should be able to call
> > CPU_OFF. Otherwise the patch looks fine to me.
> 
> err. Make that TOS is not present.

In the cases where migration is not required, resident_cpu == -1, and
psci_tos_resident_on(cpu) will return false for any valid CPU. So I
don't see that we would deny migration here.

What am I missing?

Thanks,
Mark.
