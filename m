From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 8 Aug 2014 11:59:57 -0400 (EDT)
Subject: [PATCH v17 2/9] ARM: hisi: enable MCPM implementation
In-Reply-To: <CAD6h2NStM9Od9Ds0J7GEqQ93Djh5g6hdo9Hmqk2dkDFaRBp2RA@mail.gmail.com>
References: <1407408695-19626-1-git-send-email-haojian.zhuang@linaro.org>
 <1407408695-19626-3-git-send-email-haojian.zhuang@linaro.org>
 <alpine.LFD.2.11.1408071047370.6061@knanqh.ubzr>
 <CAD6h2NStM9Od9Ds0J7GEqQ93Djh5g6hdo9Hmqk2dkDFaRBp2RA@mail.gmail.com>
Message-ID: <alpine.LFD.2.11.1408081154560.6061@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 8 Aug 2014, Haojian Zhuang wrote:

> On 7 August 2014 23:29, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > On Thu, 7 Aug 2014, Haojian Zhuang wrote:
> >
> >> +     spin_unlock(&boot_lock);
> >> +
> >> +     if (hip04_cluster_is_down(cluster))
> >> +             v7_exit_coherency_flush(all);
> >> +     else
> >> +             v7_exit_coherency_flush(louis);
> >
> > This is not sufficient.  To be safe, the MCPM cluster state must be
> > controlled as well.  And once the cache is flushed, the snoops must be
> > disabled as well.  And this should be controlled with the boot_lock
> > still held.  In other words here's what it should look like:
> >
> >         if (hip04_cluster_is_down(cluster) &&
> >             __mcpm_outbound_enter_critical(cpu, cluster)) {
> >                 spin_unlock(&boot_lock);
> >                 v7_exit_coherency_flush(all);
> >                 hip04_set_snoop_filter(cluster, 0);
> >         } else {
> >                 spin_unlock(&boot_lock);
> >                 v7_exit_coherency_flush(louis);
> >         }
> >
> 
> I can make cpu online/offline successfully in these two cases.
> 1. Add msleep() in the end of power_up and move disabling snoop filter at here.
> 2. Disable snoop filter in wait_for_power_down after target core in WFI status.
> 
> Since case #1 isn't good, I choose the #2.
> 
> I also got some hisilicon documents. They said that setting target
> core to WFI status is required before disabling snoop filter.

OK good.  In that case please add a comment explaining what the 
documentation says.  Still the lock has to be handled as shown above.


Nicolas
