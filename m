From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 14 Apr 2015 22:51:40 +0200
Subject: [RFC PATCH 5/5] arm64: qcom: add cpu operations
In-Reply-To: <20150414162953.GL28709@leverpostej>
References: <1428601031-5366-1-git-send-email-galak@codeaurora.org>
 <1428601031-5366-6-git-send-email-galak@codeaurora.org>
 <20150414162953.GL28709@leverpostej>
Message-ID: <2167031.4Enm47D6vo@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 14 April 2015 17:29:53 Mark Rutland wrote:
> 
> > +static int msm_cpu_boot(unsigned int cpu)
> > +{
> > +       int ret = 0;
> > +
> > +       if (per_cpu(cold_boot_done, cpu) == false) {
> > +               ret = msm_unclamp_secondary_arm_cpu(cpu);
> > +               if (ret)
> > +                       return ret;
> > +               per_cpu(cold_boot_done, cpu) = true;
> > +       }
> > +       return secondary_pen_release(cpu);
> > +}
> 
> Ah, so cold_boot_done is for pseudo-hotplug. Absolute NAK to that.
> 
> The only thing this gives you over spin-table is one-time powering up of
> the CPUs that can be performed prior to entry to Linux. If you do that,
> you can trivially share the spin-table code by setting each CPU's
> enable-method to "spin-table".
> 
> That won't give you cpuidle or actual hotplug. For those you'll need
> PSCI.

Maybe a way out for the broken firmware is to have a custom boot wrapper
that gets distributed separately and that uses the normal spin-table
API. We've done similar things on arch/arm/mach-sunxi for boot loaders
that are just too different from what we expect.

Once someone implements a proper loader, they could skip that extra
wrapper.

	Arnd
