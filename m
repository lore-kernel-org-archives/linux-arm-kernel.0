From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 3 May 2013 11:43:23 +0100
Subject: [Xen-devel] [PATCH 1/3] arm_arch_timer: introduce
 arch_timer_stolen_ticks
In-Reply-To: <5182DBA9.9080609@codeaurora.org>
References: <alpine.DEB.2.02.1305011939180.5398@kaball.uk.xensource.com>
 <1367436460-10183-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <51817CBE.4050003@codeaurora.org>
 <1367482772.21869.26.camel@zakaz.uk.xensource.com>
 <5182DBA9.9080609@codeaurora.org>
Message-ID: <alpine.DEB.2.02.1305031130210.5398@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2 May 2013, Christopher Covington wrote:
> > So the virtual timer should appear to have been running even while time
> > is being stolen and therefore stolen time needs to be accounted via some
> > other means.
> 
> Something that's not currently obvious to me is that given that the stolen
> cycle accounting should be done, what makes the architected timer interrupt
> handler the ideal place to do it?

That is a good question and I would appreciate suggestions to improve
the patch.

Given that Xen x86 and ia64 does stolen time accounting from the timer
interrupt handler:

arch/x86/xen/time.c:xen_timer_interrupt
arch/ia64/kernel/time.c:timer_interrupt

and given that the arch_timer is the only timer used by Xen on ARM and
that it includes a virt_timer that is made on purpose to be used by
virtual machines, I thought that it might be a good place for it.

I also thought that doing it this way, KVM should be able to reuse the
same hook.
