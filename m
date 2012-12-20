From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 20 Dec 2012 14:22:46 +0200
Subject: [PATCH 5/9] clocksource: tegra: Enable ARM arch_timer with TSC
In-Reply-To: <50D2FF19.4060600@arm.com>
References: <1355996654-6579-1-git-send-email-hdoyu@nvidia.com>
 <1355996654-6579-6-git-send-email-hdoyu@nvidia.com>
 <50D2EFFB.8030702@arm.com>
 <20121220.135758.1347753620353343245.hdoyu@nvidia.com>
 <50D2FF19.4060600@arm.com>
Message-ID: <20121220122246.GA6819@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >>> +
> >>> +	/* CNTFRQ */
> >>> +	asm("mcr p15, 0, %0, c14, c0, 0\n" : : "r" (freq));
> >>> +	asm("mrc p15, 0, %0, c14, c0, 0\n" : "=r" (val));
> >>> +	BUG_ON(val != freq);
> >>
> >> This is scary. CNTFRQ is only writable from secure mode, and will
> >> explode in any other situation.
> >>
> >> Also, writing to CNTFRQ doesn't change the timer frequency! This is just
> >> a way for secure mode to tell the rest of the world the frequency the
> >> timer is ticking at. Unless you've wired the input clock to be able to
> >> change the frequency?
> > 
> > ATM, our upstream kernel is expected in secure mode. This situation
> > may be changed later, though....
> 
> I appreciate this. But I expect this kernel to be also used on the
> non-secure side if someone tried to run KVM with it. And this would go
> bang right away.
> 

But the guest wouldn't necessarily have this peripheral, or any other Tegra114
peripheral for that matter?

Cheers,

Peter.
