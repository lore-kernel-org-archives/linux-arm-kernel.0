From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Thu, 2 May 2013 09:19:32 +0100
Subject: [Xen-devel] [PATCH 1/3] arm_arch_timer: introduce
 arch_timer_stolen_ticks
In-Reply-To: <51817CBE.4050003@codeaurora.org>
References: <alpine.DEB.2.02.1305011939180.5398@kaball.uk.xensource.com>
 <1367436460-10183-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <51817CBE.4050003@codeaurora.org>
Message-ID: <1367482772.21869.26.camel@zakaz.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-05-01 at 21:36 +0100, Christopher Covington wrote:
> Hi Stefano,
> 
> On 05/01/2013 03:27 PM, Stefano Stabellini wrote:
> > Introduce a function, called arch_timer_stolen_ticks, called from the
> > arch_timer interrupt handler to account for stolen ticks.
> 
> [...]
> 
> > diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
> > index 7ade91d..30db413 100644
> > --- a/arch/arm/include/asm/arch_timer.h
> > +++ b/arch/arm/include/asm/arch_timer.h
> > @@ -13,6 +13,11 @@
> >  int arch_timer_of_register(void);
> >  int arch_timer_sched_clock_init(void);
> >  
> > +/* per-platform function to calculate stolen ticks (clock cycles stolen
> > + * to the vcpu by the hypervisor).
> 
> Stolen from the vcpu by the hypervisor?

Stolen is time where the VCPU wants to be running bit isn't because the
hypervisor has descheduled it, e.g. because another VCPU is being run.
So yes, Stefano meant "from".

> Is the hypervisor adjusting the Virtual Offset Register?

The virtual offset register is useful when a VCPU is migrated to another
system to account for the differences in physical time on the two hosts
but isn't useful for accounting for stolen time while running on a
single host.

e.g. if a VCPU sets a timer for NOW+5, but 3 are stolen in the middle it
would not make sense (from the guests PoV) for NOW'==NOW+2 at the point
where the timer goes off. Nor does it make sense to require that the
guest actually be running for 5 before injecting the timer because that
would mean real time elapsed time for the timer would be 5+3 in the case
where 3 are stolen.

So the virtual timer should appear to have been running even while time
is being stolen and therefore stolen time needs to be accounted via some
other means.

Ian.
