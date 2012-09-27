From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Sep 2012 10:50:35 +0100
Subject: [PATCH] ARM:CPUIDLE: Fix wrongly used idle control counter
In-Reply-To: <BD54883EA7DE8B41A61B7E723561C711139F5FA938@sc-vexch3.marvell.com>
References: <1348727761-16485-1-git-send-email-fwu@marvell.com>
 <20120927085315.GA14358@n2100.arm.linux.org.uk>
 <BD54883EA7DE8B41A61B7E723561C711139F5FA938@sc-vexch3.marvell.com>
Message-ID: <20120927095035.GB14358@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 27, 2012 at 02:19:49AM -0700, Fan Wu wrote:
> Thanks a lot for reviewing. 
> 
> So, you mean it is driver's responsibility to make sure the "disable
> and enable" function are paired before using it, which I think is
> NOT OK for current code. 

It is, and always has been.

> 1. If we want different users have chance to sync about the counter, 
> 	I think we may try the following ways
> 		1). add one interface (like exported function) for other
>		 modules or driver to get the current counter value .

That is broken.

> 		2). add constraint in "enable and disable" function to
>		 avoid the possible situation that the counter is
>		 less/more than "0".

Err what?

> 2. If we want the "nohlt" is OK for every driver and module without
> sync or similar operation,
> 	We may just remove "enable and disable" interface directly,
> which will cause the "nohlt" change will only be the init interface
> and cannot be changed any more after kernel bootup.

WTF.

No.  Look, it is _VERY_ simple.

Drivers must _not_ call enable_hlt() without first having called
disable_hlt() - and the number of enable_hlt()s must _NEVER_ be more
than the number of times you've called disable_hlt().

That's exactly the same with other subsystems - eg, you must not call
enable_irq() without having first called disable_irq(), and you must
not call enable_irq() more times than you've called disable_irq().

It is senseless to export the nohlt count - doing so will _create_ bugs
because if a driver were to ever use this value (which is a cumulative
value) then it can call enable_hlt() more times than it's called
disable_hlt() because of the interaction with another driver.

When drivers comply with the interface, the "nohlt" command line argument
works - it calls disable_hlt() once without a following enable_hlt(),
which means that hlt (or rather, putting the CPU into a low power mode)
is disabled at boot time and never enabled.

So, if you have a driver which is calling enable_hlt() without first
having called disable_hlt(), fix that driver.  There is nothing wrong
in the generic ARM code, and the generic ARM code can't help you work
around the broken driver.
