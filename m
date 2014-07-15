From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 15 Jul 2014 07:44:48 -0400 (EDT)
Subject: [PATCH v11 04/12] ARM: hisi: enable MCPM implementation
In-Reply-To: <CAD6h2NT-dC_yqkx3iy3BXp7SPy_+nC+mkGk2DGRs9RF5bKZQAw@mail.gmail.com>
References: <1405330453-15104-1-git-send-email-haojian.zhuang@linaro.org>
 <alpine.LFD.2.11.1407140553300.3647@knanqh.ubzr>
 <CAD6h2NT-dC_yqkx3iy3BXp7SPy_+nC+mkGk2DGRs9RF5bKZQAw@mail.gmail.com>
Message-ID: <alpine.LFD.2.11.1407150712110.3647@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 15 Jul 2014, Haojian Zhuang wrote:

> On 14 July 2014 18:12, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > On Mon, 14 Jul 2014, Haojian Zhuang wrote:
> >
> >> +static bool hip04_init_cluster0_snoop(void)
> >> +{
> >> +     unsigned long data;
> >> +
> >> +     if (!fabric) {
> >> +             pr_err("failed to find fabric base\n");
> >> +             return false;
> >> +     }
> >> +     data = readl_relaxed(fabric + FAB_SF_MODE);
> >> +     data |= 1;
> >> +     writel_relaxed(data, fabric + FAB_SF_MODE);
> >> +     while (1) {
> >> +             if (data == readl_relaxed(fabric + FAB_SF_MODE))
> >> +                     break;
> >> +     }
> >> +     return true;
> >> +}
> >
> > In fact you probably should make this into something like:
> >
> > static bool hip04_set_cluster_snoop(int cluster, bool active)
> >
> > Eventually you'll want to turn snoops off when a cluster is completely
> > idle.  And this can be used to init snoops on cluster 0 during boot as
> > well.
> >
> I don't plan to implement power down by resetting cores since the
> operation of disabling cluster snoop is not good. It'll make core
> hang.
> 
> Now I plan to use wfi instead. Only the first time, we need to make cores
> out of reset. For the next times, we only need to use IPI to wakeup
> secondary cores instead.

Well...

If the following conditions are true:

1) snoops can be turned on even for a CPU that is not running, and

2) you do not plan to ever disable snoops after boot, and

3) you do not plan to actually power off CPUs when hotplugged out, and
   only use WFI when they are idle

... then MCPM is providing you absolutely no gain at all.  You might as 
well create your own smp_operations structure directly and skip all the 
extra MCPM complexity you are not benefiting from.

The fundamental reason why MCPM exists is to safely manage cluster wide 
resources in the presence of concurrent powering up and down of CPUs 
when standard race avoidance mechanisms can't be used.  You apparently 
don't have such resources to manage. That certainly will make for 
suboptimal power consumption but there is so far nothing more sensible 
that can be done unless more documentation for this hardware is made 
available.


Nicolas
