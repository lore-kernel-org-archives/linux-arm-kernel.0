From: will.deacon@arm.com (Will Deacon)
Date: Tue, 29 May 2018 21:16:24 +0100
Subject: [PATCH v9 00/12] Support PPTT for ARM64
In-Reply-To: <CAMuHMdU0yET6+-FfS8e9HJdKB7h0gDn7kzWGpJZV=UiWn5fLkA@mail.gmail.com>
References: <20180511235807.30834-1-jeremy.linton@arm.com>
 <20180517170523.h7tuvbzdfluuidcz@armageddon.cambridge.arm.com>
 <CAMuHMdWJWj3a0MZgEi7VJTUJRNoeR+X3eoN8A-sW6fwimEr6Fg@mail.gmail.com>
 <09fb3fe7-d703-43f1-74f7-f8cb5ff1f67a@arm.com>
 <CAMuHMdXgiMeD4uF+j8W+CpNwYYK2W_8xqk_=vGBiW=bUvKeq7w@mail.gmail.com>
 <551905a6-eaa8-97df-06ec-1ceedfbc164f@arm.com>
 <20180529150823.GD17159@arm.com>
 <CAMuHMdU0yET6+-FfS8e9HJdKB7h0gDn7kzWGpJZV=UiWn5fLkA@mail.gmail.com>
Message-ID: <20180529201623.GA591@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

On Tue, May 29, 2018 at 05:51:29PM +0200, Geert Uytterhoeven wrote:
> On Tue, May 29, 2018 at 5:08 PM, Will Deacon <will.deacon@arm.com> wrote:
> > On Tue, May 29, 2018 at 02:18:40PM +0100, Sudeep Holla wrote:
> >> On 29/05/18 12:56, Geert Uytterhoeven wrote:
> >> > On Tue, May 29, 2018 at 1:14 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >> >> On 29/05/18 11:48, Geert Uytterhoeven wrote:
> >> >>> System supend still works fine on systems with big cores only:
> >> >>>
> >> >>>     R-Car H3 ES1.0 (4xCA57 (4xCA53 disabled in firmware))
> >> >>>     R-Car M3-N (2xCA57)
> >> >>>
> >> >>> Reverting this commit fixes the issue for me.
> >> >>
> >> >> I can't find anything that relates to system suspend in these patches
> >> >> unless they are messing with something during CPU hot plug-in back
> >> >> during resume.
> >> >
> >> > It's only the last patch that introduces the breakage.
> >> >
> >>
> >> As specified in the commit log, it won't change any behavior for DT
> >> systems if it's non-NUMA or single node system. So I am still wondering
> >> what could trigger this regression.
> >
> > I wonder if we're somehow giving an uninitialised/invalid NUMA configuration
> > to the scheduler, although I can't see how this would happen.
> >
> > Geert -- if you enable CONFIG_DEBUG_PER_CPU_MAPS=y and apply the diff below
> > do you see anything shouting in dmesg?
> 
> Thanks, but unfortunately it doesn't help.
> I added some debug code to print cpumask, but so far I don't see anything
> suspicious.

Damn, sorry for wasting your time. For the record, Catalin's been seeing
boot failures under KVM on a non-big/LITTLE machine that bisect reliably
to this patch, but we've also not been able to explain them. Worse, adding
so much as a printk makes the problem disappear.

Will
