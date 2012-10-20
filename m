From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sat, 20 Oct 2012 04:42:12 -0000
Subject: [PATCH 1/2] cpufreq: return early from __cpufreq_driver_getavg()
In-Reply-To: <2737823.2JYE7UmLRN@vostro.rjw.lan>
References: <32e5bed743cc6cc4e614291a7080299f5f0d0933.1350677395.git.viresh.kumar@linaro.org>
 <2737823.2JYE7UmLRN@vostro.rjw.lan>
Message-ID: <CAKohponGwhC_zmk1Whq56vmZMvjcxXKiSpdvMk4ZU8z0Wa2TBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Oct 20, 2012 3:37 AM, "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>
> On Saturday 20 of October 2012 01:42:05 Viresh Kumar wrote:
> > There is no need to do cpufreq_get_cpu() and cpufreq_put_cpu() for
drivers that
> > don't support getavg() routine.
> >
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> The patch doesn't seem to follow the changelog or the other way around.

Sorry if my log isn't clear enough.
But i could still see it matching the code :)

I have moved the check for drivers capabilities at the top
of routine, so that there is no need to call mentioned routines.

>
> Thanks,
> Rafael
>
>
> > ---
> >  drivers/cpufreq/cpufreq.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 85df538..f552d5f 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -1511,12 +1511,14 @@ int __cpufreq_driver_getavg(struct
cpufreq_policy *policy, unsigned int cpu)
> >  {
> >       int ret = 0;
> >
> > +     if (!(cpu_online(cpu) && cpufreq_driver->getavg))
> > +             return 0;
> > +
> >       policy = cpufreq_cpu_get(policy->cpu);
> >       if (!policy)
> >               return -EINVAL;
> >
> > -     if (cpu_online(cpu) && cpufreq_driver->getavg)
> > -             ret = cpufreq_driver->getavg(policy, cpu);
> > +     ret = cpufreq_driver->getavg(policy, cpu);
> >
> >       cpufreq_cpu_put(policy);
> >       return ret;
> >
> --
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121020/6db37aed/attachment-0001.html>
