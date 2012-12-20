From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 20 Dec 2012 14:55:07 +0200
Subject: [PATCH 5/9] clocksource: tegra: Enable ARM arch_timer with TSC
In-Reply-To: <50D305A6.2080904@arm.com>
References: <1355996654-6579-1-git-send-email-hdoyu@nvidia.com>
 <1355996654-6579-6-git-send-email-hdoyu@nvidia.com>
 <50D2EFFB.8030702@arm.com>
 <20121220.135758.1347753620353343245.hdoyu@nvidia.com>
 <50D2FF19.4060600@arm.com>
 <20121220122246.GA6819@tbergstrom-lnx.Nvidia.com>
 <50D305A6.2080904@arm.com>
Message-ID: <20121220125507.GB6819@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 20, 2012 at 01:33:42PM +0100, Marc Zyngier wrote:
> On 20/12/12 12:22, Peter De Schrijver wrote:
> >>>>> +
> >>>>> +	/* CNTFRQ */
> >>>>> +	asm("mcr p15, 0, %0, c14, c0, 0\n" : : "r" (freq));
> >>>>> +	asm("mrc p15, 0, %0, c14, c0, 0\n" : "=r" (val));
> >>>>> +	BUG_ON(val != freq);
> >>>>
> >>>> This is scary. CNTFRQ is only writable from secure mode, and will
> >>>> explode in any other situation.
> >>>>
> >>>> Also, writing to CNTFRQ doesn't change the timer frequency! This is just
> >>>> a way for secure mode to tell the rest of the world the frequency the
> >>>> timer is ticking at. Unless you've wired the input clock to be able to
> >>>> change the frequency?
> >>>
> >>> ATM, our upstream kernel is expected in secure mode. This situation
> >>> may be changed later, though....
> >>
> >> I appreciate this. But I expect this kernel to be also used on the
> >> non-secure side if someone tried to run KVM with it. And this would go
> >> bang right away.
> >>
> > 
> > But the guest wouldn't necessarily have this peripheral, or any other Tegra114
> > peripheral for that matter?
> 
> The problem is not so much the guest but the host. The host has to be
> booted in non-secure, so just saying "we do not support non-secure" is
> not a very convincing argument.
> 
> Unless of course you've already decided that you don't want to support
> KVM on this SoC...
> 

I guess that means we can't support KVM yet. Tegra does not have a secure
monitor by default. It all depends on what that system integrator does.

Cheers,

Peter.
