From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 18 Apr 2018 12:32:43 +0100
Subject: [PATCH v6 20/25] drivers: firmware: psci: Introduce
 psci_dt_topology_init()
In-Reply-To: <CAPDyKFrVNtv6Z3r5DkVXVooszyJTqaBxwg9wm94aw7v3SyA4tg@mail.gmail.com>
References: <1521046715-30683-1-git-send-email-ulf.hansson@linaro.org>
 <1521046715-30683-21-git-send-email-ulf.hansson@linaro.org>
 <20180314173833.dyu7jtweu233rfi4@lakrids.cambridge.arm.com>
 <CAPDyKFpJQZ87ViwZxX_yBnKPzgRv5YxbLz=qxScBTMCvY6e2vw@mail.gmail.com>
 <20180410111043.t577a43a3bvjpkc7@lakrids.cambridge.arm.com>
 <CAPDyKFrVNtv6Z3r5DkVXVooszyJTqaBxwg9wm94aw7v3SyA4tg@mail.gmail.com>
Message-ID: <20180418113242.fnpqp3j2ayhclwmj@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 10, 2018 at 02:25:52PM +0200, Ulf Hansson wrote:
> On 10 April 2018 at 13:10, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Tue, Apr 10, 2018 at 09:19:26AM +0200, Ulf Hansson wrote:
> >> On 14 March 2018 at 18:38, Mark Rutland <mark.rutland@arm.com> wrote:
> >> > On Wed, Mar 14, 2018 at 05:58:30PM +0100, Ulf Hansson wrote:
> >> >> In case the hierarchical layout is used in DT, we want to initialize the
> >> >> corresponding PM domain topology for the CPUs, by using the generic PM
> >> >> domain (aka genpd) infrastructure.
> >> >>
> >> >> At first glance, it may seem feasible to hook into the existing
> >> >> psci_dt_init() function, although because it's called quite early in the
> >> >> boot sequence, allocating the dynamic data structure for a genpd doesn't
> >> >> work.
> >> >>
> >> >> Therefore, let's export a new init function for PSCI,
> >> >> psci_dt_topology_init(), which the ARM machine code should call from a
> >> >> suitable initcall.
> >> >>
> >> >> Succeeding to initialize the PM domain topology, which means at least one
> >> >> instance of a genpd becomes created, allows us to continue to enable the
> >> >> PSCI OS initiated mode for the platform. If everything turns out fine,
> >> >> let's print a message in log to inform the user about the changed mode.
> >> >>
> >> >> In case of any failures, we stick to the default PSCI Platform Coordinated
> >> >> mode.
> >> >
> >> > For kexec/kdump we'll need to explicitly set the suspend mode to
> >> > platform coordinated if for whatever reason we choose not to use OSI.
> >>
> >> Could you please elaborate on this? I am not really understanding what
> >> you are suggesting me to do and why.
> >
> > Sorry for not being clear.
> >
> > What I'd like to see is that we always call SET_SUSPEND_MODE before
> > invoking CPU_SUSPEND. Either deciding early if we can use OSI, or always
> > setting it to platform co-ordinated early on in boot and later switching
> > it over.
> >
> > That way we can be sure of the suspend mode, even if we've kexec'd from
> > a kernel that had fiddled with it.
> 
> Right, good point. Let's me update the patch to deal with that.
> 
> One thing though, kexec from a "new" kernel having OSI mode enabled
> into an "old" kernel that doesn't even have the new OSI mode support
> in psci driver, is going to be difficult to deal with.
> On the other hand I guess that isn't a very important usecase we need
> to cover, or is it?

I think we can also transition back to platform-coordinated in a reboot
notifier, which should cater for kexec to an old kernel. I agree it
shouldn't be a big deal, though.

Thanks,
Mark.
