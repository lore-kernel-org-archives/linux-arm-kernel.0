From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Mon, 7 Jan 2013 19:21:46 +0000
Subject: [PATCH v4 21/24] arm/v2m: initialize arch_timers even if v2m_timer
 is not present
In-Reply-To: <50EB06A4.7030908@arm.com>
References: <alpine.DEB.2.02.1209141145150.29232@kaball.uk.xensource.com>
 <1347621207-11294-21-git-send-email-stefano.stabellini@eu.citrix.com>
 <1347625628.2497.65.camel@hornet>
 <alpine.DEB.2.02.1209141347250.29232@kaball.uk.xensource.com>
 <alpine.DEB.2.02.1301071719180.4981@kaball.uk.xensource.com>
 <50EB06A4.7030908@arm.com>
Message-ID: <alpine.DEB.2.02.1301071921140.4981@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 7 Jan 2013, Marc Zyngier wrote:
> On 07/01/13 17:21, Stefano Stabellini wrote:
> > On Fri, 14 Sep 2012, Stefano Stabellini wrote:
> >> On Fri, 14 Sep 2012, Pawel Moll wrote:
> >>> On Fri, 2012-09-14 at 12:13 +0100, Stefano Stabellini wrote:
> >>>> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> >>>> CC: Russell King <linux@arm.linux.org.uk>
> >>>> CC: Pawel Moll <pawel.moll@arm.com>
> >>>> CC: Marc Zyngier <marc.zyngier@arm.com>
> >>>> ---
> >>>>  arch/arm/mach-vexpress/v2m.c |   11 ++++++-----
> >>>>  1 files changed, 6 insertions(+), 5 deletions(-)
> >>>>
> >>>> diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
> >>>> index 37608f2..4e567f7 100644
> >>>> --- a/arch/arm/mach-vexpress/v2m.c
> >>>> +++ b/arch/arm/mach-vexpress/v2m.c
> >>>> @@ -621,16 +621,17 @@ static void __init v2m_dt_timer_init(void)
> >>>>  
> >>>>  	v2m_clk_init();
> >>>>  
> >>>> -	err = of_property_read_string(of_aliases, "arm,v2m_timer", &path);
> >>>> -	if (WARN_ON(err))
> >>>> -		return;
> >>>> -	node = of_find_node_by_path(path);
> >>>> -	v2m_sp804_init(of_iomap(node, 0), irq_of_parse_and_map(node, 0));
> >>>>  	if (arch_timer_of_register() != 0)
> >>>>  		twd_local_timer_of_register();
> >>>>  
> >>>>  	if (arch_timer_sched_clock_init() != 0)
> >>>>  		versatile_sched_clock_init(v2m_sysreg_base + V2M_SYS_24MHZ, 24000000);
> >>>> +
> >>>> +	err = of_property_read_string(of_aliases, "arm,v2m_timer", &path);
> >>>> +	if (WARN_ON(err))
> >>>> +		return;
> >>>> +	node = of_find_node_by_path(path);
> >>>> +	v2m_sp804_init(of_iomap(node, 0), irq_of_parse_and_map(node, 0));
> >>>>  }
> >>>>  
> >>>>  static struct sys_timer v2m_dt_timer = {
> >>>
> >>> Fair point. The alias is going to disappear anyway (I'm working on a VE
> >>> platform rework right now), but in case I won't get it on time for 3.7,
> >>> I'll make sure this one is merged instead.
> >>
> >> Great, thanks!
> >> Should I leave this patch out of the Xen on ARM series for 3.7 then?
> >>
> > 
> > I have just noticed that this patch hasn't been merged yet, but still we
> > need it to boot Linux on Xen.
> > Do you want me to rebase and resent?
> 
> I'm looking at v3.8-rc2, and the code have changed significantly (see
> 433683a66401adb0150792e725cc4f631c94de46).
> 
> If you don't have an "arm,sp804" device in your DT, it shouldn't get
> registered and carry on registering the per-cpu timers. Can you check
> that it fixes your issue?

Yes, sorry, my Linux tree wasn't up to date enough, thanks!
