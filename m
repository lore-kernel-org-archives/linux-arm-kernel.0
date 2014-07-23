From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 23 Jul 2014 09:24:43 +0200
Subject: [PATCH v2 14/16] cpufreq: Add cpufreq driver for Tegra124
In-Reply-To: <CAKohponmg24pvnX2Jhfg5LHKKHx3VEm-6a_JXTGhVXY-aj3EOw@mail.gmail.com>
References: <1405957142-19416-1-git-send-email-ttynkkynen@nvidia.com>
 <1405957142-19416-15-git-send-email-ttynkkynen@nvidia.com>
 <CAKohpomQthJ_XE-HhzW07Q4aVtxQVy97iaL0Vy6Q4Lhw22A=VA@mail.gmail.com>
 <20140723065412.GA15759@ulmo.nvidia.com>
 <CAKohponmg24pvnX2Jhfg5LHKKHx3VEm-6a_JXTGhVXY-aj3EOw@mail.gmail.com>
Message-ID: <20140723072442.GC15759@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 23, 2014 at 12:28:21PM +0530, Viresh Kumar wrote:
> On 23 July 2014 12:24, Thierry Reding <thierry.reding@gmail.com> wrote:
> > On Wed, Jul 23, 2014 at 10:14:44AM +0530, Viresh Kumar wrote:
> >> On 21 July 2014 21:09, Tuomas Tynkkynen <ttynkkynen@nvidia.com> wrote:
> >>
> >> > diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> >> > index 7364a53..df3c73e 100644
> >> > --- a/drivers/cpufreq/Kconfig.arm
> >> > +++ b/drivers/cpufreq/Kconfig.arm
> >> > @@ -244,6 +244,7 @@ config ARM_SPEAR_CPUFREQ
> >> >  config ARM_TEGRA_CPUFREQ
> >> >         bool "TEGRA CPUFreq support"
> >> >         depends on ARCH_TEGRA
> >> > +       depends on GENERIC_CPUFREQ_CPU0
> >>
> >> Wouldn't this also disturb the existing cpufreq driver for earlier
> >> tegra platforms? i.e. we don't need cpufreq-cpu0 for them
> >> atleast as of now.
> >
> > Perhaps this should be "select" rather than "depends on"?
> 
> Don't know, its not optionaly for tegra124 and so a "depends on"
> might fit better ?

ARM_TEGRA_CPUFREQ is still optional, so the select only applies when the
Tegra cpufreq driver is enabled. This is mostly just out of convenience,
though. The Tegra cpufreq driver uses the generic CPU0 cpufreq driver so
a select will automatically pull in the necessary dependency. With a
"depends on" the Tegra cpufreq driver only becomes available after
you've selected GENERIC_CPUFREQ_CPU0, which is somewhat unintuitive.

To illustrate with an example: as a user, I want to enable CPU frequency
scaling on Tegra. So I use menuconfig to navigate to the "CPU Frequency
scaling" menu (enable it if not available yet) and look for an entry
that says "Tegra". But I can't find it because it's hidden due to the
lack of GENERIC_CPUFREQ_CPU0. That the Tegra CPU frequency driver uses a
generic driver is an implementation detail that users shouldn't have to
be aware of.

> >> > +static int tegra124_cpufreq_probe(struct platform_device *pdev)
> >> > +{
> >> > +       int ret;
> >> > +
> >> > +       cpu_dev = get_cpu_device(0);
> >> > +       if (!cpu_dev)
> >> > +               return -ENODEV;
> >> > +
> >>
> >> Shouldn't we do a of_node_get() here?
> >
> > I think this would need to be get_device() since it's the struct device
> > that's being used subsequently.
> 
> Probably I didn't write it well..
> 
> What I meant was after doing a get_cpu_device() we might also need
> to do  of_node_get(cpu_dev->of_node) as we would be using of_node
> in further code.

But we're using cpu_dev->of_node, so we need to make sure cpu_dev
doesn't go away suddenly. Simply keeping a reference to ->of_node
won't ensure that.

I guess technically it would be better if get_cpu_device() already
incremented the reference count on the returned struct device. Currently
it would theoretically still be possible for the device to disappear
between the call to get_cpu_device() and a call to get_device().

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140723/8de8a192/attachment.sig>
