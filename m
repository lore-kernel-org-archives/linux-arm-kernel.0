From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Sat, 3 Nov 2012 13:48:08 +0000
Subject: [PATCH 11/15] ARM: OMAP: timer: Interchange clksrc and clkevt
 for AM33XX
In-Reply-To: <5095165E.10403@deeprootsystems.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
 <1351859566-24818-12-git-send-email-vaibhav.bedia@ti.com>
 <5095037A.2020503@deeprootsystems.com>
 <B5906170F1614E41A8A28DE3B8D121433EBFEA0E@DBDE01.ent.ti.com>
 <5095165E.10403@deeprootsystems.com>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EBFEB57@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 03, 2012 at 18:34:30, Kevin Hilman wrote:
[...]
> >>
> >> Doesn't this also mean that you won't get timer wakeups
> >> in idle?  Or are you keeping the domain where the clockevent is
> >> on during idle?
> >>
> >
> > The lowest idle state that we are targeting will have MPU powered
> > off with external memory in self-refresh mode. Peripheral domain
> > with the clockevent will be kept on.
> 
> Is this a limitation of the hardware?  or the software?
> 

Well, making the lowest idle state same as the suspend state will require
us to involve WKUP_M3 in the idle path and wakeup sources get limited to
the IPs in the WKUP domain alone. There's no IO daisy chaining in AM33XX
so that's one big difference compared to OMAP. 

The other potential problem is that the IPC mechanism that we have
uses interrupts. Assuming that the lowest idle state, say Cx, is the same
as the suspend state, we'll need to communicate with the WKUP_M3 using
interrupts once we decide to enter Cx. I am not sure if we can do something
in the cpuidle implementation to work around the "interrupt for idle"
problem. We could probably not wait for an ACK when we want to enter Cx,
but the problem of limited wakeup sources remains. If we let the various
drivers block the entry to Cx, since almost all the IPs are in the
peripheral domain a system which uses anything other than UART and Timer
in WKUP domain will probably never be able enter Cx.

Regards,
Vaibhav
