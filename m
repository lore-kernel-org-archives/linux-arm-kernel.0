From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 23 Nov 2018 13:04:51 +0000
Subject: Sleeping in user_access section
In-Reply-To: <44297716-74aa-1f14-67be-3594b5244b74@arm.com>
References: <3e881ee6-0ff6-b8b6-0633-3d4a7743411d@arm.com>
 <5B3B6AF9-9D8C-4577-905E-D407A5E7D0E3@zytor.com>
 <20181123105034.GQ30658@n2100.armlinux.org.uk>
 <44297716-74aa-1f14-67be-3594b5244b74@arm.com>
Message-ID: <20181123130451.GS30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2018 at 11:57:31AM +0000, Julien Thierry wrote:
> 
> 
> On 23/11/18 10:50, Russell King - ARM Linux wrote:
> >On Fri, Nov 23, 2018 at 01:57:12AM -0800, hpa at zytor.com wrote:
> >>You should never call a sleeping function from a user_access section.
> >>It is intended for very limited regions.
> >
> >So, what happens if the "unsafe" user access causes a page fault that
> >ends up sleeping?
> >
> 
> Thanks for pointing that out.
> 
> On the arm64 side, PAN state is saved in spsr and (if PAN feature is enabled
> in SCTLR) PAN bit gets set (disabling the user accesses). For software PAN
> we follow the same behaviour on exception entry. So upon exception we
> implicitly exit user_access mode and then re-enter it when returning from
> the exception.
> 
> On x86, the EFLAGS.AC bit is also saved upon exception and I think it is
> cleared upon exception entry so there is implicit exit from the user_access
> mode when taking exception/interrupt.
> 
> This however is just how those two architectures happen to behave and
> doesn't seem to be specified as part of the user_access API...
> 
> Which is why I'd like to clarify the semantics of user_access region wrt
> sleeping functions.

Explicitly calling a sleeping function may not be recommended, but
it's a rather fundamental fact of the Linux kernel that if we want
to access userspace, we must be either prepared to sleep, or fail
the access and return an error.

Looking at kernel/exit.c and kernel/compat.c, I see no sign of any
retry mechanism in the current call sites, so any failed user access
would return an error to userspace - which is not the behaviour that
userspace would expect.

It's possible that, when user_access_begin() et.al. are implemented,
access_ok() also comes with the requirement to make sure that the
userspace pages are accessible, but even _that_ would be racy,
because there's no way to pin the pages, so another thread/CPU could
page those user pages back out... leading to a fault.

So, realistically, with how user_access_begin()..user_access_end()
is currently being used, an architecture fundamentally has to be
prepared for threads to sleep within that section of code through
the action of the page fault handling.  I can't see any other
realistic possibility here.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
