From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 12 Jun 2014 10:03:39 +0100
Subject: [PATCH v4 3/6] drivers: cpuidle: implement OF based idle states
 infrastructure
In-Reply-To: <CAJZ5v0gE2Jq709SXLpfrxXnHxmqcDV1FbrPPX1JYUUdHJFL_Dg@mail.gmail.com>
References: <1402503520-8611-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1402503520-8611-4-git-send-email-lorenzo.pieralisi@arm.com>
 <CAJZ5v0gE2Jq709SXLpfrxXnHxmqcDV1FbrPPX1JYUUdHJFL_Dg@mail.gmail.com>
Message-ID: <20140612090339.GB29295@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[CC'ing Preeti and Paul to check their opinions]

Hi Rafael,

On Wed, Jun 11, 2014 at 07:25:49PM +0100, Rafael J. Wysocki wrote:
> On Wed, Jun 11, 2014 at 6:18 PM, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> > On most common ARM systems, the low-power states a CPU can be put into are
> > not discoverable in HW and require device tree bindings to describe
> > power down suspend operations and idle states parameters.
> >
> > In order to enable DT based idle states and configure idle drivers, this
> > patch implements the bulk infrastructure required to parse the device tree
> > idle states bindings and initialize the corresponding CPUidle driver states
> > data.
> >
> > Code that initializes idle states checks the CPU idle driver cpumask so
> > that multiple CPU idle drivers can be initialized through it in the
> > kernel. The CPU idle driver cpumask defines which idle states should be
> > considered valid for the driver, ie idle states that are valid on a set
> > of cpus the idle driver manages.
> >
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > ---
> >  drivers/cpuidle/Kconfig          |   9 ++
> >  drivers/cpuidle/Makefile         |   1 +
> >  drivers/cpuidle/of_idle_states.c | 282 +++++++++++++++++++++++++++++++++++++++
> >  drivers/cpuidle/of_idle_states.h |   8 ++
> >  4 files changed, 300 insertions(+)
> >  create mode 100644 drivers/cpuidle/of_idle_states.c
> >  create mode 100644 drivers/cpuidle/of_idle_states.h
> >
> > diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
> > index 1b96fb9..760ce20 100644
> > --- a/drivers/cpuidle/Kconfig
> > +++ b/drivers/cpuidle/Kconfig
> > @@ -30,6 +30,15 @@ config CPU_IDLE_GOV_MENU
> >         bool "Menu governor (for tickless system)"
> >         default y
> >
> > +config OF_IDLE_STATES
> 
> One question here.
> 
> Do you want this to be generally useful or is it just ARM-specific?

The first series was targeting ARM64, then I noticed that it might be
used for ARM too (Daniel is working on that). Actually, I discovered
that Power and MIPS can reuse at least the code that initializes the
states data too, but I have to point out three things:

1) state enter function method: in my bindings it is common for all
   idle states, need to check if it applies to Power and MIPS too.
2) CPUIDLE_FLAG_TIMER_STOP and how to set it. It is non-trivial to
   add code that detects what idle states lose the tick device context.
   At the moment I am adding the flag by default to all idle states
   apart from standbywfi on ARM, but that can be optimised. Unless we
   resort to power domains (but that's not trivial), we can add a flag
   to the idle states in DT (ie local-timer-stop or suchlike) to support
   that. I think that it will be frowned upon but it is worth trying, would
   like to know what other people think about this.
3) idle states bindings should be reviewed, I expect them to be valid
   on other architectures too, but I need acknowledgments.

I think this series is not far from being ready to be upstreamed, I
would be certainly happy if it can be reused for other archs too so
just let me know.

Thanks !
Lorenzo
