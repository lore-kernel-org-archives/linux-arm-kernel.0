From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 26 May 2015 13:59:39 +0100
Subject: [PATCH 11/12] ARM: migrate to common PSCI client code
In-Reply-To: <CAJ5Y-eZd7e6mN3ryL5OCYmwY24yhFHyJp5dVBvxK5O=88JWX_w@mail.gmail.com>
References: <1431085004-32743-1-git-send-email-mark.rutland@arm.com>
 <1431085004-32743-12-git-send-email-mark.rutland@arm.com>
 <CAJ5Y-eb4m1X3DDBujGV+OkZM-6JzNdK6YrwaFTXEG3z_POBJig@mail.gmail.com>
 <CAJ5Y-eYYUr6xUTGRvr_K-Cj0dPXhickk01o9oWQVJC0EXEHLNA@mail.gmail.com>
 <20150518094630.GB3551@leverpostej>
 <CAJ5Y-eZd7e6mN3ryL5OCYmwY24yhFHyJp5dVBvxK5O=88JWX_w@mail.gmail.com>
Message-ID: <20150526125939.GB6962@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 18, 2015 at 08:14:51PM +0100, Ashwin Chaugule wrote:
> On 18 May 2015 at 05:46, Mark Rutland <mark.rutland@arm.com> wrote:
> >> >> +int psci_cpu_disable(unsigned int cpu)
> >> >> +{
> >> >> +       /* Fail early if we don't have CPU_OFF support */
> >> >> +       if (!psci_ops.cpu_off)
> >> >> +               return 0;
> >> >> +
> >> >> +       /* Trusted OS will deny CPU_OFF */
> >> >> +       if (psci_tos_resident_on(cpu))
> >> >> +               return 0;
> >> >> +
> >> >
> >> > Same question here. Seems like if MIGRATE_INFO_TYPE = 2 ( TOS is
> >> > present or does not require migration), you should be able to call
> >> > CPU_OFF. Otherwise the patch looks fine to me.
> >>
> >> err. Make that TOS is not present.
> >
> > In the cases where migration is not required, resident_cpu == -1, and
> > psci_tos_resident_on(cpu) will return false for any valid CPU. So I
> > don't see that we would deny migration here.
> >
> 
> Hm. Perhaps I was confused by the "return -EPERM" in the arm64 version
> and "return 0" here. :)

Looking at this again, you're absolutely right, and I'd gotten myself
confused about the expected return values. I'll respin this with
corrected return codes (-EPERM instead of 0 and 0 instead of 1).

Thanks for spotting that, and sorry for being so dense!

Mark.
